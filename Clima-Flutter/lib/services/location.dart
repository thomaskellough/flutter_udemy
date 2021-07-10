import 'package:geolocator/geolocator.dart';

class LocationService {

  Position lastPosition;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      lastPosition = position;
    } catch (e) {
      print(e);
    }
  }
}
