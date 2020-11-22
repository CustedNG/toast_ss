import 'dart:async';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:simple_rc4/simple_rc4.dart';

abstract class ShadowsocksCipher {
  FutureOr<Uint8List> encode(Uint8List input, String key);
  FutureOr<Uint8List> decode(Uint8List input, String key);
}

class ShadowsocksCipherRc4 implements ShadowsocksCipher {
  ShadowsocksCipherRc4();

  @override
  Future<Uint8List> encode(Uint8List input, String password) async {
    final key = md5.convert(password.codeUnits).bytes;
    final rc4 = RC4.fromBytes(key);
    final bytes = rc4.encodeBytes(input);
    return Uint8List.fromList(bytes);
  }

  @override
  Future<Uint8List> decode(Uint8List input, String password) async {
    return encode(input, password);
  }
}

