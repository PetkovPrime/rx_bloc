import 'package:favorites_advanced_base/core.dart';
import 'package:favorites_advanced_base/src/models/hotel_search_filters.dart';

import '../models/hotel.dart';

class HotelsRepository {
  HotelsRepository({
    required HotelsDataSource hotelsDataSource,
  }) : _hotelsDataSource = hotelsDataSource;

  final HotelsDataSource _hotelsDataSource;

  Future<List<Hotel>> getHotels({HotelSearchFilters? filters}) =>
      _hotelsDataSource.getHotels(filters: filters);

  Future<List<Hotel>> getFavoriteHotels() =>
      _hotelsDataSource.getFavoriteHotels();

  Future<Hotel> favoriteHotel(
    Hotel hotel, {
    required bool isFavorite,
  }) =>
      _hotelsDataSource.favoriteHotel(hotel, isFavorite: isFavorite);

  Future<List<HotelExtraDetails>> fetchExtraDetails(List<String> ids) =>
      _hotelsDataSource.fetchExtraDetails(ids);

  Future<HotelFullExtraDetails> fetchFullExtraDetails(String hotelId) =>
      _hotelsDataSource.fetchFullExtraDetails(hotelId);

  Future<String> fetchFeaturedImage(Hotel hotel) =>
      _hotelsDataSource.fetchFeaturedImage(hotel);
}
