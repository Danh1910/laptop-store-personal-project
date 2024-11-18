class Account {
  final String username;
  final String password;
  String? cartId; // ID của giỏ hàng
  List<String>? invoiceIds; // Danh sách ID của các hóa đơn

  Account({
    required this.username,
    required this.password,
    this.cartId,
    this.invoiceIds,
  });

  // Chuyển đổi object Account thành Map để lưu trữ trênFirestore
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  // Tạo object Account từ Map lấy từ Firestore
  factory Account.fromMap(String id, Map<String, dynamic> map) {
    return Account(
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }
}