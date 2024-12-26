
import 'package:encrypt/encrypt.dart';

class EncryptionDecryptionHelper{
  static String encKey = "";
  static String iv = "";
  // ask BE for this values

  //encrypt
  static String encryption(String text) {
    final cipherKey = Key.fromUtf8(encKey);
    final initVector = IV.fromUtf8(iv);
    final e = Encrypter(AES(cipherKey, mode: AESMode.cbc));
    final encryptedData = e.encrypt(text, iv: initVector);
    return encryptedData.base64;
  }

  //decrypt
  static String decryption(String text) {
    final cipherKey = Key.fromUtf8(encKey);
    final initVector = IV.fromUtf8(iv);
    final e = Encrypter(AES(cipherKey, mode: AESMode.cbc));
    final decryptedData = e.decrypt(Encrypted.fromBase64(text), iv: initVector);
    return decryptedData;
  }
}
