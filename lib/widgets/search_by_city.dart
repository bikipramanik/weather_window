import 'package:flutter/material.dart';


class SearchByCity extends StatefulWidget {
  final Function(String) onCityChanged;

  const SearchByCity({
    super.key,
    required this.onCityChanged,

  });

  @override
  State<SearchByCity> createState() => _SearchByCityState();
}

class _SearchByCityState extends State<SearchByCity> {
  final TextEditingController _cityController = TextEditingController();

  String cityName = "";

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void searchWeather() {
    final cityName = _cityController.text.trim();
    widget.onCityChanged(cityName);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
              controller: _cityController,
              onSubmitted: (value) => searchWeather(),
              onTapOutside: (event) => searchWeather(),
              cursorHeight: 25,
              cursorColor: Colors.blueAccent,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                hintText: 'Enter city name...',
                prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
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
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
                  
                ),
              ),
            ),
    );
  }
}
