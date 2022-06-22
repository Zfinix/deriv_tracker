// ignore_for_file: depend_on_referenced_packages

import 'package:deriv_api/deriv_api.dart';
import 'package:test/test.dart';

void main() {
  var model = BinaryTickerModel(
    echoReq: BinaryTickerEchoReq(
      subscribe: 12,
      ticks: 'ticks-2923',
    ),
    msgType: 'msgType',
    subscription: Subscription(id: 'id-023'),
    tick: Tick(
      ask: 0.234,
      bid: 0.235,
      epoch: 1,
      id: 'id',
      pipSize: 3,
      quote: 0.1242,
      symbol: 'symbol',
    ),
  );

  var tickerJson = <String, dynamic>{
    "echo_req": {"subscribe": 12, "ticks": "ticks-2923"},
    "msg_type": "msgType",
    "subscription": {"id": "id-023"},
    "tick": {
      "ask": 0.234,
      "bid": 0.235,
      "epoch": 1,
      "id": "id",
      "pip_size": 3,
      "quote": 0.1242,
      "symbol": "symbol"
    }
  };

  group('BinaryTickerModel', () {
    group('.toMap()', () {
      test('returns valid map', () {
        expect(
          model.toMap(),
          isA<Map<String, dynamic>>(),
        );
      });
    });
    group('.fromMap()', () {
      test('returns valid BinaryTickerModel Object', () {
        tickerJson['msgType'] = 'msgType';
        expect(
          BinaryTickerModel.fromMap(tickerJson),
          isA<BinaryTickerModel>(),
        );
      });
    });
  });

  group('BinaryActiveSymbolsModel', () {
    group('.toJson()', () {
      test('returns valid Json', () {
        Map<String, dynamic> derivModel =
            BinaryActiveSymbolsModel.empty.toMap();

        Map<String, dynamic> matcher = {
          'active_symbols': [],
          'echo_req': {'active_symbols': '', 'product_type': ''},
          'msg_type': ''
        };

        expect(
          derivModel,
          equals(matcher),
        );
      });
    });
  });
}
