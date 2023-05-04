import 'package:flutter/material.dart';
import 'package:tif_test/data-model/event-model.dart';
import 'package:tif_test/provider/get-event.dart';
import 'package:tif_test/screens/home-screen.dart';

class EventDetailScreen extends StatefulWidget {
  static const routeName = '/event-detail-screen';
  const EventDetailScreen({Key? key}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final int id = args as int;
    return FutureBuilder(
        future: getEvent(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final EventClass event = snapshot.data;
            final String eventTime = formatDateTime(event.date_time);
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(MediaQuery.of(context).size.height! * 0.3),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: const Text("Event Details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  actions: [
                    IconButton(onPressed: () {
                      setState((){
                        isSaved = !isSaved;
                      });
                    }, icon: isSaved? const Icon(Icons.bookmark) : const Icon(Icons.bookmark_add_outlined))
                  ],
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(event.banner_image),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(event.title, style: const TextStyle(fontSize: 35),),
                    ),
                    ListTile(
                      leading: Image.network(event.organiser_icon),
                      subtitle: const Text("Organizer"),
                      title: Text(event.title)
                    ),
                    ListTile(
                      leading: const Icon(Icons.calendar_month, color: Color(0xff5669FF), size: 35,),
                      title: Text(eventTime),
                      subtitle: Text(eventTime),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on, color: Color(0xff5669FF), size: 35,),
                      title: Text(event.venue_name),
                      subtitle: Row(
                        children: [
                          Text(event.venue_city),
                          const Text(", "),
                          Text(event.venue_country)
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text("About Event", style: TextStyle(fontSize: 18),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(event.description, maxLines: null, style: const TextStyle(fontSize: 18),),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: SizedBox(
                height: MediaQuery.of(context).size.height *0.1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Card(
                    shadowColor: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: const BoxDecoration(
                          color: Color(0xff5669FF),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          const Text(
                            "BOOK NOW",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25
                            ),
                          ),
                          Container(width: MediaQuery.of(context).size.width *0.13,),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_forward, color: Colors.white,)),
                          ],
                        ),
                      )
                    ),
                  ),
                ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text(snapshot.error.toString())),
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}



