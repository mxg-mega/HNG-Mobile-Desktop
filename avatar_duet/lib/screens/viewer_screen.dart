import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:avatar_duet/providers/glb_provider.dart';

class ViewerPage extends StatefulWidget {
  const ViewerPage({super.key, required this.src});
  final String? src;

  @override
  State<ViewerPage> createState() => _ViewerPageState();
}

class _ViewerPageState extends State<ViewerPage> {
  String? model1;
  String? model2;

  @override
  void initState() {
    super.initState();
    if (widget.src != null) {
      model1 = widget.src;
    }
  }

  Future<String?> _pickModelFromStorage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowedExtensions: ['glb'],
    );

    if (result != null && result.files.single.path != null) {
      return result.files.single.path!;
    }
    return null;
  }

  Future<void> _showModelSelectionDialog(bool isFirstModel) async {
    final glbProvider = Provider.of<GlbProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select ${isFirstModel ? "First" : "Second"} Model'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('From Assets:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ...glbProvider.glbFiles
                    .map(
                      (file) => ListTile(
                        leading: const Icon(Icons.view_in_ar),
                        title: Text(file.split('/').last),
                        onTap: () {
                          setState(() {
                            if (isFirstModel) {
                              model1 = file;
                            } else {
                              model2 = file;
                            }
                          });
                          Navigator.pop(context);
                        },
                      ),
                    )
                    .toList(),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.folder),
                  title: const Text('Choose from Storage'),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedPath = await _pickModelFromStorage();
                    if (pickedPath != null) {
                      setState(() {
                        if (isFirstModel) {
                          model1 = pickedPath;
                        } else {
                          model2 = pickedPath;
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("3D Model Viewer"),
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      if (model1 != null)
                        _modelViewer(model1!)
                      else
                        _addModelButton(true),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          onPressed: () => _showModelSelectionDialog(true),
                          icon: const Icon(Icons.change_circle),
                          tooltip: 'Change Model',
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      if (model2 != null)
                        _modelViewer(model2!)
                      else
                        _addModelButton(false),
                      if (model2 != null)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            onPressed: () => _showModelSelectionDialog(false),
                            icon: const Icon(Icons.change_circle),
                            tooltip: 'Change Model',
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _addModelButton(bool isFirst) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.view_in_ar,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _showModelSelectionDialog(isFirst),
            icon: const Icon(Icons.add),
            label: Text("Add ${isFirst ? 'First' : 'Second'} Model"),
          ),
        ],
      ),
    );
  }

  Widget _modelViewer(String src) {
    return ModelViewer(
      src: src,
      autoRotate: true,
      ar: true,
      autoPlay: true,
      cameraControls: true,
    );
  }
}
