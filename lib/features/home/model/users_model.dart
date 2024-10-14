class UserModel {
  final int id;
  final String name;

  UserModel({required this.id, required this.name});
}

List<UserModel> users = [
  UserModel(id: 1, name: 'Person A'),
  UserModel(id: 2, name: 'Person B'),
  UserModel(id: 3, name: 'Person C'),
  UserModel(id: 4, name: 'Person D'),
  UserModel(id: 5, name: 'Person E'),
];
