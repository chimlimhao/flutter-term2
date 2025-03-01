import 'package:flutter/material.dart';

import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';
import '../../utils/date_time_util.dart';

class RidesScreen extends StatefulWidget {
  final RidePref ridePref;

  const RidesScreen({super.key, required this.ridePref});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  late List<Ride> matchingRides;

  @override
  void initState() {
    super.initState();
    // Get matching rides based on the ride preferences
    matchingRides = RidesService.getRidesFor(widget.ridePref);
  }

  void onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: BlaColors.neutralDark),
          onPressed: onBackPressed,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.ridePref.departure.name} → ${widget.ridePref.arrival.name}",
              style: TextStyle(
                color: BlaColors.neutralDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${DateTimeUtils.formatDateTime(widget.ridePref.departureDate)}, ${widget.ridePref.requestedSeats} passenger${widget.ridePref.requestedSeats > 1 ? 's' : ''}",
              style: TextStyle(
                color: BlaColors.neutralLight,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: matchingRides.isEmpty ? _buildNoRidesFound() : _buildRidesList(),
    );
  }

  Widget _buildNoRidesFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: BlaColors.neutralLight,
          ),
          const SizedBox(height: 16),
          Text(
            "No rides found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: BlaColors.neutralDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Try changing your search criteria",
            style: TextStyle(
              fontSize: 16,
              color: BlaColors.neutralLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRidesList() {
    return ListView.separated(
      itemCount: matchingRides.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        thickness: 1,
        color: BlaColors.greyLight,
      ),
      itemBuilder: (context, index) {
        final ride = matchingRides[index];
        return RideTile(
            ride: ride, requestedSeats: widget.ridePref.requestedSeats);
      },
    );
  }
}

class RideTile extends StatelessWidget {
  final Ride ride;
  final int requestedSeats;

  const RideTile({
    super.key,
    required this.ride,
    required this.requestedSeats,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to ride details
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateTimeUtils.formatTime(ride.departureDate),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: BlaColors.neutralDark,
                  ),
                ),
                Text(
                  "€${ride.pricePerSeat.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: BlaColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(ride.driver.profilePicture),
                ),
                const SizedBox(width: 8),
                Text(
                  "${ride.driver.firstName} ${ride.driver.lastName}",
                  style: TextStyle(
                    fontSize: 14,
                    color: BlaColors.neutralDark,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.person,
                  size: 16,
                  color: BlaColors.neutralLight,
                ),
                const SizedBox(width: 4),
                Text(
                  "${ride.remainingSeats} seat${ride.remainingSeats > 1 ? 's' : ''} left",
                  style: TextStyle(
                    fontSize: 14,
                    color: BlaColors.neutralLight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
