
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);
class SlideIndexNotifier extends StateNotifier<int> {
  SlideIndexNotifier() : super(0);
  void updateIndex(int index) {
    state = index;
  }
}
final slideIndexProvider = StateNotifierProvider<SlideIndexNotifier, int>((ref) {
  return SlideIndexNotifier();
});