// Copyright (c) 2021, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../../l10n/l10n.dart';
import '../data_sources/remote/interceptors/analytics_interceptor.dart';
import '../di/app_dependencies.dart';
import '../routers/router.gr.dart' as router;
import '../theme/design_system.dart';
import 'config/environment_config.dart';

/// This widget is the root of your application.
class Reminders extends StatelessWidget {
  Reminders({this.config = EnvironmentConfig.prod, Key? key}) : super(key: key);

  final EnvironmentConfig config;
  final _router = router.Router();

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: AppDependencies.of(context, config).providers,
        child: _MyMaterialApp(_router, config),
      );
}

/// Wrapper around the MaterialApp widget to provide additional functionality
/// accessible throughout the app (such as App-level dependencies, Firebase
/// services, etc).
class _MyMaterialApp extends StatefulWidget {
  const _MyMaterialApp(this._router, this._config);

  final router.Router _router;
  final EnvironmentConfig _config;

  @override
  __MyMaterialAppState createState() => __MyMaterialAppState();
}

class __MyMaterialAppState extends State<_MyMaterialApp> {
  @override
  void initState() {
    if (widget._config != EnvironmentConfig.dev) {
      _addInterceptors();
    }

    super.initState();
  }

  void _addInterceptors() {
    context.read<Dio>().interceptors.addAll([
      AnalyticsInterceptor(context.read()),

      /// TODO: Add your own interceptors here
    ]);
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Reminders',
        theme: DesignSystem.fromBrightness(Brightness.light).theme,
        darkTheme: DesignSystem.fromBrightness(Brightness.dark).theme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        routeInformationParser: widget._router.defaultRouteParser(),
        routerDelegate: widget._router.delegate(
          navigatorObservers: () => widget._config != EnvironmentConfig.dev
              ? [
                  context.read<FirebaseAnalyticsObserver>(),
                ]
              : [],
        ),
        debugShowCheckedModeBanner: false,
      );
}
