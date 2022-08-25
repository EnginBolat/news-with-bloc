part of 'news_cubit_cubit.dart';

@immutable
abstract class NewsCubitState {}

class NewsCubitInitial extends NewsCubitState {}

class NewsLoading extends NewsCubitState {
  NewsLoading();
}

class NewsLoaded extends NewsCubitState {
  final List<Articles> news;
  NewsLoaded(this.news);
}

class NewsCantLoaded extends NewsCubitState {
  final String errorMessage;
  NewsCantLoaded(this.errorMessage);
}
