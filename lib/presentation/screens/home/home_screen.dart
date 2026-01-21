import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/config/app_theme.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/core/utils/helpers.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_event.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_state.dart';
import 'package:expense_tracker/logic/blocs/dashboard/dashboard_bloc.dart';
import 'package:expense_tracker/logic/blocs/dashboard/dashboard_event.dart';
import 'package:expense_tracker/logic/blocs/dashboard/dashboard_state.dart';
import 'package:expense_tracker/presentation/navigation/app_routes.dart';
import 'package:expense_tracker/presentation/widgets/avatar.dart';
import 'package:expense_tracker/presentation/widgets/empty_placeholder.dart';
import 'package:expense_tracker/presentation/widgets/expense_card.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<DashboardBloc>().add(LoadDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return ScreenSafeArea(
          includeTop: true,
          includeBottom: false,
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<AuthBloc>().add(AuthUserFetched(null));
              context.read<DashboardBloc>().add(LoadDashboard());
              await Future.delayed(Duration.zero);
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.spaceM),
              child: state.user != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildHeader(state),
                        SizedBox(height: AppDimensions.spaceL),
                        _buildDashboard(),
                        SizedBox(height: 96.0),
                      ],
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(AuthState state) {
    return Row(
      children: <Widget>[
        Avatar(path: state.user!.photoUrl),
        SizedBox(width: AppDimensions.spaceM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${_getGreeting()},', style: context.textTheme.bodySmall),
              Text(
                _getUserFirstName(state.user!.name),
                style: context.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(width: AppDimensions.spaceM),
        Image.asset(
          'assets/images/logo.png',
          width: 40.0,
          fit: BoxFit.fitWidth,
        ),
      ],
    );
  }

  Widget _buildDashboard() {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (BuildContext context, DashboardState state) {
        if (state.isLoading) {
          return _buildShimmer();
        }

        if (state.data == null) {
          return Column();
        }

        final recentExpenses = state.data!.lists.recentExpenses;

        if (recentExpenses.isEmpty) {
          return EmptyPlaceholder(
            title: 'No expenses yet',
            description: 'Let\'s get started by creating an expense',
            height: MediaQuery.of(context).size.height * 0.6,
            action: SizedBox(
              width: 160.0,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.createExpense),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Start'),
                    SizedBox(width: AppDimensions.spaceS),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildDashboardHeader(state),
            if ((state.data!.summary.aiInsights ?? '').isNotEmpty)
              SizedBox(height: AppDimensions.spaceL),
            if ((state.data!.summary.aiInsights ?? '').isNotEmpty)
              _buildAiInsights(state),
            SizedBox(height: AppDimensions.spaceL),
            _buildRecentExpensesList(state),
          ],
        );
      },
    );
  }

  Widget _buildDashboardHeader(DashboardState state) {
    final percentageChange = _getExpensePercentageChange(state);

    return Theme(
      data: AppTheme.dark,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceXL,
            vertical: AppDimensions.spaceL,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                context.colorScheme.primary,
                context.colorScheme.primary.withAlpha(180),
              ],
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.calendar_month, size: AppDimensions.iconSizeXS),
                  SizedBox(width: AppDimensions.spaceS),
                  Text(
                    'Total Expenses',
                    style: AppTheme.dark.textTheme.bodySmall,
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.spaceXS),
              Text(
                'TZS ${numberFormat(state.data!.summary.thisMonthExpenses)}',
                style: AppTheme.dark.textTheme.titleLarge!.copyWith(
                  fontSize: 24,
                ),
              ),
              SizedBox(height: AppDimensions.spaceXS),
              Row(
                children: <Widget>[
                  percentageChange > 0
                      ? Icon(
                          Icons.add,
                          size: AppDimensions.iconSizeXS,
                          color: context.appColors.danger,
                        )
                      : Icon(
                          Icons.remove,
                          size: AppDimensions.iconSizeXS,
                          color: context.appColors.success,
                        ),
                  Text(
                    '$percentageChange% since last month',
                    style: AppTheme.dark.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAiInsights(DashboardState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          '✨ AI Insights',
          style: context.textTheme.titleSmall!.copyWith(
            color: context.textTheme.bodySmall!.color,
          ),
        ),
        SizedBox(height: AppDimensions.spaceS),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceS,
            vertical: AppDimensions.spaceXS,
          ),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: context.colorScheme.outline, width: 3.0),
            ),
          ),
          child: Text(
            state.data!.summary.aiInsights!,
            style: context.textTheme.bodySmall!.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentExpensesList(DashboardState state) {
    final items = state.data!.lists.recentExpenses;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '🕜 Recent Expenses',
                style: context.textTheme.titleSmall!.copyWith(
                  color: context.textTheme.bodySmall!.color,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.expenses),
              child: Row(
                children: <Widget>[
                  Text('View all', style: context.textTheme.bodySmall),
                  SizedBox(width: AppDimensions.spaceS),
                  Icon(Icons.arrow_forward, size: AppDimensions.iconSizeXS),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimensions.spaceM),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpenseCard(
              expense: items[index],
              showDescription: false,
              showActions: false,
            );
          },
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.primary.withAlpha(18),
      highlightColor: context.appColors.background!.withAlpha(54),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 128.0,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          SizedBox(height: AppDimensions.spaceXL),
          GridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: (1 / 0.2),
            crossAxisCount: 1,
            crossAxisSpacing: AppDimensions.spaceM,
            mainAxisSpacing: AppDimensions.spaceM,
            children: const <Widget>[
              Card(elevation: 0),
              Card(elevation: 0),
              Card(elevation: 0),
              Card(elevation: 0),
            ],
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    int hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good afternoon';
    } else if (hour >= 17 && hour < 20) {
      return 'Good evening';
    } else {
      return 'Good night';
    }
  }

  String _getUserFirstName(String name) {
    final parts = name.split(' ');

    if (parts.length > 2) {
      return '${parts[0]} ${parts[1]}';
    }

    return parts[0];
  }

  num _getExpensePercentageChange(DashboardState state) {
    final thisMonth = state.data!.summary.thisMonthExpenses;
    final lastMonth = state.data!.summary.lastMonthExpenses;

    if (lastMonth == 0) {
      return (thisMonth > 0 ? 100 : 0);
    }

    final denominator = lastMonth == 0 ? 1 : lastMonth;
    final result = ((thisMonth - lastMonth) / denominator) * 100;
    return round(result, 1);
  }
}
