import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_004_shopapp/models_&_providers/model_authentication.dart';

enum AuthenticationMode { signUp, logIn }

class AuthenticationScreen extends StatefulWidget {
  static const routeName = '/AuthenticationScreen';

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthenticationMode _authenticationMode = AuthenticationMode.logIn;
  final Map<String, String> _authenticationData = {
    'email': '',
    // 'name': '',
    'password': '',
  };
  var _isLoading = false;
  var obscureTextData = false;
  final _passwordController = TextEditingController();
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authenticationMode == AuthenticationMode.logIn) {
      // Log user in
    } else {
      // Sign user up
     await Provider.of<Authentication>(
        context,
        listen: false,
      ).userRegister(
        _authenticationData['email'],
        _authenticationData['password'],
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthenticationMode() {
    if (_authenticationMode == AuthenticationMode.logIn) {
      setState(() {
        _authenticationMode = AuthenticationMode.signUp;
      });
    } else {
      setState(() {
        _authenticationMode = AuthenticationMode.logIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ENGAGE',
        ),
        titleTextStyle: Theme.of(context).textTheme.bodyLarge.copyWith(
              fontSize: 30,
            ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: deviceSize.height * 0.9,
          width: deviceSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: deviceSize.width * 0.8,
                height: deviceSize.width * 0.1,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(45),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Text(
                  _authenticationMode == AuthenticationMode.logIn
                      ? 'Welcome Back :)'
                      : 'Welcome to family :)',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                // decoration: BoxDecoration(
                //   shape: BoxShape.rectangle,
                //   borderRadius: BorderRadius.circular(45),
                // border: Border.all(
                //   color: Theme.of(context).colorScheme.primary,
                //   width: 0,
                // ),
                // ),
                height: deviceSize.height * 0.5,
                width: deviceSize.width * 0.8,
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            icon: Icon(
                              Icons.email,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            labelText: "E-Mail",
                            labelStyle: Theme.of(context).textTheme.bodyLarge,
                            hintText: "User Email",
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            errorStyle:
                                Theme.of(context).textTheme.bodySmall.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (email.isEmpty || !email.contains('@')) {
                              return 'Invalid email!';
                            }
                            return null;
                          },
                          onSaved: (email) {
                            _authenticationData['email'] = email;
                          },
                        ),
                        const Divider(),
                        // if (_authenticationMode == AuthenticationMode.signUp)
                        //   TextFormField(
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(15),
                        //         borderSide: BorderSide(
                        //           color: Theme.of(context).colorScheme.primary,
                        //         ),
                        //       ),
                        //       icon: Icon(
                        //         Icons.person,
                        //         color: Theme.of(context).colorScheme.primary,
                        //       ),
                        //       labelText: "Name",
                        //       labelStyle: Theme.of(context).textTheme.bodyLarge,
                        //       hintText: "User Name",
                        //       hintStyle: Theme.of(context).textTheme.bodyMedium,
                        //       errorStyle: Theme.of(context)
                        //           .textTheme
                        //           .bodySmall
                        //           .copyWith(
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     keyboardType: TextInputType.text,
                        //     validator: (name) {
                        //       if (name.isEmpty) {
                        //         return 'Please enter user name *';
                        //       }
                        //       return null;
                        //     },
                        //     onSaved: (name) {
                        //       _authenticationData['name'] = name;
                        //     },
                        //   ),
                        // if (_authenticationMode == AuthenticationMode.signUp)
                        //   const Divider(),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            icon: Icon(
                              Icons.vpn_key,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    obscureTextData = !obscureTextData;
                                  },
                                );
                              },
                              icon: Icon(
                                obscureTextData
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            labelText: "Password",
                            labelStyle: Theme.of(context).textTheme.bodyLarge,
                            hintText: "Enter Password",
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            errorStyle:
                                Theme.of(context).textTheme.bodySmall.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          obscureText: obscureTextData,
                          controller: _passwordController,
                          validator: (pass) {
                            if (pass.isEmpty || pass.length < 5) {
                              return ('Password is too short!');
                            }
                            return null;
                          },
                          onSaved: (pass) {
                            _authenticationData['password'] = pass;
                          },
                        ),
                        if (_authenticationMode == AuthenticationMode.signUp)
                          const Divider(),
                        if (_authenticationMode == AuthenticationMode.signUp)
                          TextFormField(
                            enabled: _authenticationMode ==
                                AuthenticationMode.signUp,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              icon: Icon(
                                Icons.vpn_key,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      obscureTextData = !obscureTextData;
                                    },
                                  );
                                },
                                icon: Icon(
                                  obscureTextData
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              labelText: "Confirm Password",
                              labelStyle: Theme.of(context).textTheme.bodyLarge,
                              hintText: "Enter Confirm Password",
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              errorStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            obscureText: obscureTextData,
                            // controller: _passwordController,
                            validator:
                                _authenticationMode == AuthenticationMode.signUp
                                    ? (cpass) {
                                        if (cpass != _passwordController.text) {
                                          'Passwords do not match!';
                                        }
                                        return;
                                      }
                                    : null,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_isLoading)
                    CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  else
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Theme.of(context).colorScheme.primary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(
                          Size(
                            deviceSize.width * 0.8,
                            40,
                          ),
                        ),
                      ),
                      onPressed: _submit,
                      child: Text(
                        _authenticationMode == AuthenticationMode.logIn
                            ? 'LOGIN'
                            : 'REGISTER',
                        // style: Theme.of(context).textTheme.bodyLarge,
                        style: Theme.of(context).textTheme.bodyLarge.copyWith(
                              fontSize: 20,
                            ),
                      ),
                    ),
                  const SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        _authenticationMode == AuthenticationMode.logIn
                            ? "Don't Have Any Account? "
                            : "Have Already Member?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.1),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        onPressed: _switchAuthenticationMode,
                        child: Text(
                          _authenticationMode == AuthenticationMode.logIn
                              ? 'Register'
                              : 'LogIn',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              .copyWith(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
