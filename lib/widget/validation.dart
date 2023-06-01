String? isValidEmail(String? email) {
  RegExp regex = RegExp(r'\w+@\w+\.\w+');
  if (email!.trim().isEmpty)
    return "Please enter email";
  else if (!regex.hasMatch(email.trim()))
    return "Please enter valid email";
  else
    return null;
}

String? isvalidateMobile(String? mbno) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10}$)';
  RegExp regExp = new RegExp(patttern);
  if (mbno!.isEmpty) {
    return "Please enter mobileNumber";
  } else if (!regExp.hasMatch(mbno)) {
    return "Please enter valid mobile number";
  } else {
    return null;
  }
}

String? isValidPassword(String? id) {
  if (id == null || id.isEmpty)
    return "Please enter password";
  else
    return null;
}
String? isValidpassword(String? password) {
  Pattern pattern =
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";
  RegExp regex = new RegExp(pattern as String);
  print(password);
  if (password!.isEmpty) {
    return "Please enter your password";
  } else {
    if (!regex.hasMatch(password))
      return    "Password must have minimum 8 characters with one letter, one number and one special character:";
    else
      return null;
  }
}
