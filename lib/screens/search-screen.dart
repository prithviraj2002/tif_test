import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tif_test/provider/event-provider.dart';
import 'package:tif_test/provider/search-event-provider.dart';
import 'package:tif_test/screens/home-screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  var isLoading = false;
  var searchedEventsData;

  final TextEditingController _searchText = TextEditingController();

  @override
  void initState() {
    searchedEventsData = Provider.of<EventProvider>(context,listen: false).events;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.2),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
              children: <Widget>[
                IconButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
              },
            icon: const Icon(Icons.arrow_back, color: Colors.black,
            )
                ),
                const Text("Search", style: TextStyle(color: Colors.black, fontSize: 25),),
            ],
            ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _searchText,
                validator: (value) {
                  return "Cannot have an empty value";
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type Event Name",
                  prefixIcon: IconButton(
                      onPressed: () {
                        setState((){
                          Provider.of<SearchEventProvider>(context, listen: false).searchEvents(search: _searchText.text).then((value) => {isLoading = false});
                          searchedEventsData = Provider.of<SearchEventProvider>(context, listen: false).events;
                        });
                      },
                      icon: const Icon(Icons.search, color: Color(0xff5669FF),)
                  )
                ),
              ),
            ),
          )
          ),
      ),
      body:  Container(
            height: double.infinity,
            width: double.infinity,
            child: Expanded(
                child: ListView.builder(
                  itemBuilder: (context, i) {
                    final venueDate = formatDateTime(searchedEventsData[i].date_time);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(searchedEventsData[i].banner_image),
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
                              searchedEventsData[i].title,
                              style: const TextStyle(
                                  fontSize: 18
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: searchedEventsData.length,
                )
            ),
          )
    );
  }
}

