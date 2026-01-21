import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_event.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_state.dart';
import 'package:expense_tracker/logic/blocs/theme/theme_bloc.dart';
import 'package:expense_tracker/presentation/navigation/app_routes.dart';
import 'package:expense_tracker/presentation/screens/settings/choose_theme_sheet.dart';
import 'package:expense_tracker/presentation/widgets/dialogs.dart';
import 'package:expense_tracker/presentation/widgets/outlined_card.dart';
import 'package:expense_tracker/presentation/widgets/avatar.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          return ScreenSafeArea(
            includeTop: true,
            includeBottom: false,
            child: state.user != null
                ? SingleChildScrollView(
                    padding: EdgeInsets.all(AppDimensions.spaceM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: AppDimensions.spaceM),
                        _buildPhoto(context),
                        SizedBox(height: AppDimensions.spaceM),
                        Center(
                          child: Text(
                            state.user!.name ?? '',
                            style: context.textTheme.titleMedium,
                          ),
                        ),
                        Center(
                          child: Text(
                            state.user!.email ?? '',
                            style: context.textTheme.bodySmall,
                          ),
                        ),
                        SizedBox(height: AppDimensions.spaceL),
                        _buildAccountActionsCard(context),
                        SizedBox(height: AppDimensions.spaceM),
                        _buildExpenseActionsCard(context),
                        SizedBox(height: AppDimensions.spaceM),
                        _buildAppearanceActionsCard(context),
                        SizedBox(height: AppDimensions.spaceL),
                        _buildLogoutButton(context),
                        SizedBox(height: 96.0),
                      ],
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget _buildPhoto(BuildContext context) {
    final state = context.read<AuthBloc>().state;

    return Center(
      child: SizedBox.square(
        dimension: 96.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: 96.0,
              height: 96.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(48)),
                border: Border.all(
                  color: context.colorScheme.outline,
                  width: 0.5,
                ),
              ),
              child: Center(
                child: Avatar(path: state.user?.photoUrl, size: 80.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountActionsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Account'),
              subtitle: Text('Update personal information'),
              trailing: Icon(
                Icons.chevron_right,
                size: AppDimensions.iconSizeS,
              ),
              visualDensity: VisualDensity.compact,
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.updateAccount),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              subtitle: Text('Create a new password'),
              trailing: Icon(
                Icons.chevron_right,
                size: AppDimensions.iconSizeS,
              ),
              visualDensity: VisualDensity.compact,
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.changePassword),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseActionsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.folder),
              title: Text('My Categories'),
              subtitle: Text('Manage expense categories'),
              trailing: Icon(
                Icons.chevron_right,
                size: AppDimensions.iconSizeS,
              ),
              visualDensity: VisualDensity.compact,
              onTap: () => Navigator.pushNamed(context, AppRoutes.categories),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.watch_later),
              title: Text('My Expenses'),
              subtitle: Text('Manage your past expenses'),
              trailing: Icon(
                Icons.chevron_right,
                size: AppDimensions.iconSizeS,
              ),
              visualDensity: VisualDensity.compact,
              onTap: () => Navigator.pushNamed(context, AppRoutes.expenses),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppearanceActionsCard(BuildContext context) {
    final isDarkMode = context.read<ThemeBloc>().state.isDarkMode;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Change Theme'),
              subtitle: Text(isDarkMode ? 'Dark' : 'Light'),
              trailing: Icon(
                Icons.chevron_right,
                size: AppDimensions.iconSizeS,
              ),
              visualDensity: VisualDensity.compact,
              onTap: () {
                Dialogs.showBottomSheet(
                  context,
                  'Choose Theme',
                  ChooseThemeSheet(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Dialogs.showConfirmationDialog(
          context,
          'Logout',
          'Are you sure you want to logout?',
          () {
            context.read<AuthBloc>().add(AuthLoggedOut());
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (_) => false,
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: context.appColors.danger,
        backgroundColor: context.colorScheme.surface,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.logout),
          SizedBox(width: AppDimensions.spaceM),
          Text('Logout'),
        ],
      ),
    );
  }
}
