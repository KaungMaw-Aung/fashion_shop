import 'dart:ui';

import 'package:animation_assignment/explicit_animated_widgets/animated_expand_collapse_button_view.dart';
import 'package:animation_assignment/explicit_animated_widgets/animated_favorite_button_view.dart';
import 'package:animation_assignment/resources/dimens.dart';
import 'package:animation_assignment/resources/strings.dart';
import 'package:flutter/material.dart';

const kDescriptionShowHideDuration = 250;
const kColorSwitchDuration = 200;

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  /// State Variable
  var isExpanded = true;
  var isSmallSelected = false;
  var isMediumSelected = false;
  var isLargeSelected = false;
  var isXLSelected = false;
  var isXXLSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          BannerSectionView(onTapBack: () => Navigator.pop(context)),
          const ItemNameAndPriceView(),
          const SizedBox(height: MARGIN_XLARGE),
          DescriptionSectionView(
            isExpanded: isExpanded,
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          const SizedBox(height: MARGIN_XLARGE),
          const SizeGuideTitleView(),
          const SizedBox(height: MARGIN_LARGE),
          HorizontalSizeButtonsView(
            isSmallSelected: isSmallSelected,
            isMediumSelected: isMediumSelected,
            isLargeSelected: isLargeSelected,
            isXLSelected: isXLSelected,
            isXXLSelected: isXXLSelected,
            onTapLarge: () {
              setState(() {
                isLargeSelected = !isLargeSelected;
              });
            },
            onTapSmall: () {
              setState(() {
                isSmallSelected = !isSmallSelected;
              });
            },
            onTapMedium: () {
              setState(() {
                isMediumSelected = !isMediumSelected;
              });
            },
            onTapXXL: () {
              setState(() {
                isXXLSelected = !isXXLSelected;
              });
            },
            onTapXL: () {
              setState(() {
                isXLSelected = !isXLSelected;
              });
            },
          ),
        ],
      ),
    );
  }
}

class HorizontalSizeButtonsView extends StatelessWidget {
  const HorizontalSizeButtonsView({
    Key? key,
    required this.isSmallSelected,
    required this.isMediumSelected,
    required this.isLargeSelected,
    required this.isXLSelected,
    required this.isXXLSelected,
    required this.onTapSmall,
    required this.onTapMedium,
    required this.onTapLarge,
    required this.onTapXL,
    required this.onTapXXL,
  }) : super(key: key);

  final bool isSmallSelected;
  final bool isMediumSelected;
  final bool isLargeSelected;
  final bool isXLSelected;
  final bool isXXLSelected;
  final Function onTapSmall;
  final Function onTapMedium;
  final Function onTapLarge;
  final Function onTapXL;
  final Function onTapXXL;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        SizeButtonView(
          isSelected: isSmallSelected,
          onTap: onTapSmall,
          size: SMALL,
        ),
        const Spacer(),
        SizeButtonView(
          isSelected: isMediumSelected,
          onTap: onTapMedium,
          size: MEDIUM,
        ),
        const Spacer(),
        SizeButtonView(
          isSelected: isLargeSelected,
          onTap: onTapLarge,
          size: LARGE,
        ),
        const Spacer(),
        SizeButtonView(
          isSelected: isXLSelected,
          onTap: onTapXL,
          size: XL,
        ),
        const Spacer(),
        SizeButtonView(
          isSelected: isXXLSelected,
          onTap: onTapXXL,
          size: XXL,
        ),
        const Spacer(),
      ],
    );
  }
}

class SizeButtonView extends StatelessWidget {
  final bool isSelected;
  final Function onTap;
  final String size;

  SizeButtonView({
    required this.isSelected,
    required this.onTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 4,
      shadowColor: Colors.black54,
      borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => onTap(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: kColorSwitchDuration),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isSelected ? Colors.deepPurple : Colors.white,
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
          ),
          child: Center(
            child: Text(
              size,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black38,
                fontSize: TEXT_REGULAR_3X,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SizeGuideTitleView extends StatelessWidget {
  const SizeGuideTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SizedBox(width: MARGIN_LARGE),
        Text(
          SIZE_YOUR_SIZE,
          style: TextStyle(
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        Text(
          SIZE_GUIDE,
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: MARGIN_LARGE),
      ],
    );
  }
}

class DescriptionSectionView extends StatelessWidget {
  final bool isExpanded;
  final Function onTap;

  DescriptionSectionView({
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DescriptionWithExpandCollapseButtonView(
          onTap: onTap,
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        AnimatedSize(
          duration: const Duration(
            milliseconds: kDescriptionShowHideDuration,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
            child: SizedBox(
              height: isExpanded ? null : 0,
              child: const Text(
                DUMMY_DESCRIPTION,
                style: TextStyle(
                  fontSize: TEXT_REGULAR_2X,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DescriptionWithExpandCollapseButtonView extends StatelessWidget {
  final Function onTap;

  DescriptionWithExpandCollapseButtonView({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: MARGIN_LARGE),
        const Text(
          DESCRIPTIONS,
          style: TextStyle(
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        AnimatedExpandCollapseButtonView(onTap: onTap),
        const SizedBox(width: MARGIN_LARGE),
      ],
    );
  }
}

class ItemNameAndPriceView extends StatelessWidget {
  const ItemNameAndPriceView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          OUTFIT_IDEAS,
          style: TextStyle(
            color: Colors.black38,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          MODERN_BLUE_JACKET,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: TEXT_HEADING_1X,
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          '\$ 19,39',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            fontSize: TEXT_REGULAR_3X,
          ),
        ),
      ],
    );
  }
}

class BannerSectionView extends StatelessWidget {
  final Function onTapBack;

  BannerSectionView({required this.onTapBack});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: BANNER_HEIGHT,
      child: Stack(
        children: [
          const Positioned.fill(
            child: BannerImageView(),
          ),
          Positioned(
            top: PROFILE_SECTION_TOP_PADDING,
            left: 0,
            right: 0,
            child: AppBarView(onTapBack: onTapBack),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: TOP_CURVE_CONTAINER_HEIGHT,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(MARGIN_LARGE),
                    topRight: Radius.circular(MARGIN_LARGE),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class AppBarView extends StatelessWidget {
  final Function onTapBack;

  AppBarView({required this.onTapBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: MARGIN_LARGE),
        GestureDetector(
          onTap: () => onTapBack(),
          child: const Icon(
            Icons.chevron_left,
            size: MARGIN_XLARGE,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        const AnimatedFavoriteButtonView(),
        const SizedBox(width: MARGIN_MEDIUM_2),
        const Icon(
          Icons.share,
          size: MARGIN_XLARGE,
          color: Colors.white,
        ),
        const SizedBox(width: MARGIN_LARGE),
      ],
    );
  }
}

class BannerImageView extends StatelessWidget {
  const BannerImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MARGIN_LARGE),
          topRight: Radius.circular(MARGIN_LARGE),
        ),
        image: DecorationImage(
          image: NetworkImage(
            'https://www.westend61.de/images/0001017402j/a-man-in-a-blue-jacket-in-a-modern-building-using-his-smart-phone-MINF04752.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
