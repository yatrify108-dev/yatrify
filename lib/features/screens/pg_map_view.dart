// import 'package:bookstay/core/models/pg.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class PgMapView extends StatefulWidget {
//   const PgMapView({super.key, required this.pgList});

//   final List<PgDetails> pgList;

//   @override
//   State<PgMapView> createState() => _PgMapViewState();
// }

// class _PgMapViewState extends State<PgMapView> {
//   final Map<MarkerId, Marker> _markers = {};
//   GoogleMapController? _mapController;

//   @override
//   void initState() {
//     super.initState();
//     _addPgMarkers();
//   }

//   void _addPgMarkers() {
//     for (var pg in widget.pgList) {
//       final id = MarkerId(pg.address.first.pgName);
//       final marker = Marker(
//           markerId: id,
//           position: LatLng(
//             double.parse(pg.address.first.lat),
//             double.parse(pg.address.first.long),
//           ),
//           infoWindow: InfoWindow(
//               title: pg.address.first.pgName,
//               snippet:
//                   '₹${pg.priceDetails.map((e) => e.price).reduce((a, b) => a < b ? a : b).toStringAsFixed(0)}'),
//           onTap: () {
//             _showPgDetailsPopup(pg);
//           });
//     }
//   }

//   void _showPgDetailsPopup(PgDetails pg) {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) => Container(
//         padding: const EdgeInsets.all(16),
//         height: 200,
//         child: Row(
//           children: [
//             Image.network(
//               pg.roomImage.first,
//               width: 100,
//               height: 100,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(pg.address.first.pgName,
//                       style: const TextStyle(fontWeight: FontWeight.bold)),
//                   Text(pg.address.first.roadName),
//                   Text(
//                       "₹${pg.priceDetails.map((e) => e.price).reduce((a, b) => a < b ? a : b).toStringAsFixed(0)}"),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       initialCameraPosition: CameraPosition(
//         target: LatLng(
//           double.parse(widget.pgList.first.address.first.lat),
//           double.parse(widget.pgList.first.address.first.long),
//         ),
//         zoom: 12,
//       ),
//       markers: _markers.values.toSet(),
//       onMapCreated: (controller)=> _mapController = controller,
//     );
//   }
// }
