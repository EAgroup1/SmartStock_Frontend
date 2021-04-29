import 'package:flutter/material.dart';
import 'package:rlbasic/entrar.dart';
import 'package:rlbasic/termsAndConditions.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // bool _value = true;

  @override
  Widget build(BuildContext context) {
    createNameInput() {
      return TextFormField(
        decoration: InputDecoration(filled: true, hintText: 'Nombre completo'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un texto';
          } else
            return value;
        },
      );
    }

    createEmailInput() {
      return TextFormField(
        decoration: InputDecoration(filled: true, hintText: 'Email'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un correo';
          } else
            return value;
        },
      );
    }

    createPasswordInput() {
      return TextFormField(
        decoration: InputDecoration(filled: true, hintText: 'Contraseña'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un texto';
          } else
            return value;
        },
        obscureText: true,
      );
    }

    createConPasswordInput() {
      return TextFormField(
        decoration:
            InputDecoration(filled: true, hintText: 'Confirma la contraseña'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, introduce un texto';
          } else
            return value;
        },
        obscureText: true,
      );
    }

    termsAndConditions() {
      return ButtonBar(
        children: <Widget>[
/*           CheckboxListTile(
  title: Text("title text"),
  value: _value,
  onChanged: (newValue) {
    setState(() {
      _value = newValue;
    });
  },
  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
)
 */
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              child: Text('Terms and Conditions'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => TermsAndConditionsPage()),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              child: Text('Terms and Conditions'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => TermsAndConditionsPage()),
                );
              },
            ),
          ),
        ],
      );
    }

    createRegisterButton(BuildContext context) {
      return Container(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
            child: Text(
              'Entrar',
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EntrarPage()));
            },
          ));
    }

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          Image.asset(
            'assets/images/smartstock.jpeg',
            width: 300.00,
            height: 240,
          ),
          createNameInput(),
          SizedBox(height: 12.0),
          createEmailInput(),
          // spacer
          SizedBox(height: 30.0),
          createPasswordInput(),
          SizedBox(height: 12.0),
          createConPasswordInput(),
          termsAndConditions(),
          createRegisterButton(context)
        ],
      ),
    );
  }
}
