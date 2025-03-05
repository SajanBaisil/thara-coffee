import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/labeled_textfield.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageAssets.largeBg,
              color: Colors.amber,
              width: double.infinity,
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                leadingWidth: KPadding.h80,
                leading: Container(
                  padding: EdgeInsets.all(KRadius.r17),
                  margin: EdgeInsets.only(left: KPadding.h16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: ColorManager.lightGrey2),
                  child: SvgPicture.asset(SvgAssets.location),
                ),
                actions: [
                  Container(
                    padding: EdgeInsets.all(KRadius.r18),
                    margin: EdgeInsets.only(right: KPadding.h16),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: ColorManager.lightGrey2),
                    child: SvgPicture.asset(SvgAssets.hamburger),
                  )
                ],
                expandedHeight: KHeight.h130,
                pinned: true,
                centerTitle: false,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                  padding: EdgeInsets.symmetric(horizontal: KPadding.h16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LabeledTextField(
                        hintText: 'Search “Coffee”',
                        borderRadius: KRadius.r100,
                        fillColor: ColorManager.whiteColor,
                        controller: searchController,
                        borderColor: ColorManager.grey,
                        suffix: Container(
                          margin: EdgeInsets.all(KRadius.r5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: ColorManager.grey)),
                          padding: EdgeInsets.all(KPadding.h8),
                          child: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
