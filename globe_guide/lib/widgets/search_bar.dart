import 'package:flutter/material.dart';
import 'package:globe_guide/providers/theme_provider.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: themeProv.isDarkMode
            ? const Color.fromRGBO(152, 162, 179, 0.2)
            : const Color.fromRGBO(242, 244, 247, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: themeProv.isDarkMode
                    ? const Color.fromRGBO(152, 162, 179, 0.2)
                    : const Color.fromRGBO(242, 244, 247, 1),
                focusColor: themeProv.isDarkMode
                    ? const Color.fromRGBO(152, 162, 179, 0.2)
                    : const Color.fromRGBO(242, 244, 247, 1),
                prefixIcon: Icon(
                  LucideIcons.search,
                  color: !themeProv.isDarkMode
                      ? Color.fromRGBO(102, 112, 133, 1)
                      : Color.fromRGBO(234, 236, 240, 1),
                ),
                hintText: "Search Country",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  fontFamily: "Axiforma",
                  fontStyle: FontStyle.normal,
                  color: !themeProv.isDarkMode
                      ? Color.fromRGBO(102, 112, 133, 1)
                      : Color.fromRGBO(234, 236, 240, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
