import 'package:flutter/material.dart';
import 'package:frontend_side/features/homescreen/home_screen.dart';
import 'package:frontend_side/features/products/presentation/presentation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const HomeSliverAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          const HomeSearchBar(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          const AdvertisementPanel(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          const HomeCategoriesView(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          AllHomeProductsView()
        ],
      ),
    );
  }
}
