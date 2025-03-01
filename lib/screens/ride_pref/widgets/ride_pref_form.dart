import 'package:app/utils/date_time_util.dart';
import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  DateTime departureDate = DateTime.now();
  Location? arrival;
  int requestedSeats = 1;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();

    // Override with values from initRidePref if available
    if (widget.initRidePref != null) {
      departure = widget.initRidePref?.departure;
      departureDate = widget.initRidePref?.departureDate ?? departureDate;
      arrival = widget.initRidePref?.arrival;
      requestedSeats = widget.initRidePref?.requestedSeats ?? requestedSeats;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void onLocationSwap() {
    final tempDeparture = departure;
    departure = arrival;
    arrival = tempDeparture;
  }

  void onDepartureTap() {}

  void onArrivalTap() {}

  void onDepartureDateTap() {}

  void onRequestedSeatsTap() {}

  void onSearchPressed() {}

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  Widget buildInput(
    BuildContext context,
    Icon icon,
    String label,
    Color labelColor,
    void Function()? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: BlaSpacings.s, horizontal: BlaSpacings.m),
        child: Row(
          children: [
            icon,
            const SizedBox(width: BlaSpacings.s),
            Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontWeight: FontWeight.w500,
                fontSize: BlaSpacings.m,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDepartureInput(BuildContext context) {
    String departureLabel = 'Leaving from';
    Color departureLabelColor = Colors.black;
    if (departure == null) {
      departureLabel = departureLabel;
      departureLabelColor = BlaColors.neutralLight;
    } else {
      departureLabel = departure!.name;
      departureLabelColor = BlaColors.neutralDark;
    }
    return InkWell(
      onTap: onDepartureTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: BlaSpacings.s, horizontal: BlaSpacings.m),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(Icons.radio_button_off_outlined,
                      color: BlaColors.neutralLight, size: BlaSpacings.l),
                  const SizedBox(width: BlaSpacings.s),
                  Text(
                    departureLabel,
                    style: TextStyle(
                      color: departureLabelColor,
                      fontWeight: FontWeight.w500,
                      fontSize: BlaSpacings.m,
                    ),
                  ),
                ],
              ),
            ),
            if (departure != null)
              InkWell(
                onTap: onLocationSwap,
                child: Icon(Icons.swap_horiz, color: BlaColors.primary),
              )
          ],
        ),
      ),
    );
  }

  Widget buildArrivalInput(BuildContext context) {
    String arrivalLabel = 'Going to';
    Color arrivalLabelColor = Colors.black;
    if (arrival == null) {
      arrivalLabel = arrivalLabel;
      arrivalLabelColor = BlaColors.neutralLight;
    } else {
      arrivalLabel = arrival!.name;
      arrivalLabelColor = BlaColors.neutralDark;
    }
    return InkWell(
      onTap: onArrivalTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: BlaSpacings.s, horizontal: BlaSpacings.m),
        child: Row(
          children: [
            Icon(Icons.radio_button_off_outlined,
                color: BlaColors.neutralLight, size: BlaSpacings.l),
            const SizedBox(width: BlaSpacings.s),
            Text(
              arrivalLabel,
              style: TextStyle(
                color: arrivalLabelColor,
                fontWeight: FontWeight.w500,
                fontSize: BlaSpacings.m,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDepartureDateInput(BuildContext context) {
    String departureDateLabel = DateTimeUtils.formatDateTime(departureDate);
    return InkWell(
      onTap: onDepartureDateTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: BlaSpacings.s, horizontal: BlaSpacings.m),
        child: Row(
          children: [
            Icon(Icons.calendar_month_outlined,
                color: BlaColors.neutralLight, size: BlaSpacings.l),
            const SizedBox(width: BlaSpacings.s),
            Text(
              departureDateLabel,
              style: TextStyle(
                color: BlaColors.neutralDark,
                fontWeight: FontWeight.w600,
                fontSize: BlaSpacings.m,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRequestedSeatsInput(BuildContext context) {
    String requestedSeatsLabel = requestedSeats.toString();
    return InkWell(
      onTap: onRequestedSeatsTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: BlaSpacings.s, horizontal: BlaSpacings.m),
        child: Row(
          children: [
            Icon(Icons.person_outline_rounded,
                color: BlaColors.neutralLight, size: BlaSpacings.l),
            const SizedBox(width: BlaSpacings.s),
            Text(
              requestedSeatsLabel,
              style: TextStyle(
                color: BlaColors.neutralDark,
                fontWeight: FontWeight.w500,
                fontSize: BlaSpacings.m,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildDepartureInput(context),
          const Divider(height: 1, thickness: 1, indent: 20, endIndent: 20),
          buildArrivalInput(context),
          const Divider(height: 1, thickness: 1, indent: 20, endIndent: 20),
          buildDepartureDateInput(context),
          const Divider(height: 1, thickness: 1, indent: 20, endIndent: 20),
          buildRequestedSeatsInput(context),
          InkWell(
            onTap: onSearchPressed,
            child: Container(
              padding: const EdgeInsets.all(BlaSpacings.m),
              color: BlaColors.primary,
              child: Center(
                child: Text('Search',
                    style: BlaTextStyles.button.copyWith(
                        color: BlaColors.white, fontWeight: FontWeight.w500)),
              ),
            ),
          )
        ]);
  }
}
