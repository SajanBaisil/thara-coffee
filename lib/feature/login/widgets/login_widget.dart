import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:thara_coffee/feature/login/domain/model/company_response.dart';
import 'package:thara_coffee/feature/login/logic/login_bloc/login_bloc.dart';
import 'package:thara_coffee/feature/main/main_screen.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/common_shimmer.dart';
import 'package:thara_coffee/shared/components/custom_dropdown.dart';
import 'package:thara_coffee/shared/components/datafetch_status.dart';
import 'package:thara_coffee/shared/components/labeled_textfield.dart';
import 'package:thara_coffee/shared/components/primary_button.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';
import 'package:thara_coffee/shared/extensions/on_list.dart';
import 'package:thara_coffee/shared/router/http%20utils/http_helper.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    super.key,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final buttonController = MultiStateButtonController();
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<CompanyData?> selectedState = ValueNotifier<CompanyData?>(null);

  @override
  void dispose() {
    loginController.dispose();
    phoneNumberController.dispose();
    buttonController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginBloc>().add(ViewCompanyEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.loginStatus != current.loginStatus ||
          previous.companyFetchStatus != current.companyFetchStatus,
      listener: (context, state) {
        if (state.loginStatus == DataFetchStatus.waiting) {
          buttonController.setButtonState = ButtonStates.loading;
        }
        if (state.loginStatus == DataFetchStatus.success) {
          buttonController.setButtonState = ButtonStates.idle;
          log('navigate');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false);
        }
        if (state.loginStatus == DataFetchStatus.failed) {
          buttonController.setButtonState = ButtonStates.idle;
          HttpHelper.handleMessage(state.errorMessage, context,
              type: HandleTypes.snackbar);
        }
        if (state.companyFetchStatus == DataFetchStatus.failed) {
          HttpHelper.handleMessage(state.errorMessage, context,
              type: HandleTypes.snackbar);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: KPadding.h50),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                40.verticalSpace,
                Text(
                  'Login',
                  style: textTheme(context)
                      .titleSmall
                      ?.copyWith(fontSize: KFontSize.f18),
                ),
                3.verticalSpace,
                Text(
                  'Enter your details',
                  style: textTheme(context).titleSmall?.copyWith(
                      fontSize: KFontSize.f14, color: ColorManager.lightGrey),
                ),
                21.verticalSpace,
                state.companyFetchStatus == DataFetchStatus.waiting
                    ? CommonShimmer(
                        child: CustomDropDown<CompanyData>(
                          values: [],
                          hintText: 'Select Nearest Shop',
                          borderColor: Color(0xffBEBEBE),
                          hintStyle: textTheme(context).bodyMedium?.copyWith(
                              fontSize: KFontSize.f14,
                              color: ColorManager.textFieldTextColor,
                              decoration: TextDecoration.none,
                              decorationThickness: 0),
                          borderRadius: BorderRadius.circular(KRadius.r15),
                          backGroundColor: ColorManager.whiteColor,
                          value: null,
                          onChanged: (selected) {},
                        ),
                      )
                    : ValueListenableBuilder(
                        valueListenable: selectedState,
                        builder: (context, value, _) {
                          return AnimatedSize(
                            duration: Duration(milliseconds: 300),
                            child: state.companyModel?.data?.isNullOrEmpty ??
                                    true
                                ? SizedBox()
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    child: CustomDropDown<CompanyData>(
                                      values: state.companyModel?.data ?? [],
                                      hintText: 'Select Nearest Shop',
                                      borderColor: Color(0xffBEBEBE),
                                      hintStyle: textTheme(context)
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: KFontSize.f14,
                                              color: ColorManager
                                                  .textFieldTextColor,
                                              decoration: TextDecoration.none,
                                              decorationThickness: 0),
                                      borderRadius:
                                          BorderRadius.circular(KRadius.r15),
                                      validator: (p0) {
                                        if (value == null) {
                                          return 'Company is required';
                                        }
                                        return null;
                                      },
                                      backGroundColor: ColorManager.whiteColor,
                                      value: value,
                                      onChanged: (selected) {
                                        selectedState.value = selected;
                                      },
                                      displayName: (p0) => p0.name ?? "",
                                    ),
                                  ),
                          );
                        }),
                8.verticalSpace,
                LabeledTextField(
                  prefixIcon: Padding(
                      padding: EdgeInsets.all(KPadding.h10),
                      child: SvgPicture.asset(
                        SvgAssets.person,
                        height: KHeight.h10,
                        width: KWidth.w10,
                      )),
                  controller: loginController,
                  fillColor: ColorManager.whiteColor,
                  hintText: 'Name',
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                8.verticalSpace,
                LabeledTextField(
                  counterText: '',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(KPadding.h10),
                    child: SvgPicture.asset(
                      SvgAssets.dialPad,
                      height: KHeight.h10,
                      width: KWidth.w10,
                    ),
                  ),
                  maxLength: 10,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(p0) ||
                        p0.length != 10) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  controller: phoneNumberController,
                  fillColor: ColorManager.whiteColor,
                  hintText: '999 999 99 99',
                ),
                25.verticalSpace,
                PrimaryButton(
                    key: Key('get-otp'),
                    width: KWidth.w190,
                    controller: buttonController,
                    color: ColorManager.primary,
                    borderRadius: KRadius.r100,
                    onPressed: () {
                      final userName = loginController.text.trim();
                      final phoneNumber = phoneNumberController.text.trim();
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<LoginBloc>().add(LoginButtonPressed(
                            companyId: selectedState.value?.id ?? '',
                            username: userName,
                            phoneNumber: phoneNumber));
                      }
                    },
                    text: 'Login'),
                70.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
