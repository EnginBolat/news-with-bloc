import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_with_bloc/constants/app_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/app_text.dart';
import '../core/cubit/news_cubit_cubit.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..fetchNews(ApiConst.topHeadlines),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppText.appName),
          centerTitle: false,
        ),
        body: BlocConsumer<NewsCubit, NewsCubitState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is NewsCubitInitial) {
              return _buildLoading();
            } else if (state is NewsCantLoaded) {
              return _buildError(state);
            } else if (state is NewsLoaded) {
              return _buildListView(state);
            } else {
              return _buildLoading();
            }
          },
        ),
      ),
    );
  }

  Widget _buildListView(NewsLoaded state) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          _buildCategorysButton(),
          _buildNewsList(state),
        ],
      ),
    );
  }

  Padding _buildCategorysButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ApiConst.categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<NewsCubit>()
                        .fetchNews(ApiConst.categories[index]);
                  },
                  child: Text(ApiConst.categoriesName[index],
                      textAlign: TextAlign.center),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  SizedBox _buildNewsList(NewsLoaded state) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 170,
      child: ListView.builder(
        itemCount: state.news.length,
        itemBuilder: (context, index) {
          var item = state.news[index];
          return GestureDetector(
            onTap: () => _launchUrl(item.url ?? ""),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: SizedBox(
                    height: 500,
                    width: 100,
                    child: FadeInImage.assetNetwork(
                        placeholder: "lib/assets/images/ic_man.png",
                        image: item.urlToImage ?? "",
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Center(
                              child:
                                  Image.asset("lib/assets/images/ic_man.png"));
                        },
                        fit: BoxFit.contain),
                  ),
                  title: Text(item.title ?? ""),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Center _buildError(state) {
    return Center(
      child: Text(state.error),
    );
  }

  Widget _buildLoading() {
    return const SpinKitCircle(
      color: Colors.red,
      size: 50.0,
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrlString(url)) {
      throw '${AppText.launchUrlError} $url';
    }
  }
}
