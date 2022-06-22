// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:deriv_repository/deriv_repository.dart';

part 'deriv_tracker_cubit.g.dart';
part 'deriv_tracker_state.dart';

class DerivTrackerCubit extends Cubit<DerivTrackerState> {
  DerivTrackerCubit(this.derivRepository) : super(const DerivTrackerState());

  final DerivRepository derivRepository;

  void listen() async {
    try {
      emit(
        state.copyWith(
          status: DerivTrackerStatus.loading,
        ),
      );

      derivRepository.getActiveSymbols().listen(
            (event) => emit(state.copyWith(
              activeSymbols: event.activeSymbols,
              status: DerivTrackerStatus.success,
            )),
          );
    } catch (e) {
      emit(state.copyWith(status: DerivTrackerStatus.failure));
    }
  }

  /// Fetch ticks for selected `ActiveSymbol`
  void updateSelectedSymbol(ActiveSymbol selectedSymbol) async {
    emit(
      state.copyWith(
        status: DerivTrackerStatus.loading,
        selectedSymbol: selectedSymbol,
      ),
    );

    derivRepository
      ..forgetAllTicks()
      ..fetchTicksForSymbol(selectedSymbol.symbol).listen(
        (event) => emit(
          state.copyWith(
            binaryTickerModel: event,
            status: DerivTrackerStatus.success,
          ),
        ),
      );
  }

  DerivTrackerState fromJson(Map<String, dynamic> json) =>
      DerivTrackerState.fromJson(json);

  Map<String, dynamic> toJson(DerivTrackerState state) => state.toJson();
}
