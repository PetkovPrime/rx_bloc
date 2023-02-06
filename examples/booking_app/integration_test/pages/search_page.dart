import 'package:favorites_advanced_base/resources.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_test/flutter_test.dart';


import 'base_page.dart';

class SearchPage extends BasePage{

  final Finder loc_inputSearch = find.byKey(const Key(Keys.hotelSearchElement));
  final Finder loc_sortBtn = find.byKey(const Key(Keys.hotelSortElement));


  SearchPage(WidgetTester tester) : super(tester);

  Future<void> tapSortBtn() async{
    await tapElement(loc_sortBtn);
  }

  Future<void> tapSearchBox() async{
    await tapElement(loc_inputSearch);
  }

  Future<void> setSearchBox(String text) async {
    await setText(loc_inputSearch, text);
  }
}
