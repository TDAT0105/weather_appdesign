import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_appdesign/additional_info_item.dart';
import 'package:weather_appdesign/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_appdesign/secret.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String,dynamic>> getCurrentWeather() async {
    try {
      String cityname = 'saigon';
      final res = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityname&APPID=$openWeatherAPIKEY'));
          
      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                print('refresh');
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
        print(snapshot);
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator.adaptive(
              )
            );
        }
        if(snapshot.hasError){
          return Center(child: Text(snapshot.error.toString()));
        }
        
        final data = snapshot.data;
        
        final currentWeatherData = data?['list'][0];

        final currentWeatherTemp = currentWeatherData['main']['temp'];
        final currentSky = currentWeatherData['weather'][0]['main'];
        final currentPressure = currentWeatherData['main']['pressure'];
        final currentWindSpeed = currentWeatherData['wind']['speed'];
        final currentHumdity = currentWeatherData['main']['humidity'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentWeatherTemp',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                              const SizedBox(height: 16),
                               Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain' ?  Icons.cloud : Icons.sunny,
                                size: 64,
                              ),
                              const SizedBox(height: 16),
                               Text(
                                currentSky,
                                style:const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                const Text('Weather Forecast',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),

                const SizedBox(
                  height: 16,
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyForecastItem(
                        time: '3:00',
                        icon: Icons.brightness_3,
                        tempurature: '25',
                      ),
                      HourlyForecastItem(
                        time: '6:00',
                        icon: Icons.cloud,
                        tempurature: '30',
                      ),
                      HourlyForecastItem(
                        time: '9:00',
                        icon: Icons.sunny,
                        tempurature: '35',
                      ),
                      HourlyForecastItem(
                        time: '12:00',
                        icon: Icons.sunny,
                        tempurature: '37',
                      ),
                      HourlyForecastItem(
                        time: '14:00',
                        icon: Icons.sunny,
                        tempurature: '34',
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const Text('Addtional Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),

                const SizedBox(
                  height: 16,
                ),

               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AddtionalInfoItem(
                      icon: Icons.water_drop_rounded,
                      label: 'Humidity',
                      value: currentHumdity.toString(),
                    ),
                    AddtionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AddtionalInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
