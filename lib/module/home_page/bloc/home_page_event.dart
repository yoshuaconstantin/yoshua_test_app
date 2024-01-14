part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class GetHomeCategory extends HomePageEvent{}

class GetHomeProduct extends HomePageEvent{}

class GetCategoryProducts extends HomePageEvent{
  final String categories;

  GetCategoryProducts({required this.categories});
}
