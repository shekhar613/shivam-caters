import 'package:flutter/material.dart';

class StatusBarProvider extends ChangeNotifier {
  String? _currentScreen;
  String? _statusMessage;
  bool _isLoading = false;
  int? _totalOrders;
  int? _pendingOrders;
  int? _completedOrders;

  // Getters
  String? get currentScreen => _currentScreen;
  String? get statusMessage => _statusMessage;
  bool get isLoading => _isLoading;
  int? get totalOrders => _totalOrders;
  int? get pendingOrders => _pendingOrders;
  int? get completedOrders => _completedOrders;

  // Methods to update status
  void setCurrentScreen(String? screen) {
    _currentScreen = screen;
    notifyListeners();
  }

  void setStatusMessage(String? message) {
    _statusMessage = message;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setOrderStats({
    int? total,
    int? pending,
    int? completed,
  }) {
    _totalOrders = total;
    _pendingOrders = pending;
    _completedOrders = completed;
    notifyListeners();
  }

  void clearStatus() {
    _statusMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  void updateStatus({
    String? screen,
    String? message,
    bool? loading,
    int? total,
    int? pending,
    int? completed,
  }) {
    if (screen != null) _currentScreen = screen;
    if (message != null) _statusMessage = message;
    if (loading != null) _isLoading = loading;
    if (total != null) _totalOrders = total;
    if (pending != null) _pendingOrders = pending;
    if (completed != null) _completedOrders = completed;
    notifyListeners();
  }
}
