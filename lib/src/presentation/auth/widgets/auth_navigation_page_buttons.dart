import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/cubit/signup_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_button.dart';

class AuthNavigationPageButtons extends StatefulWidget {
  const AuthNavigationPageButtons({
    required PageController pageController,
    required List<GlobalKey<FormState>> formsGlobalskeys,
    super.key,
  })  : _pageController = pageController,
        _formsGlobalsKeys = formsGlobalskeys;

  final PageController _pageController;
  final List<GlobalKey<FormState>> _formsGlobalsKeys;

  @override
  State<AuthNavigationPageButtons> createState() =>
      _AuthNavigationPageButtonsState();
}

class _AuthNavigationPageButtonsState extends State<AuthNavigationPageButtons>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Constants.mainDuration,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
  }

  void _nextPage({required int currentPage}) {
    if (widget._formsGlobalsKeys[currentPage].currentState!.validate() &&
        currentPage < widget._formsGlobalsKeys.length - 1) {
      _nextPageTrigger();
    }
    if (currentPage == widget._formsGlobalsKeys.length - 1) {
      context.read<SignupCubit>().createNewAccount();
    }
  }

  void _nextPageTrigger() {
    widget._pageController.nextPage(
      duration: Constants.mainDuration,
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    widget._pageController.previousPage(
      duration: Constants.mainDuration,
      curve: Curves.easeInOut,
    );
  }

  void _setPage(int page) {
    if (page != 0) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignupCubit, SignupState, int>(
      selector: (SignupState state) {
        _setPage(state.currentPage);
        return state.currentPage;
      },
      builder: (BuildContext context, int state) {
        final bool isLastPage = state > widget._formsGlobalsKeys.length;
        return Padding(
          padding: EdgeInsets.all(Constants.paddingValue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget? child) {
                  return FadeTransition(
                    opacity: _animation,
                    child: IgnorePointer(
                      ignoring: _animation.value == 0.0,
                      child: child,
                    ),
                  );
                },
                child: SignupButton(
                  onTap: _previousPage,
                  label: 'anterior',
                  prefixIcon: Icons.arrow_back_ios_rounded,
                ),
              ),
              IgnorePointer(
                ignoring: isLastPage,
                child: SignupButton(
                  onTap: () => _nextPage(currentPage: state),
                  label: state + 1 == widget._formsGlobalsKeys.length
                      ? 'finalizar'
                      : 'continuar',
                  suffixIcon: Icons.arrow_forward_ios_rounded,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
