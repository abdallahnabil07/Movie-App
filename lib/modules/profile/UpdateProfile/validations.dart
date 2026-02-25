class Validations {
  static String? phoneNumbers(String? value)
  {
    if (value == null || value.isEmpty) {
      return 'Phone Number is required';
    }
    if(value.length<9)
    {
      return 'phone number is incorrect';
    }
    return null;
  }

  static String? userName(String? value)
  {
    if (value == null || value.isEmpty) {
      return 'User Name is required';
    }
    return null;
  }
}