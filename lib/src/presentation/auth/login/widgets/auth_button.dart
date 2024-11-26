import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/core/extensions/string_extensions.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/cubit/login_cubit.dart';

class AuthButton extends StatefulWidget {
  const AuthButton({VoidCallback? onTap, super.key}) : _onTap = onTap;
  final VoidCallback? _onTap;

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _animation;
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(
      begin: 1,
      end: .6,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is Loading) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      builder: (BuildContext context, LoginState state) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) => FadeTransition(
            opacity: _animation,
            child: child,
          ),
          child: Padding(
            padding: Constants.mainPadding.copyWith(top: 0) * 2,
            child: Material(
              color: Colors.red,
              borderRadius: Constants.mainBorderRadius,
              child: IgnorePointer(
                ignoring: state is Loading,
                child: InkWell(
                  onTap: widget._onTap,
                  child: Padding(
                    padding: EdgeInsets.all(
                      Constants.paddingValue * 1.5,
                    ),
                    child: Center(
                      child: Text(
                        'iniciar sesion'.capitalize(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
