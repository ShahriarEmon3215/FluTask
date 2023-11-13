import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';
import '../../helpers/styles/styles.dart';
import '../../helpers/utils/validate.dart';
import '../../widgets/divider.dart';
import '../../widgets/styled_flat_button.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text('Register'),
          ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends ConsumerState<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? name;
  String? email;
  String? password;
  String? passwordConfirm;
  String? message = '';

  var response = false;

  Future<void> submit() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      response = await ref
          .read(authProvider.notifier)
          .register(name!, email!, password!, passwordConfirm!, context);
      if (response) {
        Navigator.pop(context);
      }
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
          children: <Widget>[
            Text(
              'Register To FluTask Account',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: 10.0),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: Styles.error,
            ),
            _userNameField(),
            divider(),
            _emailField(),
            divider(),
            _passwordField(),
            divider(),
            _confirmPasswordField(),
            SizedBox(height: 40),
            StyledFlatButton(
              'Register',
              onPressed: submit,
            ),
          ],
        ),
      ),
    );
  }

  Container _userNameField() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 231, 231, 231),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: TextFormField(
          decoration: Styles.input.copyWith(
            hintText: 'User Name',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          validator: (value) {
            name = value!.trim();
            return Validate.requiredField(value, 'Name is required.');
          }),
    );
  }

  Container _emailField() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 231, 231, 231),
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
          }),
    );
  }

  Widget _passwordField() {
    return Consumer(
      builder: (context, ref, child) {
        var controller = ref.watch(authProvider);
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 231, 231, 231),
          ),
          child: TextFormField(
              obscureText: controller.showRegisterPassword ? false : true,
              decoration: Styles.input.copyWith(
                hintText: 'Password',
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () => controller.toggleShowPassword("rp"),
                  icon: Icon(controller.showRegisterPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
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

  Widget _confirmPasswordField() {
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
              obscureText: controller.showRegiserConfPassword ? false : true,
              decoration: Styles.input.copyWith(
                hintText: 'Confirm Password',
                suffixIcon: IconButton(
                  onPressed: () => controller.toggleShowPassword("rcp"),
                  icon: Icon(controller.showRegiserConfPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              validator: (value) {
                passwordConfirm = value!.trim();
                return Validate.requiredField(
                    value, 'Password confirm is required.');
              }),
        );
      },
    );
  }
}
