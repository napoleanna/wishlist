import 'package:flutter/material.dart';
import 'package:wishlist/services/theme_service.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double notificationLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/images/background.webp"),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListView(
          children: [
            buildTile(
              title: 'Appearance',
              icon: Icons.dark_mode,
              trailing: Switch(
                value: themeNotifier.value == ThemeMode.dark,
                onChanged: (value) {
                  if (themeNotifier.value == ThemeMode.light) {
                    themeNotifier.value = ThemeMode.dark;
                  } else {
                    themeNotifier.value = ThemeMode.light;
                  }
                },
              ), context: context,
            ),
            buildTile(
              title: 'Notifications',
              icon: Icons.notifications,
              trailing: Switch(
                  value: notificationLevel == 1.0,
                  onChanged: (value) {
                    setState(() {
                      notificationLevel = value ? 1.0 : 0.0;
                    });
                  }), context: context,
              
            ),
            buildTile(title: 'Currency',
                icon: Icons.currency_exchange,
                onTap: () {

                },
                context: context),
            buildTile(
                title: 'Privacy and Security',
                icon: Icons.security,
              onTap: () {

              },
                context: context),
            buildTile(
                title: 'Language',
                icon: Icons.language,
                onTap: () {

                },
                context: context),
            buildTile(
                title: 'About',
                icon: Icons.info,
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Application Settings',
                    applicationVersion: '1.0.0',
                    applicationLegalese: '© 2025 All rights reserved');
                }, 
                context: context)
          ],
        ),
      ),
    );
  }
}

Widget buildTile({
  required String title,
  required IconData icon,
  Widget? trailing,
  VoidCallback? onTap,
  required BuildContext context,
}) {
  Color cardColor = Theme.of(context).brightness == Brightness.dark
      ? Colors.grey[700]!
      : Colors.white;

  return Card(
    color: cardColor,
    elevation: 10,
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 16.0),
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: onTap,
    ),
  );
}