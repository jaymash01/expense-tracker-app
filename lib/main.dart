import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_event.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_bloc.dart';
import 'package:expense_tracker/logic/blocs/dashboard/dashboard_bloc.dart';
import 'package:expense_tracker/logic/blocs/expenses/expenses_bloc.dart';
import 'package:expense_tracker/logic/blocs/home/home_navigation_bloc.dart';
import 'package:expense_tracker/logic/blocs/theme/theme_bloc.dart';
import 'package:expense_tracker/logic/blocs/theme/theme_event.dart';
import 'package:expense_tracker/logic/blocs/theme/theme_state.dart';
import 'package:expense_tracker/presentation/navigation/app_route_observer.dart';
import 'package:expense_tracker/presentation/navigation/app_router.dart';
import 'package:expense_tracker/presentation/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final routeObserver = AppRouteObserver();

void main() async {
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) =>
              ThemeBloc()..add(ThemeCheckRequested()),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc()..add(AuthCheckRequested()),
        ),
        BlocProvider<HomeNavigationBloc>(
          create: (BuildContext context) => HomeNavigationBloc(),
        ),
        BlocProvider<DashboardBloc>(
          create: (BuildContext context) =>
              DashboardBloc(authBloc: context.read<AuthBloc>()),
        ),
        BlocProvider<CategoriesBloc>(
          create: (BuildContext context) =>
              CategoriesBloc(authBloc: context.read<AuthBloc>()),
        ),
        BlocProvider<ExpensesBloc>(
          create: (BuildContext context) =>
              ExpensesBloc(authBloc: context.read<AuthBloc>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          navigatorObservers: [routeObserver],
          theme: state.themeData,
          themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRoutes.splash,
          builder: (BuildContext context, Widget? child) {
            final backgroundColor = state.themeData.scaffoldBackgroundColor;

            // Determine icon brightness based on the theme
            final iconBrightness =
                ThemeData.estimateBrightnessForColor(backgroundColor) ==
                    Brightness.dark
                ? Brightness.light
                : Brightness.dark;

            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: iconBrightness,
                systemNavigationBarColor: backgroundColor,
                systemNavigationBarIconBrightness: iconBrightness,
                systemNavigationBarContrastEnforced: false,
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
