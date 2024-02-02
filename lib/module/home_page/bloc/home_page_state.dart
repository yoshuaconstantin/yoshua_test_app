part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class onGetCategoryLoading extends HomePageState{}
class onGetCategorySuccess extends HomePageState{
  List<dynamic> data;

  onGetCategorySuccess({required this.data});
}
class onGetCategoryFailed extends HomePageState{
  final String message;

  onGetCategoryFailed({required this.message});
}
class onGetCategoryFinished extends HomePageState{}

class onGetProductsLoading  extends HomePageState{}
class onGetProductsSuccess  extends HomePageState{
  List<ProductResponse> data;

  onGetProductsSuccess({required this.data});
}
class onGetProductsFailed extends HomePageState{
  final String message;

  onGetProductsFailed({required this.message});
}
class onGetProductsFinished extends HomePageState{}
