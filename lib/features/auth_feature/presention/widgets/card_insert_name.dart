import 'package:flutter/material.dart';

import '../../../../core/utils/constant.dart';

class CardInsertName extends StatefulWidget {
  final TextEditingController textEditingController;
  final GlobalKey<FormState> formKey;
  const CardInsertName(
      {super.key, required this.textEditingController, required this.formKey});

  @override
  State<CardInsertName> createState() => _CardInsertNameState();
}

class _CardInsertNameState extends State<CardInsertName>
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
              'نام خود را وارد کنید',
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
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      maxLines: 1,
                      validator: (value) {
                        if (widget.textEditingController.text.length < 5) {
                          return "                              نام خود را کامل وارد کنید";
                        } else
                          return null;
                      },
                      controller: widget.textEditingController,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kDarkColor,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              BorderSide(color: kSecondryColor, width: 1),
                        ),

                        //border: InputBorder.none,
                        fillColor: kSecondryColor.withOpacity(0.7),

                        hintText: 'مثال : علی حسینی',
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

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              BorderSide(color: kSecondryColor, width: 1),
                        ),
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
