import 'package:explore_ton_musee/services/path_service.dart';
import 'package:explore_ton_musee/services/service_provider.dart';
import 'package:explore_ton_musee/widgets/carousel_item.dart';
import 'package:explore_ton_musee/widgets/colored_badge.dart';
import 'package:explore_ton_musee/widgets/zoomable_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';

class PathActivity extends StatefulWidget {
  static const String routeName = "/PathActivity";

  final String title;
  final PathName pathName;

  const PathActivity({this.title = 'Visite', this.pathName = PathName.Default});

  @override
  _PathActivityState createState() => _PathActivityState();
}

class _PathActivityState extends State<PathActivity> {
  double carouselHeight = 70;
  PathService _pathService;

  List<CarouselItem> _items = [];
  ImageProvider _mapProvider;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pathService = ServiceProvider.pathService;
    _items = _pathService.itemsForPath(widget.pathName);
    _mapProvider = _pathService.mapForPath(widget.pathName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        alignment: Alignment(0, -1),
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(height: carouselHeight),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ZoomableImage(
                      image: _mapProvider,
                      backgroundColor: Colors.white,
                      minScale: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.grey[200],
            width: double.infinity,
            child: CarouselSlider(
              viewportFraction: 1.0,
              height: carouselHeight,
              items: _items,
              enableInfiniteScroll: false,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }
}
