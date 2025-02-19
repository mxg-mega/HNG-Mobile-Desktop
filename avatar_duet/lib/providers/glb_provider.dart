import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class GlbProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<String> _glbFiles = [];

  bool get isLoading => _isLoading;
  List<String> get glbFiles => _glbFiles;

  Future<void> loadGlbFiles() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final manifestJson = jsonDecode(manifestContent) as Map<String, dynamic>;
      _glbFiles = manifestJson.keys
          .where((key) => key.endsWith('.glb'))
          .toList();
    } catch (e) {
      debugPrint('Error loading GLB files: $e');
      _glbFiles = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
