import 'package:flutter/material.dart';

class SearchByZip extends StatefulWidget {
  final Function(String zip, String country) onZipChanged;//functin that will notify parent the zip and country

  const SearchByZip({super.key, required this.onZipChanged});

  @override
  State<SearchByZip> createState() => _SearchByZipState();
}

class _SearchByZipState extends State<SearchByZip> {
  final TextEditingController _zipController = TextEditingController();//controller for zip field
  final TextEditingController _countryController = TextEditingController();//controller for country field

  void _notifyParent() {//to notify parent with the call back function
    widget.onZipChanged(//calling the callback function
      _zipController.text.trim(),//sending the text of zipcontroller and send it as a parameter as zip
      _countryController.text.trim(),//sending the text of countryController and send it as a parameter as country
    );
    FocusScope.of(context).unfocus();//unfocussing it after submission and on tap outside
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        children: [
          TextField(//first text field for zip code
            controller: _zipController,
            onSubmitted: (_) => _notifyParent(),//after submission calling that call back function through notify parent
            onTapOutside: (event) => _notifyParent(),//same when tap outside
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
          TextField(//second text field for country code
            controller: _countryController,
            onSubmitted: (_) => _notifyParent(),
            onTapOutside: (event) => _notifyParent(),
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
