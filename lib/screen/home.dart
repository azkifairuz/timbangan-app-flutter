import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timbangan_app/constant/constant.dart';
import 'package:timbangan_app/utils/SerialPortComunicate.dart';

class ReadDataScale extends StatefulWidget {
  const ReadDataScale({super.key});

  @override
  State<ReadDataScale> createState() => _ReadDataScaleState();
}

class _ReadDataScaleState extends State<ReadDataScale> {
  bool isConnected = false;
  String dataFromPort = "No data";

  void toggleConnection() async {
    final snackBar = SnackBar(content: Row(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(width: 16,),
        Text(isConnected? "Disconnecting..." : "Connecting...")
      ],
    ),
    duration: const Duration(days: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    if (isConnected) {
      setState(() {
        isConnected = false;
        dataFromPort = "No connection";
      });
      await SerialPortCommunication.closePort();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Disconnected successfully")),
      );
    } else {
      try {
        await SerialPortCommunication.openPort();
        setState(() {
          isConnected = true;
          dataFromPort = "Connected, waiting for data...";
        });
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Connected successfully")),
        );
      } catch (e) {
        setState(() {
          dataFromPort = "Failed to connect: $e";
        });
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to connect: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Scale Connection",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isConnected ? Icons.check_circle : Icons.error,
                  color: isConnected ? Colors.green : Colors.red,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  isConnected ? "Port Connected" : "No Connection",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: SerialPortCommunication.openPort,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text("Refresh Connection"),
            ),
            const SizedBox(height: 50),
            StreamBuilder<String>(
                stream: SerialPortCommunication.readData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Waiting for data...");
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return Text(
                      snapshot.data!,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    );
                  } else {
                    return const Text("No data received.");
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleConnection,
        backgroundColor: isConnected ? dangerColor : secondaryColor,
        child: Icon(
          isConnected ? Icons.disabled_visible : Icons.connect_without_contact,
          color: primaryColor,
        ),
      ),
    );
  }
}
