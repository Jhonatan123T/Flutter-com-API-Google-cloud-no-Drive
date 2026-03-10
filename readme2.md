Com um pequeno exemplo, podemos usar diversar IPI's como o google map usando a mesma base do ultimo projeto apenas mudando a API e pequenas coisas como


android>app>src>main>AndroidManifest.exml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="SUA_API_KEY_AQUI">

  Com o main.dart 

  import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MapScreen());
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.7749, -122.4194); // San Francisco

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: MarkerId('san_francisco'),
        position: _center,
        infoWindow: InfoWindow(
          title: 'São Francisco',
          snippet: 'Cidade conhecida pela Golden Gate Bridge',
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Example'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
        markers: _markers,
      ),
    );
  }
}

E o Pubspec

name: flutter_application_1
description: "A new Flutter project."
publish_to: 'none'
version: 0.1.0+1

environment:
  sdk: ^3.11.1

dependencies:
  flutter:
    sdk: flutter
  google_maps_flutter: ^2.2.0
  geolocator: ^9.0.2
  flutter_lints: ^6.0.0

flutter:
  uses-material-design: true



Com essa pequena diferença podemos fazer diversar alterações 
