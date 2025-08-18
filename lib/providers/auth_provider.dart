import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campus_swipe/services/auth_service.dart';
import 'package:campus_swipe/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  
  User? _user;
  UserModel? _userProfile;
  bool _isLoading = false;
  String? _error;

  // Getters
  User? get user => _user;
  UserModel? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;
  bool get isVerified => _userProfile?.isVerified ?? false;
  bool get isAdmin => _userProfile?.isAdmin ?? false;

  AuthProvider() {
    // Listen to auth state changes
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      if (user != null) {
        _loadUserProfile(user.uid);
      } else {
        _userProfile = null;
      }
      notifyListeners();
    });
  }

  // Load user profile from Firestore
  Future<void> _loadUserProfile(String uid) async {
    try {
      _userProfile = await _authService.getUserProfile(uid);
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load user profile: $e';
      notifyListeners();
    }
  }

  // Sign up with email and password
  Future<bool> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required int age,
    required String college,
    required Department department,
    required String batch,
    required String city,
    String? phone,
  }) async {
    try {
      _setLoading(true);
      _clearError();

      User? user = await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        age: age,
        college: college,
        department: department,
        batch: batch,
        city: city,
        phone: phone,
      );

      if (user != null) {
        _user = user;
        await _loadUserProfile(user.uid);
        return true;
      }
      return false;
    } catch (e) {
      _setError('Sign up failed: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Sign in with email and password
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);
      _clearError();

      User? user = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user != null) {
        _user = user;
        await _loadUserProfile(user.uid);
        return true;
      }
      return false;
    } catch (e) {
      _setError('Sign in failed: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Sign up with phone number
  Future<void> signUpWithPhoneNumber({
    required String phoneNumber,
    required Function(String verificationId, int? resendToken) codeSent,
    required Function(String error) verificationFailed,
    required Function() verificationCompleted,
  }) async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.signUpWithPhoneNumber(
        phoneNumber: phoneNumber,
        codeSent: codeSent,
        verificationFailed: (error) {
          _setError(error);
          verificationFailed(error);
        },
        verificationCompleted: verificationCompleted,
      );
    } finally {
      _setLoading(false);
    }
  }

  // Verify phone number with OTP
  Future<bool> verifyPhoneNumberWithOTP({
    required String verificationId,
    required String otp,
  }) async {
    try {
      _setLoading(true);
      _clearError();

      User? user = await _authService.verifyPhoneNumberWithOTP(
        verificationId: verificationId,
        otp: otp,
      );

      if (user != null) {
        _user = user;
        await _loadUserProfile(user.uid);
        return true;
      }
      return false;
    } catch (e) {
      _setError('OTP verification failed: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.sendPasswordResetEmail(email);
      return true;
    } catch (e) {
      _setError('Failed to send password reset email: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update user profile
  Future<bool> updateUserProfile(UserModel updatedUser) async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.updateUserProfile(updatedUser);
      _userProfile = updatedUser;
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to update profile: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Send email verification
  Future<bool> sendEmailVerification() async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.sendEmailVerification();
      return true;
    } catch (e) {
      _setError('Failed to send email verification: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Reload user to check verification status
  Future<void> reloadUser() async {
    try {
      await _authService.reloadUser();
      if (_user != null) {
        await _loadUserProfile(_user!.uid);
      }
    } catch (e) {
      _setError('Failed to reload user: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.signOut();
      _user = null;
      _userProfile = null;
    } catch (e) {
      _setError('Sign out failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Delete account
  Future<bool> deleteAccount() async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.deleteAccount();
      _user = null;
      _userProfile = null;
      return true;
    } catch (e) {
      _setError('Failed to delete account: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Check if email is already registered
  Future<bool> isEmailRegistered(String email) async {
    return await _authService.isEmailRegistered(email);
  }

  // Utility methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}
