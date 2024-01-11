class GetUserResponseName {
  final String firstName;
  final String lastName;


  GetUserResponseName({
    required this.firstName,
    required this.lastName,


  });

  factory GetUserResponseName.fromJson(Map<String, dynamic> json) => GetUserResponseName(
    firstName: json['firstName'],
    lastName: json['lastName'],

  );
}