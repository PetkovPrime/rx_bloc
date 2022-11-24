import 'package:favorites_advanced_base/core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_page.dart';

class SearchPage extends BasePage{

  final Finder loc_inputSearch = find.byType(SearchBar);

  SearchPage(WidgetTester tester) : super(tester);

  Future<void> setSearchBox(String text) async {
    await tester.enterText(loc_inputSearch, text);
  }
}
