import 'package:flutter/material.dart';
import 'package:new_laptop_project/model/DTO/account_dto.dart';
import 'package:new_laptop_project/model/service/account_service.dart';

class AccountControll {

  final AccountService accountService = AccountService();

  void themAccount(String name, String password, BuildContext context) async {
    final accountService = AccountService();
    try {
      await accountService.createAccount(Account(username: name, password: password));
      // Đăng ký thành công
      // print("Đăng ký thành công");
      // // Hiển thị SnackBar thông báo thành công
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Đăng ký thành công!')),
      // );
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
}