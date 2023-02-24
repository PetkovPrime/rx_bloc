import 'package:prime_ui_toolkit/edit_address.dart';

/// Implementation of the Contact address page's save button logic
class SaveAddressService extends EditAddressService {
  SaveAddressService({required this.showError});

  final bool showError;

  @override
  Future<AddressModel> saveAddress(AddressModel addressModel) async {
    await Future.delayed(const Duration(seconds: 1));
    if (showError) {
      throw Exception('Could not save the address');
    } else {
      return addressModel;
    }
  }
}
