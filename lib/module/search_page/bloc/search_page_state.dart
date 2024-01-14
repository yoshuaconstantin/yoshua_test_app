part of 'search_page_bloc.dart';

@immutable
abstract class SearchPageState {}

class SearchPageInitial extends SearchPageState {}

class onGetProductsLoading  extends SearchPageState{}
class onGetProductsSuccess  extends SearchPageState{
  List<ProductResponse> data;

  onGetProductsSuccess({required this.data});
}
class onGetProductsFailed extends SearchPageState{
  final String message;

  onGetProductsFailed({required this.message});
}
class onGetProductsFinished extends SearchPageState{}
