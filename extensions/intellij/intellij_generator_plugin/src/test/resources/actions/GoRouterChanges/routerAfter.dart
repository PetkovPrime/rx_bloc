// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../base/common_blocs/coordinator_bloc.dart';
import '../base/models/deep_link_model.dart';
import '../feature_counter/di/counter_page_with_dependencies.dart';
import '../feature_home/views/home_page.dart';
import '../feature_login/di/login_page_with_dependencies.dart';
import '../feature_notifications/di/notifications_page_with_dependencies.dart';
import '../feature_profile/di/profile_page_with_dependencies.dart';
import '../feature_splash/di/splash_page_with_dependencies.dart';
import '../feature_splash/services/splash_service.dart';
import '../lib_permissions/services/permissions_service.dart';
import 'models/route_data_model.dart';
import 'models/route_model.dart';
import 'models/routes_path.dart';
import '../feature_dev_menu/di/dev_menu_page_with_dependencies.dart';
import 'views/error_page.dart';

part 'router.g.dart';


part 'routes/onboarding_routes.dart';

part 'routes/profile_routes.dart';

part 'routes/routes.dart';

part 'routes/showcase_routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter(this._coordinatorBloc);

  final CoordinatorBlocType _coordinatorBloc;

  late final _GoRouterRefreshStream _refreshListener =
      _GoRouterRefreshStream(_coordinatorBloc.states.isAuthenticated);

  GoRouter get router => _goRouter;

  late final GoRouter _goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: const SplashRoute().location,
    routes: _appRoutesList(),
    redirect: _pageRedirections,
    refreshListenable: _refreshListener,
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const ErrorPage(),
    ),
  );

  List<RouteBase> _appRoutesList() => [
        $splashRoute,
        $loginRoute,
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => HomePage(
                  child: child,
                ),
            routes: [
              $counterRoute,
              $deepLinksRoute,
              $profileRoute,
            ]),
      ];

  FutureOr<String?> _pageRedirections(
    BuildContext context,
    GoRouterState state,
  ) async {
    if (_refreshListener.isLoggedIn && state.queryParams['from'] != null) {
      return state.queryParams['from'];
    }
    if (_refreshListener.isLoggedIn &&
        state.subloc == const LoginRoute().location) {
      return const CounterRoute().location;
    }

    if (state.subloc != const SplashRoute().location) {
      if (!context.read<SplashService>().isAppInitialized) {
        return '${const SplashRoute().location}?from=${state.location}';
      }
    }

    final pathInfo =
        router.routeInformationParser.matcher.findMatch(state.location);

    final routeName = RouteModel.getRouteNameByFullPath(pathInfo.fullpath);

    final hasPermissions = routeName != null
        ? await context
            .read<PermissionsService>()
            .hasPermission(routeName, graceful: true)
        : true;

    if (!_refreshListener.isLoggedIn && !hasPermissions) {
      return '${const LoginRoute().location}?from=${state.location}';
    }

    if (!hasPermissions) {
      return const CounterRoute().location;
    }

    return null;
  }
}

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<bool> stream) {
    _subscription = stream.listen(
      (bool isLoggedIn) {
        this.isLoggedIn = isLoggedIn;
        notifyListeners();
      },
    );
  }

  late final StreamSubscription<bool> _subscription;
  late bool isLoggedIn = false;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}