import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App', style: TextStyle(
          fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
            IconButton(
               onPressed: () {
                 print('refresh');
               },
               icon: Icon(Icons.refresh)
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //main card
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      
                      Text('30°C', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        ),
                      ),
                    const SizedBox(height: 16,),
                    Icon(
                      Icons.cloud, size: 64,
                      ),
                      const SizedBox(height: 16,),
                    Text(
                      'Rain',style: 
                        TextStyle(fontSize: 16
                       ),
                    )
                  ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
        
            const Placeholder(
              fallbackHeight: 150,
              
            ),
        
            const SizedBox(height: 20,),
        
        
             const Placeholder(
              fallbackHeight: 150,
              
            ),
        ],),
      ),
    );
  }
}