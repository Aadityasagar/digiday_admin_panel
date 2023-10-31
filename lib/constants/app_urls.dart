class ApiUrl {

  //base URL
  static const String baseUrl = 'http://192.168.29.254:8000';
  //static const String baseUrl = 'https://lionfish-app-ktst4.ondigitalocean.app';
  static const String kHeaders = 'application/json';
  //constants with URL
  static const route = '/vendor';
  static const version1 = '/v1';
  static const version2 = '/v2';
  static const kRegisterUserUrl = '$route/register';
  static const kLoginUserUrl = '$route/login';
  static const userProfile = '$route/profile';
  static const userProfileData = '$route/data';
  static const userProfileUpdate = '$route/profile_update';
  static const userBusinessUpdate = '$route/business_update';
  static const updateProfilePic = '$route/upload_profile_pic';
  static const getVendorPlans = '$route/get-vendor-plans';

  static const vendorProfilePicsDirectory = '/images/vendor/profile_pics/';
  static const googleStorageBase = 'gs://digiday-7570a.appspot.com';
  static const profilePicsFolder = '/images/users/profile_pics';
  static const offerBannersFolder = '/images/vendors/business/offer_banners';
  static const businessPicsFolder = '/images/vendors/business/profile_pics';


  static const paytmLocalCallBackUrl ='$baseUrl/vendor/paytm-callback';

  static const kVendorPurchasePlan = '$route/purchase-plan';
  static const kVendorSubscriptionStatus = '$route/subscription-status';

  static const kGetPaytmToken = 'https://us-central1-digiday-7570a.cloudfunctions.net/paytmTxnToken';
  static const kGetPaytmTokenFromServer = 'https://digidayapp.serveravatartmp.com/paytm-pg/getToken.php';
}