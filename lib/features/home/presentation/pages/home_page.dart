import 'package:flutter/material.dart';
import 'package:fly_ticket/core/theme/app_colors.dart';
import 'package:fly_ticket/features/home/presentation/widgets/campaign_banner.dart';
import 'package:fly_ticket/features/home/presentation/widgets/flight_search_card.dart';
import 'package:fly_ticket/features/home/presentation/widgets/popular_routes_list.dart';
import 'package:fly_ticket/features/home/presentation/widgets/recent_searches.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Header Background (Top 35% of screen)
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.darkBlue, AppColors.primaryBlue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
          ),

          SafeArea(
            child: CustomScrollView(
              slivers: [
                // App Bar / Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, Hüseyin ADIGÜZEL',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const Gap(4),
                            Text(
                              'Where to next?',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundColor: AppColors.accentBlue,
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverGap(24),

                // Flight Search Card
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: FlightSearchCard(),
                  ),
                ),

                const SliverGap(32),

                // Recent Searches Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Searches',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Clear',
                            style: TextStyle(color: AppColors.primaryBlue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverGap(8),

                // Recent Searches Widget
                const SliverToBoxAdapter(child: RecentSearches()),

                const SliverGap(24),

                // Campaigns Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Hot Campaigns',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'View All',
                            style: TextStyle(color: AppColors.primaryBlue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverGap(12),

                // Campaign Banner Widget
                const SliverToBoxAdapter(
                  child: CampaignBanner(), // Height is defined in the widget
                ),

                const SliverGap(24),

                // Popular Routes Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Routes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'See All',
                            style: TextStyle(color: AppColors.primaryBlue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverGap(12),

                // Popular Routes Widget
                const SliverToBoxAdapter(child: PopularRoutesList()),

                const SliverGap(40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
