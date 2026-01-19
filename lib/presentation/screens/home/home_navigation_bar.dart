import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/logic/blocs/home/home_navigation_bloc.dart';
import 'package:expense_tracker/logic/blocs/home/home_navigation_event.dart';
import 'package:expense_tracker/logic/blocs/home/home_navigation_state.dart';
import 'package:expense_tracker/presentation/navigation/app_routes.dart';
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
            child: <Widget>[HomeScreen(), Column()][state.index],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.createExpense),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Icon(Icons.add_rounded),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: state.index == 0
                        ? context.colorScheme.primary
                        : null,
                  ),
                  onPressed: () => context.read<HomeNavigationBloc>().add(
                    HomeNavigationIndexChanged(0),
                  ),
                ),
                SizedBox(width: 40.0),
                IconButton(
                  icon: Icon(
                    Icons.person_rounded,
                    color: state.index == 1
                        ? context.colorScheme.primary
                        : null,
                  ),
                  onPressed: () => context.read<HomeNavigationBloc>().add(
                    HomeNavigationIndexChanged(1),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
