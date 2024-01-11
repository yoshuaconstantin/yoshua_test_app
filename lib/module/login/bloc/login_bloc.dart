import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:yoshua_ui_test/api/endpoint/login/login_request.dart';
import 'package:yoshua_ui_test/api/endpoint/login/login_response.dart';

import '../../../api/api_manager.dart';
import '../../../helper/constant.dart';
import '../../../helper/preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<onLoginButton>(_login);
  }

  FutureOr<void> _login(onLoginButton event, Emitter<LoginState> emit) async {
    try {
      emit(onLoginLoading());

      LoginRequest loginRequest = LoginRequest(
        password: event.password,
        username: event.username
      );

      Response response = await ApiManager().login(
          loginRequest: loginRequest
      );

      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);

        Preferences.getInstance().setString(SharedPreferenceKey.SESSION_ID, loginResponse.token);



        Preferences.getInstance().setString(SharedPreferenceKey.FIRSTNAME, loginResponse.token);

        emit(onLoginSuccess(data: loginResponse));
      } else {
        emit(onLoginFailed(message: response.data));
      }

    }catch (e){
      String message = e.toString();

      emit(onLoginFailed(message: message));

    }finally{
      emit(onLoginFinished());
    }
  }
}
