import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_api/Login.dart';
import 'main.dart';
class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              _showLanguageDialog(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.helloWorld,
              style: const TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Login()),
                );
              },
              child: Text(AppLocalizations.of(context)!.login),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.changeLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('English'),
                onTap: () {
                  MyApp.setLocale(context, const Locale('en'));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('French'),
                onTap: () {
                  MyApp.setLocale(context, const Locale('fr'));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
