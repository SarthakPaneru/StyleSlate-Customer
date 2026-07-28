/// Every user-facing string in the app, in one place. Screens should
/// reference these constants rather than hardcoding text inline, so
/// copy changes and (eventually) localization only touch this file.
class AppStrings {
  AppStrings._();

  // ---------------------------------------------------------------------
  // Common / shared across screens
  // ---------------------------------------------------------------------
  static const ok = 'OK';
  static const yes = 'Yes';
  static const no = 'No';
  static const retry = 'Retry';
  static const skip = 'Skip';
  static const next = 'Next';
  static const email = 'Email';
  static const password = 'Password';
  static const confirmPassword = 'Confirm password';
  static const usePasswordInstead = 'Use password instead';
  static const networkErrorGeneric = 'Something went wrong. Please try again.';

  // ---------------------------------------------------------------------
  // Validation messages (shared across auth/profile forms)
  // ---------------------------------------------------------------------
  static const validationEmailRequired = 'Email is required';
  static const validationEmailInvalid = 'Enter a valid email';
  static const validationPasswordRequired = 'Password is required';
  static const validationPasswordTooShort =
      'Password must be at least 6 characters';
  static const validationConfirmPasswordRequired = 'Confirm your password';
  static const validationConfirmNewPasswordRequired =
      'Confirm your new password';
  static const validationPasswordsDoNotMatch = 'Passwords do not match';
  static const validationPhoneRequired = 'Phone number is required';
  static const validationPhoneInvalid = 'Enter a valid phone number';
  static String validationFieldRequired(String fieldName) =>
      '$fieldName is required';

  // ---------------------------------------------------------------------
  // Auth: Login
  // ---------------------------------------------------------------------
  static const loginWelcomeBack = 'Welcome back';
  static const loginSubtitle = 'Log in to book your next appointment.';
  static const loginButton = 'Log In';
  static const loginForgotPassword = 'Forgot password?';
  static const loginNoAccount = "Don't have an account? Sign up";
  static const loginFailedGeneric = 'Login failed. Please try again.';
  static const loginBiometricPromptTitle = 'Enable quick login?';
  static const loginBiometricPromptBody =
      'Use your fingerprint or face to log in next time, instead of typing your password.';
  static const loginBiometricPromptNotNow = 'Not now';
  static const loginBiometricPromptEnable = 'Enable';

  // ---------------------------------------------------------------------
  // Auth: Register
  // ---------------------------------------------------------------------
  static const registerTitle = 'Create account';
  static const registerFirstName = 'First name';
  static const registerLastName = 'Last name';
  static const registerPhone = 'Phone number';
  static const registerButton = 'Sign Up';
  static const registerSuccess = 'Account created. Please log in.';
  static const registerFailedGeneric =
      'Registration failed. Please try again.';

  // ---------------------------------------------------------------------
  // Auth: Forgot / reset password
  // ---------------------------------------------------------------------
  static const forgotPasswordTitle = 'Forgot password';
  static const forgotPasswordBody =
      "Enter the email associated with your account and we'll send you a reset code.";
  static const forgotPasswordSendCode = 'Send reset code';
  static const forgotPasswordSendFailed =
      'Could not send reset code. Please try again.';
  static const resetPasswordTitle = 'Reset password';
  static String resetPasswordBody(String email) =>
      'Enter the code sent to $email and choose a new password.';
  static const resetPasswordCode = 'Reset code';
  static const resetPasswordNewPassword = 'New password';
  static const resetPasswordConfirmNewPassword = 'Confirm new password';
  static const resetPasswordButton = 'Reset password';
  static const resetPasswordSuccess = 'Password reset. Please log in.';
  static const resetPasswordFailedGeneric =
      'Could not reset password. Please try again.';

  // ---------------------------------------------------------------------
  // Onboarding
  // ---------------------------------------------------------------------
  static const onboardingSlide1Title = 'Find barbers near you';
  static const onboardingSlide1Description =
      'Discover top-rated barbers close to your location, with real-time distance and availability.';
  static const onboardingSlide2Title = 'Book in seconds';
  static const onboardingSlide2Description =
      "Pick a service, choose a time that works for you, and you're booked — no calls needed.";
  static const onboardingSlide3Title = 'Stay connected';
  static const onboardingSlide3Description =
      'Chat with your barber and pay securely through the app, from booking to checkout.';
  static const onboardingGetStarted = 'Get Started';

  // ---------------------------------------------------------------------
  // Biometric lock screen
  // ---------------------------------------------------------------------
  static const biometricUnlockTitle = 'Unlock Hamro Barber';
  static const biometricUnlockSubtitle =
      'Use your fingerprint or face to continue.';
  static const biometricTryAgain = 'Try again';
  static const biometricLoginReason = 'Unlock Hamro Barber';
  static const biometricEnableConfirmReason =
      "Confirm it's you to enable quick login";
  static const biometricToggleLabel = 'Fingerprint / Face ID login';
  static const biometricEnabledMessage = 'Quick login enabled.';
  static const biometricDisabledMessage = 'Quick login disabled.';

  // ---------------------------------------------------------------------
  // Home
  // ---------------------------------------------------------------------
  static String homeGreeting(String firstName) => 'Hi, $firstName';
  static String homeLocation(String latitude, String longitude) =>
      'Your location: $latitude, $longitude';
  static const homeFindYourBarber = 'Find your barber';
  static const homeCategorySectionTitle = 'Category';
  static const homeRecommendedBarbersTitle = 'Recommended Barbers';
  static const homeBarbersLoadFailed = 'Could not load barbers.';
  static const homeNoBarbersNearby = 'No barbers found nearby.';
  static const categoryHaircut = 'Haircut';
  static const categoryHairStyle = 'Hair Style';
  static const categoryBeard = 'Beard';
  static const categoryTreatment = 'Treatment';
  static const categoryBeautySaloon = 'Beauty Saloon';

  // ---------------------------------------------------------------------
  // Barber search
  // ---------------------------------------------------------------------
  static const searchNothingLoadedYet =
      'Barbers will show up here once loaded on the home screen.';
  static String searchNoMatches(String query) => 'No barbers match "$query".';
  static String distanceAway(String distance) => '$distance km away';

  // ---------------------------------------------------------------------
  // Barber detail
  // ---------------------------------------------------------------------
  static const detailLoadFailed = 'Could not load this barber.';
  static const detailServiceListTitle = 'Service List';
  static String detailServiceDuration(String minutes) => '$minutes Min';
  static const detailBookButton = 'Book';

  // ---------------------------------------------------------------------
  // Booking
  // ---------------------------------------------------------------------
  static const bookingAppBarTitle = 'Appointment';
  static const bookingSelectConsultationTime = 'Select Consultation Time';
  static const bookingTuesdayUnavailable =
      'Tuesday is not available, please select another date';
  static const bookingMakeAppointment = 'Make Appointment';
  static const bookingSuccessTitle = 'Successfully Booked';
  static const bookingSuccessBody = 'Barber has been reserved';
  static const bookingPaymentAction = 'Payment';
  static const bookingFailedGeneric = 'Could not book this appointment.';

  // ---------------------------------------------------------------------
  // Appointments
  // ---------------------------------------------------------------------
  static const appointmentsTitle = 'Scheduled Appointments';
  static const appointmentsTabUpcoming = 'Upcoming';
  static const appointmentsTabCompleted = 'Completed';
  static const appointmentsTabCancelled = 'Cancelled';
  static const appointmentsLoadFailed = 'Could not load appointments.';
  static const appointmentsEmpty = 'No appointments here yet.';
  static String appointmentDate(String date) => 'Date: $date';
  static String appointmentTime(String time) => 'Time: $time';
  static String appointmentService(String service) => 'Service: $service';

  // ---------------------------------------------------------------------
  // Favourites
  // ---------------------------------------------------------------------
  static const favouritesTitle = 'Favourite Barbers';
  static const favouritesEmpty =
      'No favourites yet.\nBarbers you favourite will show up here.';

  // ---------------------------------------------------------------------
  // Notifications
  // ---------------------------------------------------------------------
  static const notificationTitle = 'Notification';

  // ---------------------------------------------------------------------
  // Profile / My Account
  // ---------------------------------------------------------------------
  static const myAccountTitle = 'My Account';
  static const myAccountLoadFailed = 'Could not load your account details.';
  static const myAccountNoPhone = 'No phone number';
  static const myAccountNoEmail = 'No email';
  static const myAccountNoName = 'No name';
  static const editProfilePicture = 'Edit Profile Picture';
  static const profilePictureUpdated = 'Profile picture updated.';
  static const profilePictureUploadFailed = 'Could not upload your photo.';
  static const profileTitle = 'Profile';
  static const logOutConfirmMessage = 'Are you sure you want to log out?';
  static const menuMyAccount = 'My Account';
  static const menuNotifications = 'Notifications';
  static const menuSettings = 'Settings';
  static const menuHelpCenter = 'Help Center';
  static const menuLogOut = 'Log Out';

  // ---------------------------------------------------------------------
  // Change password
  // ---------------------------------------------------------------------
  static const changePasswordTitle = 'Change Password';
  static const changePasswordCurrent = 'Current Password';
  static const changePasswordNew = 'New Password';
  static const changePasswordConfirm = 'Confirm Password';
  static const changePasswordButton = 'Change Password';
  static const changePasswordSuccess = 'Password changed successfully.';
  static const changePasswordFailedGeneric = 'Could not change password.';

  // ---------------------------------------------------------------------
  // Help center
  // ---------------------------------------------------------------------
  static const helpCenterTitle = 'Help Center';
  static const helpCenterContactUs = 'Contact Us';
  static const helpCenterFaqs = 'FAQs';
  static const helpCenterTerms = 'Terms and Conditions';
  static const helpCenterPrivacy = 'Privacy Policy';

  // ---------------------------------------------------------------------
  // Home shell (bottom nav / FAB)
  // ---------------------------------------------------------------------
  static const navHome = 'Home';
  static const navFavorite = 'Favorite';
  static const navBook = 'Book';
  static const navAccount = 'Account';
  static const chatTooltip = 'Chat';

  // ---------------------------------------------------------------------
  // Chat
  // ---------------------------------------------------------------------
  static String chatWithTitle(String id) => 'Chat with $id';
  static const chatMessageHint = 'Send a message';
  static const chatDisconnected = 'Disconnected from WebSocket';

  // ---------------------------------------------------------------------
  // Khalti payment
  // ---------------------------------------------------------------------
  static const khaltiPaymentTitle = 'Khalti Payment';
  static const khaltiPayWithKhalti = 'Pay with Khalti';
  static String khaltiPaymentSuccessful(String token) =>
      'Payment Successful: $token';
  static String khaltiPaymentFailed(String message) =>
      'Payment Failed: $message';
  static const khaltiPaymentCancelled = 'Payment Cancelled';
}
