import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String domain = 'ifsc.results.info';

Future<http.Response> get(Uri url, {Map<String, String>? headers}) =>
    http.get(url, headers: {...?headers, 'referer': 'https://$domain'});

Future<Map<String, dynamic>> getSeasons() async {
  http.Response res = await get(
    Uri(scheme: 'https', host: domain, path: '/api/v1'),
    headers: {'Content-Type': 'application/json'},
  );
  debugPrint(res.body);
  debugPrint("getSeasons -> status: ${res.statusCode}");
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  return {};
}
