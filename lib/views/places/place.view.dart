import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clapp/providers/place.provider.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';

class PlaceView extends StatelessWidget {
  const PlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final PlaceProvider placeProvider = Provider.of<PlaceProvider>(context);
    final Size size = MediaQuery.of(context).size;
    final place = placeProvider.place;
    final images = place?.images;
    final courts = place?.groupedCourts;
    return Scaffold(
      appBar: AppBar(
        title: Text(place?.name ?? ''),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(LineAwesomeIcons.alternate_share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (images != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CarouselSlider(
                  items: images
                      .map(
                        (img) => CachedNetworkImage(
                          imageUrl: img.image,
                          width: size.width,
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                  ),
                ),
              ),
            if (courts != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Canchas disponibles',
                  style: AppTheme.headers.headerLg,
                ),
              ),
            if (courts != null)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: courts.keys
                    .map((k) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: courts[k]!
                              .map((c) => ListTile(
                                    leading: Icon(c.sport?.icon),
                                    title: Text(c.name ?? ''),
                                    subtitle: Text(c.formattedPrice),
                                    trailing: TextButton(
                                      onPressed: () {},
                                      child: const Text('Reservar'),
                                    ),
                                  ))
                              .toList(),
                        ))
                    .toList(),
              ),
            SizedBox(
              width: size.width,
              height: 300,
              child: FlutterMap(
                options: MapOptions(
                  center: const LatLng(51.509364, -0.128928),
                  zoom: 14,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: const LatLng(51.509364, -0.128928),
                        width: 30,
                        height: 30,
                        builder: (context) => Icon(
                          Icons.location_on,
                          color: Colors.red[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(place?.fullAddress ?? ''),
          ],
        ),
      ),
    );
  }
}
