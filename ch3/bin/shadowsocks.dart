import 'dart:convert';
import 'dart:io';

import 'package:shadowsocks/ss_address.dart';
import 'package:shadowsocks/ss_cipher.dart';
import 'package:shadowsocks/ss_client.dart';

void main(List<String> arguments) async {
  final client = ShadowsocksClient(
    server: InternetAddress.tryParse('89.163.224.142'),
    port: 666,
    cipher: ShadowsocksCipherRc4(),
    password: 'dongtaiwang.com 123abc',
  );

  final requestData = 'GET / HTTP/1.1\r\nHost:google.com\r\n\r\n';

  final stream = client.request(
    ShadowsocksAddressHostname('google.com', 80),
    utf8.encode(requestData),
  );

  await for (var data in stream) {
    print(utf8.decode(data));
  }
}
