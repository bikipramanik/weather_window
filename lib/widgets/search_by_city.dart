import 'package:flutter/material.dart';

class SearchByCity extends StatefulWidget {
  final Function(String)
  onCityChanged; //this is a callback function which is used to update the city name

  const SearchByCity({super.key, required this.onCityChanged});

  @override
  State<SearchByCity> createState() => _SearchByCityState();
}

class _SearchByCityState extends State<SearchByCity> {
  final TextEditingController _cityController =
      TextEditingController(); //this the controller for getting all the text that we typed at the Text Field

  String cityName = "";//local varible that will help to update the parent city name variable

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _notifyParent() {
    //funtion to store the cityName and unfocus the textField
    final cityName = _cityController.text.trim();//stroing it locally
    widget.onCityChanged(cityName);//storing it to the parent widget
    FocusScope.of(context).unfocus();//unfocusing it 
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        controller: _cityController,//controller that is used to controll the City Name text field
        onSubmitted: (value) => _notifyParent(),//after submitted function
        onTapOutside: (event) => _notifyParent(),//outside tapping fucntion
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
