import 'package:flutter/material.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/middlewares/regex_exp.dart';
import 'package:prestamos/src/provider/auth_provider.dart';
import 'package:prestamos/src/provider/providers.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: authProvider.formKey,
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.all(7.5),
                  decoration: BoxDecoration(
                    color: Color(0xffE1A5FF),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Flexible(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        DesignText('Bienvenido', fontSize: 30, fontWeight: FontWeight.bold),
                        SizedBox(height: 10),
                        DesignText('La aplicación de administración de prestamos definitiva', fontSize: 20, textAlign: TextAlign.center),
                        SizedBox(height: 20),
                        DesignInput(
                          hintText: 'Correo electronico',
                          textInputType: TextInputType.emailAddress,
                          onChanged: (String v) => authProvider.email = v,
                          validator: (v) {
                            if (v!.isEmpty) return 'Campo vacio';
                            if (!RegexExpressions.email.hasMatch(v)) return 'Formato invalido';
                            return null;
                          },
                        ),
                        SizedBox(height: 8),
                        DesignInput(
                          hintText: 'Contraseña',
                          textInputType: TextInputType.visiblePassword,
                          obscureText: true,
                          onChanged: (String v) => authProvider.password = v,
                          validator: (v) {
                            if (v!.isEmpty) return 'Campo vacio';
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        DesignTextButton(
                          width: double.infinity,
                          height: 50,
                          child: DesignText('Iniciar sesión'),
                          color: Color(0xffFC6B68),
                          primary: Colors.white,
                          elevation: 1,
                          onPressed: () => authProvider.login(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
