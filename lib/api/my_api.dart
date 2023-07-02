import 'dart:convert';

import 'package:http/http.dart' as httpmethod;
import 'package:my_api/models/my_model.dart';

Future<MainModel> getRequest() async {
  final response = await httpmethod.get(
    Uri.https("www.boredapi.com", "/api/activity"),
  );

  if (response.statusCode == 200) {
    return MainModel.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception("Error:Can't load data");
  }
}
