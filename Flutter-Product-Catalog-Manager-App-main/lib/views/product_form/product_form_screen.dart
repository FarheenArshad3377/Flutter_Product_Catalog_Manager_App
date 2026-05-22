import 'package:assignment_9/core/themes/app_theme.dart';
import 'package:assignment_9/model/product.dart';
import 'package:assignment_9/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;
  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _priceCtrl;
  bool _isSaving = false;
  bool get _isEditing => widget.product != null;
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final item = Product(
      id: widget.product?.id,
      name: _nameCtrl.text,
      price: double.parse(_priceCtrl.text),
    );

    if (_isEditing) {
      await context.read<ProductProvider>().updateProduct(item);
    } else {
      await context.read<ProductProvider>().addProduct(item);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController(text: widget.product?.name ?? '');

    _priceCtrl = TextEditingController(
      text: widget.product?.price.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Apptheme.screenBackground,
      appBar: AppBar(
        backgroundColor: Apptheme.screenBackground,
        title: Text(
          _isEditing ? "Edit Product" : "Add Product",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25,
            color: Apptheme.buttonbackground,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "CATALOG MANAGEMENT",
                    style: TextStyle(fontSize: 15, color: Apptheme.Title),
                  ),
                  Text(
                    _isEditing ? "Modify Product" : "Define New Product",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Apptheme.blackColor,
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Apptheme.buttonbackground,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10,
              ),
              child: Card(
                elevation: 5,
                color: Apptheme.whiteColor,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Product Name",
                              style: TextStyle(
                                color: Apptheme.buttonbackground,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _nameCtrl,
                              decoration: InputDecoration(
                                filled: true,

                                fillColor: Apptheme.textFieldBackground,
                                hint: Text(
                                  "eg: Enterprise Cloud Module",
                                  style: TextStyle(color: Apptheme.hintText),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Price",
                              style: TextStyle(
                                color: Apptheme.buttonbackground,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _priceCtrl,
                              keyboardType: TextInputType.number,

                              decoration: InputDecoration(
                                hint: Text(
                                  "0.00",
                                  style: TextStyle(color: Apptheme.hintText),
                                ),
                                label: Text("Price"),
                                filled: true,
                                fillColor: Apptheme.textFieldBackground,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(
                                  Icons.monetization_on_outlined,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),

                            if (!_isEditing)
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Apptheme.textFieldBackground,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.info_outline,
                                      color: Apptheme.buttonbackground,
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Text(
                                        "Ensure product pricing aligns with current regional tax regulations and platform fees.",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Apptheme.hintText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _isSaving ? null : _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Apptheme.buttonbackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                          padding: EdgeInsets.symmetric(
                            horizontal: 45,
                            vertical: 20,
                          ),
                        ),
                        child: Text(
                          _isEditing ? "Save Changes" : "Save Product",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isSaving ? null : _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF8F8F8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 65,
                            vertical: 20,
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Apptheme.buttonbackground,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
