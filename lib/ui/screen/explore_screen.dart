import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_and_fstore/ui/screen/category_screen.dart';

import 'favorite_screen.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Explore',style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold
          )),
          bottom: TabBar(tabs: <Widget>[
            Tab(icon: Icon(Icons.list), text: 'Category'),
            Tab(icon: Icon(Icons.bookmark_border), text: 'Bookmark', )
          ]),
        ),
        body: TabBarView(children: [
           CategoryScreen(),
           FavoriteScreen()
        ]),
      ),
      
    );
  }
}