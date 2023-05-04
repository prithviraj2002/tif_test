import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tif_test/data-model/event-model.dart';
import 'package:tif_test/provider/event-provider.dart';
import 'package:tif_test/screens/event-details-screen.dart';
import 'package:tif_test/screens/search-screen.dart';

import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String formatDateTime(String dateTimeStr) {
  // Parse the input date and time string
  final dateTime = DateTime.parse(dateTimeStr);

  // Format the date and time string to the desired format
  final dayFormat = DateFormat('EEEE'); // Day of the week (e.g. Monday)
  final dateFormat = DateFormat('MMM d, y'); // Date format (e.g. Jun 1, 2023)
  final timeFormat = DateFormat('h:mm a'); // Time format (e.g. 9:00 AM)
  final formattedDay = dayFormat.format(dateTime);
  final formattedDate = dateFormat.format(dateTime);
  final formattedTime = timeFormat.format(dateTime);

  // Concatenate the formatted strings and return the result
  return '$formattedDay, $formattedDate . $formattedTime';
}

class _HomeScreenState extends State<HomeScreen> {

  var isLoading = false;

  @override
  void initState() {
    setState((){
      isLoading = true;
    });
    // TODO: implement
    Provider.of<EventProvider>(context, listen: false)
    .fetchEvents()
    .then((value) => {isLoading = false});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<EventClass> eventsData = Provider.of<EventProvider>(context).events;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Events",
          style: TextStyle(
              color: Colors.black,
              fontSize: 25
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed(SearchScreen.routeName);
              },
              icon: const Icon(Icons.search, color: Colors.black,)
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.more_vert, color: Colors.black,),
          )
        ],
      ),
      body: isLoading && eventsData.isEmpty? const Center(child: CircularProgressIndicator(color: Colors.black,))
          : Container(
              height: double.infinity,
              width: double.infinity,
              child: Expanded(
                child: ListView.builder(
                  itemBuilder: (context, i) {
                    final event = eventsData[i];
                    String venueDate = formatDateTime(event.date_time);
                    return ListTile(
                      leading: Image.network(event.banner_image),
                      onTap: () {
                        Navigator.of(context).pushNamed(EventDetailScreen.routeName, arguments: event.id);
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            venueDate,
                            style: const TextStyle(
                                color: Color(0xff5669FF),
                              fontSize: 12
                            ),
                          ),
                          Text(
                            event.title,
                            style: const TextStyle(
                              fontSize: 18
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 15,),
                              Text(event.venue_name),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: eventsData.length,),
              ),
            )
    );
  }
}
