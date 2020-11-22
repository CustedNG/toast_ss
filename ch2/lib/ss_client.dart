import 'dart:io';

import 'ss_cipher.dart';

class ShadowsocksClient {
  ShadowsocksClient({this.server, this.port, this.cipher, this.password});

  final InternetAddress server;
  final int port;
  final ShadowsocksCipher cipher;
  final String password;
}
