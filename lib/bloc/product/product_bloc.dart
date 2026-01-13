import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadleo_project/bloc/product/product_event.dart';
import 'package:quadleo_project/bloc/product/product_state.dart';
import 'package:quadleo_project/data/model/product_model.dart';
import 'package:quadleo_project/data/service/product_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;
  List<ProductModel> allProducts = [];

  ProductBloc(this.productService) : super(ProductInitial()) {

    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        allProducts = await productService.fetchProducts();
        emit(ProductLoaded(allProducts, allProducts));
      } catch (e) {
        emit(ProductError("Failed to load products"));
      }
    });

    on<SearchProducts>((event, emit) {
      final filtered = allProducts
          .where((p) =>
              p.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      emit(ProductLoaded(allProducts, filtered));
    });
  }
}
