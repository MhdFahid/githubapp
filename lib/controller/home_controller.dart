import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var isLoading = true.obs;
  var repositories = <dynamic>[].obs;
  var error = ''.obs;

  final String token;

  HomeController(this.token);

  @override
  void onInit() {
    super.onInit();
    fetchRepositories();
  }

  Future<void> fetchRepositories() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://api.github.com/user/repos'),
        headers: {
          'Authorization': 'token $token',
        },
      );

      if (response.statusCode == 200) {
        repositories.value = json.decode(response.body);
        error('');
      } else {
        error('Failed to load repositories');
      }
    } catch (e) {
      error('Error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
