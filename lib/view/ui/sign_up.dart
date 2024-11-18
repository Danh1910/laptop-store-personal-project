import 'package:flutter/material.dart';
import 'package:new_laptop_project/controller/account_controller.dart';

class Sign_up extends StatefulWidget{
  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up>{

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AccountControll accountControll = AccountControll();
  @override
  void initState() {
    super.initState();
    print("Đăng ký");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng ký"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Tên đăng nhập"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập tên đăng nhập";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Mật khẩu"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập mật khẩu";
                  }
                  if (value.length < 6) {
                    return "Mật khẩu phải có ít nhất 6 ký tự";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {// Xử lý đăng ký ở đây
                    String name = _nameController.text;
                    String password = _passwordController.text;
                    print("Name: $name, Mật khẩu: $password");
                    accountControll.themAccount(name, password, context);
                  }
                },
                child: Text("Đăng ký"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {// Xử lý đăng ký ở đây
                    String name = _nameController.text;
                    String password = _passwordController.text;
                    print("Name: $name, Mật khẩu: $password");
                    accountControll.updateAccount(name, password);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Update thành công"))
                    );
                  }
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }



}