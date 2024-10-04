import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProjectController extends GetxController {
  final String projectName, userName, token;

  ProjectController({required this.projectName, required this.userName, required this.token});

  var branches = [].obs; 
  var commits = [].obs; 
  var isLoadingBranches = true.obs;
  var isLoadingCommits = true.obs;

  @override
  void onInit() {
    fetchBranches();
    fetchCommits();
    super.onInit();
  }

  // Fetch branches from GitHub API
  void fetchBranches() async {
    isLoadingBranches(true);
    try {
      final response = await http.get(
        Uri.parse('https://api.github.com/repos/$userName/$projectName/branches'),
        headers: {
          'Authorization': 'token $token',
        },
      );
      if (response.statusCode == 200) {
        branches.value = json.decode(response.body);
      } else {
        throw Exception('Failed to load branches');
      }
    } catch (e) {
      print('Error fetching branches: $e');
    } finally {
      isLoadingBranches(false);
    }
  }

  // Fetch commits from GitHub API
  void fetchCommits() async {
    isLoadingCommits(true);
    try {
      final response = await http.get(
        Uri.parse('https://api.github.com/repos/$userName/$projectName/commits'),
        headers: {
          'Authorization': 'token $token',
        },
      );
      if (response.statusCode == 200) {
        commits.value = json.decode(response.body);
      } else {
        throw Exception('Failed to load commits');
      }
    } catch (e) {
      print('Error fetching commits: $e');
    } finally {
      isLoadingCommits(false);
    }
  }
}
