import 'package:prime_ui_toolkit/edit_address.dart';
import 'package:prime_ui_toolkit/search_picker.dart';

import '../repository/search_country_repository.dart';

/// Provides logic for the country search picker
class SearchCountryService implements SearchPickerService<CountryModel> {
  SearchCountryService(this._searchRepository, this.showError);

  final SearchCountryRepository _searchRepository;
  final bool showError;

  @override
  Future<List<CountryModel>> filteredListByName(
      List<CountryModel> list, String? searchParam) async {
    if (searchParam == null) {
      return list;
    }

    return list
        .where((item) => (item.countryName)
            .toLowerCase()
            .contains(searchParam.toLowerCase()))
        .toList();
  }

  @override
  Future<List<CountryModel>> getItems() async =>
      showError ? throw Exception() : await _searchRepository.searchList;

  @override
  List<CountryModel> getPlaceholderList() =>
      List.generate(5, (index) => CountryModel.empty());
}
