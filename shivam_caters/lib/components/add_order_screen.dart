import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:shivam_caters/database/app_database.dart';
import 'package:shivam_caters/database/dao/order_dao.dart';
import 'package:shivam_caters/database/db_instance.dart';
import '../utils/responsive_helper.dart';

import '../utils/db_functions.dart';

import 'main_layout.dart';

class SmoothScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  
  // Customer Details Controllers
  final _customerNameController = TextEditingController();
  final _customerContactController = TextEditingController();
  final _eventNameController = TextEditingController();
  final _customerAddressController = TextEditingController();
  DateTime _eventDate = DateTime.now();
  DateTime _bookingDate = DateTime.now();
  OrderDao orderDao = OrderDao(db);

  DbFunctions dbf = DbFunctions(db);


  // Event Details Controllers
  final _eventPlaceController = TextEditingController();
  final _decorationController = TextEditingController();
  final _nashtaController = TextEditingController();
  final _lunchController = TextEditingController();
  final _dinnerController = TextEditingController();
  
  // Billing Details Controllers
  final _advancePaymentController = TextEditingController();
  final _totalAmountController = TextEditingController();
  final _paymentMethodController = TextEditingController();
  final _notesController = TextEditingController();
  
  
  // Event place dropdown
  String _selectedEventPlace = '';
  final List<String> _eventPlaces = [
    'Hotel Grand Palace',
    'Community Hall - Sector 5',
    'Garden Restaurant',
    'Marriage Hall - City Center',
    'Resort Paradise',
    'Convention Center',
    'Temple Hall',
    'School Auditorium',
    'Private Venue',
    'Other (Specify)',
  ];
  
  // Nashta checkbox and details
  bool _isNashtaSelected = false;
  final _nashtaStartTimeController = TextEditingController();
  final _nashtaEndTimeController = TextEditingController();
  final _nashtaPersonsController = TextEditingController();
  final _nashtaExtraPersonsController = TextEditingController();
  final _nashtaPricePerPersonController = TextEditingController();
  double _nashtaTotal = 0.0;

  // Lunch checkbox and details
  bool _isLunchSelected = false;
  final _lunchStartTimeController = TextEditingController();
  final _lunchEndTimeController = TextEditingController();
  final _lunchPersonsController = TextEditingController();
  final _lunchExtraPersonsController = TextEditingController();
  final _lunchPricePerPersonController = TextEditingController();
  double _lunchTotal = 0.0;

  // Dinner checkbox and details
  bool _isDinnerSelected = false;
  final _dinnerStartTimeController = TextEditingController();
  final _dinnerEndTimeController = TextEditingController();
  final _dinnerPersonsController = TextEditingController();
  final _dinnerExtraPersonsController = TextEditingController();
  final _dinnerPricePerPersonController = TextEditingController();
  double _dinnerTotal = 0.0;
  double grandTotal = 0.0;

  // Menu selection for each meal type
  List<Map<String, dynamic>> _selectedNashtaDishes = [];
  List<Map<String, dynamic>> _selectedLunchDishes = [];
  List<Map<String, dynamic>> _selectedDinnerDishes = [];

  @override
  void initState() {
    super.initState();
    
    // Add listeners to nashta controllers for automatic calculation
    _nashtaPersonsController.addListener(_calculateNashtaTotal);
    _nashtaExtraPersonsController.addListener(_calculateNashtaTotal);
    _nashtaPricePerPersonController.addListener(_calculateNashtaTotal);
    _nashtaPricePerPersonController.addListener(_calculateGrandTotal);
    
    // Add listeners to lunch controllers for automatic calculation
    _lunchPersonsController.addListener(_calculateLunchTotal);
    _lunchExtraPersonsController.addListener(_calculateLunchTotal);
    _lunchPricePerPersonController.addListener(_calculateLunchTotal);
    _lunchPricePerPersonController.addListener(_calculateGrandTotal);
    
    // Add listeners to dinner controllers for automatic calculation
    _dinnerPersonsController.addListener(_calculateDinnerTotal);
    _dinnerExtraPersonsController.addListener(_calculateDinnerTotal);
    _dinnerPricePerPersonController.addListener(_calculateDinnerTotal);
    _dinnerPricePerPersonController.addListener(_calculateGrandTotal);
_calculateGrandTotal();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    
    // Customer Details Controllers
    _customerNameController.dispose();
    _customerContactController.dispose();
    _eventNameController.dispose();
    _customerAddressController.dispose();
    
    // Event Details Controllers
    _eventPlaceController.dispose();
    _decorationController.dispose();
    _nashtaController.dispose();
    _lunchController.dispose();
    _dinnerController.dispose();
    
    // Billing Details Controllers
    _advancePaymentController.dispose();
    _totalAmountController.dispose();
    _paymentMethodController.dispose();
    _notesController.dispose();
    
    // Nashta Details Controllers
    _nashtaStartTimeController.dispose();
    _nashtaEndTimeController.dispose();
    _nashtaPersonsController.dispose();
    _nashtaExtraPersonsController.dispose();
    _nashtaPricePerPersonController.dispose();
    
    // Lunch Details Controllers
    _lunchStartTimeController.dispose();
    _lunchEndTimeController.dispose();
    _lunchPersonsController.dispose();
    _lunchExtraPersonsController.dispose();
    _lunchPricePerPersonController.dispose();
    
    // Dinner Details Controllers
    _dinnerStartTimeController.dispose();
    _dinnerEndTimeController.dispose();
    _dinnerPersonsController.dispose();
    _dinnerExtraPersonsController.dispose();
    _dinnerPricePerPersonController.dispose();
    
    super.dispose();
  }



  Future<void> _selectEventDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _eventDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _eventDate) {
      setState(() {
        _eventDate = picked;
      });
    }
  }

  Future<void> _selectBookingDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _bookingDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _bookingDate) {
      setState(() {
        _bookingDate = picked;
      });
    }
  }

  Future<void> _selectNashtaStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _nashtaStartTimeController.text = picked.format(context);
      });
    }
  }

  Future<void> _selectNashtaEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _nashtaEndTimeController.text = picked.format(context);
      });
    }
  }

  Future<void> _selectLunchStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _lunchStartTimeController.text = picked.format(context);
      });
    }
  }

  Future<void> _selectLunchEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _lunchEndTimeController.text = picked.format(context);
      });
    }
  }

  Future<void> _selectDinnerStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _dinnerStartTimeController.text = picked.format(context);
      });
    }
  }

  Future<void> _selectDinnerEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _dinnerEndTimeController.text = picked.format(context);
      });
    }
  }

  void _calculateNashtaTotal() {
    final persons = int.tryParse(_nashtaPersonsController.text) ?? 0;
    final extraPersons = int.tryParse(_nashtaExtraPersonsController.text) ?? 0;
    final pricePerPerson = double.tryParse(_nashtaPricePerPersonController.text) ?? 0.0;
    
    setState(() {
      _nashtaTotal = (persons + extraPersons) * pricePerPerson;
    });
  }

  void _calculateLunchTotal() {
    final persons = int.tryParse(_lunchPersonsController.text) ?? 0;
    final extraPersons = int.tryParse(_lunchExtraPersonsController.text) ?? 0;
    final pricePerPerson = double.tryParse(_lunchPricePerPersonController.text) ?? 0.0;
    
    setState(() {
      _lunchTotal = (persons + extraPersons) * pricePerPerson;
    });
  }

  void _calculateDinnerTotal() {
    final persons = int.tryParse(_dinnerPersonsController.text) ?? 0;
    final extraPersons = int.tryParse(_dinnerExtraPersonsController.text) ?? 0;
    final pricePerPerson = double.tryParse(_dinnerPricePerPersonController.text) ?? 0.0;
    
    setState(() {
      _dinnerTotal = (persons + extraPersons) * pricePerPerson;
    });
  }
  void _calculateGrandTotal() {
    
  setState(() {
    grandTotal = _dinnerTotal + _lunchTotal + _nashtaTotal;
    _totalAmountController.text = grandTotal.toStringAsFixed(2);
  });

  }

  int _parse(String val) => int.tryParse(val) ?? 0;
  double _parseDouble(String val) => double.tryParse(val) ?? 0.0;

  // Menu selection methods
  Future<void> _showMenuSelection(BuildContext context, String mealType) async {
    List<Map<String, dynamic>> currentSelection = [];
    switch (mealType) {
      case 'nashta':
        currentSelection = List.from(_selectedNashtaDishes);
        break;
      case 'lunch':
        currentSelection = List.from(_selectedLunchDishes);
        break;
      case 'dinner':
        currentSelection = List.from(_selectedDinnerDishes);
        break;
    }

    final result = await showDialog<List<Map<String, dynamic>>>(
      context: context,
      builder: (context) => MenuSelectionDialog(
        mealType: mealType,
        selectedDishes: currentSelection,
        dbf: dbf,
      ),
    );

    if (result != null) {
      setState(() {
        switch (mealType) {
          case 'nashta':
            _selectedNashtaDishes = result;
            break;
          case 'lunch':
            _selectedLunchDishes = result;
            break;
          case 'dinner':
            _selectedDinnerDishes = result;
            break;
        }
      });
    }
  }


  // ----------- Save Order -----------
  Future<void> _saveOrder() async {
    try {
      // 1. Insert Order
      final orderId = await orderDao.insertOrder(
        OrdersCompanion.insert(
          customerName: _customerNameController.text,
          contactNumber: _customerContactController.text,
          eventName: _eventNameController.text,
          eventDate: _eventDate,
          bookingDate: _bookingDate ,
          eventPlace: "Hall 1", // You can add dropdown later
          advancePayment: Value(_parseDouble(_advancePaymentController.text)),
          totalAmount: Value(grandTotal),
          paymentMode: Value(_paymentMethodController.text ),
          notes: Value(_notesController.text),
          status: "Confirmed",
        ),
      );

      // 2. Insert Meals (if selected)
      if (_isNashtaSelected) {
        await orderDao.insertOrderMeal(
          OrderMealsCompanion.insert(
            orderId: orderId,
            mealType: "Breakfast",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            numberOfPersons: _parse(_nashtaPersonsController.text),
            pricePerPerson: _parseDouble(_nashtaPricePerPersonController.text),
            totalAmount: _nashtaTotal,
          ),
        );
        // Insert selected nashta dishes
        for (var dish in _selectedNashtaDishes) {
          await orderDao.insertOrderDish(
            OrderDishesCompanion.insert(
              orderId: orderId,
              dishName: dish['name'],
              quantity: dish['quantity'],
              price: dish['price'],
            ),
          );
        }

      }

      if (_isLunchSelected) {
        await orderDao.insertOrderMeal(
          OrderMealsCompanion.insert(
            orderId: orderId,
            mealType: "Lunch",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            numberOfPersons: _parse(_lunchPersonsController.text),
            pricePerPerson: _parseDouble(_lunchPricePerPersonController.text),
            totalAmount: _lunchTotal,
          ),
        );

        
        // Insert selected lunch dishes
        for (var dish in _selectedLunchDishes) {
          await orderDao.insertOrderDish(
            OrderDishesCompanion.insert(
              orderId: orderId,
              dishName: dish['name'],
              quantity: dish['quantity'],
              price: dish['price'],
            ),
          );
        }

      }

      if (_isDinnerSelected) {
        await orderDao.insertOrderMeal(
          OrderMealsCompanion.insert(
            orderId: orderId,
            mealType: "Dinner",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            numberOfPersons: _parse(_dinnerPersonsController.text),
            pricePerPerson: _parseDouble(_dinnerPricePerPersonController.text),
            totalAmount: _dinnerTotal,
          ),
        );

        
        // Insert selected dinner dishes
        for (var dish in _selectedDinnerDishes) {
          await orderDao.insertOrderDish(
            OrderDishesCompanion.insert(
              orderId: orderId,
              dishName: dish['name'],
              quantity: dish['quantity'],
              price: dish['price'],
            ),
          );
        }

      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order saved successfully!")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving order: $e")),
      );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      onPressed: () => Navigator.of(context).pop(),
      title: 'Create New Order',
      currentScreen: 'add_order',
      statusMessage: 'Ready to create new order',
      totalOrders: 45,
      pendingOrders: 12,
      completedOrders: 33,
      child: ScrollConfiguration(
        behavior: SmoothScrollBehavior(),
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          padding: ResponsiveHelper.getResponsivePadding(context),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  
                   SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                     context,
                     mobile: 16.0,
                     tablet: 20.0,
                     desktop: 24.0,
                   )),
                   
                   _buildCustomerDetailsSection(context),
                   
                   SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                     context,
                     mobile: 16.0,
                     tablet: 20.0,
                     desktop: 24.0,
                   )),
                   
                   _buildEventDetailsSection(context),
                   
                   SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                     context,
                     mobile: 16.0,
                     tablet: 20.0,
                     desktop: 24.0,
                   )),
                   
                   _buildBillingDetailsSection(context),
                  
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ResponsiveHelper.getResponsivePadding(context),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8A8AFF), Color(0xFFB8B8FF)],
        ),
        borderRadius: BorderRadius.circular(ResponsiveHelper.isMobile(context) ? 16 : 20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8A8AFF).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.add_shopping_cart_outlined,
                  color: Colors.white,
                  size: ResponsiveHelper.getResponsiveValue(
                    context,
                    mobile: 24.0,
                    tablet: 28.0,
                    desktop: 32.0,
                  ),
                ),
              ),
              SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Order',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(
                          context,
                          mobile: 20.0,
                          tablet: 24.0,
                          desktop: 28.0,
                        ),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 4.0,
                      tablet: 6.0,
                      desktop: 8.0,
                    )),
                    Text(
                      'Fill in the details to create a new order',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(
                          context,
                          mobile: 14.0,
                          tablet: 16.0,
                          desktop: 18.0,
                        ),
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildCustomerDetailsSection(BuildContext context) {
    return _buildSection(
      context,
      'Customer Details',
      Icons.person_outline,
      [
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return _buildMobileCustomerGrid(context);
            } else if (constraints.maxWidth < 1024) {
              return _buildTabletCustomerGrid(context);
            } else {
              return _buildDesktopCustomerGrid(context);
            }
          },
        ),
      ],
    );
  }

  Widget _buildMobileCustomerGrid(BuildContext context) {
    return Column(
      children: [
        _buildInputField(
          context,
          controller: _customerNameController,
          label: 'Customer Name',
          icon: Icons.person,
          validator: (value) => value?.isEmpty == true ? 'Please enter customer name' : null,
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildInputField(
          context,
          controller: _customerContactController,
          label: 'Contact Number',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          validator: (value) => value?.isEmpty == true ? 'Please enter contact number' : null,
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildInputField(
          context,
          controller: _eventNameController,
          label: 'Event Name',
          icon: Icons.event,
          validator: (value) => value?.isEmpty == true ? 'Please enter event name' : null,
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        Row(
          children: [
            Expanded(
              child: _buildDateTimeField(
                context,
                label: 'Event Date',
                value: '${_eventDate.day}/${_eventDate.month}/${_eventDate.year}',
                icon: Icons.calendar_today,
                onTap: _selectEventDate,
              ),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 8.0,
              tablet: 12.0,
              desktop: 16.0,
            )),
            Expanded(
              child: _buildDateTimeField(
                context,
                label: 'Booking Date',
                value: '${_bookingDate.day}/${_bookingDate.month}/${_bookingDate.year}',
                icon: Icons.book_online,
                onTap: _selectBookingDate,
              ),
            ),
          ],
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildInputField(
          context,
          controller: _customerAddressController,
          label: 'Customer Address',
          icon: Icons.location_on,
          maxLines: 3,
          validator: (value) => value?.isEmpty == true ? 'Please enter customer address' : null,
        ),
      ],
    );
  }

  Widget _buildTabletCustomerGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                context,
                controller: _customerNameController,
                label: 'Customer Name',
                icon: Icons.person,
                validator: (value) => value?.isEmpty == true ? 'Please enter customer name' : null,
              ),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            Expanded(
              child: _buildInputField(
                context,
                controller: _customerContactController,
                label: 'Contact Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) => value?.isEmpty == true ? 'Please enter contact number' : null,
              ),
            ),
          ],
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildInputField(
          context,
          controller: _eventNameController,
          label: 'Event Name',
          icon: Icons.event,
          validator: (value) => value?.isEmpty == true ? 'Please enter event name' : null,
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        Row(
          children: [
            Expanded(
              child: _buildDateTimeField(
                context,
                label: 'Event Date',
                value: '${_eventDate.day}/${_eventDate.month}/${_eventDate.year}',
                icon: Icons.calendar_today,
                onTap: _selectEventDate,
              ),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            Expanded(
              child: _buildDateTimeField(
                context,
                label: 'Booking Date',
                value: '${_bookingDate.day}/${_bookingDate.month}/${_bookingDate.year}',
                icon: Icons.book_online,
                onTap: _selectBookingDate,
              ),
            ),
          ],
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildInputField(
          context,
          controller: _customerAddressController,
          label: 'Customer Address',
          icon: Icons.location_on,
          maxLines: 3,
          validator: (value) => value?.isEmpty == true ? 'Please enter customer address' : null,
        ),
      ],
    );
  }

  Widget _buildDesktopCustomerGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                context,
                controller: _customerNameController,
                label: 'Customer Name',
                icon: Icons.person,
                validator: (value) => value?.isEmpty == true ? 'Please enter customer name' : null,
              ),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            Expanded(
              child: _buildInputField(
                context,
                controller: _customerContactController,
                label: 'Contact Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) => value?.isEmpty == true ? 'Please enter contact number' : null,
              ),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            Expanded(
              child: _buildInputField(
                context,
                controller: _eventNameController,
                label: 'Event Name',
                icon: Icons.event,
                validator: (value) => value?.isEmpty == true ? 'Please enter event name' : null,
              ),
            ),
          ],
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        Row(
          children: [
            Expanded(
              child: _buildDateTimeField(
                context,
                label: 'Event Date',
                value: '${_eventDate.day}/${_eventDate.month}/${_eventDate.year}',
                icon: Icons.calendar_today,
                onTap: _selectEventDate,
              ),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            Expanded(
              child: _buildDateTimeField(
                context,
                label: 'Booking Date',
                value: '${_bookingDate.day}/${_bookingDate.month}/${_bookingDate.year}',
                icon: Icons.book_online,
                onTap: _selectBookingDate,
              ),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            Expanded(
              child: Container(), // Empty space for alignment
            ),
          ],
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildInputField(
          context,
          controller: _customerAddressController,
          label: 'Customer Address',
          icon: Icons.location_on,
          maxLines: 3,
          validator: (value) => value?.isEmpty == true ? 'Please enter customer address' : null,
        ),
      ],
    );
  }

  Widget _buildEventDetailsSection(BuildContext context) {
    return _buildSection(
      context,
      'Event Details',
      Icons.event_outlined,
      [
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return _buildMobileEventGrid(context);
            } else if (constraints.maxWidth < 1024) {
              return _buildTabletEventGrid(context);
            } else {
              return _buildDesktopEventGrid(context);
            }
          },
        ),
      ],
    );
  }

  Widget _buildMobileEventGrid(BuildContext context) {
    return Column(
      children: [
        _buildEventPlaceDropdown(context),
        if (_selectedEventPlace == 'Other (Specify)' || (_selectedEventPlace.isEmpty && _eventPlaceController.text.isNotEmpty)) ...[
          SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
            context,
            mobile: 12.0,
            tablet: 16.0,
            desktop: 20.0,
          )),
          _buildInputField(
            context,
            controller: _eventPlaceController,
            label: 'Specify Event Place',
            icon: Icons.edit_location,
            validator: (value) {
              if ((_selectedEventPlace == 'Other (Specify)' || _selectedEventPlace.isEmpty) && value?.isEmpty == true) {
                return 'Please specify the event place';
              }
              return null;
            },
          ),
        ],
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildInputField(
          context,
          controller: _decorationController,
          label: 'Decoration',
          icon: Icons.celebration,
          maxLines: 2,
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildNashtaCheckbox(context),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildLunchCheckbox(context),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildDinnerCheckbox(context),
      ],
    );
  }

  Widget _buildTabletEventGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildEventPlaceDropdown(context),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            Expanded(
              child: _buildInputField(
                context,
                controller: _decorationController,
                label: 'Decoration',
                icon: Icons.celebration,
                maxLines: 2,
              ),
            ),
          ],
        ),
        if (_selectedEventPlace == 'Other (Specify)' || (_selectedEventPlace.isEmpty && _eventPlaceController.text.isNotEmpty)) ...[
          SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
            context,
            mobile: 12.0,
            tablet: 16.0,
            desktop: 20.0,
          )),
          _buildInputField(
            context,
            controller: _eventPlaceController,
            label: 'Specify Event Place',
            icon: Icons.edit_location,
            validator: (value) {
              if ((_selectedEventPlace == 'Other (Specify)' || _selectedEventPlace.isEmpty) && value?.isEmpty == true) {
                return 'Please specify the event place';
              }
              return null;
            },
          ),
        ],
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildNashtaCheckbox(context),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildLunchCheckbox(context),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildDinnerCheckbox(context),
      ],
    );
  }

  Widget _buildDesktopEventGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildEventPlaceDropdown(context),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            Expanded(
              child: _buildInputField(
                context,
                controller: _decorationController,
                label: 'Decoration',
                icon: Icons.celebration,
                maxLines: 2,
              ),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            Expanded(
              child: Container(), // Empty space for alignment
            ),
          ],
        ),
        if (_selectedEventPlace == 'Other (Specify)' || (_selectedEventPlace.isEmpty && _eventPlaceController.text.isNotEmpty)) ...[
          SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
            context,
            mobile: 12.0,
            tablet: 16.0,
            desktop: 20.0,
          )),
          _buildInputField(
            context,
            controller: _eventPlaceController,
            label: 'Specify Event Place',
            icon: Icons.edit_location,
            validator: (value) {
              if ((_selectedEventPlace == 'Other (Specify)' || _selectedEventPlace.isEmpty) && value?.isEmpty == true) {
                return 'Please specify the event place';
              }
              return null;
            },
          ),
        ],
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildNashtaCheckbox(context),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildLunchCheckbox(context),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildDinnerCheckbox(context),
      ],
    );
  }

  Widget _buildBillingDetailsSection(BuildContext context) {
    return _buildSection(
      context,
      'Billing Details',
      Icons.receipt_outlined,
      [
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return _buildMobileBillingGrid(context);
            } else if (constraints.maxWidth < 1024) {
              return _buildTabletBillingGrid(context);
            } else {
              return _buildDesktopBillingGrid(context);
            }
          },
        ),
      ],
    );
  }

  Widget _buildMobileBillingGrid(BuildContext context) {
    return Column(
      children: [
        _buildInputField(
          context,
          controller: _totalAmountController,
          label: 'Total Amount',
          icon: Icons.currency_rupee,
          keyboardType: TextInputType.number,
          validator: (value) => value?.isEmpty == true ? 'Please enter total amount' : null,
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildInputField(
          context,
          controller: _advancePaymentController,
          label: 'Advance Payment',
          icon: Icons.payment,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildInputField(
          context,
          controller: _paymentMethodController,
          label: 'Payment Method',
          icon: Icons.credit_card,
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildInputField(
          context,
          controller: _notesController,
          label: 'Notes (Optional)',
          icon: Icons.note_alt_outlined,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildTabletBillingGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                context,
                controller: _totalAmountController,
                label: 'Total Amount',
                icon: Icons.currency_rupee,
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty == true ? 'Please enter total amount' : null,
              ),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            Expanded(
              child: _buildInputField(
                context,
                controller: _advancePaymentController,
                label: 'Advance Payment',
                icon: Icons.payment,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                context,
                controller: _paymentMethodController,
                label: 'Payment Method',
                icon: Icons.credit_card,
              ),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            Expanded(
              child: Container(), // Empty space for alignment
            ),
          ],
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildInputField(
          context,
          controller: _notesController,
          label: 'Notes (Optional)',
          icon: Icons.note_alt_outlined,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildDesktopBillingGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                context,
                controller: _totalAmountController,
                label: 'Total Amount',
                icon: Icons.currency_rupee,
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty == true ? 'Please enter total amount' : null,
              ),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            Expanded(
              child: _buildInputField(
                context,
                controller: _advancePaymentController,
                label: 'Advance Payment',
                icon: Icons.payment,
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
              context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            )),
            Expanded(
              child: _buildInputField(
                context,
                controller: _paymentMethodController,
                label: 'Payment Method',
                icon: Icons.credit_card,
              ),
            ),
          ],
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
          context,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        )),
        _buildInputField(
          context,
          controller: _notesController,
          label: 'Notes (Optional)',
          icon: Icons.note_alt_outlined,
          maxLines: 3,
        ),
      ],
    );
  }


  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: ResponsiveHelper.getResponsivePadding(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.isMobile(context) ? 12 : 16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.grey[700],
                    padding: EdgeInsets.symmetric(
                      vertical: ResponsiveHelper.getResponsiveSpacing(
                        context,
                        mobile: 12.0,
                        tablet: 16.0,
                        desktop: 20.0,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _saveOrder,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Create Order'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A8AFF),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: ResponsiveHelper.getResponsiveSpacing(
                        context,
                        mobile: 12.0,
                        tablet: 16.0,
                        desktop: 20.0,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: ResponsiveHelper.getResponsivePadding(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.isMobile(context) ? 12 : 16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF8A8AFF),
                size: ResponsiveHelper.getResponsiveValue(
                  context,
                  mobile: 20.0,
                  tablet: 24.0,
                  desktop: 28.0,
                ),
              ),
              SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 8.0,
                tablet: 12.0,
                desktop: 16.0,
              )),
              Text(
                title,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getResponsiveFontSize(
                    context,
                    mobile: 18.0,
                    tablet: 20.0,
                    desktop: 22.0,
                  ),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3748),
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
            context,
            mobile: 16.0,
            tablet: 20.0,
            desktop: 24.0,
          )),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      constraints: BoxConstraints(
        minHeight: ResponsiveHelper.getResponsiveValue(
          context,
          mobile: 56.0,
          tablet: 60.0,
          desktop: 64.0,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF8A8AFF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF8A8AFF), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16, 
            vertical: maxLines > 1 ? 16 : 16,
          ),
        ),
      ),
    );
  }

  Widget _buildEventPlaceDropdown(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: ResponsiveHelper.getResponsiveValue(
          context,
          mobile: 56.0,
          tablet: 60.0,
          desktop: 64.0,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedEventPlace.isEmpty ? null : _selectedEventPlace,
        decoration: InputDecoration(
          labelText: 'Event Place',
          prefixIcon: Icon(Icons.location_city, color: const Color(0xFF8A8AFF)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        items: _eventPlaces.map((String place) {
          return DropdownMenuItem<String>(
            value: place,
            child: Text(
              place,
              style: TextStyle(
                fontSize: ResponsiveHelper.getResponsiveFontSize(
                  context,
                  mobile: 14.0,
                  tablet: 15.0,
                  desktop: 16.0,
                ),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedEventPlace = newValue ?? '';
            if (newValue == 'Other (Specify)') {
              _selectedEventPlace = '';
            }
          });
        },
        validator: (value) {
          if (_selectedEventPlace.isEmpty && _eventPlaceController.text.isEmpty) {
            return 'Please select or enter event place';
          }
          return null;
        },
        dropdownColor: Colors.white,
        icon: Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
        isExpanded: true,
        hint: Text(
          'Select Event Place',
          style: TextStyle(
            fontSize: ResponsiveHelper.getResponsiveFontSize(
              context,
              mobile: 14.0,
              tablet: 15.0,
              desktop: 16.0,
            ),
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildNashtaCheckbox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: ResponsiveHelper.getResponsiveValue(
              context,
              mobile: 56.0,
              tablet: 60.0,
              desktop: 64.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Checkbox(
                value: _isNashtaSelected,
                onChanged: (bool? value) {
                  setState(() {
                    _isNashtaSelected = value ?? false;
                    if (!_isNashtaSelected) {
                      // Clear all nashta details when unchecked
                      _nashtaStartTimeController.clear();
                      _nashtaEndTimeController.clear();
                      _nashtaPersonsController.clear();
                      _nashtaExtraPersonsController.clear();
                      _nashtaPricePerPersonController.clear();
                      _nashtaTotal = 0.0;
                    }
                  });
                },
                activeColor: const Color(0xFF8A8AFF),
              ),
              const SizedBox(width: 8),
              Icon(Icons.breakfast_dining, color: const Color(0xFF8A8AFF), size: 20),
              const SizedBox(width: 8),
              Text(
                'Nashta (Breakfast)',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getResponsiveFontSize(
                    context,
                    mobile: 14.0,
                    tablet: 15.0,
                    desktop: 16.0,
                  ),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2D3748),
                ),
              ),
            ],
          ),
        ),
        if (_isNashtaSelected) ...[
          SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
            context,
            mobile: 12.0,
            tablet: 16.0,
            desktop: 20.0,
          )),
          _buildNashtaDetails(context),
        ],
      ],
    );
  }

  Widget _buildLunchCheckbox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: ResponsiveHelper.getResponsiveValue(
              context,
              mobile: 56.0,
              tablet: 60.0,
              desktop: 64.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Checkbox(
                value: _isLunchSelected,
                onChanged: (bool? value) {
                  setState(() {
                    _isLunchSelected = value ?? false;
                    if (!_isLunchSelected) {
                      // Clear all lunch details when unchecked
                      _lunchStartTimeController.clear();
                      _lunchEndTimeController.clear();
                      _lunchPersonsController.clear();
                      _lunchExtraPersonsController.clear();
                      _lunchPricePerPersonController.clear();
                      _lunchTotal = 0.0;
                    }
                  });
                },
                activeColor: const Color(0xFF8A8AFF),
              ),
              const SizedBox(width: 8),
              Icon(Icons.lunch_dining, color: const Color(0xFF8A8AFF), size: 20),
              const SizedBox(width: 8),
              Text(
                'Lunch',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getResponsiveFontSize(
                    context,
                    mobile: 14.0,
                    tablet: 15.0,
                    desktop: 16.0,
                  ),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2D3748),
                ),
              ),
            ],
          ),
        ),
        if (_isLunchSelected) ...[
          SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
            context,
            mobile: 12.0,
            tablet: 16.0,
            desktop: 20.0,
          )),
          _buildLunchDetails(context),
        ],
      ],
    );
  }

  Widget _buildDinnerCheckbox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: ResponsiveHelper.getResponsiveValue(
              context,
              mobile: 56.0,
              tablet: 60.0,
              desktop: 64.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Checkbox(
                value: _isDinnerSelected,
                onChanged: (bool? value) {
                  setState(() {
                    _isDinnerSelected = value ?? false;
                    if (!_isDinnerSelected) {
                      // Clear all dinner details when unchecked
                      _dinnerStartTimeController.clear();
                      _dinnerEndTimeController.clear();
                      _dinnerPersonsController.clear();
                      _dinnerExtraPersonsController.clear();
                      _dinnerPricePerPersonController.clear();
                      _dinnerTotal = 0.0;
                    }
                  });
                },
                activeColor: const Color(0xFF8A8AFF),
              ),
              const SizedBox(width: 8),
              Icon(Icons.dinner_dining, color: const Color(0xFF8A8AFF), size: 20),
              const SizedBox(width: 8),
              Text(
                'Dinner',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getResponsiveFontSize(
                    context,
                    mobile: 14.0,
                    tablet: 15.0,
                    desktop: 16.0,
                  ),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2D3748),
                ),
              ),
            ],
          ),
        ),
        if (_isDinnerSelected) ...[
          SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
            context,
            mobile: 12.0,
            tablet: 16.0,
            desktop: 20.0,
          )),
          _buildDinnerDetails(context),
        ],
      ],
    );
  }

  Widget _buildNashtaDetails(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth < 1024;
        
        return Container(
          padding: EdgeInsets.all(ResponsiveHelper.getResponsiveValue(
            context,
            mobile: 12.0,
            tablet: 16.0,
            desktop: 20.0,
          )),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Nashta Details',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getResponsiveFontSize(
                    context,
                    mobile: 16.0,
                    tablet: 18.0,
                    desktop: 20.0,
                  ),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3748),
                ),
              ),
              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              // Time range - responsive layout
              if (isMobile) ...[
                // Mobile: Stack vertically
                _buildTimeField(
                  context,
                  controller: _nashtaStartTimeController,
                  label: 'Start Time',
                  onTap: _selectNashtaStartTime,
                ),
                SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                )),
                _buildTimeField(
                  context,
                  controller: _nashtaEndTimeController,
                  label: 'End Time',
                  onTap: _selectNashtaEndTime,
                ),
              ] else ...[
                // Tablet/Desktop: Side by side
                Row(
                  children: [
                    Expanded(
                      child: _buildTimeField(
                        context,
                        controller: _nashtaStartTimeController,
                        label: 'Start Time',
                        onTap: _selectNashtaStartTime,
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 8.0,
                      tablet: 12.0,
                      desktop: 16.0,
                    )),
                    Text(
                      'to',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(
                          context,
                          mobile: 14.0,
                          tablet: 15.0,
                          desktop: 16.0,
                        ),
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 8.0,
                      tablet: 12.0,
                      desktop: 16.0,
                    )),
                    Expanded(
                      child: _buildTimeField(
                        context,
                        controller: _nashtaEndTimeController,
                        label: 'End Time',
                        onTap: _selectNashtaEndTime,
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              // Persons and price - responsive layout
              if (isMobile) ...[
                // Mobile: Stack vertically
                _buildInputField(
                  context,
                  controller: _nashtaPersonsController,
                  label: 'Number of Persons',
                  icon: Icons.people,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_isNashtaSelected && (value?.isEmpty == true || int.tryParse(value ?? '') == null)) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                )),
                _buildInputField(
                  context,
                  controller: _nashtaExtraPersonsController,
                  label: 'Extra Persons',
                  icon: Icons.person_add,
                  keyboardType: TextInputType.number,
                ),
              ] else ...[
                // Tablet/Desktop: Side by side
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        context,
                        controller: _nashtaPersonsController,
                        label: 'Number of Persons',
                        icon: Icons.people,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (_isNashtaSelected && (value?.isEmpty == true || int.tryParse(value ?? '') == null)) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 8.0,
                      tablet: 12.0,
                      desktop: 16.0,
                    )),
                    Expanded(
                      child: _buildInputField(
                        context,
                        controller: _nashtaExtraPersonsController,
                        label: 'Extra Persons',
                        icon: Icons.person_add,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              // Price and total - responsive layout
              if (isMobile) ...[
                // Mobile: Stack vertically
                _buildInputField(
                  context,
                  controller: _nashtaPricePerPersonController,
                  label: 'Price per Person (₹)',
                  icon: Icons.currency_rupee,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_isNashtaSelected && (value?.isEmpty == true || double.tryParse(value ?? '') == null)) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                )),
                _buildTotalDisplay(context),
              ] else ...[
                // Tablet/Desktop: Side by side
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        context,
                        controller: _nashtaPricePerPersonController,
                        label: 'Price per Person (₹)',
                        icon: Icons.currency_rupee,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (_isNashtaSelected && (value?.isEmpty == true || double.tryParse(value ?? '') == null)) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 8.0,
                      tablet: 12.0,
                      desktop: 16.0,
                    )),
                    Expanded(
                      child: _buildTotalDisplay(context),
                    ),
                  ],
                ),
              ],

              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              // Menu Selection Button
              _buildMenuSelectionButton(context, 'nashta', _selectedNashtaDishes),

            ],
          ),
        );
      },
    );
  }

  Widget _buildLunchDetails(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth < 1024;
        
        return Container(
          padding: EdgeInsets.all(ResponsiveHelper.getResponsiveValue(
            context,
            mobile: 12.0,
            tablet: 16.0,
            desktop: 20.0,
          )),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Lunch Details',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getResponsiveFontSize(
                    context,
                    mobile: 16.0,
                    tablet: 18.0,
                    desktop: 20.0,
                  ),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3748),
                ),
              ),
              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              // Time range - responsive layout
              if (isMobile) ...[
                // Mobile: Stack vertically
                _buildTimeField(
                  context,
                  controller: _lunchStartTimeController,
                  label: 'Start Time',
                  onTap: _selectLunchStartTime,
                ),
                SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                )),
                _buildTimeField(
                  context,
                  controller: _lunchEndTimeController,
                  label: 'End Time',
                  onTap: _selectLunchEndTime,
                ),
              ] else ...[
                // Tablet/Desktop: Side by side
                Row(
                  children: [
                    Expanded(
                      child: _buildTimeField(
                        context,
                        controller: _lunchStartTimeController,
                        label: 'Start Time',
                        onTap: _selectLunchStartTime,
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 8.0,
                      tablet: 12.0,
                      desktop: 16.0,
                    )),
                    Text(
                      'to',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(
                          context,
                          mobile: 14.0,
                          tablet: 15.0,
                          desktop: 16.0,
                        ),
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 8.0,
                      tablet: 12.0,
                      desktop: 16.0,
                    )),
                    Expanded(
                      child: _buildTimeField(
                        context,
                        controller: _lunchEndTimeController,
                        label: 'End Time',
                        onTap: _selectLunchEndTime,
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              // Persons and price - responsive layout
              if (isMobile) ...[
                // Mobile: Stack vertically
                _buildInputField(
                  context,
                  controller: _lunchPersonsController,
                  label: 'Number of Persons',
                  icon: Icons.people,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_isLunchSelected && (value?.isEmpty == true || int.tryParse(value ?? '') == null)) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                )),
                _buildInputField(
                  context,
                  controller: _lunchExtraPersonsController,
                  label: 'Extra Persons',
                  icon: Icons.person_add,
                  keyboardType: TextInputType.number,
                ),
              ] else ...[
                // Tablet/Desktop: Side by side
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        context,
                        controller: _lunchPersonsController,
                        label: 'Number of Persons',
                        icon: Icons.people,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (_isLunchSelected && (value?.isEmpty == true || int.tryParse(value ?? '') == null)) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 8.0,
                      tablet: 12.0,
                      desktop: 16.0,
                    )),
                    Expanded(
                      child: _buildInputField(
                        context,
                        controller: _lunchExtraPersonsController,
                        label: 'Extra Persons',
                        icon: Icons.person_add,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              // Price and total - responsive layout
              if (isMobile) ...[
                // Mobile: Stack vertically
                _buildInputField(
                  context,
                  controller: _lunchPricePerPersonController,
                  label: 'Price per Person (₹)',
                  icon: Icons.currency_rupee,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_isLunchSelected && (value?.isEmpty == true || double.tryParse(value ?? '') == null)) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                )),
                _buildLunchTotalDisplay(context),
              ] else ...[
                // Tablet/Desktop: Side by side
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        context,
                        controller: _lunchPricePerPersonController,
                        label: 'Price per Person (₹)',
                        icon: Icons.currency_rupee,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (_isLunchSelected && (value?.isEmpty == true || double.tryParse(value ?? '') == null)) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 8.0,
                      tablet: 12.0,
                      desktop: 16.0,
                    )),
                    Expanded(
                      child: _buildLunchTotalDisplay(context),
                    ),
                  ],
                ),
              ],

              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              // Menu Selection Button
              _buildMenuSelectionButton(context, 'lunch', _selectedLunchDishes),

            ],
          ),
        );
      },
    );
  }

  Widget _buildDinnerDetails(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth < 1024;
        
        return Container(
          padding: EdgeInsets.all(ResponsiveHelper.getResponsiveValue(
            context,
            mobile: 12.0,
            tablet: 16.0,
            desktop: 20.0,
          )),
          decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.purple.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Dinner Details',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getResponsiveFontSize(
                    context,
                    mobile: 16.0,
                    tablet: 18.0,
                    desktop: 20.0,
                  ),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3748),
                ),
              ),
              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              // Time range - responsive layout
              if (isMobile) ...[
                // Mobile: Stack vertically
                _buildTimeField(
                  context,
                  controller: _dinnerStartTimeController,
                  label: 'Start Time',
                  onTap: _selectDinnerStartTime,
                ),
                SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                )),
                _buildTimeField(
                  context,
                  controller: _dinnerEndTimeController,
                  label: 'End Time',
                  onTap: _selectDinnerEndTime,
                ),
              ] else ...[
                // Tablet/Desktop: Side by side
                Row(
                  children: [
                    Expanded(
                      child: _buildTimeField(
                        context,
                        controller: _dinnerStartTimeController,
                        label: 'Start Time',
                        onTap: _selectDinnerStartTime,
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 8.0,
                      tablet: 12.0,
                      desktop: 16.0,
                    )),
                    Text(
                      'to',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(
                          context,
                          mobile: 14.0,
                          tablet: 15.0,
                          desktop: 16.0,
                        ),
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 8.0,
                      tablet: 12.0,
                      desktop: 16.0,
                    )),
                    Expanded(
                      child: _buildTimeField(
                        context,
                        controller: _dinnerEndTimeController,
                        label: 'End Time',
                        onTap: _selectDinnerEndTime,
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              // Persons and price - responsive layout
              if (isMobile) ...[
                // Mobile: Stack vertically
                _buildInputField(
                  context,
                  controller: _dinnerPersonsController,
                  label: 'Number of Persons',
                  icon: Icons.people,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_isDinnerSelected && (value?.isEmpty == true || int.tryParse(value ?? '') == null)) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                )),
                _buildInputField(
                  context,
                  controller: _dinnerExtraPersonsController,
                  label: 'Extra Persons',
                  icon: Icons.person_add,
                  keyboardType: TextInputType.number,
                ),
              ] else ...[
                // Tablet/Desktop: Side by side
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        context,
                        controller: _dinnerPersonsController,
                        label: 'Number of Persons',
                        icon: Icons.people,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (_isDinnerSelected && (value?.isEmpty == true || int.tryParse(value ?? '') == null)) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 8.0,
                      tablet: 12.0,
                      desktop: 16.0,
                    )),
                    Expanded(
                      child: _buildInputField(
                        context,
                        controller: _dinnerExtraPersonsController,
                        label: 'Extra Persons',
                        icon: Icons.person_add,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              // Price and total - responsive layout
              if (isMobile) ...[
                // Mobile: Stack vertically
                _buildInputField(
                  context,
                  controller: _dinnerPricePerPersonController,
                  label: 'Price per Person (₹)',
                  icon: Icons.currency_rupee,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_isDinnerSelected && (value?.isEmpty == true || double.tryParse(value ?? '') == null)) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                )),
                _buildDinnerTotalDisplay(context),
              ] else ...[
                // Tablet/Desktop: Side by side
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        context,
                        controller: _dinnerPricePerPersonController,
                        label: 'Price per Person (₹)',
                        icon: Icons.currency_rupee,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (_isDinnerSelected && (value?.isEmpty == true || double.tryParse(value ?? '') == null)) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.getResponsiveSpacing(
                      context,
                      mobile: 8.0,
                      tablet: 12.0,
                      desktop: 16.0,
                    )),
                    Expanded(
                      child: _buildDinnerTotalDisplay(context),
                    ),
                  ],
                ),
              ],

              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(
                context,
                mobile: 12.0,
                tablet: 16.0,
                desktop: 20.0,
              )),
              // Menu Selection Button
              _buildMenuSelectionButton(context, 'dinner', _selectedDinnerDishes),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuSelectionButton(BuildContext context, String mealType, List<Map<String, dynamic>> selectedDishes) {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _showMenuSelection(context, mealType),
        icon: Icon(
          _getMealIcon(mealType),
          size: 18,
        ),
        label: Text(
          selectedDishes.isEmpty 
            ? 'Select ${_capitalizeFirst(mealType)} Menu' 
            : '${_capitalizeFirst(mealType)} Menu (${selectedDishes.length} items)',
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[50],
          foregroundColor: Colors.blue[700],
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.blue.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }

  IconData _getMealIcon(String mealType) {
    switch (mealType) {
      case 'nashta':
        return Icons.breakfast_dining;
      case 'lunch':
        return Icons.lunch_dining;
      case 'dinner':
        return Icons.dinner_dining;
      default:
        return Icons.restaurant;
    }
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

            ],
          ),
        );
      },
    );
  }


  Widget _buildTotalDisplay(BuildContext context) {
    return Container(
      height: ResponsiveHelper.getResponsiveValue(
        context,
        mobile: 56.0,
        tablet: 60.0,
        desktop: 64.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Total',
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(
                context,
                mobile: 10.0,
                tablet: 11.0,
                desktop: 12.0,
              ),
              color: Colors.green[700],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 1),
          Text(
            '₹${_nashtaTotal.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(
                context,
                mobile: 13.0,
                tablet: 14.0,
                desktop: 16.0,
              ),
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildLunchTotalDisplay(BuildContext context) {
    return Container(
      height: ResponsiveHelper.getResponsiveValue(
        context,
        mobile: 56.0,
        tablet: 60.0,
        desktop: 64.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Total',
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(
                context,
                mobile: 10.0,
                tablet: 11.0,
                desktop: 12.0,
              ),
              color: Colors.orange[700],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 1),
          Text(
            '₹${_lunchTotal.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(
                context,
                mobile: 13.0,
                tablet: 14.0,
                desktop: 16.0,
              ),
              color: Colors.orange[700],
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildDinnerTotalDisplay(BuildContext context) {
    return Container(
      height: ResponsiveHelper.getResponsiveValue(
        context,
        mobile: 56.0,
        tablet: 60.0,
        desktop: 64.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Total',
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(
                context,
                mobile: 10.0,
                tablet: 11.0,
                desktop: 12.0,
              ),
              color: Colors.purple[700],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 1),
          Text(
            '₹${_dinnerTotal.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(
                context,
                mobile: 13.0,
                tablet: 14.0,
                desktop: 16.0,
              ),
              color: Colors.purple[700],
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ResponsiveHelper.getResponsiveValue(
          context,
          mobile: 56.0,
          tablet: 60.0,
          desktop: 64.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, color: const Color(0xFF8A8AFF), size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(
                        context,
                        mobile: 10.0,
                        tablet: 11.0,
                        desktop: 12.0,
                      ),
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    controller.text.isEmpty ? 'Select Time' : controller.text,
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(
                        context,
                        mobile: 12.0,
                        tablet: 13.0,
                        desktop: 14.0,
                      ),
                      fontWeight: FontWeight.w500,
                      color: controller.text.isEmpty ? Colors.grey[500] : const Color(0xFF2D3748),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeField(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ResponsiveHelper.getResponsiveValue(
          context,
          mobile: 56.0,
          tablet: 60.0,
          desktop: 64.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF8A8AFF), size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(
                        context,
                        mobile: 10.0,
                        tablet: 11.0,
                        desktop: 12.0,
                      ),
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(
                        context,
                        mobile: 12.0,
                        tablet: 13.0,
                        desktop: 14.0,
                      ),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2D3748),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.calendar_today,
              color: Colors.grey[400],
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}


class MenuSelectionDialog extends StatefulWidget {
  final String mealType;
  final List<Map<String, dynamic>> selectedDishes;
  final DbFunctions dbf;

  const MenuSelectionDialog({
    super.key,
    required this.mealType,
    required this.selectedDishes,
    required this.dbf,
  });

  @override
  State<MenuSelectionDialog> createState() => _MenuSelectionDialogState();
}

class _MenuSelectionDialogState extends State<MenuSelectionDialog> {
  List<Map<String, dynamic>> _selectedDishes = [];
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Appetizers',
    'Main Course',
    'Breads',
    'Desserts',
    'Beverages',
    'Salads',
    'Soups',
    'Snacks',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDishes = List.from(widget.selectedDishes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: ResponsiveHelper.isMobile(context) ? double.infinity : 600,
        height: ResponsiveHelper.isMobile(context) ? MediaQuery.of(context).size.height * 0.8 : 500,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  _getMealIcon(),
                  color: const Color(0xFF8A8AFF),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Select ${_capitalizeFirst(widget.mealType)} Menu',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Search and Category Filter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search dishes...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _selectedCategory,
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Dishes List
            Expanded(
              child: StreamBuilder<List<Dishe>>(
                stream: widget.dbf.watchDishes(category: _selectedCategory == 'All' ? null : _selectedCategory),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No dishes available'),
                    );
                  }

                  List<Dishe> dishes = snapshot.data!;
                  
                  // Apply search filter
                  if (_searchQuery.isNotEmpty) {
                    dishes = dishes.where((dish) =>
                        dish.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                        (dish.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
                    ).toList();
                  }

                  return ListView.builder(
                    itemCount: dishes.length,
                    itemBuilder: (context, index) {
                      final dish = dishes[index];
                      final isSelected = _selectedDishes.any((selected) => selected['id'] == dish.id);
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  _selectedDishes.add({
                                    'id': dish.id,
                                    'name': dish.name,
                                    'price': dish.price,
                                    'quantity': 1,
                                  });
                                } else {
                                  _selectedDishes.removeWhere((selected) => selected['id'] == dish.id);
                                }
                              });
                            },
                            activeColor: const Color(0xFF8A8AFF),
                          ),
                          title: Text(
                            dish.name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (dish.description != null)
                                Text(
                                  dish.description!,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              Text(
                                '₹${dish.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8A8AFF),
                                ),
                              ),
                            ],
                          ),
                          trailing: isSelected
                              ? Container(
                                  width: 60,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    ),
                                    onChanged: (value) {
                                      final quantity = int.tryParse(value) ?? 1;
                                      setState(() {
                                        final index = _selectedDishes.indexWhere((selected) => selected['id'] == dish.id);
                                        if (index != -1) {
                                          _selectedDishes[index]['quantity'] = quantity;
                                        }
                                      });
                                    },
                                  ),
                                )
                              : null,
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, _selectedDishes),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A8AFF),
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Select (${_selectedDishes.length})'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getMealIcon() {
    switch (widget.mealType) {
      case 'nashta':
        return Icons.breakfast_dining;
      case 'lunch':
        return Icons.lunch_dining;
      case 'dinner':
        return Icons.dinner_dining;
      default:
        return Icons.restaurant;
    }
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}

