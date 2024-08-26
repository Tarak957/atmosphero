import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/core/constants.dart';
import 'package:weather_app/controller/getx/global_controller.dart';
import 'package:weather_app/model/hourly_weather_model.dart';

class WeathersHourly extends StatefulWidget {
  const WeathersHourly(
      {super.key, required this.weatherDataHourly, required this.screenSize});
  final WeatherDataHourly weatherDataHourly;
  final Size screenSize;

  @override
  State<WeathersHourly> createState() => _WeathersHourlyState();
}

class _WeathersHourlyState extends State<WeathersHourly> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollForward() {
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollBackward() {
    _scrollController.animateTo(
      _scrollController.offset - 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                scrollBackward();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              alignment: Alignment.topCenter,
              child: Text(
                'Today',
                style: CustomFuction.textStyleFuction(
                    size: 18, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                scrollForward();
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
          ],
        ),
        hourlyList()
      ],
    );
  }

  Widget hourlyList() {
    final cardInd = GlobalController().getIndex();
    return Container(
      color: Colors.transparent,
      height: widget.screenSize.height * 0.18,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.weatherDataHourly.hourlyModel.length > 15
            ? 15
            : widget.weatherDataHourly.hourlyModel.length,
        itemBuilder: (context, index) {
          return Obx(
            () => Container(
              width: widget.screenSize.width * 0.23,
              margin: const EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(
                      0.5,
                      0,
                    ),
                    blurRadius: 30,
                    spreadRadius: 1,
                    color: CustomColor.dividerLine.withAlpha(200),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    CustomColor.grey.withOpacity(0.8),
                    CustomColor.white,
                  ],
                ),
              ),
              child: hourlyDetails(
                temp: widget.weatherDataHourly.hourlyModel[index].temp!.floor(),
                timeStamp:
                    widget.weatherDataHourly.hourlyModel[index].dt!.floor(),
                weatherIcon: widget
                    .weatherDataHourly.hourlyModel[index].weather![0].icon!,
                index: index,
                cardInd: cardInd.toInt(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget hourlyDetails(
      {required int temp,
      required int timeStamp,
      required String weatherIcon,
      required int index,
      required cardInd}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: CustomColor.black),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset('assets/weather/$weatherIcon.png',
              height: 40, width: 40),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            '$temp°',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: CustomColor.black),
          ),
        ),
      ],
    );
  }
}

String getTime(final timeStamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1250);
  String x = DateFormat.jm().format(dateTime);
  return x;
}
