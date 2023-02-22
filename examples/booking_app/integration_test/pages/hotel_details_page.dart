
import 'package:booking_app/base/keys/hotel_details_page_keys.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_page.dart';

class HotelDetailsPage extends BasePage{

  final Finder locBtnFavoriteBorder = find.byKey(HotelDetailsPageKeys.keyBtnFavoriteBorder);
  final Finder locBtnFavorite = find.byKey(HotelDetailsPageKeys.keyBtnFavorite);

  HotelDetailsPage(WidgetTester tester) : super(tester);

  Future<void> tapFavoriteBorderBtn() async{
    await tapElement(locBtnFavoriteBorder);
  }

  Future<void> tapFavoriteBtn() async{
    await tapElement(locBtnFavorite);
  }

  Future<bool> isFavoriteBtnDisplayed() async{
    // return isDisplayed(locBtnFavorite);
    return locBtnFavorite.evaluate().isNotEmpty ? false : true;
  }
}