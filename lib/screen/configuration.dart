import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    loadPorts();
    loadConfig();
  }

  Future<void> loadPorts() async {
    // Retrieve available serial ports
    availablePorts = SerialPort.availablePorts;  // flutter_libserialport provides availablePorts directly
    setState(() {});
  }

  Future<void> loadConfig() async {
    // Load saved configuration from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPort = prefs.getString('selectedPort');
      selectedBaudRate = prefs.getString('selectedBaudRate');
    });
  }

  Future<void> saveConfig() async {
    // Save configuration to local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedPort', selectedPort ?? '');
    await prefs.setString('selectedBaudRate', selectedBaudRate ?? '');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Configuration saved successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Port Configuration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              onPressed: saveConfig,
              child: const Text("Save Configuration"),
            ),
          ],
        ),
      ),
    );
  }
}
