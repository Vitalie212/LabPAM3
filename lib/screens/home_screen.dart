import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/doctor_model.dart';
import '../models/medical_center_model.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/carousel_slider_widget.dart';
import '../widgets/category_icon_widget.dart';
import '../widgets/doctor_card_widget.dart';
import '../widgets/medical_center_card_widget.dart';
import '../widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> locations = [
    'Seattle, USA',
    'New York, USA',
    'Los Angeles, USA'
  ];
  String selectedLocation = 'Seattle, USA';
  int activeIndex = 0;

  List<BannerModel> banners = [];
  List<CategoryModel> categories = [];
  List<MedicalCenterModel> nearbyCenters = [];
  List<DoctorModel> doctors = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = json.decode(response);
    setState(() {
      banners = (data['banners'] as List)
          .map((json) => BannerModel.fromJson(json))
          .toList();
      categories = (data['categories'] as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
      nearbyCenters = (data['nearby_centers'] as List)
          .map((json) => MedicalCenterModel.fromJson(json))
          .toList();
      doctors = (data['doctors'] as List)
          .map((json) => DoctorModel.fromJson(json))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #################### App Bar ####################
      appBar: CustomAppBar(
        locations: locations,
        selectedLocation: selectedLocation,
        onLocationChanged: (newValue) {
          setState(() {
            selectedLocation = newValue!;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // #################### Search Bar ####################
              SearchBarWidget(),
              SizedBox(height: 20),

              // #################### Carousel Slider ####################
              CarouselSliderWidget(
                imagePaths: banners.map((banner) => banner.image).toList(),
                onPageChanged: (index) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
              SizedBox(height: 20),

              // #################### Categories ####################
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Categories',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('See All', style: TextStyle(color: Colors.grey)),
                ],
              ),
              SizedBox(height: 10),

              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: categories.map((category) {
                  return CategoryIconWidget(
                    imagePath: category.icon,
                    title: category.title, // Fixed
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // #################### Nearby Medical Centers ####################
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nearby Medical Centers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('See All', style: TextStyle(color: Colors.grey)),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: nearbyCenters.length,
                  itemBuilder: (context, index) {
                    return MedicalCenterCard(center: nearbyCenters[index]);
                  },
                ),
              ),
              SizedBox(height: 20),

              // #################### Doctor List ####################
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('532 Found',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text('Default', style: TextStyle(color: Colors.grey)),
                      Icon(Icons.compare_arrows, color: Colors.grey),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 10),
              Column(
                children: doctors
                    .map((doctor) => DoctorCard(doctor: doctor))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
