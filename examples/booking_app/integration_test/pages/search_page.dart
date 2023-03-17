import 'package:booking_app/base/keys/search_page_keys.dart';
import 'package:flutter_test/flutter_test.dart';


import 'base_page.dart';
import 'hotel_details_page.dart';

class SearchPage extends BasePage{

  final Finder locInputSearch = find.byKey(SearchPageKeys.keyInputSearch);
  final Finder locSortBtn = find.byKey(SearchPageKeys.keySortBtn);
  final Finder locFirstHotelItem = find.byKey(SearchPageKeys.keyListHotelItems).first;

  SearchPage(WidgetTester tester) : super(tester);

  Future<HotelDetailsPage> tapFirstHotelItem() async{
    await tapElement(locFirstHotelItem);
    return HotelDetailsPage(tester);
  }

  Future<void> tapSortBtn() async{
    await tapElement(locSortBtn);
  }

  Future<void> tapSearchBox() async{
    await tapElement(locInputSearch);
    await tester.pumpAndSettle();
  }

  Future<void> setSearchBox(String text) async {
    await setText(locInputSearch, text);
  }
}
