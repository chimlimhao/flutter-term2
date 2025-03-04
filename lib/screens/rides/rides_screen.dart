import 'package:flutter/material.dart';
import 'package:app/screens/rides/widgets/ride_pref_bar.dart';

import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_prefs_service.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';

import 'widgets/rides_tile.dart';
import 'widgets/ride_pref_modal.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatefulWidget {
  final RidePreference ridePref;

  const RidesScreen({
    super.key,
    required this.ridePref,
  });

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  late RidePreference currentPreference;

  @override
  void initState() {
    super.initState();
    currentPreference = widget.ridePref;
    // Save the preference in the service
    RidePrefService.instance.setCurrentPreference(currentPreference);
  }

  List<Ride> get matchingRides =>
      RidesService.instance.getRidesFor(currentPreference);

  void onBackPressed() {
    // Save the current preference before going back
    RidePrefService.instance.setCurrentPreference(currentPreference);
    Navigator.of(context).pop(); //  Back to the previous view
  }

  void onPreferencePressed() async {
    // Show the modal with the current pref
    RidePreference? newPreference = await showModalBottomSheet<RidePreference>(
      context: context,
      isScrollControlled: true,
      builder: (context) => RidePrefModal(initialPreference: currentPreference),
    );

    // If we got a new preference from the modal
    if (newPreference != null) {
      // Update the service current pref
      RidePrefService.instance.setCurrentPreference(newPreference);
      // Update the view
      setState(() {
        currentPreference = newPreference;
      });
    }
  }

  void onFilterPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
            left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            // Top search Search bar
            RidePrefBar(
                ridePreference: currentPreference,
                onBackPressed: onBackPressed,
                onPreferencePressed: onPreferencePressed,
                onFilterPressed: onFilterPressed),

            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideTile(
                  ride: matchingRides[index],
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
