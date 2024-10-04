import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:githubapp/firebase_options.dart';
import 'package:githubapp/screens/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
      title: 'GitHub Auth App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final String token;
  final User user; // Include User parameter

  const HomePage({Key? key, required this.token, required this.user})
      : super(key: key);

  // Fetch user repositories from GitHub
  Future<List<dynamic>> _fetchRepositories() async {
    final response = await http.get(
      Uri.parse('https://api.github.com/user/repos'),
      headers: {
        'Authorization': 'token $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load repositories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Repositories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Display user information
          UserAccountsDrawerHeader(
            accountName: Text(user.displayName ?? 'No Name'),
            accountEmail: Text(user.email ?? 'No Email'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL ?? ''),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _fetchRepositories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No repositories found.'));
                }

                final repositories = snapshot.data!;

                return ListView.builder(
                  itemCount: repositories.length,
                  itemBuilder: (context, index) {
                    final repo = repositories[index];
                    return ListTile(
                      title: Text(repo['name']),
                      subtitle: Text(repo['description'] ?? 'No description'),
                      onTap: () {
                        // Handle repository tap (optional)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tapped on ${repo['name']}')),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
