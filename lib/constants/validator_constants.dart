// class ValidatorConstants {
//
//   // Constants for Validation Regex
const String kPhoneNoRegex = r'(^[0-9]*$)';
//static const String kNameRegex = r'(^[a-zA-Z ]*$)';
const String kNameRegex =r'(^[a-zA-Z0-9!@#$&()-.+, ]*$)';
/*const String kUrlRegex =r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";*/
/*const String kUrlRegex =r"^(http:\/\/|https:\/\/)?([a-zA-Z0-9-_]+\.)*[a-zA-Z0-9][a-zA-Z0-9-_]+\.[a-zA-Z]?$";*/
const String kUrlRegex =
    r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)"
    r"[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-@]+))*$";

const String kEmailRegex =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const String kPasswordRegex = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{12,}$';
// Constant for Validation messages
const String kPhoneNoRequired = 'Mobile is Required';
const String kPhoneNoDigits = 'Mobile number must 10 digits';
const String kPhoneNoValidate = 'Mobile number must be in digits';
const String kNameRequired = 'Name is Required';
String kFirstNameRequired = 'reqfirst';//Please enter first name
String kLastNameRequired =  'reqlast';//Please enter last name

const String kOrgNameRequired = 'orgNameReq';//Please enter organisation name
const String kTitleRequired = 'jobTitle';//Please enter Job Title

const String kEmailRequired = 'emailReq';//Please enter email address
const String kNameValidate = 'Valid name is required';
// static const String kNameValidate = 'Name must be a-z and A-Z';Name is Required
const String kEmailValidate = 'emailInvld';//Email address is invalid
const String kPasswordValidate = "passwordInvalid";//'Please enter valid password';
const String kConfirmPasswordValidate = 'Entered password is not same';
const String kOutofOfcValidate ='emailOutofOfc';//Please select a delegatee for out of office.
const String kOutofOfcValidateTime ='timeOutofOfc';//Please select a time zone
// }
