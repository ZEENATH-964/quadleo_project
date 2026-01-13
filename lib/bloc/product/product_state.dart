import 'package:equatable/equatable.dart';
import 'package:quadleo_project/data/model/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final List<ProductModel> filtered;
  ProductLoaded(this.products,this.filtered);

  @override
  List<Object?> get props => [products,filtered];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
