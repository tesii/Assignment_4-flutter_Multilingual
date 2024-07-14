import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import AppLocalizations

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aboutUs), // Localized title
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.aboutUs, // Localized about app title
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.calculatorDescription, // Localized about app description
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.features, // Localized features title
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.basicOperations, // Localized features list
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.easyInterface, // Localized features list
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.themeCustomization, // Localized features list
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              Text(
                AppLocalizations.of(context)!.enjoyApp, // Localized enjoy using app message
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
