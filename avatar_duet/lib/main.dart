import 'package:avatar_duet/providers/glb_provider.dart';
import 'package:avatar_duet/screens/veiwer_screen.dart';
import 'package:avatar_duet/screens/view_model_from_web_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                GlbProvider()..loadGlbFiles()), // Auto-load on startup
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
      appBar: AppBar(title: Text(title)),
      body: Consumer<GlbProvider>(
        builder: (context, glbProvider, child) {
          if (glbProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (glbProvider.glbFiles.isEmpty) {
            return const Center(child: Text("No GLB files found"));
          }

          return ListView.builder(
            itemCount: glbProvider.glbFiles.length,
            itemBuilder: (context, index) {
              final file = glbProvider.glbFiles[index];
              return ListTile(
                title: Text(file),
                onTap: () {
                  // Navigate to the viewer page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => ViewerPage(src: file),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const ViewModelFromWebScreen(),
                  ),
                );
        },
        child: const Icon(Icons.add),
        tooltip: "Add a Model",
      ),
    );
  }
}
