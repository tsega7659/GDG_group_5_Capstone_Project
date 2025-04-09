part of 'product_list_bloc.dart';

@immutable
abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class LoadProductList extends ProductListEvent {}