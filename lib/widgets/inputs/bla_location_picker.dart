import 'package:app/model/ride/locations.dart';
import 'package:app/service/locations_service.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/display/bla_divider.dart';
import 'package:app/widgets/inputs/bla_search_bar.dart';
import 'package:flutter/material.dart';

class BlaLocationPicker extends StatefulWidget {
  final Location? initLocation;

  const BlaLocationPicker({super.key, this.initLocation});

  @override
  State<StatefulWidget> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  String query = '';
  List<Location> filteredLocation = [];

  @override
  void initState() {
    super.initState();
    if (widget.initLocation != null) {
      query = widget.initLocation!.name;
    }
    // Initialize the filtered locations list
    queryLocations();
  }

  void queryLocations() async {
    setState(() {
      filteredLocation = LocationsService.filterLocationByName(query);
    });
  }

  void onLocationSelected(Location location) {
    Navigator.of(context).pop(location);
  }

  void onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(BlaSpacings.m),
          child: Column(
            children: [
              BlaSearchBar(
                onChanged: (text) {
                  query = text;
                  queryLocations();
                },
                onBackPressed: onBackPressed,
                initQuery: query,
              ),
              if (filteredLocation.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: filteredLocation.length,
                    itemBuilder: (ctx, index) => BlaLocationTile(
                      filteredLocation[index],
                      onPressed: () =>
                          onLocationSelected(filteredLocation[index]),
                      isLast: index == filteredLocation.length - 1,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlaLocationTile extends StatelessWidget {
  final Location location;
  final void Function() onPressed;

  // For the dividers
  final bool isLast;

  /// For current location tile and history tiles
  final IconData? leftIcon;

  const BlaLocationTile(
    this.location, {
    super.key,
    required this.onPressed,
    this.leftIcon,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: BlaSpacings.m),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: BlaSpacings.l),
              width: double.infinity,
              child: Row(
                children: [
                  if (leftIcon != null)
                    Icon(leftIcon, color: BlaColors.neutral),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          location.country.name,
                          style: TextStyle(color: BlaColors.textLight),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: BlaColors.neutral,
                  ),
                ],
              ),
            ),
            if (!isLast) BlaDivider(),
          ],
        ),
      ),
    );
  }
}
