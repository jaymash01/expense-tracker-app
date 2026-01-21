import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/logic/blocs/home/home_navigation_bloc.dart';
import 'package:expense_tracker/logic/blocs/home/home_navigation_event.dart';
import 'package:expense_tracker/logic/blocs/home/home_navigation_state.dart';
import 'package:expense_tracker/presentation/navigation/app_routes.dart';
import 'package:expense_tracker/presentation/screens/account/account_screen.dart';
import 'package:expense_tracker/presentation/screens/home/home_screen.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
      builder: (BuildContext context, HomeNavigationState state) {
        return Scaffold(
          body: ScreenSafeArea(
            child: <Widget>[HomeScreen(), AccountScreen()][state.index],
          ),
          floatingActionButton: _buildFloatingActionButton(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: _buildNavigationBar(context, state),
        );
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return SizedBox.square(
      dimension: 60.0,
      child: Tooltip(
        message: 'Create expense',
        child: Card(
          elevation: AppDimensions.elevationM,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.createExpense),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    context.colorScheme.primary,
                    context.colorScheme.primary.withAlpha(200),
                  ],
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                ),
              ),
              child: Center(
                child: Icon(Icons.add, color: context.colorScheme.onPrimary),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationBar(BuildContext context, HomeNavigationState state) {
    return BottomAppBar(
      elevation: AppDimensions.elevationXS,
      shape: CircularNotchedRectangle(),
      notchMargin: AppDimensions.spaceS,
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: state.index == 0 ? context.colorScheme.primary : null,
            ),
            tooltip: 'Home',
            onPressed: () => context.read<HomeNavigationBloc>().add(
              HomeNavigationIndexChanged(0),
            ),
          ),
          SizedBox(width: 40.0),
          IconButton(
            icon: Icon(
              Icons.person_2,
              color: state.index == 1 ? context.colorScheme.primary : null,
            ),
            tooltip: 'Account',
            onPressed: () => context.read<HomeNavigationBloc>().add(
              HomeNavigationIndexChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}
