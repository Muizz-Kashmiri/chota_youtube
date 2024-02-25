import 'package:chota_youtube/constants.dart';
import 'package:chota_youtube/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chota_youtube/helper_functions.dart';
import 'package:chota_youtube/home_page.dart';
import 'package:chota_youtube/login_page.dart';
import 'package:chota_youtube/settings.dart';
import 'package:chota_youtube/sign_up.dart';
import 'package:chota_youtube/upload_video.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Constants.url_key,
    anonKey: Constants.api,
  );

  bool isLoggedIn = await HelperFunctions.getIsLoggedIn();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'Chota Youtube',
          theme: ThemeData(
            brightness: themeProvider.isDarkModeEnabled
                ? Brightness.dark
                : Brightness.light,
            // Define other theme properties here
          ),
          home: isLoggedIn ? HomePage() : LoginPage(),
          routes: {
            '/home': (context) => HomePage(),
            '/login': (context) => LoginPage(),
            '/signup': (context) => SignUpPage(),
            '/settings': (context) => SettingsPage(),
            '/uploadVideos': (context) => UploadVideos(),
          },
        );
      },
    );
  }
}
