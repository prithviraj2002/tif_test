import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tif_test/provider/general-provider.dart';
import 'package:tif_test/screens/event-details-screen.dart';
import 'package:tif_test/screens/main-screen.dart';
import 'package:tif_test/screens/search-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => GeneralProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            // fontFamily: 'Inter'
            textTheme: GoogleFonts.interTextTheme(
              Theme.of(context).textTheme
            )
          ),
          home: const MainScreen(),
          routes: {
            SearchScreen.routeName: (ctx) => const SearchScreen(),
            EventDetailScreen.routeName: (ctx) => const EventDetailScreen()
          },
        ));
  }
}
