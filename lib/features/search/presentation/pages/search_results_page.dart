import 'package:flutter/material.dart';
import 'package:fly_ticket/core/theme/app_colors.dart';
import 'package:fly_ticket/features/home/data/datasources/flight_mock_data.dart';
import 'package:fly_ticket/features/search/presentation/widgets/flight_result_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({super.key});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  // Sort/Filter mock state
  String selectedSort = 'Price';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              'Istanbul (IST) ➔ London (LHR)',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '16 Oct • 1 Passenger, Economy',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.textPrimary,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Filter & Sort Bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: AppColors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip(
                    'Sort by: Price',
                    icon: FontAwesomeIcons.arrowDownWideShort,
                    isSelected: true,
                  ),
                  const Gap(8),
                  _buildFilterChip('Stops', icon: FontAwesomeIcons.filter),
                  const Gap(8),
                  _buildFilterChip('Airlines', icon: FontAwesomeIcons.plane),
                  const Gap(8),
                  _buildFilterChip('Time', icon: FontAwesomeIcons.clock),
                  const Gap(8),
                  _buildFilterChip(
                    'Duration',
                    icon: FontAwesomeIcons.hourglass,
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: FlightMockData.searchResults.length,
              itemBuilder: (context, index) {
                return FlightResultCard(
                  flight: FlightMockData.searchResults[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label, {
    IconData? icon,
    bool isSelected = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryBlue : AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primaryBlue : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
            const Gap(8),
          ],
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
