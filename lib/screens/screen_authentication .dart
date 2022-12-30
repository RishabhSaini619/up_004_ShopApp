// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models_&_providers/model_authentication.dart';
import '../models_&_providers/model_http_exception.dart';

enum AuthenticationMode { signUp, logIn }

class AuthenticationScreen extends StatefulWidget {
  static const routeName = '/AuthenticationScreen';

  const AuthenticationScreen({Key key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController authenticationAnimationController;
  Animation<Size> heightAnimation;

  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthenticationMode _authenticationMode = AuthenticationMode.logIn;

  final Map<String, String> _authenticationData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  var obscureTextData = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        alignment: Alignment.center,
        title: const Text("An error occurred!"),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        content: Text(errorMessage),
        contentTextStyle: Theme.of(context).textTheme.bodyMedium,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xffff5722),
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  const MaterialStatePropertyAll<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Okay',
              style: Theme.of(context).textTheme.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authenticationMode == AuthenticationMode.logIn) {
        // Log user in userLogIn
        await Provider.of<Authentication>(
          context,
          listen: false,
        ).userLogIn(
          _authenticationData['email'],
          _authenticationData['password'],
        );
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
    } on HttpException catch (error) {
      var errorMessage = "Authentication Failed.";
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = "This email address is already in use.";
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = "This is not a valid email address";
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = "Could not find a user with that email.";
      } else if (error.toString().contains('WEEK_PASSWORD')) {
        errorMessage = "This password is too weak.";
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = "This password is invalid";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          "Could not authenticate you. Please try again later.";
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void switchAuthenticationMode() {
    if (_authenticationMode == AuthenticationMode.logIn) {
      setState(() {
        _authenticationMode = AuthenticationMode.signUp;
      });
      authenticationAnimationController.forward();
    } else {
      setState(() {
        _authenticationMode = AuthenticationMode.logIn;
      });
      authenticationAnimationController.reverse();
    }
  }

  @override
  @override
  void initState() {
    super.initState();
    authenticationAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    heightAnimation = Tween<Size>(
      begin: const Size(double.infinity, 850),
      end: const Size(double.infinity, 1200),
    ).animate(
      CurvedAnimation(
        parent: authenticationAnimationController,
        curve: Curves.linear,
      ),
    );
    heightAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    authenticationAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Placeholder(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     'ENGAGE',
        //   ),
        //   titleTextStyle: Theme.of(context).textTheme.bodyLarge.copyWith(
        //         fontSize: 30,
        //       ),
        // ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: deviceSize.width * 0.9,
                  height: deviceSize.height * 0.05,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(45),
                    // border: Border.all(
                    //   color: Theme.of(context).colorScheme.primary,
                    //   width: 1,
                    // ),
                    color: Theme.of(context).colorScheme.primary,
                    // Theme.of(context).colorScheme.background,
                  ),
                  child: Text(
                    _authenticationMode == AuthenticationMode.logIn
                        ? 'Welcome Back :)'
                        : 'Welcome to family :)',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(45),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 0,
                    ),
                  ),
                  height: heightAnimation.value.height * 0.3,
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
                              errorStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
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
                              errorStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            obscureText: obscureTextData,
                            controller: _passwordController,
                            textInputAction: TextInputAction.done,
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                labelText: "Confirm Password",
                                labelStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                                hintText: "Enter Confirm Password",
                                hintStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                errorStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              obscureText: obscureTextData,
                              textInputAction: TextInputAction.done,
                              // controller: _passwordController,
                              validator: _authenticationMode ==
                                      AuthenticationMode.signUp
                                  ? (cpass) {
                                      if (cpass != _passwordController.text) {
                                        return 'Passwords do not match!';
                                      }
                                      return null;
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                          onPressed: switchAuthenticationMode,
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
      ),
    );
  }
}
