// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
    id: json['_id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    quantity: json['quantity'] as String,
    price: json['price'] as String,
    image: json['image'] as String);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'quantity': instance.quantity,
      'price': instance.price,
      'image': instance.image,
    };
