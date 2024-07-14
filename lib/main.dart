import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_api/LandingPage.dart';
import 'package:flutter_api/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // Track current theme mode
  Locale _locale = const Locale('en');

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  ThemeData _darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    // Customize other dark theme properties as needed
  );

  ThemeData getTheme() {
    return _isDarkMode ? _darkTheme : _lightTheme;
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: getTheme(), // Set theme based on current mode
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('fr', ''), // French
      ],
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
          actions: [
            IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: toggleTheme,
            ),
          ],
        ),
        body: LandingPage(),
      ),
    );
  }
}
