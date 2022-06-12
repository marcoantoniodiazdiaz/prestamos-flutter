import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/models/products_model.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/date_utils.dart';

class InventarioView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.97),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Inventario', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemBuilder: (_, index) {
            final product = productsProvider.products[index];
            return _ProductItem(product: product);
          },
          itemCount: productsProvider.products.length,
        ),
      ),
    );
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem({required this.product});

  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        productsProvider.delete(product);
      },
      background: Container(color: Colors.red, child: Center(child: DesignText('Eliminar', color: Colors.white))),
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xffECEFF4)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DesignText(product.name, fontSize: 20, fontWeight: FontWeight.bold),
                    SizedBox(height: 2.5),
                    DesignText(
                      'Añadido: ${DesignUtils.dateShortWithHour(product.createdAt)}',
                      color: Colors.black54,
                    ),
                    SizedBox(height: 7),
                    DesignText('${product.images.length} imagenes', fontWeight: FontWeight.bold),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: ImagePipes.assetOrNetwork(url: product.images[0].url),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: product.images.length,
                itemBuilder: (_, i) {
                  return InkWell(
                    onTap: () {
                      Get.to(() => _Viewer(url: product.images[i].url));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(product.images[i].url),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Viewer extends StatelessWidget {
  final String url;

  const _Viewer({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(url),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.contained * 5,
      ),
    );
  }
}
