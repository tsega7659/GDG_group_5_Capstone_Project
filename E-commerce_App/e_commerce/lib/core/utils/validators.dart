/// Contains functions to validate user inputs (e.g., email, password).
bool isValidEmail(String email) {
  // Add email validation logic
  return true;
}
/// Simple form‑field validators.
class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email required';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'Invalid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password required';
    if (value.length < 6) return 'Min 6 characters';
    return null;
  }
}
