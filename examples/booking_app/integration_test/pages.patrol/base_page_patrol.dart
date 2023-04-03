import '../tests/common.dart';

class BasePagePatrol {
  final PatrolTester tester;

  BasePagePatrol(this.tester);

  Future<void> tapElement(Finder element) async{
    await tester.waitUntilVisible(element);
    await tester.tap(element);
    await tester.pumpAndSettle();
  }

  Future<void> setText(Finder inputField, String text) async {
    await tester.waitUntilVisible(inputField);
    await tester.enterText(inputField, text);
    await tester.pumpAndSettle();
  }

  Future<bool> isDisplayed(Finder element) async{
    return element.evaluate().isNotEmpty ? true : false;
  }
}
