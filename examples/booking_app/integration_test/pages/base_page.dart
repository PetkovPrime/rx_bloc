import 'package:flutter_test/flutter_test.dart';

class BasePage {
  final WidgetTester tester;

  BasePage(this.tester);

  Future<void> tapElement(Finder element) async{
    await tester.ensureVisible(element);
    await tester.tap(element, warnIfMissed: true);
  }

  Future<void> setText(Finder inputField, String text) async {
    await tester.ensureVisible(inputField);
    await tester.enterText(inputField, text);
  }
}
