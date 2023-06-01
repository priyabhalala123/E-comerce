import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_commerce/model/images_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/utils/text_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

var dio = Dio();
final FirebaseAuth _auth = FirebaseAuth.instance;

class BaseService {
  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return true;
  }

  ///----------- get sliderImages ------------


  Future<List<ImagesModel>> getImages() async {
    List<ImagesModel> imagesModel = [];

    try {
      String query = "https://picsum.photos/v2/list";
      var response = await http.get(
        Uri.parse(query),
      );
      print(
        "==============> ${response.statusCode}",
      );
      if (response.statusCode == 200) {
        imagesModel = getImagesModellFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    return imagesModel;
  }

  ///----------- getProducts ------------
Future<List<ProductsModel>> getProducts() async {
  List<ProductsModel> productsModel = [];

    try {
        String query = TextConst.baseApiUrl + "products";

      var response = await http.get(
        Uri.parse(query),
      );
      print(
        "==============> ${response.statusCode}",
      );
      if (response.statusCode == 200) {
        productsModel = getProductModellFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    return productsModel;
  }
  // Future<ProductsModel> getProducts() async {
  //   ProductsModel productsModel = ProductsModel();
  //   String query = TextConst.baseApiUrl + "products";
  //   Map<String, dynamic> head = {
  //     "Content-Type": "application/json",
  //   };

  //   try {
  //     var response = await dio.get(
  //       query,
  //       options: Options(
  //         headers: head,
  //       ),
  //     );
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       productsModel = ProductsModel.fromJson(response.data);
  //       print(response.data);
  //       print("======response.statusCode>>>>${response.statusCode}");
  //     } else {
  //       throw Exception('Failed to load Data');
  //     }
  //   } on DioError catch (e) {
  //     print(e.response!.statusCode);
  //   }
  //   return productsModel;
  // }

}
