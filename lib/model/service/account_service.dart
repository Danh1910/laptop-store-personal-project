import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_laptop_project/model/DTO/account_dto.dart';

class AccountService {
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;
  final CollectionReference _accountCollection = FirebaseFirestore.instance.collection('accounts');

  Future<void> createAccount(Account account) async {
    final querySnapshot = await _accountCollection.where('username', isEqualTo: account.username).get();

    if (querySnapshot.docs.isNotEmpty) {
      // Tên đăng nhập đã tồn tại
      print('Tên đăng nhập đã tồn tại. Vui lòng nhập tên khác.');
      // Hoặc bạn có thể throw một exception để xử lý lỗi
      // throw Exception('Tên đăng nhập đã tồn tại.');
      final docRef = await _accountCollection.add(account.toMap());
      // Cập nhật cartId cho tài khoản
      await docRef.update({'cartId': docRef.id});
    } else {
      // Tên đăng nhập chưa tồn tại, tạo tài khoản mới
      await _accountCollection.add(account.toMap());
    }
  }

  Future<void> updateAccountByUsername(String username, Account updatedAccount) async {
    final querySnapshot = await _accountCollection.where('username', isEqualTo: username).get();if (querySnapshot.docs.isNotEmpty) {
      final documentId = querySnapshot.docs.first.id;
      await _accountCollection.doc(documentId).update(updatedAccount.toMap());
    } else {
      // Xử lý trường hợp không tìm thấy tài khoản với username đã cho
      print('Không tìm thấy tài khoản với username: $username');
    }
  }

  Future<Account?> getAccountByUsername(String username) async {
    final querySnapshot = await _accountCollection.where('username', isEqualTo: username).get();
    if (querySnapshot.docs.isNotEmpty) {
      return Account.fromMap(querySnapshot.docs.first.id,querySnapshot.docs.first.data() as Map<String, dynamic>);
    } else {
      return null; // Trả về null nếu không tìm thấy tài khoản
    }
  }

  // Future<List<Account>> getAccounts() async {
  //   final snapshot = await _accountCollection.get();
  //   return snapshot.docs.map((doc) => Account.fromMap(doc.id, doc.data())).toList();
  // }
}