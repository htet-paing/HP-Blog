import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider_and_fstore/config/theme.dart';
import 'package:provider_and_fstore/provider/catogory_provider.dart';
import 'package:provider_and_fstore/provider/post_provider.dart';
import 'package:provider_and_fstore/ui/screen/bottom_screen.dart';
import 'package:provider_and_fstore/ui/screen/category_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/theme_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]).then((_) {
    SharedPreferences.getInstance().then((prefs) {
      var darkModeOn = prefs.getBool('darkMode') ?? true;
      
      runApp(MyApp(darkModeOn));
    });
  });
}

class MyApp extends StatelessWidget {
  var darkModeOn;
  MyApp(this.darkModeOn);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: PostProvider()
        ),
        ChangeNotifierProvider.value(
          value: CatogoryProvider()
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(darkModeOn ? ThemeConfig.darkTheme : ThemeConfig.lightTheme)
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (ctx, themeData,_) => 
        MaterialApp(
          title: 'Firestore DEMO',
          debugShowCheckedModeBanner: false,
          theme: themeData.getTheme(),
          home: BottomScreen(),
          routes: {
            CategoryDetailScreen.routeName : (ctx) => CategoryDetailScreen(),
          },
        ),
      ),
    );
  }
}

