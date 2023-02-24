import 'package:flutter/material.dart';

import '../app_extensions.dart';
import 'lib_edit_address/models/address_model.dart';
import 'lib_edit_address/models/address_type_model.dart';
import 'lib_edit_address/models/country_model.dart';
import 'lib_edit_address/models/user_profile_card_types.dart';
import 'lib_edit_address/ui_components/address_for_correspondence_bottom_sheet.dart';
import 'lib_edit_address/ui_components/edit_address_widget.dart';

///TODO add license
class EditAddressBrickPage extends StatelessWidget implements AutoRouteWrapper {
  const EditAddressBrickPage({super.key});

  static const _permanentAddress =
      'This is your permanent address content message. \nTo change the address,'
      ' you must set Show read only address to false.';

  @override
  Widget wrappedRoute(BuildContext context) => this;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(context),
        body:  Center(
          child: Column(
            children: [
              Text('Edit Address Page'),
              EditAddressWidget<CountryModel>(
                cardFieldLabel: 'Contact Address',
                buttonText:'Save',
                headerText: 'Contact Address',
                permanentAddressContentMessage:_permanentAddress,
                addressModel: AddressModel(
                  addressType: AddressTypeModel.correspondence,
                  city: 'Plovd',
                  streetAddress: 'str1',
                  country: CountryModel.withDefaults(),
                ),
                type:  UserProfileCardTypes.mailingAddress,
                cityErrorMapper: (obj, context) =>
                    EditAddressErrorMapperUtil<String>()
                        .cityErrorMapper(obj, context),
                addressErrorMapper: (obj, context) =>
                    EditAddressErrorMapperUtil<String>()
                        .addressErrorMapper(obj, context),
                validator: context.read<EditAddressFieldsService>(),
                searchCountryService: SearchCountryService(
                  SearchCountryRepository(),
                  _buildSearchPickerShowError(context),
                ),
                countryCityAddressStrings: CountryCityAddressStrings(
                  countrySearchPickerTitle:
                  _buildCountrySearchPickerTitleText(context),
                  countrySearchPickerHintText: _buildCountryHintText(context),
                  countrySearchPickerRetryText:
                  _buildCountryRetryButtonText(context),
                  countryLabelText: _buildCountryLabelText(context),
                  cityButtonText: _buildCityButtonText(context),
                  cityLabelText: _buildCityLabelText(context),
                  cityEmptyLabel: context.l10n.editAddress.addCity,
                  addressButtonText: _buildAddressButtonText(context),
                  addressLabelText: _buildAddressLabelText(context),
                  addressEmptyLabel: context.l10n.editAddress.addAddress,
                  addressChangedMessage: _buildAddressChangedMessage(context),
                ),
                editAddressService: SaveAddressService(
                    showError: _buildSaveContactAddressShowError(context)),
              )
            ],
          ),
        ),
      );

  AppBar _buildAppBar(BuildContext context) => AppBar(
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      );
}
