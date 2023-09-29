import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tif_test/constants/color.dart';
import 'package:tif_test/provider/general-provider.dart';
import 'package:tif_test/screens/event-details-screen.dart';
import 'package:tif_test/screens/search-screen.dart';
import 'package:tif_test/constants/dimens.dart';
import 'package:tif_test/constants/strings.dart';

import 'package:tif_test/utils/date-function.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late BuildContext ctx;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GeneralProvider>(ctx, listen: false).fetchEvents();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      ctx = context;
    });
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            StringLiterals.events,
            style: TextStyle(color: Colors.black, fontSize: Dimens.dimens25),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            const Padding(
              padding: EdgeInsets.only(right: Dimens.dimens8),
              child: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Consumer<GeneralProvider>(
            builder: (context, generalProvider, child) => generalProvider
                    .allEvents.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.black,
                  ))
                : ListView.builder(
                    itemBuilder: (context, i) {
                      final event = generalProvider.allEvents[i];
                      String venueDate =
                          DateFunctions.formatDateTime(event.date_time);
                      return ListTile(
                        leading: Image.network(event.banner_image),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              EventDetailScreen.routeName,
                              arguments: event.id);
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              venueDate,
                              style: const TextStyle(
                                  color: AppColor.appColor,
                                  fontSize: Dimens.dimens12),
                            ),
                            Text(
                              event.title,
                              style: const TextStyle(fontSize: Dimens.dimens18),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: Dimens.dimens15,
                            ),
                            MediaQuery.of(context).orientation == Orientation.landscape ?
                            Text(
                              event.venue_name,
                            )
                            : SizedBox(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: Text(
                                event.venue_name,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: generalProvider.allEvents.length,
                  )));
  }
}
