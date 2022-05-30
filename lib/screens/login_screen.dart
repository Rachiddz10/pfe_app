import 'package:flutter/material.dart';
import 'package:pfe_app/apis/login_api.dart';
import 'package:pfe_app/components/user.dart';
import 'package:pfe_app/screens/loading_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  final _formKeyKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('images/img_unsplashztpsx.jpg'),
              colorFilter: ColorFilter.mode(
                  Colors.green.withOpacity(0.2), BlendMode.saturation),
              fit: BoxFit.cover,
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 24.0, right: 24.0, top: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  Form(
                    key: _formKeyKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Email name is required';
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return 'Invalid Email Address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                              label: Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.pink[300]),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'xyw...@gmail.com',
                              hintStyle: const TextStyle(color: Colors.black38),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 8) {
                                return 'Password must be over 7 caracters';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              password = value;
                            },
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              label: Text(
                                'Password',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.pink[300]),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Enter your password.',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            color: Colors.lightBlueAccent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
                            elevation: 5.0,
                            child: MaterialButton(
                              onPressed: () async {
                                if (!_formKeyKey.currentState!.validate()) {
                                  return;
                                }
                                _formKeyKey.currentState!.save();
                                dynamic json = await LoginAPI().loginFunction(email!, password!);
                                if (json['message'] == 'fail') {
                                  Alert(
                                      context: context,
                                      title: 'Login Failed',
                                      content: Column(
                                        children: const [
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          Text('Email or Password invalid'),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                        ],
                                      ),
                                      buttons: [
                                        DialogButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            // ignore: use_build_context_synchronously
                                            AppLocalizations.of(context)!.close,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ]).show();
                                } else if (json['message'] == 'success') {
                                  User.addUser(json);
                                  if (!mounted) return;
                                  Navigator.pushNamed(context, LoadingScreen.id);
                                }
                              },
                              minWidth: 200.0,
                              height: 42.0,
                              child: const Text(
                                'Log In',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
