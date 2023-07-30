import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thiran_tech_task_2/controller/github_repo_data_controller.dart';
import 'package:thiran_tech_task_2/core/constant_color.dart';
import 'package:thiran_tech_task_2/core/constant_size.dart';
import 'package:thiran_tech_task_2/core/constant_textstyle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<GitHubRepoDataProvider>(context, listen: false).getGitHubData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GitHubRepoDataProvider>(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlack,
        elevation: 20,
        title: Text(
          'Most Starred Repositories',
          style: appBarTextStyle,
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    height: height * 0.15,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: kAmber),
                    child: Row(
                      children: [
                        kWidth10,
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(provider.gitHubModel!.items[index].owner.avatarUrl),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return kHeight10;
                },
                itemCount: provider.gitHubModel!.items.length,
              ),
            ),
    );
  }
}
