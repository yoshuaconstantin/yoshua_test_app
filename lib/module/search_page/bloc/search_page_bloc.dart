import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../api/api_manager.dart';
import '../../../api/endpoint/product/get_product_response.dart';

part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  SearchPageBloc() : super(SearchPageInitial()) {
    on<SearchPageEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetAllProduct>(_getProduct);
  }

  FutureOr<void> _getProduct(GetAllProduct event, Emitter<SearchPageState> emit) async {
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
}
