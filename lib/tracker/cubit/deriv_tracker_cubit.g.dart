// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deriv_tracker_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DerivTrackerState _$DerivTrackerStateFromJson(Map<String, dynamic> json) =>
    DerivTrackerState(
      status:
          $enumDecodeNullable(_$DerivTrackerStatusEnumMap, json['status']) ??
              DerivTrackerStatus.initial,
      activeSymbols: (json['activeSymbols'] as List<dynamic>?)
              ?.map((e) => ActiveSymbol.fromJson(e as String))
              .toList() ??
          const [],
      binaryTickerModel: json['binaryTickerModel'] == null
          ? BinaryTickerModel.empty
          : BinaryTickerModel.fromJson(json['binaryTickerModel'] as String),
      selectedSymbol: json['selectedSymbol'] == null
          ? null
          : ActiveSymbol.fromJson(json['selectedSymbol'] as String),
    );

Map<String, dynamic> _$DerivTrackerStateToJson(DerivTrackerState instance) =>
    <String, dynamic>{
      'status': _$DerivTrackerStatusEnumMap[instance.status],
      'selectedSymbol': instance.selectedSymbol,
      'binaryTickerModel': instance.binaryTickerModel,
      'activeSymbols': instance.activeSymbols,
    };

const _$DerivTrackerStatusEnumMap = {
  DerivTrackerStatus.initial: 'initial',
  DerivTrackerStatus.loading: 'loading',
  DerivTrackerStatus.success: 'success',
  DerivTrackerStatus.failure: 'failure',
};
