import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String description;
  final String quantity;
  final String price;
  final String image;

  Item(
      {required this.id,
      required this.name,
      required this.description,
      required this.quantity,
      required this.price,
      required this.image});

  factory Item.fromJson(Map<String, dynamic> obj) => _$ItemFromJson(obj);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
