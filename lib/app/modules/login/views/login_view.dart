import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.usernameController,
                decoration: InputDecoration(hintText: "Masukkan Username", icon: Icon(Icons.person_2_sharp)),
                validator: (value){
                  if (value!.isEmpty) { //minimal username
                    return "Username tidak boleh kosong";
                  }
                  return null;
                }
              ),
              TextFormField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(hintText: "Masukkan Password", icon: Icon(Icons.lock_outline_sharp)),
                  validator: (value){
                    if (value!.length<2) { //minimal huruf password
                      return "password tidak boleh kosong";
                    }
                    return null;
                  }
              ),
              Obx(() => controller.loading.value?
              CircularProgressIndicator():
                ElevatedButton(onPressed: (){
                  controller.login();
                }, child: Text("Login"))
              )
            ],
          ),
        )
      ),
    );
  }
}
