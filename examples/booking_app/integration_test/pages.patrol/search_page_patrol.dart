import 'package:booking_app/base/keys/search_page_keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';


import '../pages/base_page.dart';
import '../pages/hotel_details_page.dart';
import 'base_page_patrol.dart';

class SearchPagePatrol extends BasePagePatrol{


  final Finder locInputSearch = find.byKey(SearchPageKeys.keyInputSearch);
  final Finder locSortBtn = find.byKey(SearchPageKeys.keySortBtn);
  final Finder locFirstHotelItem = find.byKey(SearchPageKeys.keyListHotelItems).first;

  SearchPagePatrol(PatrolTester tester) : super(tester);

  Future<void> tapFirstHotelItem() async{
    await tapElement(tester(SearchPageKeys.keyInputSearch));
  }

  Future<void> tapSortBtn() async{
    await tapElement(locSortBtn);
  }

  Future<void> tapSearchBox() async{
    await tapElement(locInputSearch);
    await tester.pumpAndSettle();
  }

  Future<void> setSearchBox(String text) async {
    await setText(tester(SearchPageKeys.keyInputSearch), text);
  }
}
