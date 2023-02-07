import 'package:favorites_advanced_base/resources.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_test/flutter_test.dart';


import 'base_page.dart';

class SearchPage extends BasePage{

  final Finder locInputSearch = find.byKey(const Key(Keys.hotelSearchElement));
  final Finder locSortBtn = find.byKey(const Key(Keys.hotelSortElement));


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
