import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:fly_ticket/core/theme/app_colors.dart';
import 'package:fly_ticket/features/home/data/datasources/flight_mock_data.dart';
import 'package:fly_ticket/features/search/presentation/pages/search_results_page.dart';

class FlightSearchCard extends StatefulWidget {
  const FlightSearchCard({super.key});

  @override
  State<FlightSearchCard> createState() => _FlightSearchCardState();
}

class _FlightSearchCardState extends State<FlightSearchCard> {
  // Controllers
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  DateTime? _departureDate;
  DateTime? _returnDate;
  int _passengers = 1;
  String _seatClass = 'Economy';
  bool _isRoundTrip = true;

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDeparture
          ? (_departureDate ?? DateTime.now())
          : (_returnDate ??
                (_departureDate ?? DateTime.now()).add(
                  const Duration(days: 3),
                )),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryBlue,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departureDate = picked;
          if (_returnDate != null && _returnDate!.isBefore(picked)) {
            _returnDate = null;
          }
        } else {
          _returnDate = picked;
        }
      });
    }
  }

  void _swapLocations() {
    final temp = _originController.text;
    _originController.text = _destinationController.text;
    _destinationController.text = temp;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.primaryBlue.withOpacity(0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Tabs
            Row(
              children: [
                _buildTab(
                  'Round Trip',
                  true,
                  () => setState(() => _isRoundTrip = true),
                ),
                const Gap(12),
                _buildTab(
                  'One Way',
                  false,
                  () => setState(() => _isRoundTrip = false),
                ),
              ],
            ),
            const Gap(20),

            // Route Inputs
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Column(
                  children: [
                    _buildAutocompleteField(
                      controller: _originController,
                      hint: 'From',
                      icon: FontAwesomeIcons.planeDeparture,
                    ),
                    const Gap(12),
                    _buildAutocompleteField(
                      controller: _destinationController,
                      hint: 'To',
                      icon: FontAwesomeIcons.planeArrival,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.border),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.arrowRightArrowLeft,
                        size: 14,
                        color: AppColors.primaryBlue,
                      ),
                      onPressed: _swapLocations,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),

            const Gap(16),

            // Date Inputs
            Row(
              children: [
                Expanded(
                  child: _buildDateSelector(
                    title: 'Departure',
                    date: _departureDate,
                    onTap: () => _selectDate(context, true),
                  ),
                ),
                if (_isRoundTrip) ...[
                  const Gap(12),
                  Expanded(
                    child: _buildDateSelector(
                      title: 'Return',
                      date: _returnDate,
                      onTap: () => _selectDate(context, false),
                    ),
                  ),
                ],
              ],
            ),

            const Gap(16),

            // Passengers & Class
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    value:
                        '$_passengers Passenger${_passengers > 1 ? 's' : ''}',
                    icon: FontAwesomeIcons.user,
                    onTap: () {
                      setState(() {
                        _passengers = _passengers >= 5 ? 1 : _passengers + 1;
                      });
                    },
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: _buildDropdown(
                    value: _seatClass,
                    icon: FontAwesomeIcons.chair,
                    onTap: () {
                      setState(() {
                        _seatClass = _seatClass == 'Economy'
                            ? 'Business'
                            : 'Economy';
                      });
                    },
                  ),
                ),
              ],
            ),

            const Gap(24),

            // Search Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchResultsPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                // Let's stick to Primary Blue as requested for theme
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: AppColors.primaryBlue.withOpacity(0.4),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.magnifyingGlass, size: 18),
                  Gap(10),
                  Text(
                    'Search Flights',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, bool isSelectedTab, VoidCallback onTap) {
    // Only highlight if it matches current state
    bool isActive =
        (title == 'Round Trip' && _isRoundTrip) ||
        (title == 'One Way' && !_isRoundTrip);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primaryBlue.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? AppColors.primaryBlue : Colors.transparent,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.primaryBlue : AppColors.textSecondary,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildAutocompleteField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return Autocomplete<Map<String, String>>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Map<String, String>>.empty();
        }
        return FlightMockData.airports.where((Map<String, String> option) {
          return option['city']!.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              ) ||
              option['code']!.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
        });
      },
      displayStringForOption: (Map<String, String> option) =>
          '${option['city']} (${option['code']})',
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
            if (controller.text.isNotEmpty &&
                textEditingController.text.isEmpty) {
              textEditingController.text = controller.text;
            }
            return TextField(
              controller: textEditingController,
              focusNode: focusNode,
              onSubmitted: (val) {
                controller.text = val;
                onFieldSubmitted();
              },
              decoration: InputDecoration(
                hintText: hint,
                prefixIcon: Icon(
                  icon,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            );
          },
      onSelected: (Map<String, String> selection) {
        controller.text = '${selection['city']} (${selection['code']})';
      },
    );
  }

  Widget _buildDateSelector({
    required String title,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const Gap(4),
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.calendar,
                  size: 14,
                  color: AppColors.primaryBlue,
                ),
                const Gap(8),
                Text(
                  date != null
                      ? DateFormat('EEE, dd MMM').format(date)
                      : 'Select Date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: date != null
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: AppColors.textSecondary),
            const Gap(8),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              FontAwesomeIcons.chevronDown,
              size: 14,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
