import 'get_user_response_data_name.dart';

class GetUserResponse {
  final GetUserResponseName? name;


  GetUserResponse({
    required this.name,
  });

  factory GetUserResponse.fromJson(Map<String, dynamic> json) {
    GetUserResponseName? data;

    if(json['name'] != null){
      data = GetUserResponseName.fromJson(json['name']);
    }

    return GetUserResponse(
      name: data,

    );
  }
}