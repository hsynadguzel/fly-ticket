import 'package:flutter/material.dart';
import 'package:fly_ticket/core/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:fly_ticket/features/search/presentation/widgets/flight_detail_bottom_sheet.dart';

class FlightResultCard extends StatelessWidget {
  final Map<String, dynamic> flight;

  const FlightResultCard({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    bool isDirect = flight['stops'] == 0;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => FlightDetailBottomSheet(flight: flight),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: AppColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Top Row: Time & Route
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Departure
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flight['departureTime'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Text(
                        'IST',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ), // Hardcoded for demo
                    ],
                  ),

                  // Duration & Path
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          Text(
                            flight['duration'],
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(4),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 3,
                                backgroundColor: AppColors.border,
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColors.border,
                                  thickness: 1,
                                ),
                              ),
                              Icon(
                                FontAwesomeIcons.plane,
                                size: 14,
                                color: AppColors.primaryBlue,
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColors.border,
                                  thickness: 1,
                                ),
                              ),
                              const CircleAvatar(
                                radius: 3,
                                backgroundColor: AppColors.border,
                              ),
                            ],
                          ),
                          const Gap(4),
                          Text(
                            isDirect ? 'Direct' : '${flight['stops']} Stop',
                            style: TextStyle(
                              color: isDirect
                                  ? AppColors.success
                                  : AppColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Arrival
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        flight['arrivalTime'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Text(
                        'LHR',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ), // Hardcoded for demo
                    ],
                  ),
                ],
              ),

              const Gap(16),
              const Divider(color: AppColors.border),
              const Gap(12),

              // Bottom Row: Airline & Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Airline Logo/Name
                  Row(
                    children: [
                      // Placeholder for logo
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: AppColors.lightBlue,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            flight['airline'][0],
                            style: const TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const Gap(8),
                      Text(
                        flight['airline'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),

                  // Price
                  Text(
                    '${flight['price']} ${flight['currency']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
