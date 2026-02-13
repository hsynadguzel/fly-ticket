import 'package:flutter/material.dart';
import 'package:fly_ticket/core/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildNotificationItem(
            icon: FontAwesomeIcons.clock,
            iconColor: Colors.orange,
            title: 'Flight Delayed',
            message: 'Your flight TK 1983 to London is delayed by 45 minutes.',
            time: '2 mins ago',
            isUnread: true,
          ),
          const Gap(16),
          _buildNotificationItem(
            icon: FontAwesomeIcons.doorOpen,
            iconColor: AppColors.primaryBlue,
            title: 'Gate Change',
            message: 'Gate for flight TK 1983 has changed to B12.',
            time: '15 mins ago',
            isUnread: true,
          ),
          const Gap(16),
          _buildNotificationItem(
            icon: FontAwesomeIcons.checkToSlot,
            iconColor: Colors.green,
            title: 'Check-in Open',
            message: 'Online check-in for your flight to London is now open.',
            time: '2 hours ago',
            isUnread: false,
          ),
          const Gap(16),
          _buildNotificationItem(
            icon: FontAwesomeIcons.tags,
            iconColor: Colors.purple,
            title: 'Special Offer',
            message:
                'Get 20% off on your next flight to Paris! Limited time offer.',
            time: '1 day ago',
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? Colors.white : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: isUnread
            ? Border.all(color: AppColors.primaryBlue.withOpacity(0.2))
            : Border.all(color: Colors.transparent),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Gap(4),
                Text(
                  message,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (isUnread)
            Container(
              margin: const EdgeInsets.only(top: 8, left: 8),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
