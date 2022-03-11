// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getorder_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGetOrder _$ResponseGetOrderFromJson(Map<String, dynamic> json) =>
    ResponseGetOrder(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => ResponseOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseGetOrderToJson(ResponseGetOrder instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
