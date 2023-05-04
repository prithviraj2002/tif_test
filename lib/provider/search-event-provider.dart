import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tif_test/data-model/event-model.dart';

class SearchEventProvider with ChangeNotifier{
  List<EventClass> _searchedEvents = [];

  List<EventClass> get events{
    return [..._searchedEvents];
  }

  Future<void> searchEvents({required String search}) async{
    final url = Uri.parse("https://sde-007.api.assignment.theinternetfolks.works/v1/event?search=$search");

    try{
      final response = await http.get(url);
      final eventsData = jsonDecode(response.body);
      final fetchedEvents = eventsData['content'];
      final fromJson = fetchedEvents['data'];
      _searchedEvents.clear();
      for(Map<String, dynamic> event in fromJson){
        _searchedEvents.add(EventClass.fromJson(event));
      }
      notifyListeners();
    }
    catch(error){
      rethrow;
    }
  }
}