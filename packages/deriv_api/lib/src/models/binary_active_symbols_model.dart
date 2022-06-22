import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mockito/annotations.dart';

export 'binary_active_symbols_model.mocks.dart';

@GenerateMocks([BinaryActiveSymbolsModel, ActiveSymbol, ActiveSymbolEchoReq])
class BinaryActiveSymbolsModel with EquatableMixin {
  final List<ActiveSymbol> activeSymbols;
  final ActiveSymbolEchoReq echoReq;
  final String msgType;
  const BinaryActiveSymbolsModel({
    required this.activeSymbols,
    required this.echoReq,
    required this.msgType,
  });

  BinaryActiveSymbolsModel copyWith({
    List<ActiveSymbol>? activeSymbols,
    ActiveSymbolEchoReq? echoReq,
    String? msgType,
  }) {
    return BinaryActiveSymbolsModel(
      activeSymbols: activeSymbols ?? this.activeSymbols,
      echoReq: echoReq ?? this.echoReq,
      msgType: msgType ?? this.msgType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'active_symbols': activeSymbols.map((x) => x.toMap()).toList(),
      'echo_req': echoReq.toMap(),
      'msg_type': msgType,
    };
  }

  static const empty = BinaryActiveSymbolsModel(
    activeSymbols: [],
    echoReq: ActiveSymbolEchoReq.empty,
    msgType: '',
  );

  factory BinaryActiveSymbolsModel.fromMap(Map<String, dynamic> map) {
    return BinaryActiveSymbolsModel(
      activeSymbols: List<ActiveSymbol>.from(
          map['active_symbols']?.map((x) => ActiveSymbol.fromMap(x))),
      echoReq: ActiveSymbolEchoReq.fromMap(map['echo_req']),
      msgType: map['msg_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BinaryActiveSymbolsModel.fromJson(String source) =>
      BinaryActiveSymbolsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ActiveSymbolsModel(active_symbols: $activeSymbols, echo_req: $echoReq, msg_type: $msgType)';

  @override
  List<Object> get props => [activeSymbols, echoReq, msgType];
}

class ActiveSymbol with EquatableMixin {
  final int allowForwardStarting;
  final String displayName;
  final int exchangeIsOpen;
  final int isTradingSuspended;
  final String market;
  final String marketDisplayName;
  final double pip;
  final String submarket;
  final String submarketDisplayName;
  final String symbol;
  final String symbolType;

  const ActiveSymbol({
    required this.allowForwardStarting,
    required this.displayName,
    required this.exchangeIsOpen,
    required this.isTradingSuspended,
    required this.market,
    required this.marketDisplayName,
    required this.pip,
    required this.submarket,
    required this.submarketDisplayName,
    required this.symbol,
    required this.symbolType,
  });

  ActiveSymbol copyWith({
    int? allowForwardStarting,
    String? displayName,
    int? exchangeIsOpen,
    int? isTradingSuspended,
    String? market,
    String? marketDisplayName,
    double? pip,
    String? submarket,
    String? submarketDisplayName,
    String? symbol,
    String? symbolType,
  }) {
    return ActiveSymbol(
      allowForwardStarting: allowForwardStarting ?? this.allowForwardStarting,
      displayName: displayName ?? this.displayName,
      exchangeIsOpen: exchangeIsOpen ?? this.exchangeIsOpen,
      isTradingSuspended: isTradingSuspended ?? this.isTradingSuspended,
      market: market ?? this.market,
      marketDisplayName: marketDisplayName ?? this.marketDisplayName,
      pip: pip ?? this.pip,
      submarket: submarket ?? this.submarket,
      submarketDisplayName: submarketDisplayName ?? this.submarketDisplayName,
      symbol: symbol ?? this.symbol,
      symbolType: symbolType ?? this.symbolType,
    );
  }

  static const empty = ActiveSymbol(
    allowForwardStarting: 0,
    displayName: '',
    exchangeIsOpen: 0,
    isTradingSuspended: 0,
    market: '',
    marketDisplayName: '',
    pip: 0.0,
    submarket: '',
    submarketDisplayName: '',
    symbol: '',
    symbolType: '',
  );

  Map<String, dynamic> toMap() {
    return {
      'allow_forward_starting': allowForwardStarting,
      'display_name': displayName,
      'exchange_is_open': exchangeIsOpen,
      'is_trading_suspended': isTradingSuspended,
      'market': market,
      'market_display_name': marketDisplayName,
      'pip': pip,
      'submarket': submarket,
      'submarket_display_name': submarketDisplayName,
      'symbol': symbol,
      'symbol_type': symbolType,
    };
  }

  factory ActiveSymbol.fromMap(Map<String, dynamic> map) {
    return ActiveSymbol(
      allowForwardStarting: map['allow_forward_starting'] ?? 0,
      displayName: map['display_name'] ?? '',
      exchangeIsOpen: map['exchange_is_open'] ?? 0,
      isTradingSuspended: map['is_trading_suspended'] ?? 0,
      market: map['market'] ?? '',
      marketDisplayName: map['market_display_name'] ?? '',
      pip: map['pip'] ?? 0.0,
      submarket: map['submarket'] ?? '',
      submarketDisplayName: map['submarket_display_name'] ?? '',
      symbol: map['symbol'] ?? '',
      symbolType: map['symbol_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ActiveSymbol.fromJson(String source) =>
      ActiveSymbol.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ActiveSymbol(allow_forward_starting: $allowForwardStarting, display_name: $displayName, exchange_is_open: $exchangeIsOpen, is_trading_suspended: $isTradingSuspended, market: $market, market_display_name: $marketDisplayName, pip: $pip, submarket: $submarket, submarket_display_name: $submarketDisplayName, symbol: $symbol, symbol_type: $symbolType)';
  }

  @override
  List<Object> get props {
    return [
      allowForwardStarting,
      displayName,
      exchangeIsOpen,
      isTradingSuspended,
      market,
      marketDisplayName,
      pip,
      submarket,
      submarketDisplayName,
      symbol,
      symbolType,
    ];
  }
}

class ActiveSymbolEchoReq with EquatableMixin {
  final String activeSymbols;
  final String productType;
  const ActiveSymbolEchoReq({
    required this.activeSymbols,
    required this.productType,
  });

  ActiveSymbolEchoReq copyWith({
    String? activeSymbols,
    String? productType,
  }) {
    return ActiveSymbolEchoReq(
      activeSymbols: activeSymbols ?? this.activeSymbols,
      productType: productType ?? this.productType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'active_symbols': activeSymbols,
      'product_type': productType,
    };
  }

  static const empty = ActiveSymbolEchoReq(
    activeSymbols: '',
    productType: '',
  );

  factory ActiveSymbolEchoReq.fromMap(Map<String, dynamic> map) {
    return ActiveSymbolEchoReq(
      activeSymbols: map['active_symbols'] ?? '',
      productType: map['product_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ActiveSymbolEchoReq.fromJson(String source) =>
      ActiveSymbolEchoReq.fromMap(json.decode(source));

  @override
  String toString() =>
      'ActiveSymbolEchoReq(active_symbols: $activeSymbols, product_type: $productType)';

  @override
  List<Object> get props => [activeSymbols, productType];
}
