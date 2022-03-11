import 'package:json_annotation/json_annotation.dart';
import 'package:shop_app/models/responseorder.dart';

import '../models/item.dart';

part 'getorder_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseGetOrder {
  final bool success;

  final List<ResponseOrder> data;

  ResponseGetOrder({
    required this.success,
    required this.data,
  });

  factory ResponseGetOrder.fromJson(Map<String, dynamic> obj) =>
      _$ResponseGetOrderFromJson(obj);

  Map<String, dynamic> toJson() => _$ResponseGetOrderToJson(this);
}
