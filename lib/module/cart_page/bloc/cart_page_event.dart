part of 'cart_page_bloc.dart';

@immutable
abstract class CartPageEvent {}

class GetUserCart extends CartPageEvent {}
class GetSingleProduct extends CartPageEvent {
  List<int> id;

  GetSingleProduct({required this.id});
}
