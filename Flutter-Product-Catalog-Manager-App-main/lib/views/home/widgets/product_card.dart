import 'package:assignment_9/core/themes/app_theme.dart';
import 'package:assignment_9/providers/product_provider.dart';
import 'package:assignment_9/views/product_form/product_form_screen.dart';
import 'package:flutter/material.dart';

ListView ProductCard(ProductProvider provider) {
  return ListView.builder(
    itemCount: provider.products.length,
    itemBuilder: (context, index) {
      final product = provider.products[index];
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          elevation: 5,
          color: Apptheme.whiteColor,
          shadowColor: Apptheme.greyColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Apptheme.buttonbackground,
                        radius: 15,
                        child: Text(
                          "${index + 1}".toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Apptheme.whiteColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name ?? "Product Name",
                            style: TextStyle(
                              color: Apptheme.blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "PKR ${product.price ?? 0}".toString(),
                            style: TextStyle(
                              color: Apptheme.buttonbackground,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Divider(color: Apptheme.greyColor, thickness: 1),
                SizedBox(height: 10),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductFormScreen(product: product),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.edit, color: Apptheme.Title, size: 20),

                          Text(
                            "EDIT",
                            style: TextStyle(
                              color: Apptheme.Title,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      GestureDetector(
                        onTap: () {
                          provider.deleteProduct(product.id!);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Apptheme.deleteIcon,
                              size: 20,
                            ),

                            Text(
                              "DELETE",
                              style: TextStyle(
                                color: Apptheme.deleteIcon,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    },
  );
}
