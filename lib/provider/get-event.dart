import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tif_test/data-model/event-model.dart';
import 'package:http/http.dart' as http;

Future<EventClass> getEvent(int id) async{
  final url = Uri.parse("https://sde-007.api.assignment.theinternetfolks.works/v1/event/$id");

  try{
    final response = await http.get(url);
    final jsonData = jsonDecode(response.body);
    final contentData = jsonData['content'];
    final eventData = contentData['data'];
    return EventClass.fromJson(eventData);
  }
  catch(error){
    rethrow;
  }
}