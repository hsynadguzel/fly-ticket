import 'package:flutter/material.dart';
import 'package:fly_ticket/core/theme/app_colors.dart';
import 'package:fly_ticket/features/home/data/datasources/flight_mock_data.dart';
import 'package:fly_ticket/features/trips/presentation/widgets/ticket_card.dart';
import 'package:gap/gap.dart';

class MyTripsPage extends StatefulWidget {
  const MyTripsPage({super.key});

  @override
  State<MyTripsPage> createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'My Trips',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryBlue,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primaryBlue,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active/Upcoming Flights
          _buildFlightList(FlightMockData.upcomingFlights, false),
          // Past Flights
          _buildFlightList(FlightMockData.pastFlights, true),
          // Cancelled Flights
          _buildFlightList(FlightMockData.cancelledFlights, true),
        ],
      ),
    );
  }

  Widget _buildFlightList(List<Map<String, dynamic>> flights, bool isPast) {
    if (flights.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.airplane_ticket_outlined,
              size: 64,
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            const Gap(16),
            Text(
              'No flights found',
              style: TextStyle(
                color: AppColors.textSecondary.withOpacity(0.8),
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: flights.length,
      itemBuilder: (context, index) {
        return TicketCard(flight: flights[index], isPast: isPast);
      },
    );
  }
}
