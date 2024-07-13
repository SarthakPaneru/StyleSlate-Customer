import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key? key}) : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;
  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_bT2o5-AMBsFvMBvxxD-BcGVI0m-jNJhZuw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKAsFi7ZZFy334239AbNqiQPtWUfwrpDjI2w&s',
    'https://haircation.com/wp-content/uploads/2022/09/Screenshot-2022-09-20-133606-1024x574.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180.0,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: imgList
              .map((item) => GestureDetector(
                    onTap: () {
                      print('Tapped on $item');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        child: Stack(
                          children: <Widget>[
                            Image.network(item,
                                fit: BoxFit.cover, width: 1000.0),
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? const Color.fromRGBO(0, 0, 0, 0.9)
                    : const Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
