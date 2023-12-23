import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../helpers/styles/styles.dart';
import '../../helpers/utils/validate.dart';
import '../../widgets/divider.dart';
import '../../widgets/styled_flat_button.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: LogInForm(),
          ),
        ),
      ),
    );
  }
}

class LogInForm extends ConsumerStatefulWidget {
  const LogInForm({Key? key}) : super(key: key);

  @override
  LogInFormState createState() => LogInFormState();
}

class LogInFormState extends ConsumerState<LogInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? message = '';

  Future<void> submit() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      await ref.read(authProvider.notifier).login(email!, password!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'FluTask',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 30.0),
            _emailTextField(),
            divider(),
            _passwordTextField(),
            SizedBox(height: 15.0),
            StyledFlatButton(
              'LOGIN',
              onPressed: submit,
            ),
            SizedBox(height: 20.0),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account? ",
                      style: Styles.p,
                    ),
                    TextSpan(
                      text: 'Register.',
                      style: Styles.p
                          .copyWith(color: Colors.blue[500], fontSize: 20),
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () => Navigator.pushNamed(context, '/register'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Forgot Your Password?',
                  style: Styles.p.copyWith(color: Colors.blue[500]),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => Navigator.pushNamed(context, '/password-reset'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return Consumer(
      builder: (context, ref, child) {
        var controller = ref.watch(authProvider);
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 231, 231, 231),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          child: TextFormField(
              obscureText: controller.showLoginPassword ? false : true,
              decoration: Styles.input.copyWith(
                hintText: 'Password',
                suffixIcon: IconButton(
                    onPressed: () => controller.toggleShowPassword("lp"),
                    icon: Icon(controller.showLoginPassword
                        ? Icons.visibility_off
                        : Icons.visibility)),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              validator: (value) {
                password = value!.trim();
                return Validate.requiredField(value, 'Password is required.');
              }),
        );
      },
    );
  }

  Widget _emailTextField() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 231, 231, 231),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: TextFormField(
        decoration: Styles.input.copyWith(
          hintText: 'Email',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        validator: (value) {
          email = value!.trim();
          return Validate.validateEmail(value);
        },
      ),
    );
  }
}
