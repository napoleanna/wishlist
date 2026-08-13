import 'package:material_ui/material_ui.dart';
import 'package:wishlist/screens/profile_screen/widgets/setting_tile.dart';
import 'package:wishlist/services/theme_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  double notificationLevel = 1.0;

  Future<void> _launchCoffeeUrl() async {
    final Uri url = Uri.parse(
        'https://www.instagram.com/napoleann_');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Thank you for your support! ☕'),
          duration: Duration(seconds: 2),
      ),
    );
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open the link: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = const Color(0xFF6d66b1);
    final headerColor = isDark ? Colors.white.withValues(alpha: 0.7)
        : accentColor.withValues(alpha: 0.8);
    final itemContentColor = Colors.black87;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            'Settings',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: headerColor),
          ),
        ),
        SettingTile(
          icon: Icons.dark_mode_outlined,
          title: 'Dark Mode',
          contentColor: itemContentColor,
          trailing: Switch(
            value: ThemeService.themeNotifier.value == ThemeMode.dark,
            onChanged: (value)  async {
              await ThemeService.toggleTheme(value);
              setState(() {});
            },
          ),
        ),
        SettingTile(
          icon: Icons.notifications_none_rounded,
          title: 'Notifications',
          contentColor: itemContentColor,
          trailing: Switch(
            value: notificationLevel == 1.0,
            onChanged: (value) => setState(() => notificationLevel = value ? 1.0 : 0.0),
          ),
        ),
        SettingTile(
          icon: Icons.language_rounded,
          title: 'Language',
          contentColor: itemContentColor,
          onTap: () {},
        ),
        SettingTile(
            icon: Icons.security_outlined,
            title: 'Privacy and Security',
          contentColor: itemContentColor,
            onTap: () {},
        ),
        SettingTile(
          icon: Icons.currency_exchange_rounded,
          title: 'Currency',
          contentColor: itemContentColor,
          onTap: () { },
        ),
        const SizedBox(height: 20),
         Padding(
            padding: EdgeInsets.only(
              left: 8,
              bottom: 12,
            ),
            child: Text(
              'Support',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: headerColor),
            ),
        ),
        SettingTile(
          icon: Icons.coffee_rounded,
          title: 'Buy author a coffee',
          contentColor: itemContentColor,
          onTap: _launchCoffeeUrl,
        ),
        SettingTile(
          icon: Icons.info_outline_rounded,
          title: 'About',
          contentColor: itemContentColor,
          onTap: () => _showAbout(context),
        ),
        const SizedBox(height: 100)
      ],
    );
  }



  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Wishlist App',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2026 All rights reserved',
    );
  }
}