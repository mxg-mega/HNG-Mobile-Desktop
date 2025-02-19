import 'package:avatar_duet/screens/veiwer_screen.dart';
import 'package:flutter/material.dart';

class ViewModelFromWebScreen extends StatelessWidget {
  const ViewModelFromWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController urlController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("View from Web"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                hintText: "Input Model URL here",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ),
            ),
            const SizedBox(height: 7),
            ElevatedButton(
                onPressed: () {
                  if (urlController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter a URL")));
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => ViewerPage(
                          src: urlController.text,
                          isInternetSrc: true,
                        ),
                      ),
                    );
                  }
                },
                child: Text("Open Model"))
          ],
        ),
      ),
    );
  }
}
