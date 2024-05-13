import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screen/bottom_navigation_bar.dart';
import 'package:weather_app/screen/home_screen.dart';

import '../bloc/weather_bloc.dart';

class SearchByCityNamePage extends StatefulWidget {
  const SearchByCityNamePage({super.key});

  @override
  State<SearchByCityNamePage> createState() => _SearchByCityNamePageState();
}

class _SearchByCityNamePageState extends State<SearchByCityNamePage> {
  String searchCityName = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 1.2 * kToolbarHeight, 20, 20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(8, -0.1),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF543868),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-8, -0.1),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF543868),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1.2),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  color: Color(0xFF5C2EE0),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Weather",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.transparent.withOpacity(0.2),
                        ),
                        child: TextFormField(
                          // controller: _textEditingController,
                          initialValue: searchCityName,
                          onChanged: (value) => setState(() {
                            searchCityName = value;
                          }),
                          maxLines: 2,
                          decoration: const InputDecoration(
                            isDense: true, // important line
                            contentPadding: EdgeInsets.all(7),
                            hintText: 'Search for a city',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                        if (searchCityName.isNotEmpty) {
                          BlocProvider.of<WeatherBloc>(context)
                              .add(FetchWeatherByCityName(searchCityName));

                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));

                          },
                          child: Text("GO")),


                    ],
                  ),

                  BlocBuilder<WeatherBloc, WeatherState>(builder: ( context, state) {
                    if (state is WeatherBlocSuccess){
                      return Column(
                        children: [
                          Text(state.weather.areaName!,style: TextStyle(color: Colors.white,fontSize: 20),),
                          Text(state.weather.tempMin.toString(),style: TextStyle(color: Colors.white,fontSize: 20),),

                        ],
                      );
                    }else{
                      return Text("noi");
                    }

                  },),
                  const SizedBox(height: 15),
                  SizedBox(
                    // color: Colors.pink,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: 5,
                      itemBuilder: (e, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent.withOpacity(0.3),
                          ),
                          child: const Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Weather",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Noida",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "35°C",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    "Sunny",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "H:32",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "L:26",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 10),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
