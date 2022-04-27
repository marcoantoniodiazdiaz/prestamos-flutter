import 'dart:io';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/provider/providers.dart';

class NuevoProductoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: DesignText('Nuevo producto', fontWeight: FontWeight.bold),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: productsProvider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DesignInput(
                    hintText: 'Nombre',
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    onChanged: (String v) => productsProvider.name = v,
                    validator: (v) {
                      if (v == null) return 'Campo vacio';
                      if (v.length < 3) return 'Campo demaciado corto';
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  DesignInput(
                    hintText: 'Descripción',
                    minLines: 3,
                    textCapitalization: TextCapitalization.characters,
                    textInputType: TextInputType.text,
                    onChanged: (String v) => productsProvider.description = v,
                    validator: (v) {
                      if (v == null) return 'Campo vacio';
                      if (v.length < 10) return 'Campo demaciado corto';
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  DesignTextButton(
                    width: double.infinity,
                    height: 45,
                    child: DesignText('Guardar producto'),
                    color: DesignColors.dark,
                    primary: Colors.white,
                    onPressed: () => productsProvider.post(),
                  ),
                  SizedBox(height: 10),
                  Builder(
                    builder: (_) {
                      if (productsProvider.imagesTaken.isNotEmpty) {
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 200,
                          ),
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return _Image(file: productsProvider.imagesTaken[index]);
                          },
                          itemCount: productsProvider.imagesTaken.length,
                        );
                      } else {
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.07),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.all(10),
                            child: DesignText('Sin imagenes'),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  DesignTextButton(
                    width: double.infinity,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FeatherIcons.camera),
                        SizedBox(height: 10),
                        DesignText('Tomar fotografia'),
                      ],
                    ),
                    color: DesignColors.pink,
                    primary: Colors.white,
                    onPressed: () => productsProvider.takeImage(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final File file;

  const _Image({required this.file});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(file),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Get.to(() => _Viewer(image: FileImage(file)));
            },
            icon: Icon(FeatherIcons.eye),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              productsProvider.removeImageFromList(file);
            },
            icon: Icon(FeatherIcons.trash),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _Viewer extends StatelessWidget {
  final FileImage image;

  const _Viewer({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: PhotoView(
        imageProvider: image,
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.contained * 5,
      ),
    );
  }
}
