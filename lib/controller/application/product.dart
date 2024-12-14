import 'package:frist_project/data/model/productmodel.dart';
import 'package:get/get.dart';

class ProductcontrollerImp extends GetxController {
  List<Product> loadedproducts = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'assets/images/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl: 'assets/images/Trousers.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'assets/images/YellowScarf.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/Pan.jpg',
    ),
    Product(
      id: 'E_l_1',
      title: 'lap1',
      description: 'description',
      price: 2005,
      imageUrl: 'assets/images/laptop1.jpg',
    ),
    Product(
      id: 'E_l_2',
      title: 'lap2',
      description: 'description',
      price: 1105,
      imageUrl: 'assets/images/laptop2.jpg',
    ),
    Product(
      id: 'E_l_3',
      title: 'lap3',
      description: 'description',
      price: 1205,
      imageUrl: 'assets/images/laptop3.jpg',
    ),
    Product(
      id: 'E_l_4',
      title: 'lap4',
      description: 'description',
      price: 1505,
      imageUrl: 'assets/images/laptop4.jpg',
    ),
    Product(
      id: 'E_l_5',
      title: 'lap5',
      description: 'description',
      price: 2200,
      imageUrl: 'assets/images/laptop5.jpg',
    ),
    Product(
      id: 'E_l_6',
      title: 'lap6',
      description: 'description',
      price: 1215,
      imageUrl: 'assets/images/laptop6.png',
    ),
    Product(
      id: 'E_l_7',
      title: 'lap7',
      description: 'description',
      price: 2100,
      imageUrl: 'assets/images/laptop7.jpg',
    ),
    Product(
      id: 'E_l_8',
      title: 'lap8',
      description: 'description',
      price: 1670,
      imageUrl: 'assets/images/laptop8.jpg',
    ),
    Product(
      id: 'E_M_1',
      title: 'mob1',
      description: 'description',
      price: 200,
      imageUrl: 'assets/images/mobile1.jpg',
    ),
    Product(
      id: 'E_M_2',
      title: 'mob2',
      description: 'description',
      price: 199,
      imageUrl: 'assets/images/mobile2.jpg',
    ),
    Product(
      id: 'E_M_3',
      title: 'mob3',
      description: 'description',
      price: 350,
      imageUrl: 'assets/images/mobile3.jpg',
    ),
    Product(
      id: 'E_M_4',
      title: 'mob4',
      description: 'description',
      price: 650,
      imageUrl: 'assets/images/mobile4.jpg',
    ),
    Product(
      id: 'E_M_5',
      title: 'mob5',
      description: 'description',
      price: 450,
      imageUrl: 'assets/images/mobile5.jpg',
    ),
    Product(
      id: 'E_Pc_1',
      title: 'pc1',
      description: 'description',
      price: 4500,
      imageUrl: 'assets/images/pc1.jpg',
    ),
    Product(
      id: 'E_Pc_2',
      title: 'pc2',
      description: 'description',
      price: 1500,
      imageUrl: 'assets/images/pc2.jpg',
    ),
    Product(
      id: 'E_Pc_3',
      title: 'pc3',
      description: 'description',
      price: 500,
      imageUrl: 'assets/images/pc3.jpg',
    ),
    Product(
      id: 'E_Pc_4',
      title: 'pc4',
      description: 'description',
      price: 3500,
      imageUrl: 'assets/images/pc4.jpg',
    ),
    // Add more products here
  ];

  void togglefavoritestate(int index) {
    loadedproducts[index].isfavorite = !loadedproducts[index].isfavorite;

    update(); // Notify GetBuilder to rebuild the UI
  }

  bool isFavorite(int index) {
    return loadedproducts[index].isfavorite;
  }

  List<Product> get favoriteProducts {
    return loadedproducts.where((product) => product.isfavorite).toList();
  }
}
