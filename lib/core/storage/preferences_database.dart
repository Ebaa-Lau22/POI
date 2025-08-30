import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:poi/core/app_models/new_profile_model.dart';

class PreferencesDatabase {
  static final PreferencesDatabase _instance = PreferencesDatabase._internal();
  factory PreferencesDatabase() => _instance;

  PreferencesDatabase._internal();

  Database? _db;

  final String _secretKey = 'v3ryS3cur3AndR4nd0mAESKey00012345';

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'app_preferences.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE preferences (
            key TEXT PRIMARY KEY,
            value TEXT
          )
        ''');
      },
    );
  }

  // set encoded dynamic value in the database
  Future<void> setValue(String key, dynamic value) async {
    final stringValue = json.encode(value);
    final db = await database;
    await db.insert('preferences', {
      'key': key,
      'value': stringValue,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // get decoded dynamic value from the database
  Future<T?> getValue<T>(String key) async {
    final db = await database;
    final result = await db.query(
      'preferences',
      where: 'key = ?',
      whereArgs: [key],
    );
    if (result.isNotEmpty) {
      final val = result.first['value'] as String;
      try {
        final decoded = json.decode(val);
        return decoded as T;
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<void> removeValue(String key) async {
    final db = await database;
    await db.delete('preferences', where: 'key = ?', whereArgs: [key]);
  }

  // Encrypted Storage
  static final _fixedIV = encrypt.IV.fromUtf8('A1B2C3D4E5F6G7H8');

  String _encrypt(String plainText) {
    final key = encrypt.Key.fromUtf8(_secretKey.substring(0, 32));
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    return encrypter.encrypt(plainText, iv: _fixedIV).base64;
  }

  String _decrypt(String base64Text) {
    final key = encrypt.Key.fromUtf8(_secretKey.substring(0, 32));
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    return encrypter.decrypt64(base64Text, iv: _fixedIV);
  }

  Future<void> setEncryptedValue(String key, dynamic value) async {
    final encoded = json.encode(value);
    final encrypted = _encrypt(encoded);
    await setValue(key, encrypted);
  }

  Future<T?> getEncryptedValue<T>(String key) async {
    final encrypted = await getValue<String>(key);
    if (encrypted == null) return null;
    try {
      final decrypted = _decrypt(encrypted);
      print('Decrypted $key => $decrypted');
      return json.decode(decrypted) as T;
    } catch (e) {
      print('Error decoding value for $key: $e');
      return null;
    }
  }

  // 4. Encrypted Token
  Future<void> setToken(String token) async {
    await setEncryptedValue('AUTH_TOKEN', token);
  }

  Future<String?> getToken() async {
    return await getEncryptedValue<String>('AUTH_TOKEN');
  }

  Future<void> clearToken() async {
    await removeValue('AUTH_TOKEN');
  }

  // 5. Profile Data Storage
  Future<void> setProfileData(ProfileData profileData) async {
    await setEncryptedValue('PROFILE_DATA', profileData);
  }

  Future<ProfileData?> getProfileData() async {
    final jsonObject = await getEncryptedValue<Map<String, dynamic>>(
      'PROFILE_DATA',
    );
    if (jsonObject == null) return null;
    return ProfileData.fromJson(jsonObject);
  }

  Future<void> deleteProfileData() async {
    await removeValue('PROFILE_DATA');
  }

  Future<void> updateProfileData(ProfileData profileData) async {
    await setProfileData(profileData);
  }

  Future<void> printPreferencesTable() async {
    try {
      // Query all rows from the 'preferences' table
      final List<Map<String, dynamic>> rows = await _db!.query('preferences');

      // Print the table structure (column names)
      if (rows.isNotEmpty) {
        print('Columns in "preferences" table: ${rows.first.keys.join(', ')}');
      }

      // Print each row
      print('\nContents of "preferences" table:');
      for (final row in rows) {
        print(row);
      }

      if (rows.isEmpty) {
        print('The "preferences" table is empty.');
      }
    } catch (e) {
      print('Error reading "preferences" table: $e');
    }
  }
}

Future<String> getDocumentsPath() async {
  if (kIsWeb) {
    // Simulate a logical path on Web
    print("Simulating documents directory for Web");
    return '/web_documents'; // or any other virtual path your app can recognize
  }

  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}
