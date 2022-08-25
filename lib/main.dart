import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_with_bloc/core/cubit/news_cubit_cubit.dart';
import 'package:news_with_bloc/view/home_page.dart';

import 'constants/app_text.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppText.appName,
        theme: ThemeData(
            primarySwatch: Colors.red,
            appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness:
                    Brightness.light,
                statusBarBrightness:
                    Brightness.dark,
              ),
            )),
        home: const HomePageView(),
      ),
    );
  }
}
