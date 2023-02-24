import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../models.dart';

part 'country_model.g.dart';

@JsonSerializable()
@CopyWith()
class CountryModel with EquatableMixin implements PickerItemModel {
  CountryModel({
    required this.countryCode,
    required this.countryName,
  });

  final String countryCode;

  final String countryName;

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  factory CountryModel.withDefaults() =>
      CountryModel(countryName: 'Bulgaria', countryCode: 'BG');

  factory CountryModel.empty() => CountryModel(
        countryName: '',
        countryCode: '',
      );

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [countryName, countryCode];

  @override
  String? get itemDisplayName => countryName;
}
