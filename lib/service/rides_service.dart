import 'package:app/model/ride/ride.dart';
import 'package:app/model/ride_pref/ride_pref.dart';
import 'package:app/repository/rides_repository.dart';

/// Class to aggregate filters for ride search
class RidesFilter {
  final bool? acceptPets;

  RidesFilter({this.acceptPets});
}

///
/// This service handles:
/// - The list of available rides
///
class RidesService {
  // Static private instance
  static RidesService? _instance;

  // Repository instance
  final RidesRepository repository;

  // Private constructor
  RidesService._internal(this.repository);

  ///
  /// Initialize
  ///
  static void initialize(RidesRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("RidesService is already initialized.");
    }
  }

  ///
  /// Singleton accessor
  ///
  static RidesService get instance {
    if (_instance == null) {
      throw Exception(
          "RidesService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  /// Return the relevant rides, given the passenger preferences and filters
  List<Ride> getRidesFor(RidePreference preferences, {RidesFilter? filter}) {
    return repository.getRides(preferences, filter);
  }
}
