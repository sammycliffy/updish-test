import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product_model.dart';
import 'package:flutter_application_1/repository/product_repository.dart';
import 'package:flutter_application_1/widget/cart_componet.dart';
import 'package:flutter_application_1/widget/product_visibility.dart';

class ProductCatalog extends StatefulWidget {
  const ProductCatalog({super.key});

  @override
  _ProductCatalogState createState() => _ProductCatalogState();
}

class _ProductCatalogState extends State<ProductCatalog> {
  final List<Product> _products = ProductRepository.getProducts();
  final Set<int> _visibleItems = {};

  void _onProductVisible(int index) {
    setState(() {
      _visibleItems.add(index);
    });
  }

  void _onAddToCart(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
      ),
      body: ProductGrid(
        products: _products,
        visibleItems: _visibleItems,
        onProductVisible: _onProductVisible,
        onAddToCart: _onAddToCart,
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final Set<int> visibleItems;
  final void Function(int index) onProductVisible;
  final void Function(BuildContext context, String title) onAddToCart;

  const ProductGrid({
    super.key,
    required this.products,
    required this.visibleItems,
    required this.onProductVisible,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductVisibilityDetector(
          index: index,
          onVisibilityChanged: onProductVisible,
          child: visibleItems.contains(index)
              ? ProductCard(
                  imageUrl: products[index].imageUrl,
                  title: products[index].title,
                  price: products[index].price,
                  onAddToCart: () =>
                      onAddToCart(context, products[index].title),
                )
              : const SizedBox(),
        );
      },
    );
  }
}
