


import '../../di/di.dart';
import '../../imports/services.dart';



class RepositoryDependencies{
 static final HttpConnectionInfoServices httpConnectionInfo =
  instance<HttpConnectionInfoServices>();
  static final AuthenticationData authenticationRecord = instance<AuthenticationData>();
}