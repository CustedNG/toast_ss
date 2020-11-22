import 'dart:io';
import 'dart:typed_data';

import 'package:shadowsocks/ss_address.dart';
import 'package:shadowsocks/ss_cipher.dart';

class ShadowsocksClient {
  ShadowsocksClient({this.server, this.port, this.cipher, this.password});

  final InternetAddress server;
  final int port;
  final ShadowsocksCipher cipher;
  final String password;

  Stream<Uint8List> request(ShadowsocksAddress address, Uint8List data) async* {
    final connection = await Socket.connect(server, port);
    print('connection $connection');

    final payload = Uint8List.fromList(address.encode() + data);
    connection.add(await cipher.encode(payload, password));
    final flush = await connection.flush();
    print('flush $flush');

    await for (var data in connection) {
      print('data ${data.length}');
      final decodedBytes = await cipher.decode(data, password);
      yield decodedBytes;
    }
  }
}