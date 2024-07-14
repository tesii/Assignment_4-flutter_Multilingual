import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Services extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.services),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.ourServices,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.servicesDescription,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ServiceItem(
                icon: Icons.calculate,
                title: AppLocalizations.of(context)!.basicCalculations,
                description: AppLocalizations.of(context)!.basicCalculationsDescription,
              ),
              SizedBox(height: 20),
              ServiceItem(
                icon: Icons.history,
                title: AppLocalizations.of(context)!.history,
                description: AppLocalizations.of(context)!.historyDescription,
              ),
              SizedBox(height: 20),
              ServiceItem(
                icon: Icons.settings,
                title: AppLocalizations.of(context)!.customization,
                description: AppLocalizations.of(context)!.customizationDescription,
              ),
              SizedBox(height: 20),
              ServiceItem(
                icon: Icons.support,
                title: AppLocalizations.of(context)!.support,
                description: AppLocalizations.of(context)!.supportDescription,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 40,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                description,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
