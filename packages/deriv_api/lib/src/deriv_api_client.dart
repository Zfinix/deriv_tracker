import 'dart:async';
import 'dart:convert';

import 'package:deriv_api/src/models/models.dart';
import 'package:mockito/annotations.dart';
import 'package:web_socket_channel/io.dart' as ws;
import 'package:web_socket_channel/web_socket_channel.dart';

export 'deriv_api_client.mocks.dart';

/// Exception thrown when request fails.
class DerivRequestFailure implements Exception {}

/// Exception thrown when no deriv is found.
class DerivNotFoundFailure implements Exception {}

/// {@template deriv_api_client}
/// Dart Websocket Client which wraps the [Deriv API](https://developers.binary.com/api).
/// {@endtemplate}
@GenerateMocks([
  DerivApiClient,
  ws.IOWebSocketChannel,
  WebSocketSink,
  Stream,
])
class DerivApiClient {
  /// {@macro deriv_api_client}
  DerivApiClient({
    ws.IOWebSocketChannel? activeSymbolsChannel,
    ws.IOWebSocketChannel? tickerChannel,
    Object url = _baseUrl,
  })  : _activeSymbolsChannel =
            activeSymbolsChannel ?? ws.IOWebSocketChannel.connect(url),
        _tickerChannel = tickerChannel ?? ws.IOWebSocketChannel.connect(url);

  static const _baseUrl =
      'wss://frontend.binaryws.com/websockets/v3?l=EN&app_id=1089&brand=binary';

  final ws.IOWebSocketChannel _tickerChannel;
  final ws.IOWebSocketChannel _activeSymbolsChannel;

  /// Close all active streams
  void disconnect() {
    _activeSymbolsChannel.sink.close();
    _tickerChannel.sink.close();
  }

  /// Throw `DerivRequestFailure` on Error
  void onError() {
    _activeSymbolsChannel.stream.handleError(
      (error) => throw DerivRequestFailure(),
    );
    _tickerChannel.stream.handleError(
      (error) => throw DerivRequestFailure(),
    );
  }

  /// Fetches all active symbols into [BinaryActiveSymbolsModel]
  Stream<BinaryActiveSymbolsModel> getActiveSymbols() {
    final activeSymbolsRequest = json.encode(
      {
        'active_symbols': 'brief',
        'product_type': 'basic',
      },
    );

    _activeSymbolsChannel.sink.add(activeSymbolsRequest);

    return _activeSymbolsChannel.stream
        .map((event) => BinaryActiveSymbolsModel.fromJson(event));
  }

  /// Fetches all ticks for `symbol` into [BinaryTickerModel]
  Stream<BinaryTickerModel> fetchTicksForSymbol(String symbol) {
    final fetchTicksRequest = json.encode({'ticks': symbol});

    _tickerChannel.sink.add(fetchTicksRequest);

    return _tickerChannel.stream
        .map((event) => BinaryTickerModel.fromJson(event));
  }

  /// Cancels all subscriptions to `fetchTicksForSymbol()`
  void forgetAllTicks() {
    final forgetAllTicksRequest = json.encode({'forget_all': 'ticks'});
    _tickerChannel.sink.add(forgetAllTicksRequest);
  }
}
