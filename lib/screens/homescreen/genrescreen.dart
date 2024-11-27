import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  List<bool> selectedButtons = List<bool>.filled(10, false);

  final List<String> genres = [
    "Romance",
    "Horror",
    "Comedy",
    "Thriller",
    "Adventure",
    "Action",
    "Drama",
    "Sci-fi",
    "Mystery",
    "Romcom",
  ];

  void toggleSelection(int index) {
    setState(() {
      selectedButtons[index] = !selectedButtons[index];
    });
  }

  int getSelectedCount() {
    return selectedButtons.where((isSelected) => isSelected).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'images/genere background.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: const Color.fromRGBO(21, 21, 21, 0.8), 
              ),
            ),
            const Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Select Your Favourite Genre",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: 300,
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                     
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // first column
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: SizedBox(
                                  width: 150,
                                  height: 39,
                                  child: ElevatedButton(
                                    onPressed: () => toggleSelection(index),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: selectedButtons[index]
                                          ? const Color.fromRGBO(0, 160, 75, 0.4)
                                          : const Color.fromRGBO(0, 160, 75, 0.1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                          color: Color.fromRGBO(15, 70, 41, 1),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      genres[index],
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(width: 16.0), 
                          // second column
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: SizedBox(
                                  width: 150,
                                  height: 39,
                                  child: ElevatedButton(
                                    onPressed: () => toggleSelection(index + 5),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: selectedButtons[index + 5]
                                          ? const Color.fromRGBO(0, 160, 75, 0.4)
                                          : const Color.fromRGBO(0, 160, 75, 0.1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                          color: Color.fromRGBO(15, 70, 41, 1),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      genres[index + 5],
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0), 
                      // next button
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: getSelectedCount() >= 3
                              ? () {
                                  
                                }
                              : null, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getSelectedCount() >= 3
                                ? const Color.fromRGBO(5, 100, 49, 1)
                                : const Color.fromRGBO(0, 160, 75, 0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
