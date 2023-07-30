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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<GitHubRepoDataProvider>(context, listen: false).getGitHubData();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll == currentScroll) {
        Provider.of<GitHubRepoDataProvider>(context, listen: false)
            .loadMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GitHubRepoDataProvider>(context);
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
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (index == provider.itemList.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (index > provider.itemList.length) {
                    return const Text('No more items available');
                  } else {
                    final item = provider.itemList[index];
                    return ListTile(
                      tileColor: kBlack12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(item.owner.avatarUrl),
                      ),
                      title: Text(
                        item.fullName.toUpperCase(),
                        style: listTileTitleStyle,
                      ),
                      subtitle: Text(
                        item.description ?? 'No description available',
                        style: listTileDescriptionStyle,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_border,
                            size: 20,
                            color: kBlack,
                          ),
                          kWidth5,
                          Text(
                            item.stargazersCount.toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: kBlack,
                              title: Text(
                                item.name.toUpperCase(),
                                style: alertDialogTitleStyle,
                              ),
                              content: Text(
                                item.description ?? 'No description',
                                style: alertDialogDescriptionStyle,
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
                separatorBuilder: (context, index) => kHeight10,
                itemCount: provider.itemList.length + 1,
              ),
            ),
    );
  }
}
