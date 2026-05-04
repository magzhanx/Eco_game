import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int points = 0;
  int unlockedLevel = 1;
  int unlockedBlock = 1;

  Set<int> completedTasks = {};
  Map<int, Map<String, dynamic>> taskResults = {};

  void setUnlockedLevel(int level) {
    unlockedLevel = level;
    notifyListeners();
  }

  void setUnlockedBlock(int block) {
    unlockedBlock = block;
    notifyListeners();
  }

  Future<void> loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;


    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists) {
      final data = doc.data()!;

      unlockedLevel = doc.data()?['unlockedLevel'] ?? 1;
      unlockedBlock = doc.data()?['unlockedBlock'] ?? 1;
      completedTasks = Set<int>.from(data['completedTasks'] ?? []);
      points = doc.data()?['points'] ?? 0;
      notifyListeners();
    }
  }

  void completeTask(int level, Map<String, dynamic> result) {
    completedTasks.add(level);
    taskResults[level] = result;

    if (level == unlockedLevel) {
      unlockedLevel++;
    }

    points += 1000;

    notifyListeners();
  }
}