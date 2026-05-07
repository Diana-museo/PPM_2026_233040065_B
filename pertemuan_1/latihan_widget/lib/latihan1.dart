import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Halo Flutter!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Ini teks biasa dengan ukuran kecil',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey
                ),
              ),
            ],
          ),
        ),
      ),
  ));
}