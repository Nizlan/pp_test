// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyDto _$CurrencyDtoFromJson(Map<String, dynamic> json) => CurrencyDto(
  id: json['id'] as String,
  symbol: json['symbol'] as String,
  currencySymbol: json['currencySymbol'] as String?,
  type: json['type'] as String,
  rateUsd: json['rateUsd'] as String,
);

Map<String, dynamic> _$CurrencyDtoToJson(CurrencyDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'currencySymbol': instance.currencySymbol,
      'type': instance.type,
      'rateUsd': instance.rateUsd,
    };
