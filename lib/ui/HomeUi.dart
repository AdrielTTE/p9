import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:product_table_demo/models/Product.dart';

import '../services/DatabaseService.dart';

class HomeUi extends StatefulWidget {
  final String title;

  const HomeUi(this.title);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<HomeUi> {
  List<ProductModel>? _itemList;
  String? _dirPath;

  Future<void> _loadData() async {
    final dbService = DatabaseService();
    final data = await dbService.getProduct();

    final appDocDir = await getApplicationDocumentsDirectory();

    setState(() {
      _itemList = data;
      _dirPath = appDocDir.path;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = _itemList == null || _dirPath == null;

    return Center(
      child:
          isLoading
              ? const CircularProgressIndicator()
              : Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.80,

                    child: ListView.separated(
                      itemCount: _itemList!.length,

                      itemBuilder: (BuildContext context, int index) {
                        final product = _itemList![index];
                        final imagePath = '$_dirPath/${product.img}';
                        final imageFile = File(imagePath);
                        final imageWidget =
                            imageFile.existsSync()
                                ? Image.file(imageFile, fit: BoxFit.cover)
                                : const Icon(Icons.image_not_supported);

                        return ListTile(
                          leading: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              child: imageWidget,
                            ),
                          ),

                          title: Text(_itemList![index].description),
                        );
                      },

                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
