class ContactUsRequestModel {
  final String userId, firstName, lastName, email, message,number, code;

  const ContactUsRequestModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.message,
    required this.code,
    required this.number,
  });
}
