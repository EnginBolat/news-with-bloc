import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:news_with_bloc/model/news_model.dart';

part 'news_cubit_state.dart';

class NewsCubit extends Cubit<NewsCubitState> {
  NewsCubit() : super(NewsCubitInitial());

  Future<NewsLoaded?> fetchNews(String apiLink) async {
    try {
      emit(NewsLoading());
      var response = await Dio().get(apiLink);
      switch (response.statusCode) {
        case HttpStatus.ok:
          final data = response.data["articles"];
          if (data is List) {
            emit(NewsLoaded(data.map((e) => Articles.fromJson(e)).toList()));
            return NewsLoaded(data.map((e) => Articles.fromJson(e)).toList());
          }
          break;
        default:
          emit(NewsCantLoaded("Error"));
      }
      emit(NewsLoading());
    } catch (e) {
      emit(NewsCantLoaded(e.toString()));
    }
    return null;
  }
}
