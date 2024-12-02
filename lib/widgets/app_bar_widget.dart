import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> locations;
  final String selectedLocation;
  final ValueChanged<String?> onLocationChanged;

  CustomAppBar({
    required this.locations,
    required this.selectedLocation,
    required this.onLocationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_sharp, color: Colors.black),
              SizedBox(width: 8),
              DropdownButton<String>(
                value: selectedLocation,
                items: locations.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors.black)),
                  );
                }).toList(),
                onChanged: onLocationChanged,
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.notifications_active, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
