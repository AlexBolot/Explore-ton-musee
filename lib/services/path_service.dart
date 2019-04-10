import 'package:explore_ton_musee/widgets/carousel_item.dart';
import 'package:flutter/material.dart';

class PathService {
  Map _data = {
    PathName.Fast: {
      'map_path': 'assets/museum_map_fast.png',
      'items': [
        CarouselItem(label: 'Moyen Age', prefix: Image.asset('assets/badge_1.png')),
        CarouselItem(label: 'Egypte des Pharaons', prefix: Image.asset('assets/badge_2.png')),
        CarouselItem(label: 'Civilisation Future', prefix: Image.asset('assets/badge_3.png')),
      ]
    },
    PathName.Slow: {
      'map_path': 'assets/museum_map_slow.png',
      'items': [
        CarouselItem(label: 'Moyen Age', prefix: Image.asset('assets/badge_1.png')),
        CarouselItem(label: 'Renaissance', prefix: Image.asset('assets/badge_2.png')),
        CarouselItem(label: 'Période Gothique', prefix: Image.asset('assets/badge_3.png')),
        CarouselItem(label: 'Egypte des Pharaons', prefix: Image.asset('assets/badge_4.png')),
        CarouselItem(label: 'Civilisation Future', prefix: Image.asset('assets/badge_5.png')),
      ]
    },
    PathName.Children: {
      'map_path': 'assets/museum_map_children.png',
      'items': [
        CarouselItem(label: 'Atelier De Vinci', prefix: Image.asset('assets/badge_1.png')),
        CarouselItem(label: 'Démonstration armures', prefix: Image.asset('assets/badge_2.png')),
        CarouselItem(label: 'Jeux "ville et écologie"', prefix: Image.asset('assets/badge_3.png')),
      ]
    },
    PathName.English: {
      'map_path': 'assets/museum_map_english.png',
      'items': [
        CarouselItem(label: 'Medieval Age', prefix: Image.asset('assets/badge_1.png')),
        CarouselItem(label: 'Renaissance', prefix: Image.asset('assets/badge_2.png')),
        CarouselItem(label: 'Gothic period', prefix: Image.asset('assets/badge_3.png')),
        CarouselItem(label: 'Pharaon\'s Egypt', prefix: Image.asset('assets/badge_4.png')),
        CarouselItem(label: 'Civilisation of the future', prefix: Image.asset('assets/badge_5.png')),
        CarouselItem(label: 'Da Vinci workshop', prefix: Image.asset('assets/badge_6.png')),
        CarouselItem(label: 'Armor exhibit', prefix: Image.asset('assets/badge_7.png')),
        CarouselItem(label: 'Game "cities and ecology"', prefix: Image.asset('assets/badge_8.png')),
      ]
    },
    PathName.Default: {
      'map_path': 'assets/museum_map.png',
      'items': [CarouselItem(label: 'Pas de visite disponible', prefix: Container())]
    },
  };

  List<CarouselItem> itemsForPath(PathName pathName) => _data[pathName]['items'];

  ImageProvider mapForPath(PathName pathName) => AssetImage(_data[pathName]['map_path']);
}

enum PathName {
  Slow,
  Fast,
  Children,
  English,
  Default,
}
