class UserModel {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String gendre;
  final bool isAdmin;
  final String? imageUrl;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.gendre,
    required this.isAdmin,
    this.imageUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['mail'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      gendre: map['gendre'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      imageUrl: map['imageUrl'],
    );
  }
}
