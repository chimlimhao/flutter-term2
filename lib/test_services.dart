import 'service/rides_service.dart';

void testRidesService() {
  // 1. Get all available rides from RidesService
  final allRides = RidesService.availableRides;

  // 2. Filter rides for today
  final today = DateTime.now();
  final todayRides = allRides
      .where((ride) =>
          ride.departureDate.year == today.year &&
          ride.departureDate.month == today.month &&
          ride.departureDate.day == today.day)
      .toList();

  // 3. Display the rides
  print('Available rides for today:');
  print('------------------------');

  if (todayRides.isEmpty) {
    print('No rides available today.');
  } else {
    for (final ride in todayRides) {
      print('From: ${ride.departureLocation.name}');
      print('To: ${ride.arrivalLocation.name}');
      print('Time: ${ride.departureDate}');
      print('Price: €${ride.pricePerSeat}');
      print('Available seats: ${ride.availableSeats}');
      print('Driver: ${ride.driver.firstName} ${ride.driver.lastName}');
      print('------------------------');
    }
  }
}
