import 'package:booking_app/base/keys/search_page_keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';


import 'base_page.dart';
import 'hotel_details_page.dart';

class SearchPagePatrol{

  final PatrolTester patrolTester;

  SearchPagePatrol(this.patrolTester);

  final Finder locInputSearch = find.byKey(SearchPageKeys.keyInputSearch);
  final Finder locSortBtn = find.byKey(SearchPageKeys.keySortBtn);
  final Finder locFirstHotelItem = find.byKey(SearchPageKeys.keyListHotelItems).first;



}
