import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ViewerPage extends StatelessWidget {
  const ViewerPage({super.key, required this.src, this.isInternetSrc = false});

  final String src;
  final bool isInternetSrc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Viewer"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: ModelViewer(
                  loading: Loading.lazy,
                  src: src,
                  autoRotate:
                      false, // Set to true only if you need auto-rotation
                  cameraControls: true, // Allow user to rotate and zoom
                  disableZoom: false, // Enables zooming
                  disableTap: false, // Allows interactions
                  backgroundColor: Colors.grey, // Change if needed
                  exposure: 1.0, // Adjust lighting balance
                  onWebViewCreated: (webViewController) {
                    debugPrint('WebView created');
                    // webViewController.clearCache(); // Only clear cache if necessary
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Model path/url: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        src,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow
                            .ellipsis, // Prevents long URLs from breaking layout
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
