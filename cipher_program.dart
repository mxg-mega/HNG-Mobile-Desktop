import 'dart:io';
import 'dart:math';

/// Encrypts the [plaintext] using the provided [key].
/// Returns a hyphen-separated string of integer values.
String encrypt(String plaintext, String key) {
  if (key.isEmpty) throw Exception("Key must not be empty.");
  List<int> encryptedCodes = [];
  for (int i = 0; i < plaintext.length; i++) {
    int plainChar = plaintext.codeUnitAt(i);
    int keyChar = key.codeUnitAt(i % key.length);
    // Apply XOR and add the index to the result.
    int encryptedValue = (plainChar ^ keyChar) + i;
    encryptedCodes.add(encryptedValue);
  }
  return encryptedCodes.join("-");
}

/// Decrypts the [ciphertext] using the provided [key].
/// The ciphertext should be a hyphen-separated string of integers.
String decrypt(String ciphertext, String key) {
  if (key.isEmpty) throw Exception("Key must not be empty.");
  List<String> parts = ciphertext.split("-");
  StringBuffer decrypted = StringBuffer();
  for (int i = 0; i < parts.length; i++) {
    int encryptedValue = int.parse(parts[i]);
    int keyChar = key.codeUnitAt(i % key.length);
    // Reverse the encryption process: subtract the index then apply XOR.
    int plainChar = (encryptedValue - i) ^ keyChar;
    decrypted.write(String.fromCharCode(plainChar));
  }
  return decrypted.toString();
}

/// Generates a random key of the specified [length].
String generateRandomKey(int length) {
  const String chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random rnd = Random.secure();
  return List.generate(length, (_) => chars[rnd.nextInt(chars.length)]).join();
}

void main() {
  String? key;

  print("Welcome to the Custom Encryption/Decryption Program.");
  print("Please choose an operation:");
  print("1. Encrypt");
  print("2. Decrypt");
  stdout.write("Enter your choice (1 or 2): ");
  String? choice = stdin.readLineSync();

  if (choice == "1") {
    // Encryption process
    stdout.write("Enter plaintext: ");
    String? plaintext = stdin.readLineSync();

    // Ask user if they have a key or would like to generate one
    stdout.write("Would you like to generate a key (y/n): ");
    String? generateKey = stdin.readLineSync();

    if (generateKey == "y") {
      key = generateRandomKey(10);
      print("Generated key: $key");
    } else {
      stdout.write("Enter secret key: ");
      key = stdin.readLineSync();
    }

    if (plaintext == null || plaintext.isEmpty || key == null || key.isEmpty) {
      print("Invalid input. Please ensure both plaintext and key are provided.");
      return;
    }

    String encrypted = encrypt(plaintext, key);
    print("\nEncrypted text: $encrypted");
  } else if (choice == "2") {
    // Decryption process
    stdout.write("Enter ciphertext (hyphen-separated numbers): ");
    String? ciphertext = stdin.readLineSync();
    stdout.write("Enter secret key: ");
    key = stdin.readLineSync();

    if (ciphertext == null || ciphertext.isEmpty || key == null || key.isEmpty) {
      print("Invalid input. Please ensure both ciphertext and key are provided.");
      return;
    }

    try {
      String decrypted = decrypt(ciphertext, key);
      print("\nDecrypted text: $decrypted");
    } catch (e) {
      print("Error in decryption: $e");
    }
  } else {
    print("Invalid choice. Please restart the program and select either 1 or 2.");
  }
}
