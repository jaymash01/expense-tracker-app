import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_state.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return ScreenSafeArea(
          includeTop: true,
          includeBottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // _buildAppBar(context, state),
                // _buildHeader(context, state),
                // SizedBox(height: AppDimensions.spaceS),
                // Padding(
                //   padding: EdgeInsets.all(AppDimensions.spaceM),
                //   child: Column(
                //     children: <Widget>[_buildServicesGrid(context)],
                //   ),
                // ),
                SizedBox(height: AppDimensions.spaceS),
              ],
            ),
          ),
        );
      },
    );
  }
}
