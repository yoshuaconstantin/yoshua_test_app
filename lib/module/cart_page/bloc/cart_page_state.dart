part of 'cart_page_bloc.dart';

@immutable
abstract class CartPageState {}

class CartPageInitial extends CartPageState {}

class onGetCartLoading extends CartPageState {}
class onGetCartSuccess extends CartPageState {
  List<GetCartResponse> data;

  onGetCartSuccess({required this.data});
}
class onGetCartFailed extends CartPageState {
  final String message;

  onGetCartFailed({required this.message});
}
class onGetCartFinished extends CartPageState {}

class onGetSingleProductSuccess extends CartPageState {
  final List<ProductResponse> data;

  onGetSingleProductSuccess({required this.data});
}
class onGetSingleProductFailed extends CartPageState {
  final String message;

  onGetSingleProductFailed({required this.message});
}

class onDoNothing extends CartPageState{}

