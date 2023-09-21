
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

// ignore: camel_case_types
class api
{
	// ignore: constant_identifier_names
	static const String GET = 'get', POST = 'post', PUT = 'put', DELETE = 'delete';
	static const String apiURL = 'https://festapp.ru/api/v1_Literary_Odyssey';

	static const String? token = null;

	static Map<String, String> categoryURL =
	{
		'news':	   '/public/content/news',
		'videos':  '/public/videolenta',
		'quiz':	   '/public/content/quiz',
		'content': '/public/content/articles',
	};

	static getContentCards(String category) => doRequest('$apiURL${categoryURL[category]}', GET);

	static Future<Map<String, dynamic>> doRequest(String url, String type, {String? body}) async
	{
		final uri = Uri.parse(url);
		Map<String, String> headers = {};
		if (token != null) { headers.addAll({'X-Authorization': token!}); }
		if (body != null) { headers.addAll({'Content-Type': 'application/json'}); }

		debugPrint(url);
		if (body != null) debugPrint(body);

		Response response = type == POST ? await http.post(uri, headers: headers, body: body) :
							type == PUT ? await http.put(uri, headers: headers, body: body) :
							type == DELETE ? await http.delete(uri) :
							await http.get(uri);

		debugPrint(response.body);



		if (response.statusCode == 200) return json.decode(response.body);

		Map<String, dynamic> resp = { 'status': 470, 'message': 'Some thing wrong :('};

		return resp;
	}
}
