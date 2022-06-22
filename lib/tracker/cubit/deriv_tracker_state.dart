part of 'deriv_tracker_cubit.dart';

enum DerivTrackerStatus { initial, loading, success, failure }

extension DerivStatusX on DerivTrackerStatus {
  bool get isInitial => this == DerivTrackerStatus.initial;
  bool get isLoading => this == DerivTrackerStatus.loading;
  bool get isSuccess => this == DerivTrackerStatus.success;
  bool get isFailure => this == DerivTrackerStatus.failure;
}

@JsonSerializable()
class DerivTrackerState extends Equatable {
  const DerivTrackerState({
    this.status = DerivTrackerStatus.initial,
    this.activeSymbols = const [],
    this.binaryTickerModel = BinaryTickerModel.empty,
    this.selectedSymbol,
  });

  factory DerivTrackerState.fromJson(Map<String, dynamic> json) =>
      _$DerivTrackerStateFromJson(json);

  final DerivTrackerStatus status;
  final ActiveSymbol? selectedSymbol;
  final BinaryTickerModel binaryTickerModel;
  final List<ActiveSymbol> activeSymbols;

  Map<String, dynamic> toJson() => _$DerivTrackerStateToJson(this);

  DerivTrackerState copyWith({
    DerivTrackerStatus? status,
    ActiveSymbol? selectedSymbol,
    BinaryTickerModel? binaryTickerModel,
    List<ActiveSymbol>? activeSymbols,
  }) {
    return DerivTrackerState(
      status: status ?? this.status,
      selectedSymbol: selectedSymbol ?? this.selectedSymbol,
      binaryTickerModel: binaryTickerModel ?? this.binaryTickerModel,
      activeSymbols: activeSymbols ?? this.activeSymbols,
    );
  }

  @override
  List<Object?> get props => [
        status,
        activeSymbols,
        binaryTickerModel,
        selectedSymbol,
      ];
}
