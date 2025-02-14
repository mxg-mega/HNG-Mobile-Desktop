import 'package:flutter/material.dart';
import 'package:encryption_program/decrypt_form.dart';
import 'package:encryption_program/encrypt_form.dart';
import 'package:encryption_program/encrypt_decrypt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encryption App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Encryption App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController plainText = TextEditingController();
  final TextEditingController keyController = TextEditingController();
  final TextEditingController cipherText = TextEditingController();
  final TextEditingController decryptText = TextEditingController();

  bool _isEncrypted = false;

  void _toggleMode(bool value) {
    setState(() {
      _isEncrypted = value;
      cipherText.clear();
      decryptText.clear();
    });
  }

  void _processText() {
    setState(() {
      if (!_isEncrypted) {
        cipherText.text = encrypt(plainText.text, keyController.text);
      } else {
        decryptText.text = decrypt(cipherText.text, keyController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Encryption"),
                    Switch(value: _isEncrypted, onChanged: _toggleMode),
                    const Text("Decryption"),
                  ],
                ),
                _isEncrypted
                    ? DecryptForm(
                        cipherController: cipherText,
                        keyController: keyController)
                    : EncryptForm(
                        plainTextCntrl: plainText, keyCntrl: keyController),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _processText,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50)),
                  child: Text(!_isEncrypted ? "Encrypt" : "Decrypt"),
                ),
                const SizedBox(height: 10),
                TextField(
                  readOnly: true,
                  controller: !_isEncrypted ? cipherText : decryptText,
                  decoration: const InputDecoration(
                      labelText: "Output", border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
