import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/logic/blocs/theme/theme_bloc.dart';
import 'package:expense_tracker/logic/blocs/theme/theme_event.dart';
import 'package:expense_tracker/logic/blocs/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseThemeSheet extends StatelessWidget {
  const ChooseThemeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        final bloc = context.read<ThemeBloc>();

        return Padding(
          padding: EdgeInsets.all(AppDimensions.spaceM),
          child: RadioGroup<bool>(
            groupValue: state.isDarkMode,
            onChanged: (bool? value) {
              if (value == true) {
                bloc.add(DarkThemeSelected());
              } else if (value == false) {
                bloc.add(LightThemeSelected());
              }
            },
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Radio<bool>(value: false),
                  title: Text('Light Theme'),
                  onTap: () {
                    bloc.add(LightThemeSelected());
                  },
                ),
                ListTile(
                  leading: Radio<bool>(value: true),
                  title: Text('Dark Theme'),
                  onTap: () {
                    bloc.add(DarkThemeSelected());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
