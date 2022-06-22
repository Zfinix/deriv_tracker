import 'dart:async';

import 'package:deriv_api/deriv_api.dart';
import 'package:mockito/annotations.dart';

export 'deriv_repository.mocks.dart';


class DerivFailure implements Exception {}

@GenerateMocks([DerivRepository, DerivFailure])
class DerivRepository {
  DerivRepository({
    DerivApiClient? derivApiClient,
  }) : _derivApiClient = derivApiClient ?? DerivApiClient();

  final DerivApiClient _derivApiClient;

  Stream<BinaryActiveSymbolsModel> getActiveSymbols() =>
      _derivApiClient.getActiveSymbols();

  Stream<BinaryTickerModel> fetchTicksForSymbol(String symbol) =>
      _derivApiClient.fetchTicksForSymbol(symbol);

  void forgetAllTicks() => _derivApiClient.forgetAllTicks();

  void disconnect() => _derivApiClient.disconnect();
}
