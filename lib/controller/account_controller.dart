import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:new_laptop_project/model/DTO/account_dto.dart';
import 'package:new_laptop_project/model/service/account_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountControll {

  final AccountService accountService = AccountService();

  // RxString _userId = ''.obs; // Biến lưutrữ userId
  // String get userId => _userId.value;

  void themAccount(String name, String password, BuildContext context) async {
    final accountService = AccountService();
    try {
      await accountService.createAccount(Account(username: name, password: password));
      // // Hiển thị SnackBar thông báo thành công
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng ký thành công!')),
      );
    } catch (e) {
      // Xử lý lỗi, ví dụ: tên đăng nhập đã tồn tại
      print("Lỗi: $e");
      // Hiển thị SnackBar thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tên đăng nhập đã tồn tại. Vui lòng nhập tên khác.')),
      );
    }
  }

  void updateAccount(String username, String newPassword) {
    final updatedAccount = Account(username: username, password: newPassword);
    accountService.updateAccountByUsername(username, updatedAccount);
  }

  // void docdulieu() {
  //   final accountController = AccountService();
  //
  //   accountController.getAccounts().then((accounts) {
  //     for (final account in accounts) {
  //       print('Account: ${account.username}, ${account.password}');
  //     }
  //   });
  // }

  Future<Account?> getAccountByUsername(String username) async {
    try {
      final account = await accountService.getAccountByUsername(username);
      return account;
    } catch (e) {
      print('Lỗi khi lấy tài khoản: $e');
      return null;
    }
  }

  Future<bool> login(String username, String password, BuildContext context) async {
    try {
      final account = await accountService.getAccountByUsername(username);

      if (account != null && account.password == password) {
        // Đăng nhập thành công
        final userId = account.username;
        print('Đăng nhập thành công với userId: $userId');// Lưu trữ userId (ví dụ: sử dụng SharedPreferences)
        // ...
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userId); // gán userid
        // Chuyển hướng người dùng đến màn hình chính
        // Navigator.pushReplacementNamed(context, '/home'); // Thay thế '/home' bằng route của màn hình chính
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Đăng nhập thành công"))
        );
        return true; // Trả về true nếu đăng nhập thành công
      } else {
        // Đăng nhập thất bại
        print('Đăng nhập thất bại');

        // Hiển thị thông báo lỗi cho người dùng
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Đăng nhập thất bại"))
        );
        return false; // Trả về false nếu đăng nhập thất bại
      }
    } catch (e) {
      print('Lỗi khi đăng nhập: $e');

      // Hiển thị thông báo lỗi cho người dùng
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi khi đăng nhập"))
      );
      return false; // Trảvề false nếu có lỗi
    }
  }

}