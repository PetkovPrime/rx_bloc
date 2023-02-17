{{> licence.dart }}

import 'package:auto_route/auto_route.dart';

import '../../feature_counter/views/counter_page.dart';{{#edit_address}}
import '../../feature_edit_address/views/edit_address_brick_page.dart';{{/edit_address}}
import '../../feature_login/views/login_page.dart';
import '../../feature_notifications/views/notifications_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    MaterialRoute(page: CounterPage, initial: true),
    MaterialRoute(page: LoginPage),
    MaterialRoute(page: NotificationsPage){{#edit_address}},
    MaterialRoute(page: EditAddressBrickPage),{{/edit_address}}
  ],
)
class $Router {}
