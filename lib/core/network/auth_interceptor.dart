import 'package:dio/dio.dart';
import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/data/repositories/auth_repository.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/presentation/navigation/app_route_observer.dart';
import 'package:expense_tracker/presentation/navigation/app_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final AuthRepository _authRepository = AuthRepository();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Fetch token from local storage
    final String? token = await _storage.read(key: Preferences.accessToken);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // 2. Continue the request
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 3. Handle 401 Unauthorized globally
    if (err.response?.statusCode == 401) {
      // Logout the user and redirect to login
      String? currentRoute = AppRouteObserver.currentRoute;

      if (currentRoute != AppRoutes.login) {
        _authRepository.logout();
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          AppRoutes.login,
          (_) => false,
        );
      }
    }
    return handler.next(err);
  }
}
