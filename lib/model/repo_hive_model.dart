import 'package:hive_flutter/adapters.dart';
part 'repo_hive_model.g.dart';

@HiveType(typeId: 1)
class GitHubRepoHive {
  @HiveField(0)
  String? fullName;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? starCount;
  @HiveField(3)
  String? imageUrl;

  GitHubRepoHive({
    this.fullName,
    this.description,
    this.starCount,
    this.imageUrl,
  });
}
