import 'package:flutter/material.dart';

class SearchByZip extends StatefulWidget {
  final Function(String zip, String country) onZipChanged;

  const SearchByZip({super.key, required this.onZipChanged});

  @override
  State<SearchByZip> createState() => _SearchByZipState();
}

class _SearchByZipState extends State<SearchByZip> {
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  void _notifyParent() {
    widget.onZipChanged(
      _zipController.text.trim(),
      _countryController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        children: [
          TextField(
            controller: _zipController,
            onChanged: (_) => _notifyParent(),
            cursorHeight: 25,
            cursorColor: Colors.blueAccent,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: 'Enter zip code...',
              prefixIcon: const Icon(Icons.pin_drop, color: Colors.blueAccent),
              filled: true,
              fillColor: const Color.fromARGB(255, 236, 241, 238),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Colors.blueAccent,
                  width: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _countryController,
            onChanged: (_) => _notifyParent(),
            cursorHeight: 25,
            cursorColor: Colors.blueAccent,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: 'Country code',
              prefixIcon: const Icon(
                Icons.flag_outlined,
                color: Colors.blueAccent,
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 236, 241, 238),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Colors.blueAccent,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
