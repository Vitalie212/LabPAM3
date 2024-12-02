import 'package:flutter/material.dart';
import 'package:doctorappointment_v2/screens/home_screen.dart';

void main() => runApp(const DoctorAppointmentApp());

class DoctorAppointmentApp extends StatelessWidget {
  const DoctorAppointmentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Appointment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
