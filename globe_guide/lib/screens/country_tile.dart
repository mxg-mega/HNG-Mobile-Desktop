import 'package:flutter/material.dart';
import 'package:globe_guide/screens/country_details_screen.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CountryTile extends StatelessWidget {
  final String countryName;
  final String capitalName;
  final String? image;
  final VoidCallback? onTap;

  const CountryTile({
    Key? key,
    required this.countryName,
    required this.capitalName,
    this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          image ?? '',
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 40,
            height: 40,
            color: Colors.grey[300],
          ),
        ),
      ),
      title: Text(
        countryName,
        style: const TextStyle(
          fontFamily: "Axiforma",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        capitalName,
        style: TextStyle(
          fontFamily: "Axiforma",
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      onTap: onTap ??
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CountryDetailsScreen(title: countryName),
              ),
            );
          },
    );
  }
}
