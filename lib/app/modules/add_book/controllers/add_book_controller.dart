import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petugas_perpustakaan_kelas_b/app/modules/book/controllers/book_controller.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class AddBookController extends GetxController {
  final loading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
  final TextEditingController tahunterbitController = TextEditingController();
  final BookController bookController = Get.find();
  //final BookController bookController = Get.put(BookController());  - jika error pakai ini

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  post() async{
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus(); //untuk ngeclose keyboard
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.book,
        data:
        {
          "judul": judulController.text.toString(),
          "penulis": penulisController.text.toString(),
          "penerbit": penerbitController.text.toString(),
          "tahun_terbit": int.parse(tahunterbitController.text.toString())
        }
        );
        if (response.statusCode == 201) {
          bookController.getData();
          Get.back();
        } else {
          Get.snackbar(
              "Sorry", "Login Gagal", backgroundColor: Colors.amberAccent);
        }
      }
      loading(false);
    }on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.amberAccent);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    }catch (e) {loading(false);
    Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}
