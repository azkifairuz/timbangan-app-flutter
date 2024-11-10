import 'package:flutter/foundation.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SerialPortCommunication {
  static late SerialPort _serialPort;
  static late SerialPortConfig _config;
  static Future<void> openPort() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedPort = prefs.getString('selectedPort');
    String? selectedBaudRate = prefs.getString('selectedBaudRate');

    if (selectedPort == null || selectedBaudRate == null) {
      throw Exception('Port or Baud Rate not configured');
    }
    int baudRate = int.parse(selectedBaudRate);
    _config = SerialPortConfig()
      ..baudRate = baudRate
      ..bits = 8
      ..parity = SerialPortParity.none
      ..stopBits = 1;
    _serialPort = SerialPort(selectedPort);

    try {
      _serialPort.openReadWrite();
    }on SerialPortError catch (err, _){
      if (kDebugMode) {
        print(SerialPort.lastError);

      }}
  }
}