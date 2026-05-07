import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Latihan 4: Icon & Text - 233040065'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Ikon 1: Home
            _buildNavItem(Icons.home, "Home", Colors.red, 32),
            // Ikon 2: Search
            _buildNavItem(Icons.search, "Search", Colors.green, 32),
            // Ikon 3: Library Music
            _buildNavItem(Icons.library_music, "Your Library", Colors.purple, 32),
            // Ikon 4: Diamond
            _buildNavItem(Icons.diamond, "Premium", Colors.blue, 32),
            // Ikon 5: Add
            _buildNavItem(Icons.add_box, "Create", Colors.orange, 32),
          ],
        ),
      ),
    ),
  ));
}

// Helper function untuk membuat Ikon + Teks di bawahnya
Widget _buildNavItem(IconData icon, String label, Color color, double size) {
  return Column(
    mainAxisSize: MainAxisSize.min, // Agar column tidak memakan semua ruang vertikal
    children: [
      Icon(
        icon,
        color: color,
        size: size,
      ),
      const SizedBox(height: 8), // Jarak antara ikon dan teks
      Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    ],
  );
}