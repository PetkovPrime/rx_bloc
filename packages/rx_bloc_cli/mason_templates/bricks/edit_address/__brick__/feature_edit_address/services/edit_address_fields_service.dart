import 'package:prime_ui_toolkit/prime_ui_toolkit.dart';

import '../../feature_text_field_dialog/models/long_field_error_model.dart';
import '../../feature_text_field_dialog/models/short_field_error_model.dart';

/// Provides validation for the input values of the city and address
class EditAddressFieldsService extends TextFieldValidator<String> {
  static const int minLengthRequired = 2;
  static const int maxLengthRequired = 6;

  @override
  Future<String> validateOnSubmit(String text) async {
    await Future.delayed(const Duration(seconds: 1));
    if (text.length >= maxLengthRequired) {
      await Future.delayed(const Duration(seconds: 1));

      throw LongFieldErrorModel<String>(
        maxLength: maxLengthRequired,
        fieldValue: text,
      );
    }
    return text;
  }

  @override
  void validateOnType(String text) {
    if (text.length < minLengthRequired) {
      throw ShortFieldErrorModel<String>(
        minimalLength: minLengthRequired,
        fieldValue: text,
      );
    }
  }
}
