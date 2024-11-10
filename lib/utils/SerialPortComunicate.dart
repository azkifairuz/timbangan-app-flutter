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
    SerialPortConfig()
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

   Future<void> writeData(String data) async {
    try{
      _serialPort.write(_stringToUint8List(data));

    }on SerialPortError catch (err,_){
      if (kDebugMode) {
        print(SerialPort.lastError);
      }
    }
  }

  Uint8List _stringToUint8List(String data) {
    List<int> codeUnits = data.codeUnits;
    Uint8List uint8list = Uint8List.fromList(codeUnits);
    return uint8list;
  }
}