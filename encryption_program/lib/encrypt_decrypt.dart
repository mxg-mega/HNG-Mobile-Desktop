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