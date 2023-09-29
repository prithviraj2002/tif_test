import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tif_test/constants/color.dart';
import 'package:tif_test/constants/dimens.dart';
import 'package:tif_test/constants/strings.dart';
import 'package:tif_test/data-model/event-model.dart';
import 'package:tif_test/provider/general-provider.dart';
import 'package:tif_test/utils/date-function.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _search = TextEditingController();
  String searchText = '';

  @override
  void dispose() {
    // TODO: implement dispose
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          StringLiterals.search,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<GeneralProvider>(
        builder: (buildContext, generalProvider, child) => Column(
          children: <Widget>[
            const SizedBox(
              height: Dimens.dimens10,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      searchText = _search.text;
                    });
                  },
                  icon: const Icon(Icons.search),
                  color: Colors.deepPurpleAccent,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _search,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: StringLiterals.typeEventName),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: Dimens.dimens10,
            ),
            Expanded(
                child: searchText.isEmpty
                    ? ListView.builder(
                        itemBuilder: (context, i) {
                          final event = generalProvider.allEvents[i];
                          String venueDate =
                              DateFunctions.formatDateTime(event.date_time);
                          return ListTile(
                            leading: Image.network(event.banner_image),
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
                                  style: const TextStyle(
                                      fontSize: Dimens.dimens18),
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
                      )
                    : FutureBuilder(
                        future:
                            generalProvider.searchEvents(search: searchText),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            final List<EventClass> events = snapshot.data;
                            return ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) => ListTile(
                                title: Text(events[index].title),
                                subtitle: Text(events[index].description),
                                leading:
                                    Image.network(events[index].banner_image),
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider();
                              },
                              itemCount: events.length,
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(snapshot.error.toString()));
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }))
          ],
        ),
      ),
    );
  }
}
