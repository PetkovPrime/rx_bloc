import 'package:booking_app/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../pages/search_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  SearchPage searchPage;

  group('end-to-end test', () {
    testWidgets('Set text in search box', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      searchPage = SearchPage(tester);

      await searchPage.setSearchBox('TEST!!!');

      // final Finder hotel = find.widgetWithText(Row, '0 - Premier Inn Dubai International Airport');
      // final Finder favorite = find.byKey(const Key('hotelSearchBar'));

      // await tester.tap(favorite);

      // expect(
      //     find.byKey(hotelSearchBarKey, skipOffstage: false), findsOneWidget);

      // await tester.enterText(searchPage.loc_inputSearch, 'TEST!!!');
    });
  });
}
