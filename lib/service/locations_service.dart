import 'package:app/model/ride/locations.dart';
import 'package:app/repository/location_repository.dart';

///
/// This service handles:
/// - The list of available locations
///
class LocationsService {
  // Static repository instance
  static LocationsService? _instance;

  // Access to past preferences
  final LocationRepository repository;

  ///
  /// Private constructor
  ///
  LocationsService._internal(this.repository);

  ///
  /// Initialize
  ///
  static void initialize(LocationRepository repository) {
    if (_instance == null) {
      _instance = LocationsService._internal(repository);
    } else {
      throw Exception("LocationsService is already initialized.");
    }
  }

  ///
  /// Singleton accessor
  ///
  static LocationsService get instance {
    if (_instance == null) {
      throw Exception(
          "LocationsService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  // Get all available locations from the repository
  static List<Location> getAvailableLocations() {
    return _instance!.repository.getLocations();
  }

  // Filter locations by search text
  static List<Location> getLocationsFor(String searchText) {
    return _instance!.repository
        .getLocations()
        .where((location) =>
            location.name.toUpperCase().contains(searchText.toUpperCase()))
        .toList();
  }
}
