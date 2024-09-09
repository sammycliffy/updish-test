import 'package:flutter_application_1/models/product_model.dart';

class ProductRepository {
  static List<Product> getProducts() {
    return List.generate(
      20,
      (index) => Product(
        imageUrl: 'https://picsum.photos/200/200?random=$index',
        title: 'Product $index',
        price: (index + 1) * 10.0,
      ),
    );
  }
}
