import 'package:favorites_advanced_base/ui_components.dart';
import 'package:flutter_test/flutter_test.dart';

import '../keys/search_page_keys.dart';
import 'base_page.dart';

class SearchPage extends BasePage{

  final Finder locInputSearch = find.byKey(SearchPageKeys.keyInputSearch);
  final Finder locSortBtn = find.byKey(SearchPageKeys.keyBtnSort);

  SearchPage(WidgetTester tester) : super(tester);

  Future<void> tapSortBtn() async{
    await tapElement(locSortBtn);
  }

  Future<void> tapSearchBox() async{
    await tapElement(locInputSearch);
  }

  Future<void> setSearchBox(String text) async {
    await setText(locInputSearch, text);
  }
}
