import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ott_app/screens/homescreen/categories.dart';
import 'package:ott_app/screens/homescreen/homepage.dart';
import 'package:ott_app/screens/homescreen/profilepage.dart';
import 'package:ott_app/screens/homescreen/searchscreen.dart';


final bottomNavIndexProvider = StateProvider<int>((ref) => 0);


class BottomNavScreen extends ConsumerWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final List<Widget> screens = [
      const Homepage(),
       SearchScreen(),
      const CategoryScreen(),
      const AccountScreen(),

    ];
 
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          
          ref.read(bottomNavIndexProvider.notifier).state = index;
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}