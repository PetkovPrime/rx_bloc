
import 'package:favorites_advanced_base/core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_utils.dart';

class ElementUtils extends BaseUtils{
  ElementUtils(WidgetTester tester) : super(tester);

  Future<void> tapElementAndWait<T>(Finder element) async {
    await tester.tap(element);
    await tester.pumpAndSettle();
  }
}