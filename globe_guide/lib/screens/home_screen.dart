import 'package:flutter/material.dart';
import 'package:globe_guide/providers/country_provider.dart';
import 'package:globe_guide/providers/theme_provider.dart';
import 'package:globe_guide/screens/country_details_screen.dart';
import 'package:globe_guide/screens/country_tile.dart';
import 'package:globe_guide/widgets/search_bar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CountryProvider>().fetchCountries();
    });
  }

  Map<String, List<Map<String, dynamic>>> organizeCountriesByLetter(
      List<Map<String, dynamic>> countries) {
    final Map<String, List<Map<String, dynamic>>> organized = {};

    for (var country in countries) {
      final firstLetter =
          country['name'].toString().substring(0, 1).toUpperCase();
      if (!organized.containsKey(firstLetter)) {
        organized[firstLetter] = [];
      }
      organized[firstLetter]!.add(country);
    }

    return Map.fromEntries(
        organized.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
  }

  Widget buildCountryList(List<Map<String, dynamic>> countries) {
    final organizedCountries = organizeCountriesByLetter(countries);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: organizedCountries.length,
      itemBuilder: (context, index) {
        final letter = organizedCountries.keys.elementAt(index);
        final countriesForLetter = organizedCountries[letter]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                letter,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Axiforma",
                ),
              ),
            ),
            ...countriesForLetter
                .map((country) => CountryTile(
                      countryName: country['name'] ?? '',
                      capitalName: country['capital'] ?? '',
                      image: country['href']['flag'],
                    ))
                .toList(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final countryProv = Provider.of<CountryProvider>(context);
    final newSearchThemeData = SearchBarTheme.of(context).copyWith(
      elevation: WidgetStateProperty.all(0),
      hintStyle: WidgetStateProperty.all(
        const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 16,
          fontFamily: "Axiforma",
          color: Color.fromRGBO(102, 112, 133, 1),
        ),
      ),
      padding:
          WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 10)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              themeProv.toggleTheme();
            },
            icon: Icon(
              !themeProv.isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          // SearchBar(
          //   leading: const Icon(
          //     LucideIcons.search,
          //     color: Color.fromRGBO(102, 112, 133, 1),
          //   ),
          //   hintText: "Search Country",
          //   elevation: newSearchThemeData.elevation,
          //   hintStyle: newSearchThemeData.hintStyle,
          //   padding: newSearchThemeData.padding,
          // ),
          const MySearchBar(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyActionProcessingButtons(
                icon: LucideIcons.globe,
                label: "EN",
                onPressed: () {},
              ),
              MyActionProcessingButtons(
                icon: LucideIcons.filter,
                label: "Filter",
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          countryProv.isloading
              ? const Center(child: CircularProgressIndicator())
              : buildCountryList(countryProv.countries),
        ],
      ),
    );
  }
}

class MyActionProcessingButtons extends StatelessWidget {
  MyActionProcessingButtons(
      {super.key, required this.icon, required this.label, this.onPressed});

  final IconData icon;
  final String label;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(
            width: 5,
          ),
          Text(label)
        ],
      ),
    );
  }
}
