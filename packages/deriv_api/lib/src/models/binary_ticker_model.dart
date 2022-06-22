import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mockito/annotations.dart';

export 'binary_ticker_model.mocks.dart';

@GenerateMocks([BinaryTickerModel, BinaryTickerEchoReq, Subscription, Tick])
class BinaryTickerModel with EquatableMixin {
  final BinaryTickerEchoReq echoReq;
  final String msgType;
  final Subscription subscription;
  final Tick tick;
  const BinaryTickerModel({
    required this.echoReq,
    required this.msgType,
    required this.subscription,
    required this.tick,
  });

  BinaryTickerModel copyWith({
    BinaryTickerEchoReq? echoReq,
    String? msgType,
    Subscription? subscription,
    Tick? tick,
  }) {
    return BinaryTickerModel(
      echoReq: echoReq ?? this.echoReq,
      msgType: msgType ?? this.msgType,
      subscription: subscription ?? this.subscription,
      tick: tick ?? this.tick,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'echo_req': echoReq.toMap(),
      'msg_type': msgType,
      'subscription': subscription.toMap(),
      'tick': tick.toMap(),
    };
  }

  static const empty = BinaryTickerModel(
    echoReq: BinaryTickerEchoReq.empty,
    msgType: '',
    subscription: Subscription.empty,
    tick: Tick.empty,
  );

  factory BinaryTickerModel.fromMap(Map<String, dynamic> map) {
    return BinaryTickerModel(
      echoReq: BinaryTickerEchoReq.fromMap(map['echo_req']),
      msgType: map['msg_type'] ?? '',
      subscription: Subscription.fromMap(map['subscription']),
      tick: Tick.fromMap(map['tick']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BinaryTickerModel.fromJson(String source) =>
      BinaryTickerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BinaryTickerModel(echo_req: $echoReq, msg_type: $msgType, subscription: $subscription, tick: $tick)';
  }

  @override
  List<Object> get props => [echoReq, msgType, subscription, tick];
}

class BinaryTickerEchoReq with EquatableMixin {
  final int subscribe;
  final String ticks;
  const BinaryTickerEchoReq({
    required this.subscribe,
    required this.ticks,
  });

  BinaryTickerEchoReq copyWith({
    int? subscribe,
    String? ticks,
  }) {
    return BinaryTickerEchoReq(
      subscribe: subscribe ?? this.subscribe,
      ticks: ticks ?? this.ticks,
    );
  }

  static const empty = BinaryTickerEchoReq(
    subscribe: 0,
    ticks: '',
  );

  Map<String, dynamic> toMap() {
    return {
      'subscribe': subscribe,
      'ticks': ticks,
    };
  }

  factory BinaryTickerEchoReq.fromMap(Map<String, dynamic> map) {
    return BinaryTickerEchoReq(
      subscribe: map['subscribe'] ?? 0,
      ticks: map['ticks'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BinaryTickerEchoReq.fromJson(String source) =>
      BinaryTickerEchoReq.fromMap(json.decode(source));

  @override
  String toString() => 'Echo_req(subscribe: $subscribe, ticks: $ticks)';

  @override
  List<Object> get props => [subscribe, ticks];
}

class Subscription with EquatableMixin {
  final String id;
  const Subscription({
    required this.id,
  });

  Subscription copyWith({
    String? id,
  }) {
    return Subscription(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  static const empty = Subscription(id: '');

  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Subscription.fromJson(String source) =>
      Subscription.fromMap(json.decode(source));

  @override
  String toString() => 'Subscription(id: $id)';

  @override
  List<Object> get props => [id];
}

class Tick with EquatableMixin {
  final double ask;
  final double bid;
  final int epoch;
  final String id;
  final int pipSize;
  final double quote;
  final String symbol;

  const Tick({
    required this.ask,
    required this.bid,
    required this.epoch,
    required this.id,
    required this.pipSize,
    required this.quote,
    required this.symbol,
  });

  Tick copyWith({
    double? ask,
    double? bid,
    int? epoch,
    String? id,
    int? pipSize,
    double? quote,
    String? symbol,
  }) {
    return Tick(
      ask: ask ?? this.ask,
      bid: bid ?? this.bid,
      epoch: epoch ?? this.epoch,
      id: id ?? this.id,
      pipSize: pipSize ?? this.pipSize,
      quote: quote ?? this.quote,
      symbol: symbol ?? this.symbol,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ask': ask,
      'bid': bid,
      'epoch': epoch,
      'id': id,
      'pip_size': pipSize,
      'quote': quote,
      'symbol': symbol,
    };
  }

  factory Tick.fromMap(Map<String, dynamic> map) {
    return Tick(
      ask: map['ask'] ?? 0.0,
      bid: map['bid'] ?? 0.0,
      epoch: map['epoch'] ?? 0,
      id: map['id'] ?? '',
      pipSize: map['pip_size'] ?? 0,
      quote: map['quote'] ?? 0.0,
      symbol: map['symbol'] ?? '',
    );
  }

  static const empty = Tick(
    ask: 0.0,
    bid: 0.0,
    epoch: 0,
    id: '',
    pipSize: 0,
    quote: 0.0,
    symbol: '',
  );

  String toJson() => json.encode(toMap());

  factory Tick.fromJson(String source) => Tick.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tick(ask: $ask, bid: $bid, epoch: $epoch, id: $id, pip_size: $pipSize, quote: $quote, symbol: $symbol)';
  }

  @override
  List<Object> get props {
    return [
      ask,
      bid,
      epoch,
      id,
      pipSize,
      quote,
      symbol,
    ];
  }
}
