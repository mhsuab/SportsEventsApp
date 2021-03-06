import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String domain = 'ifsc.results.info';
String getNationImage(String country) =>
    'https://ifsc.results.info/images/flags/$country.png';

Future<http.Response> get(Uri url, {Map<String, String>? headers}) => http.get(
      url,
      headers: {
        ...?headers,
        'referer': 'https://$domain',
      },
    );

Future<List<T>> getIfscData<T>(
    String url, String jsonKey, Function(Map<String, dynamic>) func) async {
  http.Response res = await get(
    Uri(scheme: 'https', host: domain, path: url),
    headers: {'Content-Type': 'application/json'},
  );
  if (res.statusCode == 200 || res.statusCode == 304) {
    var data = jsonDecode(res.body);
    debugPrint(data.toString());
    return data[jsonKey].map((response) => func(response)).toList().cast<T>();
  }
  return [];
}
