import 'dart:ui';

import 'package:animation_assignment/pages/detail_page.dart';
import 'package:animation_assignment/resources/colors.dart';
import 'package:animation_assignment/resources/dimens.dart';
import 'package:animation_assignment/resources/strings.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

const kProfileSectionAnimationDuration = 1000;
const kSwitchThemeAnimationDuration = 500;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// State Variables
  var isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: kSwitchThemeAnimationDuration),
        color: (isDarkTheme) ? Colors.black : Colors.white,
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserProfileAndNotiIconSectionView(
                    onTapNoti: () {
                      setState(() {
                        isDarkTheme = !isDarkTheme;
                      });
                    },
                    isDarkTheme: isDarkTheme,
                  ),
                  const SizedBox(height: MARGIN_LARGE),
                  TweenAnimationBuilder(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailPage(),
                          ),
                        );
                      },
                      child: TrendingSectionView(isDarkTheme: isDarkTheme),
                    ),
                    tween: Tween<double>(begin: 0, end: 1),
                    curve: Curves.linear,
                    duration: const Duration(
                      milliseconds: kProfileSectionAnimationDuration,
                    ),
                    builder: (context, double value, child) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MARGIN_XLARGE * value,
                        ),
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: MARGIN_LARGE),
                  TweenAnimationBuilder(
                    child: RecomendedSectionView(isDarkTheme: isDarkTheme),
                    tween: Tween<double>(begin: 0, end: 1),
                    curve: Curves.linear,
                    duration: const Duration(
                      milliseconds: kProfileSectionAnimationDuration,
                    ),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MARGIN_XLARGE,
                            right: MARGIN_XLARGE,
                            top: MARGIN_LARGE * (1 - value),
                          ),
                          child: child,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
                child: FloatingBottomNavView(isDarkTheme: isDarkTheme),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecomendedSectionView extends StatelessWidget {
  final bool isDarkTheme;

  RecomendedSectionView({required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWithDotIndicatorView(
          title: RECOMENDED,
          isDarkTheme: isDarkTheme,
        ),
        const SizedBox(height: MARGIN_LARGE),
        const RecomendedItemsView(),
      ],
    );
  }
}

class RecomendedItemsView extends StatelessWidget {
  const RecomendedItemsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RecomendedItemView(
            backgroundColor: RECOMENDED_FIRST_COLOR,
            labelColor: SHOES_TEXT_COLOR,
            photoUrl: 'assets/heels.png',
            label: SHOES,
          ),
          const Spacer(),
          RecomendedItemView(
            backgroundColor: RECOMENDED_SECOND_COLOR,
            labelColor: CACTUS_TEXT_COLOR,
            photoUrl: 'assets/cactus.png',
            label: CACTUS,
          )
        ],
      ),
    );
  }
}

class RecomendedItemView extends StatelessWidget {
  final Color backgroundColor;
  final Color labelColor;
  final String label;
  final String photoUrl;

  RecomendedItemView({
    required this.backgroundColor,
    required this.labelColor,
    required this.label,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 140,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
      ),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              photoUrl,
              width: 100,
              height: 100,
            ),
            Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrendingSectionView extends StatelessWidget {
  final bool isDarkTheme;

  TrendingSectionView({required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWithDotIndicatorView(
          title: TRENDING_FOR_YOU,
          isDarkTheme: isDarkTheme,
        ),
        const SizedBox(height: MARGIN_LARGE),
        const OutfitCollectionView(),
      ],
    );
  }
}

class OutfitCollectionView extends StatelessWidget {
  const OutfitCollectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
        image: const DecorationImage(
          image: AssetImage(
            "assets/collection.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: const [
          Positioned(
            top: MARGIN_LARGE,
            right: MARGIN_LARGE,
            child: FavoriteButtonView(),
          ),
          Positioned(
            left: MARGIN_LARGE,
            bottom: MARGIN_LARGE,
            child: OutfitCollectionInfoView(),
          ),
        ],
      ),
    );
  }
}

class OutfitCollectionInfoView extends StatelessWidget {
  const OutfitCollectionInfoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "NEW 2020",
          style: TextStyle(
            color: Colors.white70,
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        const Text(
          "Modern Outfit",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Collection",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        Row(
          children: const [
            CircleAvatar(
              radius: MARGIN_MEDIUM_2,
              backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzfG4grVjejPN1T_WwTFu0ig24GINUAjokZA&usqp=CAU",
              ),
            ),
            SizedBox(width: MARGIN_MEDIUM),
            Text(
              "Firna Surapt",
              style: TextStyle(
                color: Colors.white70,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class FavoriteButtonView extends StatelessWidget {
  const FavoriteButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: FAVORITE_BUTTON_SIZE,
      height: FAVORITE_BUTTON_SIZE,
      decoration: BoxDecoration(
        color: FAVORITE_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(
          FAVORITE_BUTTON_SIZE / 2,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.favorite_outline,
          color: Colors.white70,
        ),
      ),
    );
  }
}

class SectionTitleWithDotIndicatorView extends StatelessWidget {
  final String title;
  final bool isDarkTheme;

  SectionTitleWithDotIndicatorView({
    required this.title,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: TEXT_REGULAR_3X,
              fontWeight: FontWeight.w700,
              color: isDarkTheme ? Colors.white70 : Colors.black54,
            ),
          ),
          const Spacer(),
          DotsIndicator(
            dotsCount: 2,
            decorator: const DotsDecorator(
              spacing: EdgeInsets.all(4),
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileAndNotiIconSectionView extends StatelessWidget {
  final Function onTapNoti;
  final bool isDarkTheme;

  UserProfileAndNotiIconSectionView({
    required this.onTapNoti,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: PROFILE_SECTION_HEIGHT,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: MARGIN_MEDIUM_3,
            right: MARGIN_LARGE,
            child: GestureDetector(
              onTap: () => onTapNoti(),
              child: Icon(
                Icons.notifications_none_rounded,
                size: MARGIN_XLARGE,
                color: isDarkTheme ? Colors.white70 : Colors.black26,
              ),
            ),
          ),
          TweenAnimationBuilder(
            child: ProfileSectionView(isDarkTheme: isDarkTheme),
            tween: Tween<double>(begin: 0, end: 1),
            curve: Curves.linear,
            duration: const Duration(
              milliseconds: kProfileSectionAnimationDuration,
            ),
            builder: (context, double value, child) {
              return Padding(
                padding: EdgeInsets.only(
                  top: PROFILE_SECTION_TOP_PADDING * value,
                  left: MARGIN_LARGE,
                ),
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileSectionView extends StatelessWidget {
  final bool isDarkTheme;

  ProfileSectionView({required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: PROFILE_AVATAR_SIZE,
          height: PROFILE_AVATAR_SIZE,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              PROFILE_AVATAR_SIZE / 2,
            ),
            border: Border.all(
              color: Colors.purpleAccent,
              width: 1,
            ),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzfG4grVjejPN1T_WwTFu0ig24GINUAjokZA&usqp=CAU"),
            ),
          ),
        ),
        const SizedBox(width: MARGIN_CARD_MEDIUM_2),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: MARGIN_MEDIUM),
            Text(
              "Howdy",
              style: TextStyle(
                fontSize: MARGIN_MEDIUM_2,
                color: isDarkTheme ? Colors.white70 : Colors.black,
              ),
            ),
            const SizedBox(height: MARGIN_SMALL),
            Text(
              "Christina Yota",
              style: TextStyle(
                fontSize: MARGIN_MEDIUM_2,
                fontWeight: FontWeight.bold,
                color: isDarkTheme ? Colors.white70 : Colors.black,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class FloatingBottomNavView extends StatelessWidget {
  final bool isDarkTheme;

  FloatingBottomNavView({required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: MARGIN_MEDIUM,
      shadowColor: Colors.black38,
      borderRadius: const BorderRadius.all(
        Radius.circular(MARGIN_XLARGE),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkTheme ? BOTTOM_NAV_DARK_COLOR : Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(MARGIN_XLARGE),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: MARGIN_LARGE),
              const Icon(
                Icons.home,
                size: MARGIN_XLARGE,
                color: Colors.deepPurple,
              ),
              const SizedBox(width: MARGIN_XLARGE),
              Icon(
                Icons.search,
                size: MARGIN_XLARGE,
                color: isDarkTheme ? Colors.white70 : Colors.black26,
              ),
              const SizedBox(width: MARGIN_XLARGE),
              Icon(
                Icons.shopping_bag_outlined,
                size: MARGIN_XLARGE,
                color: isDarkTheme ? Colors.white70 : Colors.black26,
              ),
              const SizedBox(width: MARGIN_XLARGE),
              Icon(
                Icons.bookmark_border_rounded,
                size: MARGIN_XLARGE,
                color: isDarkTheme ? Colors.white70 : Colors.black26,
              ),
              const SizedBox(width: MARGIN_XLARGE),
              const CircleAvatar(
                radius: MARGIN_MEDIUM_2,
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzfG4grVjejPN1T_WwTFu0ig24GINUAjokZA&usqp=CAU",
                ),
              ),
              const SizedBox(width: MARGIN_LARGE),
            ],
          ),
        ),
      ),
    );
  }
}
