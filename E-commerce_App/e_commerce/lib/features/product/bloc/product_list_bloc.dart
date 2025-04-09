import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../core/models/product_model.dart';
import '../../../core/api/api_service.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ApiService apiService;

  ProductListBloc({required this.apiService}) : super(ProductListInitial()) {
    on<LoadProductList>((event, emit) async {
      emit(ProductListLoading());
      try {
        final List<Product> products = await apiService.getProducts();
        emit(ProductListLoaded(products));
      } catch (e) {
        emit(ProductListError(e.toString()));
      }
    });
  }
}