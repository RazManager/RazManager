import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../app_model.dart';
import '../../app_progress_indicator.dart';
import '../../utilities/exception_message.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, this.refresh});
  final AsyncCallback? refresh;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with ExceptionMessage {
  final formGroup = FormGroup({
    'userName': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required, Validators.minLength(6)]),
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: formGroup,
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign-in'), flexibleSpace: const AppProgressIndicator()),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1300),
                child: ReactiveTextField(
                  formControlName: 'userName',
                  maxLength: 100,
                  decoration: const InputDecoration(labelText: 'Username *'),
                  validationMessages: {ValidationMessage.required: (error) => 'Please enter an username address.'},
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1300),
                child: ReactiveTextField(
                  formControlName: 'password',
                  maxLength: 100,
                  decoration: const InputDecoration(labelText: 'Password *'),
                  obscureText: true,
                  validationMessages: {
                    ValidationMessage.required: (error) => 'Please enter a password.',
                    ValidationMessage.minLength: (error) => 'The password must have at least 6 characters.',
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              ReactiveFormConsumer(
                builder: (context, formGroup, child) {
                  final model = context.read<AppModel>();
                  return FilledButton(
                    onPressed: formGroup.valid && formGroup.dirty & !model.busy
                        ? () async {
                            try {
                              model.setBusy(value: true, notify: true);
                              await model.tokenSignIn(formGroup.control('userName').value, formGroup.control('password').value);
                              if (!model.isAuthenticated()) {
                                model.setBusy(value: false, notify: true);

                                if (!context.mounted) {
                                  return;
                                }
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text('Invalid username or password.'), duration: const Duration(seconds: 10)));
                                return;
                              }

                              if (!context.mounted) {
                                return;
                              }
                              await widget.refresh!();
                              if (!context.mounted) {
                                return;
                              }
                              context.pop();
                            } on Exception catch (exception) {
                              model.setBusy(value: false, notify: true);
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(exceptionMessage(exception)), duration: const Duration(seconds: 10)));
                            }
                          }
                        : null,
                    child: const Text('Sign-in'),
                  );
                },
              ),
              //const SizedBox(width: 16),
              //FilledButton.tonal(onPressed: () => context.pop, child: const Text('Forgot password'))
            ],
          ),
        ),
      ),
    );
  }
}
