import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_and_fstore/config/theme.dart';
import 'package:provider_and_fstore/provider/auth_provider.dart';
import 'package:provider_and_fstore/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'explore_screen.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  var _darkTheme = true;
  void onThemeChanged(bool value, ThemeProvider themeProvider) async{
    (value) 
        ? themeProvider.setTheme(ThemeConfig.darkTheme)
        : themeProvider.setTheme(ThemeConfig.lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
  

  List items;

  @override
  void initState() {
    super.initState();
    items = [
      {
        'icon': Feather.bookmark,
        'title': 'Bookmark',
        'function': () => _pushPage(ExploreScreen()),
      },
      {
        'icon': Feather.log_out,
        'title': 'Logout',
        'function' : () => _logout()
      },
      {
        'icon': Feather.moon,
        'title': 'Dark Mode',
      },
      {
        'icon': Feather.info,
        'title': 'About',
        'function': () => showAbout(),
      },
      
    ];
  }



  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Setting',style: GoogleFonts.playfairDisplay(
          fontWeight: FontWeight.bold
        )),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          if (items[index]['title'] == 'Dark Mode') {
            return _buildThemeSwitch(items[index], themeProvider);
          }
          return ListTile(
            onTap: items[index]['function'],
            leading: Icon(
              items[index]['icon'],
            ),
            title: Text(
              items[index]['title'],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
  Widget _buildThemeSwitch(Map item, ThemeProvider themeProvider) {
    return SwitchListTile(
      secondary: Icon(
        item['icon'],
      ),
      title: Text(
        item['title'],
      ),
      value: _darkTheme,
      onChanged: (val) {
        setState(() {
          _darkTheme = val;
        });
        onThemeChanged(val, themeProvider);
      },
    );
  }

  _pushPage(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return page;
        }
      )
    );
  }

  _logout() {
    Provider.of<AuthProvider>(context).logout();
  }

  showAbout() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'About',
          ),
          content: Text(
            'Simple CRUD with provider and firestore',
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Theme.of(context).accentColor,
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }
}