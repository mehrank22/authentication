import 'dart:math';
import 'package:auth_with_phone_number/features/auth_feature/presention/cubit/page_view_status.dart';
import 'package:auth_with_phone_number/features/auth_feature/presention/cubit/signup_cubit.dart';
import 'package:auth_with_phone_number/features/auth_feature/presention/cubit/sms_auth_status.dart';
import 'package:auth_with_phone_number/features/auth_feature/presention/widgets/card_insert_name.dart';
import 'package:auth_with_phone_number/features/auth_feature/presention/widgets/card_opt_code.dart';
import 'package:auth_with_phone_number/features/auth_feature/presention/widgets/card_welcome.dart';
import 'package:auth_with_phone_number/features/auth_feature/presention/widgets/cart_inser_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constant.dart';
import '../../../../second_screen.dart';
import '../widgets/count_down_timer.dart';

class SignupScreen extends StatefulWidget {
  static String optCode = "";
  static int makeOptCode = 0;
  static String phoneNumber = "0";

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  late PageController pageControler;

  late AnimationController animationController;

  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingControllerName = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formKeyName = GlobalKey<FormState>();
  late Animation<double> size;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    size = Tween(begin: 300.0, end: 70.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.ease));

    pageControler = PageController(initialPage: 0);

    super.initState();
  }

  @override
  void dispose() {
    pageControler.dispose();
    animationController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  //int pageNumber = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: BlocConsumer<SignUpCubit, SignUpState>(
            listenWhen: (previous, current) {
              if (previous.smsAuthStatus == current.smsAuthStatus) {
                return false;
              }
              return true;
            },
            listener: (context, state) async {
              if (state.smsAuthStatus is SmsAuthCompleted) {
                if (pageControler.page!.toInt() == 2) {
                  pageControler.nextPage(
                      duration: const Duration(seconds: 1), curve: Curves.ease);
                  await animationController.reverse();
                }
              }
            },
            builder: (context, state) {
              return Stack(alignment: Alignment.center, children: [
                Opacity(
                  opacity: 0.6,
                  child: Image.asset(
                    'assets/images/background.jpg',
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: height * 0.1,
                  child: Image.asset(
                    'assets/images/logoniyateb.png',
                    width: width * 0.8,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Center(
                  child: Container(
                    height: height * 0.4,
                    decoration: const BoxDecoration(),
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: PageView(
                            controller: pageControler,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              const CardWelcome(
                                title: 'نیاطب',
                                subtitle:
                                    " با ما به آسانی پزشکی را بیاموزید و در آزمونها موفق شوید",
                                imagePath: 'assets/images/welcome.png',
                              ),
                              const CardWelcome(
                                title: 'آموزش تصویری',
                                subtitle:
                                    "بیش از 200 ویدیو آموزشی با تحلیل آن ",
                                imagePath: 'assets/images/welcome2.png',
                              ),
                              CardInsertPhoneNumber(
                                textEditingController: textEditingController,
                                formKey: formKey,
                              ),
                              Stack(
                                //Opt code insert                                alignment: Alignment.centerRight,
                                children: [
                                  const CardInserOptCode(),
                                  const Positioned(
                                      right: 15,
                                      bottom: 50,
                                      child: CountDownTimer()),
                                  Positioned(
                                    bottom: 5,
                                    right: 16,
                                    child: TextButton(
                                        onPressed: () {
                                          pageControler.previousPage(
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve: Curves.ease);
                                        },
                                        child: Text(
                                          "تغییر شماره موبایل",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: kDarkColor, fontSize: 16),
                                        )),
                                  ),
                                ],
                              ),
                              CardInsertName(
                                textEditingController:
                                    textEditingControllerName,
                                formKey: formKeyName,
                              ),
                            ],
                            onPageChanged: (value) {
                              if (value > 1 && value < 4) {
                                BlocProvider.of<SignUpCubit>(context)
                                    .changeButtonText("تایید");
                              } else if (value > 3) {
                                BlocProvider.of<SignUpCubit>(context)
                                    .changeButtonText("تمام");
                              }
                            },
                          )),
                    ),
                  ),
                ),
                Positioned(
                  // Button accept
                  bottom: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) {
                          return SizedBox(
                            width: size.value,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (pageControler.page!.toInt() == 2) {
                                  if (formKey.currentState!.validate()) {
                                    SignupScreen.phoneNumber =
                                        textEditingController.text;
                                    // phone number insert page
                                    SignupScreen.makeOptCode =
                                        Random().nextInt(8999) + 1000;
                                    await animationController.forward();
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    if (!mounted) return;
                                    BlocProvider.of<SignUpCubit>(context)
                                        .callSmsAuth(
                                            SignupScreen.phoneNumber,
                                            SignupScreen.makeOptCode
                                                .toString());
                                  }

                                  // await animationController.reverse();
                                } else if (pageControler.page!.toInt() == 3) {
                                  // opt code insert page
                                  if ((SignupScreen.makeOptCode.toString()) ==
                                      SignupScreen.optCode) {
                                    // Check opt_code

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("کد صحیح است")));
                                    pageControler.nextPage(
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.ease);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("کد غلط است")));
                                  }
                                } else if (pageControler.page == 4) {
                                  if (formKeyName.currentState!.validate()) {
                                    // phone number insert page

                                    if (!mounted) return;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SecondScreen(),
                                        ));
                                  }
                                } else if (pageControler.page!.toInt() < 2) {
                                  pageControler.nextPage(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.ease);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kButtonColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: (size.value < 100)
                                      ? BorderRadius.circular(30)
                                      : BorderRadius.circular(10.0),
                                ),
                              ),
                              child: (size.value < 150)
                                  ? CircularProgressIndicator(
                                      color: kSecondryColor,
                                    )
                                  : BlocBuilder<SignUpCubit, SignUpState>(
                                      builder: (context, state) {
                                        if (state.pageViewStatus
                                            is PageViewCompleted) {
                                          PageViewCompleted pageViewCompleted =
                                              state.pageViewStatus
                                                  as PageViewCompleted;

                                          return Text(
                                            pageViewCompleted.text,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        }
                                        return const Text(
                                          'بعدی',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ]);
            },
          ),
        );
      }),
    );
  }
}
