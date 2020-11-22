import 'dart:io';

class ShadowsocksClient {
  ShadowsocksClient({this.server, this.port, this.cipher, this.password});

  final InternetAddress server;
  final int port;
  final String cipher;
  final String password;
}
