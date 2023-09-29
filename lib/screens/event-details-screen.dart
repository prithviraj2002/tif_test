import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tif_test/constants/color.dart';
import 'package:tif_test/constants/dimens.dart';
import 'package:tif_test/data-model/event-model.dart';
import 'package:tif_test/provider/general-provider.dart';
import 'package:tif_test/utils/date-function.dart';
import 'package:tif_test/constants/strings.dart';

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
        future: Provider.of<GeneralProvider>(context, listen: false)
            .getEventById(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final EventClass event = snapshot.data;
            final String eventTime =
                DateFunctions.formatDateTime(event.date_time);
            return Scaffold(
              appBar: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height! * 0.3),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: const Text(
                    StringLiterals.eventDetails,
                    style: TextStyle(
                        fontSize: Dimens.dimens25, fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isSaved = !isSaved;
                          });
                        },
                        icon: isSaved
                            ? const Icon(Icons.bookmark)
                            : const Icon(Icons.bookmark_add_outlined))
                  ],
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(event.banner_image),
                            fit: BoxFit.fill)),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(Dimens.dimens20),
                      child: Text(
                        event.title,
                        style: const TextStyle(fontSize: Dimens.dimens35),
                      ),
                    ),
                    ListTile(
                        leading: Image.network(event.organiser_icon),
                        subtitle: const Text(StringLiterals.organizer),
                        title: Text(event.title)),
                    ListTile(
                      leading: const Icon(
                        Icons.calendar_month,
                        color: AppColor.appColor,
                        size: Dimens.dimens35,
                      ),
                      title: Text(eventTime),
                      subtitle: Text(eventTime),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.location_on,
                        color: AppColor.appColor,
                        size: Dimens.dimens35,
                      ),
                      title: Text(event.venue_name),
                      subtitle: Row(
                        children: [
                          Text(event.venue_city),
                          const Text(", "),
                          Text(event.venue_country)
                        ],
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(Dimens.dimens12),
                          child: Text(
                            StringLiterals.aboutEvent,
                            style: TextStyle(fontSize: Dimens.dimens18),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Dimens.dimens12),
                      child: Text(
                        event.description,
                        maxLines: null,
                        style: const TextStyle(fontSize: Dimens.dimens18),
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: AppColor.appColor,
                    borderRadius: BorderRadius.circular(Dimens.dimens10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          StringLiterals.bookNow,
                          style: TextStyle(
                              color: Colors.white, fontSize: Dimens.dimens25),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: Dimens.dimens5),
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
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

