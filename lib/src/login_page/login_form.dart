part of login_page;

class _NameInput extends StatelessWidget {
  const _NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return _InputField(key: key,
          icon: Icons.account_circle_outlined,
          hintText: 'User name...',
          onChanged: (email){
            ///TODO : get name enter here, for mail without name
          },
          //errorText: state.email.invalid ? 'invalid email' : null,
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return _InputField(
          key: key,
          icon: Icons.email_outlined,
          hintText: 'Email...',
          isEmail: true,
          onChanged: (email) => BlocProvider
              .of<LoginCubit>(context)
              .emailChanged(email),
          errorText: state.email.invalid ? 'invalid email' : null,
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return _InputField(
          key: widget.key,
          icon: Icons.lock_outline,
          hintText:  'Password...',
          isPassword: showPassword,
          onChanged: (password) =>
              BlocProvider.of<LoginCubit>(context).passwordChanged(password),
          errorText: state.password.invalid ? 'invalid password' : null,
          suffixIcon: IconButton(
            icon: Icon(showPassword? CupertinoIcons.eye_slash : CupertinoIcons.eye),
            onPressed: (){
              setState(() {
                showPassword = !showPassword;
              });

            },
          ),
        );
      },
    );
  }
}


