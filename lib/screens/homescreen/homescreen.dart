import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ott_app/screens/homescreen/homeprovider.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  Timer? _slideTimer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _stopAutoSlide();
    super.dispose();
  }


  void _startAutoSlide() {
    _slideTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      final currentIndex = ref.read(slideIndexProvider);
      final nextIndex = (currentIndex + 1) % 6; 
      ref.read(slideIndexProvider.notifier).updateIndex(nextIndex);
    });
  }


  void _stopAutoSlide() {
    _slideTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final slideIndex = ref.watch(slideIndexProvider);

    final slides = [
      {
        'image': 'images/moving image 1.png',
        'genres': ['|Action|', '|Adventure|', '|Thriller|'],
      },
      {
        'image': 'images/moving image 1.png',
        'genres': ['|Drama|', '|Romance|'],
      },
      {
        'image': 'images/moving image 1.png',
        'genres': ['|Comedy|', '|Family|'],
      },
      {
        'image': 'images/moving image 1.png',
        'genres': ['|Romance|', '|Drama|'],
      },
      {
        'image': 'images/moving image 1.png',
        'genres': ['|Horror|', '|Thriller|'],
      },
      {
        'image': 'images/moving image 1.png',
        'genres': ['|Sci-Fi|', '|Action|'],
      },
    ];

    final newSections = [
      {
        'heading': 'Because you watched Shaandaar',
        'images': [
          'images/moving image 1.png',
          'images/moving image 1.png',
          'images/moving image 1.png',
          'images/moving image 1.png',
        ],
      },
      {
        'heading': 'Latest Releases',
        'images': [
          'images/moving image 1.png',
          'images/moving image 1.png',
          'images/moving image 1.png',
          'images/moving image 1.png',
        ],
      },
      {
        'heading': 'Top 5 in India Today',
        'images': [
          'images/moving image 1.png',
          'images/moving image 1.png',
          'images/moving image 1.png',
          'images/moving image 1.png',
        ],
      },
      {
        'heading': 'Phoenix Specials',
        'images': [
          'images/moving image 1.png',
          'images/moving image 1.png',
          'images/moving image 1.png',
          'images/moving image 1.png',
        ],
      },
      {
        'heading': 'Coming Soon',
        'images': [
          'images/moving image 1.png',
          'images/moving image 1.png',
          'images/moving image 1.png',
          'images/moving image 1.png',
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1B15),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A7B6C46),
                      blurRadius: 50,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                child: Image.asset(
                  'images/logo.png',
                  fit: BoxFit.contain,
                  height: 100,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cast, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFF151515),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 3,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF003A1B),
                      Color(0xFF00A04B),
                      Color(0xFF003A1B),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(
                  children: [
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Image.asset(
                        slides[slideIndex]['image'] as String,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '4.5/5 ratings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        (slides[slideIndex]['genres'] as List<String>).length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              (slides[slideIndex]['genres'] as List<String>)[index],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Watch',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50),
                        backgroundColor: const Color(0xFF202126),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(slides.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              ref.read(slideIndexProvider.notifier).updateIndex(index);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: slideIndex == index ? Colors.white : Colors.grey,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Continue Watching',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(4, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/moving image 1.png',
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    for (var section in newSections)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: section['heading'] == 'Phoenix Specials'
                                  ? RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Phoenix',
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF00A04B)
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' Specials',
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Text(
                                      section['heading'] as String,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    (section['images'] as List<String>).length,
                                    (index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 16.0),
                                        child: Image.asset(
                                          (section['images'] as List<String>)[index],
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
