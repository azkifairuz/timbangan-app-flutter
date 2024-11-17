import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timbangan_app/constant/constant.dart';
import 'package:timbangan_app/utils/SerialPortComunicate.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  List<String> availablePorts = [];
  String? selectedPort;
  String? selectedBaudRate;
  final List<String> baudRates = ["9600", "14400", "19200", "38400", "57600", "115200"];

  List<String> availablePrinterPorts = [];
  String? selectedPrinterPort;
  String? selectedPrinterBaudRate;
  final List<String> printerBaudRates = ["9600", "14400", "19200", "38400", "57600", "115200"];

  @override
  void initState() {
    super.initState();
    loadPorts();
    loadConfig();
  }

  Future<void> loadPorts() async {
    availablePorts = SerialPort.availablePorts;
    availablePrinterPorts = SerialPort.availablePorts;
    setState(() {});
  }

  Future<void> loadConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPort = prefs.getString('selectedPort');
      selectedBaudRate = prefs.getString('selectedBaudRate');
      selectedPrinterPort = prefs.getString('selectedPrinterPort');
      selectedPrinterBaudRate = prefs.getString('selectedPrinterBaudRate');
    });
  }

  Future<void> saveConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedPort', selectedPort ?? '');
    await prefs.setString('selectedBaudRate', selectedBaudRate ?? '');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Configuration saved successfully")),
    );
  }

  Future<void> savePrinterConfig() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedPrinterPort', selectedPrinterPort ?? '');
    await prefs.setString('selectedPrinterBaudRate', selectedPrinterBaudRate ?? '');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Configuration printer saved successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Port Configuration",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Port Configuration",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Select Port:", style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    value: selectedPort,
                    hint: const Text("Choose a port"),
                    items: availablePorts.map((port) {
                      return DropdownMenuItem<String>(
                        value: port,
                        child: Text(port),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPort = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text("Select Baud Rate:", style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    value: selectedBaudRate,
                    hint: const Text("Choose a baud rate"),
                    items: baudRates.map((rate) {
                      return DropdownMenuItem<String>(
                        value: rate,
                        child: Text(rate),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBaudRate = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    onPressed: saveConfig,
                    child: const Text("Save Configuration"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Printer Configuration",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Select Printer Port:", style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    value: selectedPrinterPort,
                    hint: const Text("Choose a printer port"),
                    items: availablePrinterPorts.map((port) {
                      return DropdownMenuItem<String>(
                        value: port,
                        child: Text(port),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPrinterPort = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text("Select Printer Baud Rate:", style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    value: selectedPrinterBaudRate,
                    hint: const Text("Choose a printer baud rate"),
                    items: printerBaudRates.map((rate) {
                      return DropdownMenuItem<String>(
                        value: rate,
                        child: Text(rate),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPrinterBaudRate = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    onPressed: savePrinterConfig,
                    child: const Text("Save Printer Configuration"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),],)
    );
  }
}
