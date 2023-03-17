import 'package:booking_app/base/keys/hotel_details_page_keys.dart';
import 'package:booking_app/base/keys/search_page_keys.dart';
import 'package:booking_app/main.dart' as app;
import 'package:favorites_advanced_base/core.dart';
import 'package:flutter/foundation.dart';

import '../pages/hotel_details_page.dart';
import '../pages/search_page.dart';
import 'common.dart';

void main() {
  SkeletonText.testMode = true;
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  SearchPage searchPage;
  HotelDetailsPage hotelDetailsPage;

  group('end-to-end test', () {
    testWidgets('Set text in search box', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      searchPage = SearchPage(tester);

      // await searchPage.tapSortBtn();

      // await searchPage.tapSearchBox();
      //
      await searchPage.setSearchBox('Rose');

      hotelDetailsPage = await searchPage.tapFirstHotelItem();

      await hotelDetailsPage.tapFavoriteBorderBtn();

      expect(hotelDetailsPage.isFavoriteBtnDisplayed(), true);
    });
  });

  // patrol('Add hotel to favorite', ($) async {
  //   await $.pumpWidgetAndSettle(const MyApp());
  //
  //   await $(SearchPageKeys.keyInputSearch).enterText('Rose');
  //   await $(SearchPageKeys.keyListHotelItems).first.tap();
  //   await $(HotelDetailsPageKeys.keyBtnFavoriteBorder).tap();
  //   await $.native.pressBack();
  // });
  //
}
