import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryProvider extends ChangeNotifier {
  bool _isloading = false;
  String? errorMessage = '';
  final String _baseUrl = "https://restfulcountries.com/api/v1";
  final String _token = '2203|8JVFE7M45XkV0tIytZ5qqFNwdQ1653db10zB8kiU';
  List<Map<String, dynamic>> _countries = [];

  bool get isloading => _isloading;
  List<Map<String, dynamic>> get countries => _countries;

  Future<void> fetchCountries({int? limit}) async {
    _isloading = true;
    notifyListeners();

    try {
      final response = await http.get(
          Uri.parse(
              "$_baseUrl/countries${limit != null ? '?per_page=$limit' : ''}"),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $_token",
          });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> data = jsonData['data'];
        _countries =
            data.map((country) => country as Map<String, dynamic>).toList();
      } else {
        errorMessage = 'Failed to load data';
        throw Exception('Failed to load data');
      }
    } catch (e) {
      errorMessage = e.toString();
      print("$e");
      _countries = [];
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> fetchCountryDataByName(String name) async {
    _isloading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/countries/$name"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $_token",
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final Map<String, dynamic> data = jsonData['data'];
        return data;
      } else {
        throw Exception("Failed to fetch data on Country: $name");
      }
    } catch (e) {
      print("$e");
      errorMessage = e.toString();
      return {};
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
}
