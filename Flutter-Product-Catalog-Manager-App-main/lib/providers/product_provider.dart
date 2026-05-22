import 'package:assignment_9/model/product.dart';
import 'package:flutter/foundation.dart';

import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();
  // These private fields hold your state.
  // Never expose them directly — use the getters below.
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;
  List<Product> get products => List.unmodifiable(_products);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  bool get isEmpty => !_isLoading && _products.isEmpty;



  // TODO: Implement fetchProducts().
  // Steps: set _isLoading = true + notifyListeners(), clear _errorMessage,
  // call _service.fetchProducts(), store result in _products,
  // catch any exception into _errorMessage,
  // always set _isLoading = false + notifyListeners() at the end.
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _service.fetchProducts();
    } catch (e) {
      print(e);
    }
    _isLoading = false;
    notifyListeners();
  }



  // TODO: Implement addProduct().
  // Steps: call _service.createProduct(), add the returned Product
  // to _products, then call notifyListeners().
  // Catch exceptions into _errorMessage + notifyListeners().
  Future<void> addProduct(Product product) async {
    try {
      final newProduct = await _service.addProduct(product);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }



  // TODO: Implement updateProduct().
  // Steps: call _service.updateProduct(), then find the item in
  // _products by id using indexWhere(), replace it, notifyListeners().
  Future<void> updateProduct(Product product) async {
    try{
      await _service.updateProduct(product);
      final index = _products.indexWhere((p)=> p.id == product.id);
      if(index != -1 ){
        _products[index] = product;
        notifyListeners();
      }
    }
    catch(e){
      print(e);
    }
  }



  // TODO: Implement deleteProduct().
  // Steps: call _service.deleteProduct(id), then remove the item
  // from _products using removeWhere(), then notifyListeners().
  Future<void> deleteProduct(String id) async {
   try{
    await _service.deleteProduct(id);
    _products.removeWhere((p)=> p.id == id);
    notifyListeners();
   }
   catch(e){
    print(e);
   }
  }
}
