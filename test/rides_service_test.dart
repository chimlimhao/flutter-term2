import 'package:app/model/ride/locations.dart';
import 'package:app/model/ride_pref/ride_pref.dart';
import 'package:app/repository/mock/mock_rides_repository.dart';
import 'package:app/service/rides_service.dart';
import 'package:test/test.dart';

void main() {
  // Initialize the RidesService with MockRidesRepository
  RidesService.initialize(MockRidesRepository());

  // Test 1: Search rides without pet filter
  test('T1: Search rides without pet filter', () {
    // 1 - Create ride preference
    final preference = RidePreference(
      departure: Location(name: 'Battambong', country: Country.kh),
      arrival: Location(name: 'Siem Reap', country: Country.kh),
      departureDate: DateTime.now(),
      requestedSeats: 1,
    );

    // 2 - Get rides
    final rides = RidesService.instance.getRidesFor(preference);

    // 3 - Sort rides by departure time
    rides.sort((a, b) {
      // First sort by hour
      int hourCompare = a.departureDate.hour.compareTo(b.departureDate.hour);
      if (hourCompare != 0) return hourCompare;
      // If same hour, sort by minute
      return a.departureDate.minute.compareTo(b.departureDate.minute);
    });

    // 4 - Print results
    print(
        '\nFor your preference (${preference.departure.name} -> ${preference.arrival.name}, today, 1 passenger) we founded ${rides.length} rides:');
    for (final ride in rides) {
      final hour = ride.departureDate.hour;
      final minute = ride.departureDate.minute;
      final period = hour < 12 ? 'am' : 'pm';
      final displayHour = hour > 12 ? hour - 12 : hour;
      print(
          '- at $displayHour.${minute.toString().padLeft(2, '0')} $period\twith ${ride.driver.firstName} (${ride.duration.inHours} hours)');
    }

    // 5 - Assertions
    expect(rides.length, 4,
        reason: 'Should find 4 rides (excluding the full one)');
    expect(rides.any((ride) => ride.availableSeats == 0), false,
        reason: 'Should not include full rides');
    print('\nWarning: 1 ride is full!');
  });

  // Test 2: Search rides with pet filter
  test('T2: Search rides with pet filter', () {
    // 1 - Create ride preference
    final preference = RidePreference(
      departure: Location(name: 'Battambang', country: Country.kh),
      arrival: Location(name: 'Siem Reap', country: Country.kh),
      departureDate: DateTime.now(),
      requestedSeats: 1,
    );

    // 2 - Create pet filter
    final filter = RidesFilter(acceptPets: true);

    // 3 - Get rides
    final rides = RidesService.instance.getRidesFor(preference, filter: filter);

    // 4 - Sort rides by departure time
    rides.sort((a, b) {
      // First sort by hour
      int hourCompare = a.departureDate.hour.compareTo(b.departureDate.hour);
      if (hourCompare != 0) return hourCompare;
      // If same hour, sort by minute
      return a.departureDate.minute.compareTo(b.departureDate.minute);
    });

    // 5 - Print results
    print(
        '\nFor your preference (${preference.departure.name} -> ${preference.arrival.name}, today, 1 passenger, with pets) we found ${rides.length} ride:');
    for (final ride in rides) {
      final hour = ride.departureDate.hour;
      final minute = ride.departureDate.minute;
      final period = hour < 12 ? 'am' : 'pm';
      final displayHour = hour > 12 ? hour - 12 : hour;
      print(
          '- at $displayHour.${minute.toString().padLeft(2, '0')} $period\twith ${ride.driver.firstName} (${ride.duration.inHours} hours)');
    }

    // 6 - Assertions
    expect(rides.length, 1, reason: 'Should find 1 ride that accepts pets');
    expect(rides.first.driver.firstName, 'Limhao',
        reason: 'The ride should be with Limhao');
  });
}
