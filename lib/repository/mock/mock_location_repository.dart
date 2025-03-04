import 'package:app/model/ride/locations.dart';
import 'package:app/repository/location_repository.dart';

class MockLocationRepository extends LocationRepository {
  @override
  List<Location> getLocations() {
    return [
      Location(name: 'Phnom Penh', country: Country.kh),
      Location(name: 'Siem Reap', country: Country.kh),
      Location(name: 'Battambong', country: Country.kh),
      Location(name: 'Sihanoukville', country: Country.kh),
      Location(name: 'Kampot', country: Country.kh),
    ];
  }
}
