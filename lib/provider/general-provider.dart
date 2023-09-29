import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:tif_test/constants/constants.dart';
import 'package:tif_test/data-model/event-model.dart';

class GeneralProvider extends ChangeNotifier{

  List<EventClass> allEvents = [];

  Future<void> fetchEvents() async{
    final url = Uri.parse(ApiUrl.getAllEventsUrl);

    try{
      final response = await http.get(url);
      final eventsData = jsonDecode(response.body);
      final fetchedEvents = eventsData['content'];
      final fromJson = fetchedEvents['data'];
      for(Map<String, dynamic> event in fromJson){
        allEvents.add(EventClass.fromJson(event));
      }
      notifyListeners();
    }
    catch(error){
      rethrow;
    }
  }

  Future<EventClass> getEventById(int id) async{
    final url = Uri.parse(ApiUrl.getEventById+id.toString());

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

  Future<List<EventClass>> searchEvents({required String search}) async{
    List<EventClass> searchedEvents = [];
    final url = Uri.parse(ApiUrl.searchEventUrl+search);
    try{
      final response = await http.get(url);
      final eventsData = jsonDecode(response.body);
      final fetchedEvents = eventsData['content'];
      final fromJson = fetchedEvents['data'];
      for(Map<String, dynamic> event in fromJson){
        searchedEvents.add(EventClass.fromJson(event));
      }
      return searchedEvents;
    }
    catch(error){
      rethrow;
    }
  }
}