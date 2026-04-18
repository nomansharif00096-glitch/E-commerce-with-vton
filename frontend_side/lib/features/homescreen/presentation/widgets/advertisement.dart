import 'package:flutter/material.dart';
import 'package:frontend_side/core/utils/utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AdvertisementPanel extends StatefulWidget {
  const AdvertisementPanel({super.key});

  @override
  State<AdvertisementPanel> createState() => _AdvertisementPanelState();
}

class _AdvertisementPanelState extends State<AdvertisementPanel> {
  final advertisements = [
    'assets/images/ad0.avif',
    'assets/images/ad1.png',
    'assets/images/ad2.jpg',
    'assets/images/ad3.jpg',
    'assets/images/ad4.jpg',
  ];
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: PageView(
              controller: _pageController,
              children: advertisements
                  .map((toElement) => Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(12),
                              child: Image.asset(
                                toElement,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ))
                  .toList(),
            ),
          ),
          SizedBox(
            height: 25,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: advertisements.length,
              effect: ExpandingDotsEffect(
                expansionFactor: 8,
                dotWidth: 8,
                dotHeight: 5,
                dotColor: customColors.blackAndWhite,
                activeDotColor: customColors.mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
