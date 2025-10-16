import 'package:flutter_riverpod/legacy.dart';
import 'package:pandyt_app/pages/products/models/product_model.dart';
import 'package:pandyt_app/pages/products/services/product_service.dart';

class ProductState {
  final List<Product> products;
  final bool isLoading;
  final bool hasError;
  final bool hasMore;
  final int skip;

  ProductState({
    this.products = const [],
    this.isLoading = false,
    this.hasError = false,
    this.hasMore = true,
    this.skip = 0,
  });

  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    bool? hasError,
    bool? hasMore,
    int? skip,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      hasMore: hasMore ?? this.hasMore,
      skip: skip ?? this.skip,
    );
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductService _service;

  ProductNotifier(this._service) : super(ProductState()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true, hasError: false);

    try {
      final products = await _service.fetchProducts(skip: state.skip);
      state = state.copyWith(
        products: [...state.products, ...products],
        skip: state.skip + 10,
        hasMore: products.isNotEmpty,
      );
    } catch (e) {
      state = state.copyWith(hasError: true);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

// Provider instance
final productProvider = StateNotifierProvider<ProductNotifier, ProductState>((
  ref,
) {
  return ProductNotifier(ProductService());
});
