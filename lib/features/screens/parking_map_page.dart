import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yatrify/features/widgets/app_button.dart';
import 'package:yatrify/utils/extensions.dart';

class ParkingMapPage extends StatefulWidget {
  const ParkingMapPage({super.key});

  @override
  State<ParkingMapPage> createState() => _ParkingMapPageState();
}

class _ParkingMapPageState extends State<ParkingMapPage> {
  GoogleMapController? mapController;

  final ValueNotifier<LatLng?> selectedLocation = ValueNotifier<LatLng?>(null);
  final ValueNotifier<bool> isLoading = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

 Future<void> getCurrentLocation() async {
    try {
      // 1. Check if GPS/Location Services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Prompt user to enable location services or set fallback
        debugPrint("Location services are disabled.");
        _setFallbackLocation();
        return;
      }

      // 2. Check Permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _setFallbackLocation();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _setFallbackLocation();
        return;
      }

      // 3. Get Current Position (with timeout to prevent hanging on Android)
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10), // ✅ Prevents infinite waiting
      );

      LatLng userLocation = LatLng(
        position.latitude,
        position.longitude,
      );

      selectedLocation.value = userLocation;

      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(userLocation, 16),
      );
    } catch (e) {
      debugPrint("Error fetching location: $e");
      _setFallbackLocation();
    } finally {
      // ✅ ALWAYS stop loading, no matter what happens!
      isLoading.value = false;
    }
  }

  // Fallback if user denies permissions or GPS is OFF
  void _setFallbackLocation() {
    // Default fallback position (e.g., center position or last saved position)
    selectedLocation.value ??= const LatLng(13.3409, 74.7421); // Default location
  }

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          label.selectParkingLocation,
          style: context.style.titleSmall!
              .copyWith(fontSize: 20, ),
        ),
      ),
      body: Stack(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: isLoading,
            builder: (context, loading, child) {
              if (loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ValueListenableBuilder<LatLng?>(
                valueListenable: selectedLocation,
                builder: (context, location, child) {
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: location!, // ✅ direct current location
                      zoom: 16,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                    onTap: (position) {
                      selectedLocation.value = position;
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId("parking"),
                        position: location,
                      )
                    },
                  );
                },
              );
            },
          ),
          ValueListenableBuilder<LatLng?>(
            valueListenable: selectedLocation,
            builder: (context, location, child) {
              if (location == null) {
                return const SizedBox();
              }

              return Stack(
                children: [
                  Positioned(
                    right: 20,
                    bottom: 100,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          mini: true,
                          heroTag: "zoomIn",
                          onPressed: () {
                            mapController?.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                          child: const Icon(Icons.add),
                        ),
                        const SizedBox(height: 10),
                        FloatingActionButton(
                          mini: true,
                          heroTag: "zoomOut",
                          onPressed: () {
                            mapController?.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          },
                          child: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: AppButton(
                        label: label.saveParking,
                        onPressed: () async {
                          await ParkingController.save(
                            location.latitude,
                            location.longitude,
                          );

                          Navigator.pop(context);
                        },
                      )),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class ParkingController {
  static final ValueNotifier<bool> isSaved = ValueNotifier(false);

  static const String latKey = "parking_lat";

  static const String lngKey = "parking_lng";

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    isSaved.value = prefs.containsKey(latKey) && prefs.containsKey(lngKey);
  }

  static Future<void> save(double lat, double lng) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(
      latKey,
      lat,
    );

    await prefs.setDouble(
      lngKey,
      lng,
    );

    isSaved.value = true;
  }

  static Future<Map<String, double>?> get() async {
    final prefs = await SharedPreferences.getInstance();

    double? lat = prefs.getDouble(latKey);

    double? lng = prefs.getDouble(lngKey);

    if (lat != null && lng != null) {
      return {
        "lat": lat,
        "lng": lng,
      };
    }

    return null;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(latKey);

    await prefs.remove(lngKey);

    isSaved.value = false;
  }
}
