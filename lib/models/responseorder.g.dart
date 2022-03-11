// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responseorder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseOrder _$OrderFromJson(Map<String, dynamic> json) => ResponseOrder(
    id: json['_id'] as String,
    user: json['user'] as String,
    item: json['product'] as String,
    quantity: json['quantity'] as String,
    totalPrice: json['totalPrice'] as String);

Map<String, dynamic> _$OrderToJson(ResponseOrder instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'item': instance.item,
      'quantity': instance.quantity,
      'totalPrice': instance.totalPrice,
    };
