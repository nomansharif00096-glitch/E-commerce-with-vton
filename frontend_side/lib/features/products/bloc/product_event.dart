import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingProducts extends ProductEvent {}

class LoadingProduct extends ProductEvent {
  final int id;
  LoadingProduct({required this.id});

  @override
  List<Object?> get props => [id];
}

class LoadingCategories extends ProductEvent {}

class LoadProductsByCategory extends ProductEvent {
  final int categoryId;
  LoadProductsByCategory({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}
