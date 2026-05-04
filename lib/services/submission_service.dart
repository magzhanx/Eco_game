import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecogame/pages/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SubmissionService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static final FirebaseStorage _storage =
      FirebaseStorage.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  /// Загрузка файла в Firebase Storage
  static Future<String?> uploadFile(File? file, String folder) async {
    if (file == null) return null;

    try {
      final user = _auth.currentUser;
      if (user == null) {
        print("❌ User not logged in");
        return null;
      }

      final uid = user.uid;

      final ref = _storage.ref().child(
        '$folder/$uid/${DateTime.now().millisecondsSinceEpoch}',
      );

      print("⬆ Uploading: $folder");

      await ref.putFile(
        file,
        SettableMetadata(
          cacheControl: "public, max-age=31536000",
        ),
      );

      final url = await ref.getDownloadURL();

      print("✅ Upload success: $url");

      return url;
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }

  /// Отправка задания
  static Future<void> submitTask({
    required int taskId,
    required String taskTitle,
    required String taskDescription,
    required String taskBlock,
    String? text,
    File? image,
    File? video,
  }) async {
    final uid = _auth.currentUser!.uid;

    final imageUrl = await uploadFile(image, 'images');
    final videoUrl = await uploadFile(video, 'videos');
    final userDoc = await _firestore.collection('users').doc(uid).get();

    final userData = userDoc.data();
    final userName = userData?['name'] ?? 'Unknown';

    await _firestore.collection('submissions').add({
      'taskBlock': taskBlock,
      'name': userName,
      'userId': uid,
      'taskId': taskId,
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'text': text,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'status': 'pending',
      'feedback': '',
      'createdAt': Timestamp.now(),
    });
  }

  /// Получить pending задания для админа
  static Stream<QuerySnapshot> getPendingSubmissions() {
    return _firestore
        .collection('submissions')
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }

  /// Одобрить задание
  static Future<void> approveSubmission({
    required String submissionId,
    required String userId,
    required int taskId,
    required String taskBlock,

  }) async {
    await _firestore
        .collection('submissions')
        .doc(submissionId)
        .update({
      'status': 'approved',
    });

    final approvedTasks = await _firestore
        .collection('submissions')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'approved')
        .where('taskBlock', isEqualTo: taskBlock)
        .get();

    int completedInBlock = approvedTasks.docs.length;

    final currentBlock = taskBlocks.firstWhere(
          (block) => block.title == taskBlock,
    );

    int totalTasksInBlock = currentBlock.tasks.length;

    print('taskBlock: $taskBlock');
    print('completedInBlock: $completedInBlock');
    print('totalTasksInBlock: $totalTasksInBlock');

    await _firestore.collection('users').doc(userId).update({
      'points': FieldValue.increment(1000),
      'completedTasks': FieldValue.arrayUnion([taskId]),
    });

    if (completedInBlock >= totalTasksInBlock) {
      await _firestore.collection('users').doc(userId).update({
        'unlockedBlock': FieldValue.increment(1),
      });
    }
  }

  /// Отклонить задание
  static Future<void> rejectSubmission({
    required String submissionId,
    required String feedback,
  }) async {
    await _firestore
        .collection('submissions')
        .doc(submissionId)
        .update({
      'status': 'rejected',
      'feedback': feedback,
    });
  }

  static Future<Map<String, dynamic>?> getUserSubmission(int taskId) async {
    final uid = _auth.currentUser!.uid;

    final snapshot = await _firestore
        .collection('submissions')
        .where('userId', isEqualTo: uid)
        .where('taskId', isEqualTo: taskId)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;

    return snapshot.docs.first.data();
  }
}