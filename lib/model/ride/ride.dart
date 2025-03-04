import 'package:app/model/ride/locations.dart';

import '../../utils/date_time_util.dart';
import '../user/user.dart';

enum RideStatus {
  created,
  published,
  ongoing,
  finished;
}

///
/// This model describes a Ride.
///
class Ride {
  final Location departureLocation;
  final DateTime departureDate;
  final Location arrivalLocation;
  final Duration duration;
  final User driver;
  final int availableSeats;
  final double pricePerSeat;
  final bool acceptsPets;

  RideStatus status = RideStatus.created;
  final List<User> passengers = [];

  DateTime get arrivalDateTime => departureDate.add(duration);

  Ride({
    required this.departureLocation,
    required this.departureDate,
    required this.arrivalLocation,
    required this.duration,
    required this.driver,
    required this.availableSeats,
    required this.pricePerSeat,
    this.acceptsPets = false,
  });

  void addPassenger(User passenger) {
    passengers.add(passenger);
  }

  int get remainingSeats => availableSeats - passengers.length;

  @override
  String toString() {
    return 'Ride from $departureLocation at ${DateTimeUtils.formatDateTime(departureDate)} '
        'to $arrivalLocation arriving at ${DateTimeUtils.formatDateTime(arrivalDateTime)}, '
        'Driver: $driver, Seats: $availableSeats, Price: \$${pricePerSeat.toStringAsFixed(2)}, '
        'Accepts Pets: ${acceptsPets ? 'Yes' : 'No'}';
  }
}
