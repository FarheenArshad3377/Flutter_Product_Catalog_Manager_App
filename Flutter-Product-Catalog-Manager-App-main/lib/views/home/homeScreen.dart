import 'package:assignment_9/core/themes/app_theme.dart';
import 'package:assignment_9/providers/product_provider.dart';
import 'package:assignment_9/views/home/widgets/empty_state.dart';
import 'package:assignment_9/views/home/widgets/loading_state.dart';
import 'package:assignment_9/views/home/widgets/product_card.dart';
import 'package:assignment_9/views/product_form/product_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 25.0,
          left: 16,
          right: 16,
          bottom: 50,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Products",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: AppColors.screenTitle,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.shopping_bag_outlined, size: 30),
              ],
            ),
            SizedBox(height: 10),
            Consumer<ProductProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return LoadingState();
                } else if (provider.isEmpty) {
                  return EmptyState();
                } else {
                  return Expanded(child: ProductCard(provider));
                }
              },
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.fabBackground,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductFormScreen()),
            );
          },
          icon: Icon(Icons.add, color: AppColors.whiteColor),
          label: Text(
            "ADD PRODUCT",
            style: TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
