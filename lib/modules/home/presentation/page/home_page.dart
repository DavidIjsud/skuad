import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skuadchallengue/modules/home/presentation/bloc/home_bloc.dart';
import 'package:skuadchallengue/modules/home/presentation/bloc/home_state.dart';
import 'package:skuadchallengue/modules/home/presentation/page/widgets/article_item.dart';

import '../bloc/home_events.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = context.read<HomeBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeBloc.add(GetArticlesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BlocBuilder<HomeBloc, HomeState>(builder: (_, homeState) {
          if (homeState.isLoadingArticles == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (homeState.articles != null && homeState.isSuccess == true) {
            return RefreshIndicator(
                onRefresh: () async {
                  _homeBloc.add(GetArticlesEvent());
                },
                child: ListView.builder(
                    itemCount: homeState.articles?.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final article = homeState.articles![index];
                      return ArticleItem(
                        storyTitle: article.storyTitle,
                        author: article.author,
                        createdAt: article.createdAt,
                      );
                    }));
          }

          return const SizedBox.shrink();
        }),
      )),
    );
  }
}
