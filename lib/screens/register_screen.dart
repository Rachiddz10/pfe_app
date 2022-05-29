import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfe_app/apis/register_api.dart';
import 'package:pfe_app/screens/login_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? first;
  String? last;
  String? email;
  String? password;
  String? confirm;
  String? genderString;
  int? genderInt = 1;
  DateTime? birthday;

  final _formKey = GlobalKey<FormState>();

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
                      height: 100.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildFirst(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        buildLast(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        buildEmail(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        buildPassword(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        buildConfirm(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        // buildGender(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Material(
                            color: Colors.blueAccent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
                            elevation: 5.0,
                            child: MaterialButton(
                              minWidth: 200.0,
                              height: 42.0,
                              onPressed: () {
                                showDatePicker(
                                  initialDatePickerMode: DatePickerMode.year,
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: birthday == null
                                      ? DateTime.now()
                                      : birthday!,
                                  lastDate: DateTime(DateTime.now().year + 1),
                                ).then((value) {
                                  setState(() {
                                    birthday = value;
                                  });
                                });
                              },
                              child: birthday == null
                                  ? const Text(
                                      'Date of Birth',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : Text(
                                      'Date of Birth:    ${DateFormat("dd-MM-yyyy").format(birthday!)}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        buildGender(),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            color: Colors.blueAccent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
                            elevation: 5.0,
                            child: MaterialButton(
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                _formKey.currentState!.save();
                                if (genderInt == 1) {
                                  genderString = "M";
                                } else if (genderInt == 2) {
                                  genderString = "F";
                                }
                                int year = birthday!.year;
                                String message = await RegisterAPI()
                                    .registerFunction(first!, last!, email!,
                                        password!, year, genderString!);
                                if (message == 'Email already used') {
                                  Alert(
                                      context: context,
                                      title: 'Registration failed',
                                      content: Column(
                                        children: [
                                          const SizedBox(
                                            height: 30.0,
                                          ),
                                          Text(message),
                                          const SizedBox(
                                            height: 30.0,
                                          ),
                                        ],
                                      ),
                                      buttons: [
                                        DialogButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            // ignore: use_build_context_synchronously
                                            AppLocalizations.of(context)!.close,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        )
                                      ]).show();
                                } else if (message == 'success') {
                                  if (!mounted) return;
                                  Navigator.pushNamed(context, LoginScreen.id);
                                }
                              },
                              minWidth: 200.0,
                              height: 42.0,
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
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

  Widget buildFirst() {
    return Flexible(
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'First name is required';
          }
          return null;
        },
        onSaved: (String? value) {
          first = value;
        },
        textAlign: TextAlign.center,
        onChanged: (value) {
          //Do something with the user input.
        },
        decoration: InputDecoration(
          label: Text(
            'First name',
            style: TextStyle(fontSize: 20.0, color: Colors.pink[300]),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Enter your first name',
          hintStyle: const TextStyle(color: Colors.black38),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }

  Widget buildLast() {
    return Flexible(
      child: TextFormField(
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Last name is required';
          }
          return null;
        },
        onSaved: (String? value) {
          last = value;
        },
        textAlign: TextAlign.center,
        onChanged: (value) {
          //Do something with the user input.
        },
        decoration: InputDecoration(
          label: Text(
            'Last name',
            style: TextStyle(fontSize: 20.0, color: Colors.pink[300]),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Enter your Last name',
          hintStyle: const TextStyle(color: Colors.black38),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Flexible(
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
        onSaved: (String? value) {
          email = value;
        },
        textAlign: TextAlign.center,
        onChanged: (value) {
          //Do something with the user input.
        },
        decoration: InputDecoration(
          label: Text(
            'Email',
            style: TextStyle(fontSize: 20.0, color: Colors.pink[300]),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'xyw...@gmail.com',
          hintStyle: const TextStyle(color: Colors.black38),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }

  Widget buildPassword() {
    return Flexible(
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
        onChanged: (value) {
          password = value;
        },
        decoration: InputDecoration(
          label: Text(
            'Password',
            style: TextStyle(fontSize: 20.0, color: Colors.pink[300]),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Enter your Password',
          hintStyle: const TextStyle(color: Colors.black38),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }

  Widget buildConfirm() {
    return Flexible(
      child: TextFormField(
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Confirmation is required';
          }
          if (value != password) {
            return 'confirmation does not match';
          }
          return null;
        },
        onSaved: (String? value) {
          confirm = value;
        },
        textAlign: TextAlign.center,
        onChanged: (value) {
          //Do something with the user input.
        },
        decoration: InputDecoration(
          label: Text(
            'Confirm',
            style: TextStyle(fontSize: 20.0, color: Colors.pink[300]),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Retype password',
          hintStyle: const TextStyle(color: Colors.black38),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }

  Widget buildGender() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.9,
          color: Colors.blueAccent,
        ),
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Gender:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10.0,
          ),
          const Text('Male'),
          Radio<int>(
            value: 1,
            groupValue: genderInt,
            onChanged: (value) {
              setState(() {
                genderInt = value;
              });
            },
          ),
          const SizedBox(
            width: 20.0,
          ),
          const Text('Female'),
          Radio<int>(
            value: 2,
            groupValue: genderInt,
            onChanged: (value) {
              setState(() {
                genderInt = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
