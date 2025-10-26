import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final VoidCallback onSearchPressed;

  const SearchButton({super.key, required this.onSearchPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ElevatedButton.icon(
        onPressed: onSearchPressed,
        icon: const Icon(Icons.location_on_outlined, color: Colors.white),
        label: const Text(
          "Search Weather",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          shadowColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
