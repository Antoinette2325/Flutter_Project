import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: LeaderboardList(),
    );
  }
}

class LeaderboardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy('score', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
              child: Text(
                  'No data available. Check your Firestore collection and fields.'));
        }

        List<DocumentSnapshot> users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            var userData = users[index].data() as Map<String, dynamic>;
            String username = userData['username'];
            int score = userData['score'];

            return ListTile(
              title: Text(username),
              subtitle: Text('Score: $score'),
            );
          },
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LeaderboardScreen(),
  ));
}
