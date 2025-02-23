import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:file_picker/file_picker.dart';

class ViewerPage extends StatefulWidget {
  const ViewerPage({super.key, required this.src});
  final String src;

  @override
  State<ViewerPage> createState() => _ViewerPageState();
}

class _ViewerPageState extends State<ViewerPage> {
  String? model1;
  String? model2;

  Future<void> _pickModel(bool isFirst) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.single.path != null) {
      setState(() {
        if (isFirst) {
          model1 = result.files.single.path!;
        } else {
          model2 = result.files.single.path!;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("3D Model Viewer")),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ModelViewer(src: model1 ?? widget.src, autoRotate: true, ar: true, autoPlay: true,),
                ),
                Expanded(
                  child: model2 == null
                      ? _addModelButton(false)
                      : ModelViewer(src: model2!, autoRotate: true, ar: true, autoPlay: true,),
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
      child: ElevatedButton(
        onPressed: () => _pickModel(isFirst),
        child: const Text("Add Model"),
      ),
    );
  }
}
