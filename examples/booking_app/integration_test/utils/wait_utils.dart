import 'package:flutter_test/flutter_test.dart';

import 'base_utils.dart';

class WaitUtils extends BaseUtils{

  WaitUtils(WidgetTester tester) : super(tester);

  Future<void> waitElementToBeLoaded(String text, Finder finder) async {
    await tester.pump();

    bool isDisplayed = false;

    while (isDisplayed != true) {
      try {
        expect(finder, findsOneWidget);
      } catch (NoSuchElementExpection) {
        isDisplayed = false;
        print('Element $finder is not displayed');
      }
    }
  }
}
