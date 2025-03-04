import 'package:app/model/ride/locations.dart';

abstract class LocationRepository {
  List<Location> getLocations();
}
