import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Latihan 3: 6 Jenis Alignment - 233040065'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView( // Agar bisa di-scroll jika layar penuh
        child: Column(
          children: [
            _buildRowSection("1. .start (Tumpuk di kiri)", MainAxisAlignment.start),
            _buildRowSection("2. .center (Tumpuk di tengah)", MainAxisAlignment.center),
            _buildRowSection("3. .end (Tumpuk di kanan)", MainAxisAlignment.end),
            _buildRowSection("4. .spaceBetween (Ujung ke ujung)", MainAxisAlignment.spaceBetween),
            _buildRowSection("5. .spaceAround (Setengah jarak di tepi)", MainAxisAlignment.spaceAround),
            _buildRowSection("6. .spaceEvenly (Jarak sama rata)", MainAxisAlignment.spaceEvenly),
          ],
        ),
      ),
    ),
  ));
}

// Helper function supaya kode kamu tidak panjang dan rapi
Widget _buildRowSection(String title, MainAxisAlignment alignment) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          color: Colors.grey[200], // Background abu agar terlihat batas Row
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: alignment,
            children: [
              Container(width: 40, height: 40, color: Colors.blue),
              Container(width: 40, height: 40, color: Colors.red),
              Container(width: 40, height: 40, color: Colors.green),
            ],
          ),
        ),
        const Divider(),
      ],
    ),
  );
}