import 'dart:io';

import 'dart:typed_data';

abstract class ShadowsocksAddress {
  Uint8List encode();
}

class ShadowsocksAddressIp implements ShadowsocksAddress {
  ShadowsocksAddressIp(this.address, this.port);

  final InternetAddress address;
  final int port;

  @override
  Uint8List encode() {
    if (address.type == InternetAddressType.IPv4) {
      return _encodeIpv4();
    } else {
      return _encodeIpv6();
    }
  }

  Uint8List _encodeIpv4() {
    // 1-byte type, 4-byte address, 2-byte port
    final addr = Uint8List(1 + 4 + 2);
    addr[0] = 0x01;
    addr.setAll(1, address.rawAddress);
    addr.buffer.asByteData().setUint16(5, port);
    return addr;
  }

  Uint8List _encodeIpv6() {
    // 1-byte type, 16-byte address, 2-byte port
    final addr = Uint8List(1 + 16 + 2);
    addr[0] = 0x04;
    addr.setAll(1, address.rawAddress);
    addr.buffer.asByteData().setUint16(17, port);
    return addr;
  }
}

class ShadowsocksAddressHostname implements ShadowsocksAddress {
  ShadowsocksAddressHostname(this.host, this.port);

  final String host;
  final int port;

  @override
  Uint8List encode() {
    final hostEncoded = host.codeUnits;
    final dataLength = 1 + 1 + hostEncoded.length + 2;
    final addr = Uint8List(dataLength);
    addr[0] = 0x03;
    addr[1] = hostEncoded.length;
    addr.setAll(1 + 1, hostEncoded);
    addr.buffer.asByteData().setUint16(1 + 1 + hostEncoded.length, port);
    return addr;
  }
}
