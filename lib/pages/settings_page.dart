import 'package:flutter/material.dart';
import 'package:test_project/components/country_selector.dart'; // Add this import
import 'package:provider/provider.dart';
import 'package:test_project/themes/theme_provider.dart';
import 'package:test_project/themes/light_mode.dart';
import 'package:test_project/themes/dark_mode.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedCountry = "Select a country";
  final ExpansibleController _themeController = ExpansibleController();
  final ExpansibleController _countryController = ExpansibleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            ExpansionTile(
              controller: _themeController,
              title: const Text("Theme"),
              subtitle: const Text("Change the app theme"),
              trailing: const Icon(Icons.arrow_drop_down_rounded),
              children: [
                ListTile(
                  title: const Text("Light"),
                  leading: const Icon(Icons.light_mode),
                  onTap: () {
                    Provider.of<ThemeProvider>(context, listen: false).setTheme(lightmode);
                    _themeController.collapse();
                  },
                ),
                ListTile(
                  title: const Text("Dark"),
                  leading: const Icon(Icons.dark_mode),
                  onTap: () {
                    Provider.of<ThemeProvider>(context, listen: false).setTheme(darkmode);
                    _themeController.collapse();
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            ExpansionTile(
              controller: _countryController,
              title: const Text("Country"),
              subtitle: Text(_selectedCountry),
              trailing: const Icon(Icons.arrow_drop_down_rounded),
              children: countryOptions().map((country) {
                return ListTile(
                  title: Text(country),
                  onTap: () {
                    setState(() {
                      _selectedCountry = country;
                    });
                    _countryController.collapse();
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}