import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandyt_app/pages/products/provider/product_provider.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productProvider);
    final notifier = ref.read(productProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('🛍️ Product List')),
      body: Column(
        children: [
          Expanded(
            child: state.hasError
                ? const Center(child: Text('❌ Failed to load products'))
                : ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ListTile(
                        title: Text(product.title),
                        trailing: Text('\$${product.price}'),
                      );
                    },
                  ),
          ),
          if (state.isLoading)
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: CircularProgressIndicator(),
            )
          else if (state.hasMore)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () => notifier.fetchProducts(),
                child: const Text('Load More'),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('🎉 No more products'),
            ),
        ],
      ),
    );
  }
}
