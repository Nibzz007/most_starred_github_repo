import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:thiran_tech_task_2/model/github_most_starred_repo_model.dart';
import 'package:http/http.dart' as http;

class GitHubRepoDataProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Item> itemList = [];
  int currentPage = 1;
  int perPage = 8;

  Future<void> getRepo(int page) async {
    try {
      String baseUrl =
          'https://api.github.com/search/repositories?q=created:>2022-04-29&sort=stars&order=desc&page=$page&per_page=$perPage';
      Uri url = Uri.parse(baseUrl);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<Item> newItems = GitHubModel.fromJson(jsonData).items;
        itemList.addAll(newItems);
        notifyListeners();
      } else {
        log('Error occurred');
      }
    } catch (e) {
      throw Exception("Error occurred, ${e.toString()}");
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
  // bool isLoading = false;
  // GitHubModel? gitHubModel;
  // List<Item> itemList = [];
  // int currentPage = 1;
  // int perPage = 6;

  // // Function for getting the data 

  // Future<GitHubModel?> getRepo() async {
  //   try {
  //     String baseUrl =
  //         'https://api.github.com/search/repositories?q=created:>2022-04-29&sort=stars&order=desc';
  //     Uri url = Uri.parse(baseUrl);
  //     final response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       GitHubModel data = GitHubModel.fromJson(jsonDecode(response.body));
  //       return data;
  //     } else {
  //       log('Error occured');
  //     }
  //   } catch (e) {
  //     throw Exception('Error occured, $e.toString()');
  //   }
  //   return null;
  // }

  // void getGitHubData() async {
  //   isLoading = true;
  //   gitHubModel = await getRepo();
  //   isLoading = false;
  //   notifyListeners();
  // }
}
