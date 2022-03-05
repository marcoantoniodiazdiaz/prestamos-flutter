import 'package:flutter/material.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/drawers.dart';
import 'package:prestamos/src/design/texts.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerDesign(),
      appBar: AppBar(
        backgroundColor: DesignColors.dark,
        title: DesignText('Inicio'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          color: DesignColors.dark,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(59, 102, 74, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DesignText('Universal', color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(59, 102, 74, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DesignText('Credito', color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 25),
              DesignText(
                '\$20,000.00',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 45,
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
