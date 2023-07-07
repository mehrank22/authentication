import 'package:flutter/material.dart';

import '../../../../core/utils/constant.dart';

class CardInsertPhoneNumber extends StatefulWidget {
  final TextEditingController textEditingController;
  final GlobalKey<FormState> formKey;
  const CardInsertPhoneNumber(
      {super.key, required this.textEditingController, required this.formKey});

  @override
  State<CardInsertPhoneNumber> createState() => _CardInsertPhoneNumberState();
}

class _CardInsertPhoneNumberState extends State<CardInsertPhoneNumber>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> size;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    size = Tween(begin: 300.0, end: 70.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.ease));

    super.initState();
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
            const SizedBox(height: 40.0),
            Text(
              'شماره موبایل خود را وارد کنید',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kDarkColor,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 40.0),
            Form(
              key: widget.formKey,
              child: Column(
                children: [
                  TextFormField(
                    maxLines: 1,
                    validator: (value) {
                      if (validateMobile(value.toString())) {
                        return "                              شماره تماس را صحیح وارد کنید";
                      } else
                        return null;
                    },
                    controller: widget.textEditingController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 4.0,
                      color: kDarkColor,
                    ),
                    decoration: InputDecoration(
                      hintText: '0912345678',
                      hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          decorationColor: kSecondryColor),
                      errorStyle: const TextStyle(
                        height: 1,
                        fontSize: 14,
                      ),
                      errorMaxLines: 1,
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: kSecondryColor, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: kSecondryColor, width: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  bool validateMobile(String value) {
    String pattern = r'(^\+?09[0-9]{9}$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }
}
