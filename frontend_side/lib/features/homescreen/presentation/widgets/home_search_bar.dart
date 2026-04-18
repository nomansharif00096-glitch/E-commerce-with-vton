import 'package:flutter/material.dart';
import 'package:frontend_side/core/utils/utils.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SizedBox(
              height: 60,
              width: MediaQuery.sizeOf(context).width * 0.80,
              child: TextFormField(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Palette.blackColor,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.15),
                  labelText: "Search",
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              height: 55,
              width: MediaQuery.sizeOf(context).width * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: customColors.mainColor),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
