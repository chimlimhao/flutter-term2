import 'package:app/model/ride/locations.dart';

import '../dummy_data/dummy_data.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  static const List<Location> availableLocations =
      fakeLocations; // TODO for now fake data

  static List<Location> filterLocationByName(String name) {
    String query = name.toLowerCase();
    return availableLocations
        .where((location) => location.name.toLowerCase().contains(query))
        .toList();
  }
}
