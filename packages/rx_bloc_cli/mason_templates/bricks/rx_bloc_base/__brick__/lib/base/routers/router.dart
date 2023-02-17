{{> licence.dart }}

import 'package:auto_route/auto_route.dart';

import '../../feature_counter/views/counter_page.dart';
import '../../feature_login/views/login_page.dart';
import '../../feature_notifications/views/notifications_page.dart';{{#ui_toolkit}}
import '../../feature_ui_toolkit/views/ui_toolkit_page.dart';{{/ui_toolkit}}

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    MaterialRoute(page: CounterPage, initial: true),
    MaterialRoute(page: LoginPage),
    MaterialRoute(page: NotificationsPage),{{#ui_toolkit}}
    MaterialRoute(page: UiToolkitPage),{{/ui_toolkit}}
  ],
)
class $Router {}
