import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thiran_tech_task_2/model/github_most_starred_repo_model.dart';
import 'package:http/http.dart' as http;

class GitHubRepoDataProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Item> itemList = [];
  int currentPage = 1;
  int perPage = 10;

  getDate() {
    var now = DateTime.now();
    var lastThirtyDays = now.subtract(const Duration(days: 30));
    var format = DateFormat('yyyy-MM-dd').format(lastThirtyDays);
    return format;
  }

  Future<void> getRepo(int page) async {
    try {
      String baseUrl =
          'https://api.github.com/search/repositories?q=created:>${getDate()}&sort=stars&order=desc&page=$page&per_page=$perPage';
      Uri url = Uri.parse(baseUrl);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<Item> newItems = GitHubModel.fromJson(jsonData).items;
        itemList.addAll(newItems);
      } else {
        log('Error occurred');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> loadMoreData() async {
    currentPage++;
    await getRepo(currentPage);
  }

  Future<void> getGitHubData() async {
    isLoading = true;
    await getRepo(currentPage);
    isLoading = false;
    notifyListeners();
  }
}
