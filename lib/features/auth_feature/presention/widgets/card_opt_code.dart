import 'package:auth_with_phone_number/features/auth_feature/presention/Screen/signup_with_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../core/utils/constant.dart';

class CardInserOptCode extends StatefulWidget {
  const CardInserOptCode({super.key});

  @override
  State<CardInserOptCode> createState() => _CardInserOptCodeState();
}

class _CardInserOptCodeState extends State<CardInserOptCode>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> size;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    size = Tween(begin: 300.0, end: 70.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.ease)); //button animation

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30.0),
            Text(
              '.کد ارسال شده به  ${SignupScreen.phoneNumber} را وارد کنید',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: kDarkColor,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 40.0),
            OTPTextField(
              otpFieldStyle: OtpFieldStyle(
                  backgroundColor: kSecondryColor,
                  focusBorderColor: kDarkColor),
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 50,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onChanged: (value) {},
              onCompleted: (pin) {
                SignupScreen.optCode = pin;
              },
            ),
            const SizedBox(height: 20.0),
            // CountDownTimer(),
            // const SizedBox(height: 20.0),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
