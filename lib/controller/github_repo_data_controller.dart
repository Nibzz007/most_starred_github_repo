import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:thiran_tech_task_2/model/github_most_starred_repo_model.dart';
import 'package:http/http.dart' as http;

class GitHubRepoDataProvider extends ChangeNotifier {
  bool isLoading = false;
  GitHubModel? gitHubModel;

  getRepo() async {
    try {
      String baseUrl =
          'https://api.github.com/search/repositories?q=created:>2022-04-29&sort=stars&order=desc';
      Uri url = Uri.parse(baseUrl);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = GitHubModel.fromJson(jsonDecode(response.body));
        return data;
      } else {
        print('Error occured');
      }
    } catch (e) {
      throw Exception('Error occured, $e.toString()');
    }
  }

  getGitHubData() async {
    isLoading = true;
    gitHubModel = await getRepo();
    isLoading = false;
    notifyListeners();
  }
}
