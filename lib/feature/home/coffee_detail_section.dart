import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:thara_coffee/feature/home/domain/model/cart_item.dart';
import 'package:thara_coffee/feature/home/domain/model/product_model.dart';
import 'package:thara_coffee/feature/home/logic/home_bloc/home_bloc.dart';
import 'package:thara_coffee/feature/home/logic/home_bloc/home_event.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/labeled_textfield.dart';
import 'package:thara_coffee/shared/components/primary_button.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/router/responsive_helper.dart' as res;

class CoffeeDetailSection extends StatefulWidget {
  const CoffeeDetailSection({super.key, required this.product});

  final ProductModel? product;

  @override
  State<CoffeeDetailSection> createState() => _CoffeeDetailSectionState();
}

class _CoffeeDetailSectionState extends State<CoffeeDetailSection> {
  final TextEditingController preferenceController = TextEditingController();
  final buttonController = MultiStateButtonController();
  final ValueNotifier<int> itemCount = ValueNotifier<int>(0);

  @override
  void dispose() {
    preferenceController.dispose();
    buttonController.dispose();
    itemCount.dispose();
    super.dispose();
  }

  // Add this method
  void _updateCount(bool increment) {
    if (increment && itemCount.value < 99) {
      itemCount.value++;
    } else if (!increment && itemCount.value > 1) {
      itemCount.value--;
    }
  }

  @override
  void initState() {
    super.initState();
    context
        .read<HomeBloc>()
        .add(SingleProductFetchEvent(widget.product?.id ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = serviceLocator<res.ResponsiveHelper>().isSmallScreen;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Container(
        margin: EdgeInsets.only(
            top: isSmallScreen ? 50.h : 85.h,
            bottom: 35.h,
            left: 20.w,
            right: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(KRadius.r35),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(KRadius.r35),
                    child: Image.asset(
                      ImageAssets.coffee,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  CloseButton(),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: isSmallScreen ? 160.h : KPadding.h170,
                            left: 6.w,
                            right: 6.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cappuccino',
                                  style: textTheme(context)
                                      .displayMedium
                                      ?.copyWith(fontSize: KFontSize.f20),
                                ),
                                Text(
                                  'with chocolate',
                                  style: textTheme(context)
                                      .displaySmall
                                      ?.copyWith(fontSize: KFontSize.f14),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: KPadding.h6,
                                  vertical: KPadding.v2),
                              margin: EdgeInsets.symmetric(
                                  vertical: KPadding.v10,
                                  horizontal: KPadding.h10),
                              decoration: BoxDecoration(
                                  color: ColorManager.fff6c0,
                                  borderRadius:
                                      BorderRadius.circular(KRadius.r100)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(SvgAssets.star),
                                  Text('4.8'),
                                  5.horizontalSpace,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace,
                      Container(
                        decoration: BoxDecoration(
                            color: ColorManager.whiteColor,
                            borderRadius: BorderRadius.circular(KRadius.r35)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            19.verticalSpace,
                            Container(
                              padding: EdgeInsets.only(
                                  left: KPadding.h15,
                                  right: KPadding.h15,
                                  top: KPadding.v15,
                                  bottom: KPadding.v17),
                              margin: EdgeInsets.symmetric(
                                  horizontal: KPadding.h15),
                              decoration: BoxDecoration(
                                color: ColorManager.eee,
                                borderRadius:
                                    BorderRadius.circular(KRadius.r100),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(SvgAssets.coffeeBean),
                                    Text(
                                      'Coffee',
                                      style: textTheme(context)
                                          .labelLarge
                                          ?.copyWith(
                                              color: ColorManager.grey484848,
                                              fontSize: KFontSize.f13),
                                    ),
                                    Container(
                                      width: KWidth.w2,
                                      color: ColorManager.errorColor,
                                    ),
                                    SvgPicture.asset(SvgAssets.chocolate),
                                    Text('Chocolate',
                                        style: textTheme(context)
                                            .labelLarge
                                            ?.copyWith(
                                                color: ColorManager.grey484848,
                                                fontSize: KFontSize.f13)),
                                    Container(
                                      width: KWidth.w2,
                                      color: ColorManager.errorColor,
                                    ),
                                    Text('Roasted',
                                        style: textTheme(context)
                                            .labelLarge
                                            ?.copyWith(
                                                color: ColorManager.grey484848,
                                                fontSize: KFontSize.f13))
                                  ],
                                ),
                              ),
                            ),
                            20.verticalSpace,
                            Padding(
                              padding: EdgeInsets.only(
                                left: KPadding.h15,
                                right: KPadding.h15,
                              ),
                              child: Text('About',
                                  style: textTheme(context)
                                      .labelLarge
                                      ?.copyWith(
                                          color: ColorManager.grey484848,
                                          fontSize: KFontSize.f15)),
                            ),
                            2.verticalSpace,
                            Padding(
                              padding: EdgeInsets.only(
                                left: KPadding.h15,
                                right: KPadding.h15,
                              ),
                              child: Text(
                                  'A cappuccino is a classic Italian coffee drink made with a combination of espresso, steamed milk, and a layer of frothed milk on top. The traditional ratio of the drink is one-third espresso, one-third steamed milk, and one-third frothed milk.',
                                  style: textTheme(context)
                                      .labelMedium
                                      ?.copyWith(
                                          color: ColorManager.grey545454,
                                          fontSize: isSmallScreen
                                              ? KFontSize.f10
                                              : KFontSize.f13)),
                            ),
                            15.verticalSpace,
                            Padding(
                              padding: EdgeInsets.only(
                                left: KPadding.h15,
                                right: KPadding.h15,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹ 149.00',
                                    style: textTheme(context)
                                        .titleMedium
                                        ?.copyWith(fontSize: KFontSize.f18),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () => _updateCount(false),
                                        child: Container(
                                          padding: EdgeInsets.all(KRadius.r10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorManager.eee),
                                          child: Icon(Icons.remove),
                                        ),
                                      ),
                                      6.horizontalSpace,
                                      ValueListenableBuilder(
                                          valueListenable: itemCount,
                                          builder: (context, count, _) {
                                            return Container(
                                              padding:
                                                  EdgeInsets.all(KRadius.r15),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      ColorManager.errorColor),
                                              child: Text(
                                                count.toString(),
                                                style: textTheme(context)
                                                    .headlineLarge
                                                    ?.copyWith(
                                                        fontSize:
                                                            KFontSize.f20),
                                              ),
                                            );
                                          }),
                                      7.horizontalSpace,
                                      InkWell(
                                        onTap: () => _updateCount(true),
                                        child: Container(
                                          padding: EdgeInsets.all(KRadius.r10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorManager.grey4F4F4F),
                                          child: Icon(
                                            Icons.add,
                                            color: ColorManager.whiteColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            11.verticalSpace,
                            Padding(
                              padding: EdgeInsets.only(
                                left: KPadding.h15,
                                right: KPadding.h15,
                              ),
                              child: Text(
                                'Add preference',
                                style: textTheme(context).labelLarge?.copyWith(
                                    color: ColorManager.grey484848,
                                    fontSize: KFontSize.f14),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: KPadding.h8,
                                right: KPadding.h8,
                              ),
                              child: LabeledTextField(
                                controller: preferenceController,
                                fillColor: ColorManager.whiteColor,
                                hintText: 'e.g., ‘without sugar’',
                              ),
                            ),
                            14.verticalSpace,
                            Padding(
                              padding: EdgeInsets.only(
                                left: KPadding.h15,
                                right: KPadding.h15,
                              ),
                              child: PrimaryButton(
                                  key: Key('get-otp'),
                                  width: double.infinity,
                                  controller: buttonController,
                                  color: ColorManager.primary,
                                  borderRadius: KRadius.r100,
                                  onPressed: () {
                                    final cartItem = CartItem(
                                      id: widget.product?.id ?? '',
                                      price: double.tryParse(
                                              widget.product?.price ?? "") ??
                                          0,
                                      quantity: itemCount.value,
                                      customerNote:
                                          preferenceController.text.trim(),
                                    );
                                  },
                                  text: 'Add to cart'),
                            ),
                            17.verticalSpace
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  const CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(top: 10.h, right: 10.w),
            padding: EdgeInsets.all(KRadius.r6),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: ColorManager.whiteColor),
            child: Icon(
              Icons.close,
              color: ColorManager.secondary,
            ),
          ),
        )
      ],
    );
  }
}
