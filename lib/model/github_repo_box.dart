import 'package:hive/hive.dart';
import 'package:thiran_tech_task_2/model/repo_hive_model.dart';

class RepoBox {
  static Box<GitHubRepoHive>? box;
  static Box<GitHubRepoHive> getBox() {
    return box ??= Hive.box<GitHubRepoHive>('repo');
  }
}
