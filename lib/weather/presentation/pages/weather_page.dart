import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/global_components/app_bar_title.dart';
import 'package:flutter_planner/global_components/gradient_button.dart';
import 'package:flutter_planner/global_components/login_field.dart';
import 'package:flutter_planner/login/bloc/auth_bloc.dart';
import 'package:flutter_planner/login/presentation/login_page.dart';
import 'package:flutter_planner/pallete.dart';
import 'package:flutter_planner/weather/bloc/weather_bloc.dart';
import 'package:flutter_planner/weather/presentation/components/additional_info_item.dart';
import 'package:flutter_planner/weather/presentation/components/hourly_forecast_item.dart';
import 'package:flutter_planner/weather/presentation/components/main_weather_card.dart';
import 'package:flutter_planner/utils/date_format.dart';
import 'package:flutter_planner/weather/presentation/components/weather_search_bar.dart';

/*
________________________________________________________________________________
  
  Route name: /weather
    Accessed by:
      Route /main-page
        main_page.dart with no arguments
    
    Access to:
      Route /
        /main_page.dart sending no arguments
________________________________________________________________________________

  Stateless class WeatherPage
    Displays current weather and conditions for a city

    Displays hourly weather with the temp and weather condition icon 
      it has 5 tiles that 3 hours apart in time with the predicted weather

    Displays Temp, humidity, pressure, wind speed, weather condition icon
________________________________________________________________________________

  State Manager: WeatherBloc
    WeatherFetched() - gets the current weather
________________________________________________________________________________
*/

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherPage> {
  final TextEditingController cityController =
      TextEditingController(text: "San Diego");
  final TextEditingController stController = TextEditingController(text: "CA");

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherFetched(
          city: cityController.text.trim(),
          st: stController.text.trim(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "Weather App",
        ),
        centerTitle: true,
        actions: [
          // Refetch weather data
          //
          IconButton(
            onPressed: () {
              context.read<WeatherBloc>().add(WeatherFetched(
                    city: cityController.text.trim(),
                    st: stController.text.trim(),
                  ));
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return const LoginPage();
          }

          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AuthFailure) {
            return const Center(
              child: Text("State is Auth Failure"),
            );
          }

          return BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              // If the current state has an error display the error
              // returned by the WeatherFailure
              //
              if (state is WeatherFailure) {
                return Center(
                  child: Text(state.error),
                );
              }

              // If the state is not WeatherSuccess display the spinning progress
              // indicator
              //
              if (state is! WeatherSuccess) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              // Set data to the current weather model
              //
              final data = state.weatherModel;

              // Displayed when state = WeatherSuccess
              //
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WeatherSearchBar(
                        cityController: cityController,
                        stController: stController,
                        onPressed: () {
                          context.read<WeatherBloc>().add(
                                WeatherFetched(
                                  city: cityController.text.trim(),
                                  st: stController.text.trim(),
                                ),
                              );
                          Navigator.pop(context);
                        },
                      ),

                      const SizedBox(height: 20),
                      // MainWeatherCard
                      // [sky] - String of the icon describing the weather
                      // [temp] - Number of the current temp
                      //
                      MainWeatherCard(
                          sky: data.currentSky, temp: data.currentTemp),

                      // Space between widgets
                      //
                      const SizedBox(height: 20),

                      // Start of Hourly forecast section
                      //
                      const Text(
                        'Hourly Forecast',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Space between widgets
                      //
                      const SizedBox(height: 8),

                      // Iterates through the ['list'] field and returns the hourly report
                      //
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            // Set data to the current hour being iterated
                            final data = state.weatherModel.hourlyWeather
                                .hourlyData[index + 1];

                            // formatTime - /utils/date_formate.dart
                            // formats the date "yyyy-MM-dd HH:mm:ss" to "h:mm a"
                            // requires one parameter that is a String of the time
                            //
                            String formattedTime = formatTime(data.hourTime);

                            // HourlyForecastItem
                            //  displays the hour weather tile
                            // [time] - String to display the time
                            // [temperature] - String to display the temp
                            // [sky] - String to determin the icon for the hours weather
                            //
                            return HourlyForecastItem(
                              time: formattedTime,
                              temperature: data.hourTemp.toStringAsFixed(1),
                              sky: data.hourSky,
                            );
                          },
                        ),
                      ),

                      // Space between widgets
                      //
                      const SizedBox(height: 20),

                      // Start of Additinaol information section at the bottom of page
                      // Displays the pressure, wind speed, and humidity
                      //
                      const Text(
                        'Additional Information',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Space between widgets
                      //
                      const SizedBox(height: 8),

                      // Row that contains the current weather data
                      // wind speed, humidity, and pressure
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AdditionalInfoItem(
                            icon: Icons.water_drop,
                            label: 'Humidity',
                            value: data.currentHumidity.toString(),
                          ),
                          AdditionalInfoItem(
                            icon: Icons.air,
                            label: 'Wind Speed',
                            value: data.currentWindSpeed.toString(),
                          ),
                          AdditionalInfoItem(
                            icon: Icons.beach_access,
                            label: 'Pressure',
                            value: data.currentPressure.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
