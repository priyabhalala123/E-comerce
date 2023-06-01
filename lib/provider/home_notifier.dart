import 'package:e_commerce/model/product_model.dart';
import 'package:flutter/cupertino.dart';

import '../model/images_model.dart';
import '../service/service.dart';

class HomeNotifier extends ChangeNotifier {
  int currentIndex = 0;
  onIndexChanged(index) {
    currentIndex = index;
    notifyListeners();
  }

  ///-------- product controller-----------
  List<ProductsModel> productsModel = [];
  List<ProductsModel> searchList = [];
  List<ProductsModel> addToCart = [];
  
  getProducts() async {
    try {
      productsModel = await BaseService().getProducts();
    } catch (e) {
      print(e);
    } finally {}
    notifyListeners();
  }

  ///-------- image controller-----------

  // ImagesDataModel imagesDataModel = ImagesDataModel();
  List<ImagesModel> imagesDataModel = [];

  getImages() async {
    try {
      imagesDataModel = await BaseService().getImages();
    } catch (e) {
      print(e);
    } finally {}
    notifyListeners();
  }
}
