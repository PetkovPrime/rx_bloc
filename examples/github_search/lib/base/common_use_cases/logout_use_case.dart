// Copyright (c) 2021, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import '../app/config/app_constants.dart';
import '../repositories/auth_repository.dart';
import '../repositories/push_notification_repository.dart';

class LogoutUseCase {
  LogoutUseCase(
    this._authRepository,
    this._pushSubscriptionRepository,
  );

  final AuthRepository _authRepository;
  final PushNotificationRepository _pushSubscriptionRepository;

  Future<bool> execute() async {
    // Unsubscribe user push token
    try {
      final pushToken =
          await _pushSubscriptionRepository.getToken(vapidKey: webVapidKey);
      if (pushToken != null) {
        await _pushSubscriptionRepository.unsubscribe(pushToken);
      }
    } catch (e) {
      print(e);
    }

    // Perform user logout
    await _authRepository.logout();

    // Clear locally stored auth data
    await _authRepository.clearAuthData();

    return true;
  }
}
