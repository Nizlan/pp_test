import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/currency.dart';

part 'currency_dto.g.dart';

@JsonSerializable()
class CurrencyDto extends Currency {
  CurrencyDto({
    required super.id,
    required super.symbol,
    required super.currencySymbol,
    required super.type,
    required super.rateUsd,
  });

  factory CurrencyDto.fromJson(Map<String, dynamic> json) =>
      _$CurrencyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyDtoToJson(this);

  CurrencyDto copyWith({String? rateUsd}) => CurrencyDto(
    id: id,
    symbol: symbol,
    currencySymbol: currencySymbol,
    type: type,
    rateUsd: rateUsd ?? this.rateUsd,
  );
}
