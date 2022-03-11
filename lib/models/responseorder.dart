import 'package:json_annotation/json_annotation.dart';
import 'package:shop_app/models/item.dart';
import 'package:shop_app/models/user.dart';

part 'responseorder.g.dart';

@JsonSerializable()
class ResponseOrder {
  @JsonKey(name: '_id')
  final String id;
  final String user;
  final String item;
  final String quantity;
  final String totalPrice;

  ResponseOrder(
      {required this.id,
      required this.user,
      required this.item,
      required this.quantity,
      required this.totalPrice});

  factory ResponseOrder.fromJson(Map<String, dynamic> obj) =>
      _$OrderFromJson(obj);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
