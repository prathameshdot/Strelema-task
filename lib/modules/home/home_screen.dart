import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import '../profile/profile_screen.dart';
import '../que/que_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController ctrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        title: const Text('Available Quizzes', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'My Profile',
            onPressed: () => Get.to(() => ProfileScreen()),
          ),
        ],
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (ctrl.ques.isEmpty) {
          return const Center(
            child: Text(
              'No quizzes available right now.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: ctrl.fetchQues,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: ctrl.ques.length,
            itemBuilder: (context, index) {
              final q = ctrl.ques[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: Colors.yellow.shade100,
                    child: const Icon(Icons.quiz, color: Colors.black),
                  ),
                  title: Text(
                    q.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(q.desc, style: const TextStyle(color: Colors.black54)),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.black),
                  onTap: () {
                    Get.to(() => QueScreen(queModel: q));
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
