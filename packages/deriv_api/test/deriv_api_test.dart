// ignore_for_file: depend_on_referenced_packages
import 'dart:async';

import 'package:deriv_api/deriv_api.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  group('DerivApiClient', () {
    final derivApiClient = MockDerivApiClient();
    group('constructor', () {
      test('does not require any channels', () {
        expect(DerivApiClient(), isNotNull);
      });
    });

    group('getDerivs', () {
      test('makes correct ws request', () async {
        final stream = MockStream();
        when(stream.first).thenAnswer((_) => Future.value(7));
        expect(await stream.first, 7);
      });

      test(
        'returns BinaryActiveSymbolsModel from .getActiveSymbols()',
        () async {
          when(derivApiClient.getActiveSymbols()).thenAnswer(
            (_) => Stream.fromFuture(
              Future.value(
                BinaryActiveSymbolsModel.fromMap({
                  'active_symbols': [
                    {
                      'allow_forward_starting': 0,
                      'display_name': 'AUD Basket',
                      'exchange_is_open': 1,
                      'is_trading_suspended': 0,
                      'market': 'basket_index',
                      'market_display_name': 'Basket Indices',
                      'pip': 0.001,
                      'submarket': 'forex_basket',
                      'submarket_display_name': 'Forex Basket',
                      'symbol': 'WLDAUD',
                      'symbol_type': 'forex_basket'
                    }
                  ],
                  'echo_req': {
                    'active_symbols': 'brief',
                    'product_type': 'basic'
                  },
                  'msg_type': 'active_symbols'
                }),
              ),
            ),
          );
          // when(() => tickerChannel.stream.map).thenAnswer((_) => .map((event) => null));
          final actual = await derivApiClient.getActiveSymbols().first;
          expect(
            actual,
            isA<BinaryActiveSymbolsModel>()
                .having(
              (w) => w.echoReq,
              'echoReq',
              isA<ActiveSymbolEchoReq>()
                  .having((t) => t.activeSymbols, 'activeSymbols', 'brief')
                  .having(
                    (t) => t.productType,
                    'productType',
                    'basic',
                  ),
            )
                .having(
              (w) => w.activeSymbols,
              'activeSymbols',
              [
                isA<ActiveSymbol>()
                    .having((t) => t.pip, 'pip', 0.001)
                    .having((t) => t.symbol, 'symbol', 'WLDAUD')
                    .having((t) => t.market, 'market', 'basket_index')
                    .having((t) => t.symbolType, 'symbolType', 'forex_basket')
                    .having((t) => t.marketDisplayName, 'marketDisplayName',
                        'Basket Indices')
                    .having((t) => t.displayName, 'displayName', 'AUD Basket'),
              ],
            ),
          );
        },
      );

      test('returns BinaryTickerModel from .fetchTicksForSymbol()', () async {
        when(derivApiClient.fetchTicksForSymbol(any)).thenAnswer(
          (_) => Stream.fromFuture(
            Future.value(
              BinaryTickerModel.fromMap({
                'echo_req': {'subscribe': 1, 'ticks': 'R_50'},
                'msg_type': 'tick',
                'subscription': {'id': 'c3327742-e461-1441-00f4-3cd4cda938bb'},
                'tick': {
                  'ask': 195.7823,
                  'bid': 195.7623,
                  'epoch': 1655913864,
                  'id': 'c3327742-e461-1441-00f4-3cd4cda938bb',
                  'pip_size': 4,
                  'quote': 195.7723,
                  'symbol': 'R_50'
                }
              }),
            ),
          ),
        );
        // when(() => tickerChannel.stream.map).thenAnswer((_) => .map((event) => null));
        final actual = await derivApiClient.fetchTicksForSymbol('R_50').first;
        expect(
          actual,
          isA<BinaryTickerModel>()
              .having((w) => w.msgType, 'msgType', 'tick')
              .having(
                (w) => w.echoReq,
                'echoReq',
                isA<BinaryTickerEchoReq>()
                    .having((t) => t.subscribe, 'subscribe', 1)
                    .having((t) => t.ticks, 'ticks', 'R_50'),
              )
              .having(
                (w) => w.subscription,
                'subscription',
                isA<Subscription>().having(
                  (t) => t.id,
                  'id',
                  'c3327742-e461-1441-00f4-3cd4cda938bb',
                ),
              )
              .having(
                (w) => w.tick,
                'tick',
                isA<Tick>()
                    .having((t) => t.ask, 'ask', 195.7823)
                    .having((t) => t.bid, 'bid', 195.7623)
                    .having((t) => t.epoch, 'epoch', 1655913864)
                    .having((t) => t.id, 'id',
                        'c3327742-e461-1441-00f4-3cd4cda938bb')
                    .having((t) => t.pipSize, 'pipSize', 4)
                    .having((t) => t.quote, 'quote', 195.7723)
                    .having(
                      (t) => t.symbol,
                      'symbol',
                      'R_50',
                    ),
              ),
        );
      });
    });
  });
}
