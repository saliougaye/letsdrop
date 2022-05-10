import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsdrop/blocs/auth/auth_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/routes.dart';
import 'package:letsdrop/services/spotify_service.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';
import 'package:letsdrop/widgets/loading.dart';

class Login extends StatelessWidget {

  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {

        if(state is AuthFailed) {
           ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(const SnackBar(content: Text("Auth Failed")));
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                Future.delayed(const Duration(seconds: 0), () {
                  Navigator.pushNamed(context, AppRoutes.Home,
                      arguments: state.user);
                });

                return const Loading();
              }

              if (state is AuthLoading) {
                return const Loading();
              }

              return _loginWidget(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _loginWidget(BuildContext authContext) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black, spreadRadius: 1, blurRadius: 4)
            ], color: Colors.white, shape: BoxShape.circle),
            child: CircleAvatar(
              child: Image.asset(
                "assets/images/spotify-logo.png",
              ),
              radius: 80,
              backgroundColor: Theme.of(context).backgroundColor,
            ),
          ),
          addVerticalSpace(20),
          InkWell(
            onTap: () async {
              authContext.read<AuthBloc>().add(UserRequestLogin());
            },
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(29, 185, 84, 1),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "LOG IN WITH SPOTIFY",
                    style: Theme.of(context).textTheme.button,
                  ),
                )),
          )
        ],
      );
    });
  }
}
