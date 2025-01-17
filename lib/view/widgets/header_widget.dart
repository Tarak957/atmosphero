import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/core/constants.dart';
import 'package:weather_app/controller/getx/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = '';
  DateTime dateTime = DateTime.now();
  final GlobalController controller =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getPlace(controller.getLatitude().value, controller.getLongitude().value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeights.minHeight(context),
        CustomHeights.minHeight(context),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: CustomColor.black,
                size: 30,
              ),
              CustomWidth.commonwidth(context),
              Text(
                city,
                style: CustomFuction.textStyleFuction(
                  size: 23,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.black,
                ),
              ),
            ],
          ),
        ),
        Text(
          DateFormat.yMMMMEEEEd().format(dateTime),
          style: CustomFuction.textStyleFuction(
              size: 14, fontWeight: FontWeight.w500, color: CustomColor.black),
        ),
      ],
    );
  }

  Future<void> getPlace(double lat, double log) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(lat, log);
    Placemark place = placeMark[0];
    setState(() {
      city = place.locality!;
    });
  }
}
