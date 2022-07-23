import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sports/ifsc/data/events.dart';

const String domain = 'ifsc.results.info';

Future<http.Response> get(Uri url, {Map<String, String>? headers}) => http.get(
      url,
      headers: {
        ...?headers,
        'referer': 'https://$domain',
      },
    );

Future<List<SeasonsInfo>> getSeasons() async {
  http.Response res = await get(
    Uri(scheme: 'https', host: domain, path: '/api/v1'),
    headers: {'Content-Type': 'application/json'},
  );
  if (res.statusCode == 200 || res.statusCode == 304) {
    return (jsonDecode(res.body)['seasons'] as List<dynamic>)
        .map((season) => SeasonsInfo.fromJson(season))
        .toList();
  }
  debugPrint(res.statusCode.toString());
  return [];
}
