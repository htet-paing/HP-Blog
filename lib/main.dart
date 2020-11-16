import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider_and_fstore/config/theme.dart';
import 'package:provider_and_fstore/provider/catogory_provider.dart';
import 'package:provider_and_fstore/provider/post_provider.dart';
import 'package:provider_and_fstore/ui/screen/auth_screen.dart';
import 'package:provider_and_fstore/ui/screen/bottom_screen.dart';
import 'package:provider_and_fstore/ui/screen/category_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/auth_provider.dart';
import 'provider/theme_provider.dart';
import 'ui/screen/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]).then((_) {
    SharedPreferences.getInstance().then((prefs) {
      var darkModeOn = prefs.getBool('darkMode') ?? true;
      
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (ctx) => AuthProvider.instance()
            ),
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
          child: MyApp(),
        )
      );
    });
  });
}

class MyApp extends StatelessWidget {
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (ctx, themeData,_) => 
      MaterialApp(
        title: 'Firestore DEMO',
        debugShowCheckedModeBanner: false,
        theme: themeData.getTheme(),
        home: Consumer<AuthProvider>(
          builder: (ctx, auth, _) {
            switch (auth.status) {
              case AuthStatus.Uninitialized :
                return SplashScreen();
              case AuthStatus.Unauthenticated :
              case AuthStatus.Authenticating :
                return AuthScreen();
              case AuthStatus.Authenticated :
                return BottomScreen();
            }
            return Container();
          },
        ),
        routes: {
          CategoryDetailScreen.routeName : (ctx) => CategoryDetailScreen(),
        },
      ),
    );
  }
}

