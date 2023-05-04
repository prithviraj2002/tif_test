import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tif_test/data-model/event-model.dart';

class EventProvider with ChangeNotifier{
  List<EventClass> _events = [];

  List<EventClass> get events{
    return [..._events];
  }
  
  Future<void> fetchEvents() async{
    final url = Uri.parse("https://sde-007.api.assignment.theinternetfolks.works/v1/event");

    try{
      final response = await http.get(url);
      final eventsData = jsonDecode(response.body);
      final fetchedEvents = eventsData['content'];
      final fromJson = fetchedEvents['data'];
      for(Map<String, dynamic> event in fromJson){
        _events.add(EventClass.fromJson(event));
      }
      notifyListeners();
    }
    catch(error){
      rethrow;
    }
  }
}