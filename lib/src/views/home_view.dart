import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/design/buttons_design.dart';
import 'package:prestamos/src/design/drawers.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/transactions_provider.dart';
import 'package:prestamos/src/utils/date_utils.dart';
import 'package:prestamos/src/utils/parsers_utils.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        drawer: DrawerDesign(),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Builder(builder: (context) {
                              return IconButton(
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                icon: Icon(FeatherIcons.menu),
                              );
                            }),
                            SizedBox(height: 5),
                          ],
                        ),
                        DesignText(
                          'Hola ${ParsersUtils.capitalize(UserPreferences.name).split(' ')[0]}',
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: ImagePipes.assetOrNetwork(url: UserPreferences.photo),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                _Balance(),
                SizedBox(height: 15),
                DesignText('Ultima actividad', fontWeight: FontWeight.bold, fontSize: 20),
                SizedBox(height: 10),
                _Transactions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Transactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionsProvider = Provider.of<TransactionsProvider>(context);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: transactionsProvider.transactions.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        final positive = transactionsProvider.transactions[index].amount >= 0;

        return ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: positive ? Colors.green : Colors.red,
            child: Icon(positive ? FeatherIcons.arrowUp : FeatherIcons.arrowDown, color: Colors.white),
          ),
          trailing: DesignText(
            '\$${transactionsProvider.transactions[index].amount.toStringAsFixed(2)}',
            fontWeight: FontWeight.bold,
          ),
          title: DesignText(
            '${positive ? 'Ingreso' : 'Retiro'} a cuenta ${transactionsProvider.transactions[index].account.name}',
            fontSize: 14,
          ),
          subtitle: DesignText(
            DesignUtils.dateShortWithHour(transactionsProvider.transactions[index].createdAt),
            fontSize: 12,
          ),
        );
      },
    );
  }
}

class _Balance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffAA32FF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DesignText(
            'Tu balance',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          SizedBox(height: 25),
          Row(
            children: [
              DesignText(
                '\$20,000.00',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              SizedBox(width: 5),
              DesignText(
                'MXN',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Flexible(
                child: DesignTextButton(
                  width: double.infinity,
                  height: 45,
                  child: DesignText('Movimientos'),
                  color: Colors.white,
                  primary: Color(0xffAA32FF),
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 5),
              Flexible(
                child: DesignTextButton(
                  width: double.infinity,
                  height: 45,
                  child: DesignText('Clientes'),
                  color: Colors.white,
                  primary: Color(0xffAA32FF),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
