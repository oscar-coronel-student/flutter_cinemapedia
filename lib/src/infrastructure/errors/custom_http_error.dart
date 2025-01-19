import 'dart:convert';

import 'package:cinemapedia/src/config/constants/http_entities.dart';
import 'package:cinemapedia/src/config/constants/http_methods.dart';


class CustomHttpError {

  final HttpEntities entity;
  final HttpMethods method;
  final String datasource;
  final String message;

  final String? uri;
  final dynamic bodyData;
  final Map<String, dynamic>? headers;

  CustomHttpError({
    required this.entity,
    required this.method,
    required this.datasource,
    required this.message,
    this.uri,
    this.bodyData,
    this.headers
  });

  Map<String, dynamic> _toMap(){
    return {
      'entity': entityValues[entity],
      'method': methodValues[method],
      'datasource': datasource,
      'message': message,
      'uri': uri,
      'bodyData': bodyData is Map ? json.encode(bodyData) : bodyData,
      'headers': json.encode(headers)
    };
  }

  @override
  String toString() {
    return json.encode(_toMap());
  }

}