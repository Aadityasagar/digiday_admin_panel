/// All error messages and other app Messages
class AppMessages {
  static const applicationTimeoutError =
      "An application time out error occurred, please try again later.";

  static const unHandledException =
      "An unhandled exception occurred during processing the request.";

  static const studyNotFound = "Study not found.";
  static const siteNotFound = "Site not found.";
  static const mvNotFound = "Monitoring Visit not found.";
  static const actionItemNotFound = "Action Item not found.";
  static const sitePersonnelNotFound = "Site Personnel not found.";
  static const teamMemberNotFound = "Team member not found.";

  static const accessDenied = "Access Denied.";

  static const authorizationDenied =
      "Authorization has been denied for this request.";

  static const conflictInCurrentState =
      "Concurrency Error: The request could not be processed because of conflict in the current state of the resource."; //409

  static const dataNotCached = "Data not cached";
  static const mvDataNotLoaded = "Monitor Visit Data not loaded to mobile device";
  static const actionDataNotLoaded = "Site Action data not loaded to mobile device yet";
  static const somethingWentWrong = "Something went wrong.";
  static const pleaseTurnOfDevMode = "Please turn off the developer mode";
  static const yourDeviceIsRooted = "Your Device is Rooted.";
  static const pleaseSync = "Please wait until visit get synced.";
  static const actionSyncIssue = "An error occurred while syncing action";
  static const mvSyncIssue = "An error occurred while syncing visit";
  static const notConnected = "Please check your connection";
  static const syncingInProgress = "Syncing in progress";
  static const connectionToolTip = "Not connected to internet please check your connection.";


  static const mv409Message = "The Monitor Visit Status or Planned Visit Dates have changed in ICOTrial, the Monitor Visit data will be refreshed from ICOTrial.";
  static const action409Message = "The Site Action Status has changed in ICOTrial, the Site Action data will be refreshed from ICOTrial.";
  //Api Error
  static const connectionTimedOut = "Connection timeout";
  static const sendTimeout = "Send Timeout";
  static const receiveTimeout = "Receive timeout";
  static const connectionCanceled = "Connection canceled";
  static const generalError = "Something went wrong";



}
