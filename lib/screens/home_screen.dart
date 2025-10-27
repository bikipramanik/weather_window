import 'package:flutter/material.dart';
import 'package:weather_window/models/weather_model.dart';
import 'package:weather_window/services/weather_service.dart';
import 'package:weather_window/widgets/search_button.dart';
import 'package:weather_window/widgets/search_by_city.dart';
import 'package:weather_window/widgets/search_by_zip.dart';
import 'package:weather_window/widgets/weather_report.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // to notify which search mode using -> Search by city or zip
  bool zipMode = false; 

  String cityName = ""; // City name when searching using city
  String zipCode = ""; // zip code when searching using zip mode
  String countryCode = ""; // // country code when searching using zip mode


//instance of weather Service which is used to call the api
  final WeatherService _weatherService = WeatherService(); 

// the model which we will be getting after calling the API
  WeatherModel?  _weatherData;
  // checking the laoding state -> is calling or is finished calling 
  bool _isLoading =  false; 

  void updateCity(String newCity) {
    // after writing the City name in Text Field updating the city using this function
    cityName = newCity; // city which is typed updating as cityName
  }

  void updateZip(String newZipCode, String newCountryCode) {
    // after writing the zip and country in ZipMode updating the varibales
    zipCode = newZipCode; // updating the new ZipCode
    countryCode = newCountryCode; // updating the new country code
  }

  Future<void> searchWeather() async {
    //Search weather button onpress function -> this will actually call the API
    if (!zipMode && cityName.isEmpty) {
      // if Zip Mode is not true means Searching by city and then City is empty show an warning message and return without calling the API
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter city name")),
      ); //showing the SnackBar after getting empty cityName
      return; //return the function don't have to call the API
    } else if (zipMode && (zipCode.isEmpty || countryCode.isEmpty)) {
      //in Zip Mode if the zip and country is empty we don't need to call the API
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter ZIP code and Country code")),
      ); //showing warning about the required fields
      return; // return without calling the API
    }

    setState(() {
      // if all the condintion false then we can call the API so here we are updating isLoading as true
      _isLoading = true;
    });


//initializing the varibale to store the result after calling API
    WeatherModel? result; 


// if in ZIP mode call the ZIP API
    if (zipMode) {
      result = await _weatherService.fetchWeatherByZipCode(
        zipCode,
        countryCode,
      );
    } else {
      //IF not call the Weather by city Name API
      result = await _weatherService.fetchWeatherByCityName(cityName);
    }

    setState(() {
      //here we are updating the state after getting the API result
      _weatherData =
          result; //updating the weatherData variable with result that we got
      _isLoading = false; //making is Loading as false as we got Loading is done
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("Weather Window"),
        actions: [
          IconButton(
            onPressed: () => setState(
              () => zipMode = !zipMode,
            ), //toggling the Zip Mode in the app bar
            icon: zipMode
                ? const Icon(Icons.numbers) //if zip mode on then show this Icon
                : const Icon(
                    Icons.location_city_rounded,
                  ), //if not then show this Icon
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          zipMode //here in ListView the first child is also dynamic
              ? SearchByZip(
                  onZipChanged: updateZip,
                ) //If zip Mode on then show the Search by Zip widget, and also the callback function which is curcial for updating the city
              : SearchByCity(
                  onCityChanged: updateCity,
                ), ////If zip Mode is not on then show the Search by city widget, callback fucntion parameter for updating zip,country

          const SizedBox(height: 10),

          SearchButton(
            onSearchPressed: searchWeather,
          ), //search button which have also a callback function that is responsibe for calling the API

          const SizedBox(height: 20),

          if (_isLoading) // if it is loading
            const Center(child: CircularProgressIndicator()) //show buffer
          else if (_weatherData != null) //is it has data like data is not null
            WeatherReport(
              weather: _weatherData!,
            ) //show the UI of weather report
          else //if is null
            const Center(
              child: Row(
                children: [
                  Icon(Icons.search),
                  Text(
                    "Enter a city or zip code to get started",
                  ), //showing that you need to put the fields and search
                ],
              ),
            ),
        ],
      ),
    );
  }
}
