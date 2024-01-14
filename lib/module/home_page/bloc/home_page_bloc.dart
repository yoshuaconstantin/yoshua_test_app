import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../api/api_manager.dart';
import '../../../api/endpoint/product/get_product_response.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetHomeCategory>(_getCategory);
    on<GetHomeProduct>(_getProducts);
    on<GetCategoryProducts>(_getFilterCategory);

  }

  FutureOr<void> _getCategory(GetHomeCategory event, Emitter<HomePageState> emit) async {
    try{
      emit(onGetCategoryLoading());

      Response response = await ApiManager().getCategory();

      if (response.statusCode == 200) {
        List<dynamic> data = [];

        data.addAll(response.data);

        emit(onGetCategorySuccess(data: data));
      } else {
        emit(onGetCategoryFailed(message: response.data));
      }

    }catch (e) {
      String message = e.toString();

      emit(onGetCategoryFailed(message: message));

    }finally{

    }
  }

  FutureOr<void> _getProducts(GetHomeProduct event, Emitter<HomePageState> emit) async {
    try{
      emit(onGetProductsLoading());

      Response response = await ApiManager().getProduct();

      if (response.statusCode == 200) {

        List<ProductResponse> data = (response.data as List)
            .map((item) => ProductResponse.fromJson(item))
            .toList();

        emit(onGetProductsSuccess(data: data));
      } else {
        emit(onGetProductsFailed(message: response.data));
      }

    }catch (e) {
      String message = e.toString();

      emit(onGetProductsFailed(message: message));

    }finally{
      emit(onGetProductsFinished());
    }
  }

  FutureOr<void> _getFilterCategory(GetCategoryProducts event, Emitter<HomePageState> emit) async {
    try{
      emit(onGetProductsLoading());

      Response response = await ApiManager().getCategoriesProduct(categories: event.categories);

      if (response.statusCode == 200) {

        List<ProductResponse> data = (response.data as List)
            .map((item) => ProductResponse.fromJson(item))
            .toList();

        emit(onGetProductsSuccess(data: data));
      } else {
        emit(onGetProductsFailed(message: response.data));
      }

    }catch (e) {
      String message = e.toString();

      emit(onGetProductsFailed(message: message));

    }finally{

    }
  }
}
