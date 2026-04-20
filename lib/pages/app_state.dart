import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int points = 0;
  int unlockedLevel = 1;
  Set<int> completedTasks = {};
  Map<int, String> taskImages = {};

  void completeTask(int level, String imagePath) {
    if (!completedTasks.contains(level)) {
      completedTasks.add(level);
      taskImages[level] = imagePath; //
      points += 1000;

      if (unlockedLevel < 10) {
        unlockedLevel++;
      }

      notifyListeners(); // 🔥 обновляет UI
    }
  }
}