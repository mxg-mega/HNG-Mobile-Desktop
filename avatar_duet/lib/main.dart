import 'package:avatar_duet/providers/glb_provider.dart';
import 'package:avatar_duet/screens/viewer_screen.dart';
import 'package:avatar_duet/screens/view_model_from_web_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => GlbProvider()
              ..loadGlbFiles()
              ..loadAnimFiles()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avatar Duet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Avatar Duet'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.view_in_ar,
                color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        elevation: 2,
      ),
      body: Consumer<GlbProvider>(
        builder: (context, glbProvider, child) {
          if (glbProvider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading 3D Models...'),
                ],
              ),
            );
          }

          if (glbProvider.glbFiles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_amber_rounded,
                      size: 64, color: Theme.of(context).colorScheme.error),
                  const SizedBox(height: 16),
                  const Text(
                    "No 3D Models Found",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Add models using the button below",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Available Models',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: glbProvider.glbFiles.length,
                    itemBuilder: (context, index) {
                      final file = glbProvider.glbFiles[index];
                      return _buildModelCard(context, file);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'web',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const ViewModelFromWebScreen(),
                ),
              );
            },
            child: const Icon(Icons.link),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'local',
            onPressed: () async {
              final path = await _pickModelFromStorage();
              if (path != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ViewerPage(src: path as String?),
                  ),
                );
              }
            },
            child: const Icon(Icons.folder),
          ),
        ],
      ),
    );
  }

  Future<String?> _pickModelFromStorage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      // allowedExtensions: ['glb'],
    );

    if (result != null && result.files.single.path != null) {
      return result.files.single.path!;
    }
    return null;
  }

  Widget _buildModelCard(BuildContext context, String file) {
    final fileName = file.split('/').last;
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => ViewerPage(src: file),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.view_in_ar,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                fileName,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
