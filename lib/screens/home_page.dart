import 'package:apiweatherapp/data/image_path.dart';
import 'package:apiweatherapp/services/location_provider.dart';
import 'package:apiweatherapp/services/weather_service_provider.dart';
import 'package:apiweatherapp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {

    final locationProvider=Provider.of<LocationProvider>(context,listen: false);

    locationProvider.determinePosition().then((_){
      if(locationProvider.currentLocationName!=null){
        var city=locationProvider.currentLocationName!.locality;
        if(city!=null){
          Provider.of<WeatherServiceProvider>(context,listen: false).fetchWeatherDataByCity("Perintalmanna");
        }
      }
    } );
    // Provider.of<LocationProvider>(context, listen: false).determinePosition();
    //
    // Provider.of<WeatherServiceProvider>(context,listen: false).fetchWeatherDataByCity("Dubai");
    super.initState();
  }
  TextEditingController _cityController=TextEditingController();
  @override
  void dispose() {
   _cityController.dispose();
    super.dispose();
  }

  bool _clicked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final locationProvider = Provider.of<LocationProvider>(context);
    final weatherProvider = Provider.of<WeatherServiceProvider>(context);

   int sunriseTimestamp=weatherProvider.weather?.sys?.sunrise??0;
    int sunsetTimestamp=weatherProvider.weather?.sys?.sunset??0;

    //conver the timestamp to a DateTime object

    DateTime sunriseDateTime=DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp*100);
    DateTime sunsetDateTime=DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp*100);
    //Format the sunrise time as a string

    String formattedSunrise=DateFormat.Hm().format(sunriseDateTime);
    String formattedSunset=DateFormat.Hm().format(sunsetDateTime);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 65, left: 30, right: 20, bottom: 20),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(background[weatherProvider.weather?.weather?[0].main??"N/A"]??"assets/img/clouds.jpg"), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Container(
              height: 50,
              child: Consumer<LocationProvider>(
                  builder: (context, locationProvider, child){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(

                                    fw: FontWeight.w700,
                                    size: 18,
                                    color: Colors.white, text: locationProvider.currentLocationName?.locality?? "Unknown",
                                  ),
                                  const CustomText(
                                    text: "Good Morning",
                                    fw: FontWeight.w400,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            print("IconButton pressed");
                            setState(() {
                              _clicked = !_clicked;
                            });
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 32,
                            color: Colors.white, // Add this line to specify the icon color
                          ),
                        )

                      ],
                    );
                  }),
            ),
            Align(
              alignment: const Alignment(0, -.6),
              child: Image.asset(
                imagePath[weatherProvider.weather?.weather?[0].main??"N/A"]??"assets/img/default.png",
                height: 150,
                width: 150,
              ),
            ),
            Align(
              alignment: Alignment(0, 0),
              child: Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text:"${weatherProvider.weather?.main?.temp?.toStringAsFixed(0)??"21"}\u00B0 C" ,
                      size: 30,
                      color: Colors.white,
                      fw: FontWeight.bold,
                    ),
                    CustomText(
                      text:weatherProvider.weather?.name??"Kochi",
                      color: Colors.white,
                      size: 22,
                      fw: FontWeight.w600,
                    ),
                     CustomText(
                      text: weatherProvider.weather?.weather?[0].main??"snow",
                      color: Colors.white,
                      size: 20,
                      fw: FontWeight.w600,
                    ),
                    CustomText(
                      text: DateFormat("hh:mm:a").format(DateTime.now()),
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, .75),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.4)),
                height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/temperature-high.png",
                              height: 55,
                            ),
                             Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Temp Max",
                                  size: 14,
                                  fw: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                CustomText(
                                  text: "${weatherProvider.weather?.main?.tempMax?.toStringAsFixed(0)}\u00B0 C"??"N/A",
                                  size: 14,
                                  fw: FontWeight.w600,
                                  color: Colors.white,
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Image.asset(
                             "assets/img/temperature-low.png",
                              height: 55,
                            ),
                             Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Temp Min",
                                  size: 14,
                                  fw: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                CustomText(
                                  text: "${weatherProvider.weather?.main?.tempMin?.toStringAsFixed(0)}\u00B0 C"??"N/A",
                                  size: 14,
                                  fw: FontWeight.w600,
                                  color: Colors.white,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/sun.png",
                              height: 55,
                            ),
                             Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Sunrise",
                                  size: 14,
                                  fw: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                CustomText(
                                  text: "${formattedSunrise} AM",
                                  size: 14,
                                  fw: FontWeight.w600,
                                  color: Colors.white,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/moon.png",
                              height: 55,
                            ),
                             Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Sunset",
                                  size: 14,
                                  fw: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                CustomText(
                                  text:
                                  "${formattedSunset} PM",
                                  size: 14,
                                  fw: FontWeight.w600,
                                  color: Colors.white,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment(0, -.8),
              child: Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          hintText: "Search by city",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),

                    IconButton(onPressed:(){
                      print("_cityController.text");
                      weatherProvider.fetchWeatherDataByCity(_cityController.text);
                    }, icon: Icon(Icons.search))
                  ],

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
