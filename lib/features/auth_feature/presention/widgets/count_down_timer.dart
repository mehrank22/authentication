import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constant.dart';
import '../Screen/signup_with_phone_number.dart';
import '../cubit/signup_cubit.dart';
import '../cubit/sms_auth_status.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({
    super.key,
  });

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  late Timer _timer;
  int _start = 10;

  get kdarkColor => null;

  @override
  void initState() {
    // ignore: unnecessary_new
    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listenWhen: (previous, current) =>
          (previous.smsAuthStatus == current.smsAuthStatus) ? false : true,
      listener: (context, state) {
        if (state.smsAuthStatus is SmsAuthCompleted) {
          _start = 10;
          startTimer();
        }
      },
      builder: (context, state) {
        if (state.smsAuthStatus is SmsAuthCompleted) {
          //
          return (_start != 0)
              ? TextButton(
                  onPressed: () {},
                  child: Text(
                    "ارسال مجدد کد تا $_start ثانیه دیگر",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kSecondryColor, fontSize: 16),
                  ),
                )
              : TextButton(
                  onPressed: () async {
                    SignupScreen.makeOptCode = Random().nextInt(8999) + 1000;

                    BlocProvider.of<SignUpCubit>(context).callSmsAuth(
                        SignupScreen.phoneNumber,
                        SignupScreen.makeOptCode.toString());
                  },
                  child: Text(
                    " درخواست ارسال دوباره کد",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: kDarkColor, fontSize: 16),
                  ),
                );
        }
        if (state.smsAuthStatus is SmsAuthLoading) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  onPressed: () async {},
                  child: const Text(
                    "... در حال ارسال دوباره کد",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.blue,
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  void startTimer() {
    // ignore: unnecessary_new
    _timer = new Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }
}
