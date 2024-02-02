import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../api/api_manager.dart';
import '../../../api/endpoint/cart/get_user_cart_response.dart';
import '../../../api/endpoint/product/get_product_response.dart';

part 'cart_page_event.dart';
part 'cart_page_state.dart';

class CartPageBloc extends Bloc<CartPageEvent, CartPageState> {
  CartPageBloc() : super(CartPageInitial()) {
    on<CartPageEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetUserCart>(_getUserCart);
    on<GetSingleProduct>(_getSingleProduct);
  }

  FutureOr<void> _getUserCart(GetUserCart event, Emitter<CartPageState> emit) async {
    try{
      emit(onGetCartLoading());

      Response response = await ApiManager().getUserCart();

      if (response.statusCode == 200) {

        List<GetCartResponse> data = (response.data as List)
            .map((item) => GetCartResponse.fromJson(item))
            .toList();

        emit(onGetCartSuccess(data: data));
      } else {
        emit(onGetCartFailed(message: response.data));
      }

    }catch (e) {
      String message = e.toString();

      emit(onGetCartFailed(message: message));

    }finally{

    }
  }

  FutureOr<void> _getSingleProduct(GetSingleProduct event, Emitter<CartPageState> emit) async {
    try{
      emit(onDoNothing());

      List<ProductResponse> data = [];

      for(var e in event.id){
        Response response = await ApiManager().getSingleProduct(id: e);

        if (response.statusCode == 200) {

          data.add(ProductResponse.fromJson(response.data));
        } else {
          emit(onGetSingleProductFailed(message: response.data));
        }
      }

      emit(onGetSingleProductSuccess(data: data));

    }catch (e) {
      String message = e.toString();

      emit(onGetSingleProductFailed(message: message));

    }finally{
    }
  }
}
