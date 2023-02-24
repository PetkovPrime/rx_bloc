import 'package:flutter/cupertino.dart';
import 'package:flutter_rx_bloc/rx_form.dart';

import '../../base/extensions/rx_field_exception_extensions.dart';
import '../../feature_text_field_dialog/models/error_form_field_model.dart';
import '../../feature_text_field_dialog/models/error_form_field_server_model.dart';

class EditAddressErrorMapperUtil<T> {
  RxFieldException<T> cityErrorMapper(Object error, BuildContext context) {

    if (error is ErrorFormFieldModel) {
      throw RxFieldExceptionFatory.fromFormField<T>(error, context);
    }

    if (error is ErrorFormFieldServerModel<T>) {
      throw RxFieldExceptionFatory.fromServerErrorField<T>(error, context);
    }

    if (error is RxFieldException) {
      throw error.translate(context);
    }
    throw error;
  }

  RxFieldException<T> addressErrorMapper(Object error, BuildContext context) {
    if (error is ErrorFormFieldModel) {
      throw RxFieldExceptionFatory.fromFormField<T>(error, context);
    }

    if (error is ErrorFormFieldServerModel<T>) {
      throw RxFieldExceptionFatory.fromServerErrorField<T>(error, context);
    }

    if (error is RxFieldException) {
      throw error.translate(context);
    }
    throw error;
  }
}
