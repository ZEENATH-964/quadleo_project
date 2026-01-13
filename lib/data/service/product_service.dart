import 'package:dio/dio.dart';
import 'package:quadleo_project/data/model/product_model.dart';

class ProductService {
  final Dio dio = Dio();

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await dio.get("https://fakestoreapi.com/products");

      final List data = response.data;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to load products");
    }
  }
}
