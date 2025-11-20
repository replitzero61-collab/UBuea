class InputValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    
    return null;
  }
  
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    return null;
  }
  
  static String? validateMatriculeNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Matricule number is required';
    }
    
    final trimmedValue = value.trim().toUpperCase();
    
    final matriculeRegex = RegExp(
      r'^[A-Z]{1,3}\d{2}[A-Z]\d{3,4}$',
    );
    
    if (!matriculeRegex.hasMatch(trimmedValue)) {
      return 'Invalid matricule format (e.g., CT23A254, SC25A342)';
    }
    
    return null;
  }
  
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    
    return null;
  }
  
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
  
  static String? validateNumber(String? value, {int? min, int? max}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a number';
    }
    
    final number = int.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    
    if (min != null && number < min) {
      return 'Number must be at least $min';
    }
    
    if (max != null && number > max) {
      return 'Number must be at most $max';
    }
    
    return null;
  }
}
