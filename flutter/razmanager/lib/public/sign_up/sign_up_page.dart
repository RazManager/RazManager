import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protobuf/well_known_types/google/protobuf/wrappers.pb.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../app_model.dart';
import '../../app_progress_indicator.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/user.pbgrpc.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/grpc_client.dart';
import '../../utilities/image_field.dart';
import '../../utilities/uppercase_textformatter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, this.refresh});
  final AsyncCallback? refresh;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with GrpcClient, ExceptionMessage {
  final formGroup = FormGroup({
    'userName': FormControl<String>(validators: [Validators.required]),
    'email': FormControl<String>(validators: [Validators.email]),
    'name': FormControl<String>(validators: [Validators.required]),
    'shortName': FormControl<String>(validators: [Validators.required, Validators.minLength(3)]),
    'password': FormControl<String>(validators: [Validators.required, Validators.minLength(6)]),
    'image': FormControl<Uint8List?>(value: null),
    'imageDeleted': FormControl<bool?>(),
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: formGroup,
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign-up'), flexibleSpace: const AppProgressIndicator()),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > 600) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Expanded(flex: 2, child: _SignUpBodyMain()), const SizedBox(width: 16), Expanded(child: ImageField(formGroup: formGroup))],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_SignUpBodyMain(), const SizedBox(height: 16), ImageField(formGroup: formGroup)],
                );
              }
            })),
        bottomNavigationBar: BottomAppBar(
          child: ReactiveFormConsumer(builder: (context, formGroup, child) {
            final model = context.read<AppModel>();
            return Row(
              children: [
                IntrinsicWidth(
                  child: FilledButton(
                    onPressed: formGroup.valid && formGroup.dirty & !model.busy
                        ? () async {
                            try {
                              model.setBusy(value: true, notify: true);
                              await signUp();
                              await model.tokenSignIn(formGroup.control('userName').value, formGroup.control('password').value);
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(exceptionMessage(exception)), duration: const Duration(seconds: 10)));
                            }
                          }
                        : null,
                    child: const Text('Sign-up'),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final clientChannel = createClientChannel();
    final client = UserServiceClient(clientChannel);
    final proto = UserCreate(
        userName: formGroup.control('userName').value,
        email: StringValue(value: formGroup.control('email').value),
        name: formGroup.control('name').value,
        shortName: formGroup.control('shortName').value,
        password: formGroup.control('password').value);
    if (formGroup.control('image').dirty && formGroup.control('image').value != null) {
      proto.image = formGroup.control('image').value;
    }
    await client.create(proto);
    await clientChannel.shutdown();
  }
}

class _SignUpBodyMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1300),
        child: ReactiveTextField(
          formControlName: 'userName',
          maxLength: 100,
          decoration: const InputDecoration(
            labelText: 'Username *',
          ),
          validationMessages: {ValidationMessage.required: (error) => 'Please enter an username.'},
        ),
      ),
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1300),
        child: ReactiveTextField(
          formControlName: 'email',
          maxLength: 100,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'E-mail',
          ),
          validationMessages: {ValidationMessage.email: (error) => 'Please enter a valid e-mail address.'},
        ),
      ),
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1300),
        child: ReactiveTextField(
          formControlName: 'name',
          maxLength: 100,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Name *',
          ),
        ),
      ),
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 100),
        child: ReactiveTextField(
          formControlName: 'shortName',
          maxLength: 3,
          inputFormatters: [UpperCaseTextFormatter()],
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(
            labelText: 'Short name *',
          ),
          validationMessages: {ValidationMessage.minLength: (error) => 'Short name must be 3 characters long.'},
        ),
      ),
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1300),
        child: ReactiveTextField(
          formControlName: 'password',
          maxLength: 100,
          decoration: const InputDecoration(
            labelText: 'Password *',
          ),
          obscureText: true,
          validationMessages: {
            ValidationMessage.required: (error) => 'Please enter a password.',
            ValidationMessage.minLength: (error) => 'The password must have at least 6 characters.'
          },
        ),
      ),
    ]);
  }
}
