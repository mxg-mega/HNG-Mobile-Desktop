import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globe_guide/providers/country_provider.dart';
import 'package:globe_guide/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class CountryDetailsScreen extends StatefulWidget {
  const CountryDetailsScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<CountryDetailsScreen> createState() => _CountryDetailsScreenState();
}

class _CountryDetailsScreenState extends State<CountryDetailsScreen> {
  Map<String, dynamic> countryInfo = {};

  @override
  void initState() {
    super.initState();
    _loadCountryData();
  }

  Future<void> _loadCountryData() async {
    final data = await context
        .read<CountryProvider>()
        .fetchCountryDataByName(widget.title);
    print("${data}");
    setState(() {
      countryInfo = data;
    });
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 200),
            // width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: !context.read<ThemeProvider>().isDarkMode
                    ? Colors.black
                    : const Color.fromRGBO(242, 244, 247, 1),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final countryProv = Provider.of<CountryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: countryProv.isloading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        countryInfo['href']?['flag'] ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Country Information
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow('Population:',
                            '${countryInfo['population'] ?? 'N/A'}'),
                        _buildInfoRow(
                            'Region:', countryInfo['continent'] ?? 'N/A'),
                        _buildInfoRow(
                            'Capital:', countryInfo['capital'] ?? 'N/A'),
                        _buildInfoRow('Motto:', countryInfo['motto'] ?? 'N/A'),
                        _buildInfoRow('Official language:',
                            countryInfo['languages']?.join(', ') ?? 'N/A'),
                        _buildInfoRow('Ethnic group:',
                            countryInfo['ethnic_groups']?.join(', ') ?? 'N/A'),
                        _buildInfoRow('Religion:',
                            countryInfo['religions']?.join(', ') ?? 'N/A'),
                        _buildInfoRow('Government:',
                            countryInfo['government_type'] ?? 'N/A'),
                        _buildInfoRow('Independence:',
                            countryInfo['independence_date'] ?? 'N/A'),
                        _buildInfoRow('Area:', '${countryInfo['size']}'),
                        _buildInfoRow(
                            'Currency:', countryInfo['currency'] ?? 'N/A'),
                        _buildInfoRow('GDP:', countryInfo['gdp'] ?? 'N/A'),
                        _buildInfoRow(
                            'Time zone:', countryInfo['timezone'] ?? 'N/A'),
                        _buildInfoRow('Date format:',
                            countryInfo['date_format'] ?? 'N/A'),
                        _buildInfoRow('Dialling code:',
                            countryInfo['dialling_code'] ?? 'N/A'),
                        _buildInfoRow('Driving side:',
                            countryInfo['driving_side'] ?? 'N/A'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
