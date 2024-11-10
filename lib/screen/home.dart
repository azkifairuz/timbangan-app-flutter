import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timbangan_app/constant/constant.dart';

class ReadDataScale extends StatefulWidget {
  const ReadDataScale({super.key});

  @override
  State<ReadDataScale> createState() => _ReadDataScaleState();
}

class _ReadDataScaleState extends State<ReadDataScale> {
  bool isConnected = false;
  String dataFromPort = "No data";

  void toggleConnection() {
    setState(() {
      isConnected = !isConnected;
      dataFromPort = isConnected ? "Connected, waiting for data..." : "No connection";
    });
  }

  void refreshConnection() {
    setState(() {
      dataFromPort = "Refreshing data...";
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        dataFromPort = isConnected ? "Data from port: 123.45" : "No connection";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scale Connection",style: TextStyle(color: Colors.white),),
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
              onPressed: refreshConnection,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12), backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text("Refresh Connection"),
            ),
            const SizedBox(height: 50),

            // Teks besar untuk menampilkan data dari port
            Text(
              dataFromPort,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleConnection,
        backgroundColor: isConnected ? dangerColor : secondaryColor,
        child: Icon(isConnected ? Icons.disabled_visible : Icons.connect_without_contact,color: primaryColor,),
      ),
    );
  }
}
