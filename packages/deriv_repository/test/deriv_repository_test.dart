// ignore_for_file: prefer_const_constructors
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:deriv_repository/deriv_repository.dart';

void main() {
  group('DerivRepository', () {
    final derivApiClient = MockDerivApiClient();
    late DerivRepository derivRepository;
    setUpAll(() {
      derivRepository = DerivRepository(derivApiClient: derivApiClient);
    });

    group('constructor', () {
      test('instantiates internal DerivApiClient when not injected', () {
        expect(DerivRepository(), isNotNull);
      });
    });

    group('getActiveSymbols', () {
      test('calls .getActiveSymbols()', () async {
        try {
          await derivRepository.getActiveSymbols();
        } catch (_) {}
        verify(derivApiClient.getActiveSymbols()).called(1);
      });

      test('returns correct data on success', () async {
        final model = MockBinaryTickerModel();

        var epoch = 1655913864;

        when(model.tick).thenReturn(
          Tick.fromMap({
            'ask': 195.7823,
            'bid': 195.7623,
            'epoch': epoch,
            'id': 'c3327742-e461-1441-00f4-3cd4cda938bb',
            'pip_size': 4,
            'quote': 195.7723,
            'symbol': 'R_50'
          }),
        );

        when((await derivApiClient.fetchTicksForSymbol(any))).thenAnswer(
          (_) => Stream.fromIterable([model]),
        );

        final actual = await derivRepository.fetchTicksForSymbol('R_50').first;

        expect(
          actual.tick,
          Tick(
            ask: 195.7823,
            bid: 195.7623,
            epoch: epoch,
            pipSize: 4,
            quote: 195.7723,
            symbol: 'R_50',
            id: 'c3327742-e461-1441-00f4-3cd4cda938bb',
          ),
        );
      });
    });

    group('fetchTicksForSymbol', () {
      test('calls .fetchTicksForSymbol()', () async {
        try {
          await derivRepository.fetchTicksForSymbol('');
        } catch (_) {}
        verify(derivApiClient.fetchTicksForSymbol('')).called(1);
      });

      test('returns correct data on success', () async {
        final model = MockBinaryActiveSymbolsModel();

        var pip = 102.32;

        when(model.activeSymbols).thenReturn([
          ActiveSymbol.fromMap(
            {
              "allow_forward_starting": 0,
              "display_name": "AUD Basket",
              "exchange_is_open": 1,
              "is_trading_suspended": 0,
              "market": "basket_index",
              "market_display_name": "Basket Indices",
              "pip": pip,
              "submarket": "forex_basket",
              "submarket_display_name": "Forex Basket",
              "symbol": "WLDAUD",
              "symbol_type": "forex_basket"
            },
          )
        ]);

        when((await derivApiClient.getActiveSymbols())).thenAnswer(
          (_) => Stream.fromIterable([model]),
        );

        final actual = await derivRepository.getActiveSymbols().first;

        expect(
          actual.activeSymbols,
          [
            ActiveSymbol(
              allowForwardStarting: 0,
              displayName: "AUD Basket",
              exchangeIsOpen: 1,
              isTradingSuspended: 0,
              market: "basket_index",
              marketDisplayName: "Basket Indices",
              pip: pip,
              submarket: "forex_basket",
              submarketDisplayName: "Forex Basket",
              symbol: "WLDAUD",
              symbolType: "forex_basket",
            )
          ],
        );
      });
    });

    group('forgetAllTicks', () {
      test('calls .forgetAllTicks()', () async {
        try {
          derivRepository.forgetAllTicks();
        } catch (_) {}
        verify(derivApiClient.forgetAllTicks()).called(1);
      });
    });

    group('disconnect', () {
      test('calls .disconnect()', () async {
        try {
          derivRepository.disconnect();
        } catch (_) {}
        verify(derivApiClient.disconnect()).called(1);
      });
    });
  });
}
