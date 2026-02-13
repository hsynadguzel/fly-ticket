import 'package:flutter/material.dart';
import 'package:fly_ticket/core/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class TicketCard extends StatelessWidget {
  final Map<String, dynamic> flight;
  final bool isPast;

  const TicketCard({super.key, required this.flight, this.isPast = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          // Upper Part (Flight Route & Time)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isPast
                            ? Colors.grey.shade100
                            : AppColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        flight['airline'] ?? '',
                        style: TextStyle(
                          color: isPast ? Colors.grey : AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    _buildStatusBadge(flight['status'] ?? ''),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Origin
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          flight['fromCode'] ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          flight['fromCity'] ?? '',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          flight['fromTime'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          flight['fromDate'] ?? '',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    // Flight Path Graphic
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            const Icon(
                              FontAwesomeIcons.plane,
                              color: AppColors.primaryBlue,
                              size: 20,
                            ),
                            const Gap(4),
                            // FIXED: Replaced nested ListView with Row for stability
                            SizedBox(
                              height: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  10,
                                  (index) => Container(
                                    width: 4,
                                    height: 1,
                                    color: AppColors.border,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(4),
                            Text(
                              flight['duration'] ?? '',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Destination
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          flight['toCode'] ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          flight['toCity'] ?? '',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          flight['toTime'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          flight['toDate'] ?? '',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Divider with Cutouts
          Container(
            color: AppColors.white,
            height: 20,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          const dashWidth = 6.0;
                          const dashSpace = 4.0;
                          final dashCount =
                              (constraints.maxWidth / (dashWidth + dashSpace))
                                  .floor();
                          // Safety check for layout constraints
                          if (dashCount <= 0) return const SizedBox();
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(dashCount, (_) {
                              return SizedBox(
                                width: dashWidth,
                                height: 1,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors.border.withOpacity(0.5),
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -6,
                  top: -6,
                  bottom: -6,
                  child: Container(
                    width: 20,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: -6,
                  top: -6,
                  bottom: -6,
                  child: Container(
                    width: 20,
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Lower Part (Flight Details)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem('Date', flight['fromDate'] ?? ''),
                _buildDetailItem('Gate', flight['gate'] ?? ''),
                _buildDetailItem('Seat', flight['seat'] ?? ''),
                _buildDetailItem('Flight No', flight['flightNumber'] ?? ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        const Gap(4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'on time':
      case 'scheduled':
        color = const Color(0xFFE8F5E9); // Light Green
        textColor = const Color(0xFF2E7D32); // Dark Green
        break;
      case 'delayed':
        color = const Color(0xFFFFF3E0); // Light Orange
        textColor = const Color(0xFFEF6C00); // Dark Orange
        break;
      case 'cancelled':
        color = const Color(0xFFFFEBEE); // Light Red
        textColor = const Color(0xFFC62828); // Dark Red
        break;
      case 'landed':
        color = const Color(0xFFE3F2FD); // Light Blue
        textColor = const Color(0xFF1565C0); // Dark Blue
        break;
      default:
        color = const Color(0xFFF5F5F5); // Light Grey
        textColor = const Color(0xFF757575); // Dark Grey
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withOpacity(0.3), width: 1),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
