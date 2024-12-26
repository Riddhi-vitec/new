
import 'package:template_flutter_mvvm_repo_bloc/root_app.dart';
import 'app_configuration/app_environments.dart';
import 'imports/common.dart';

void main(){
  AppEnvironments.setUpEnvironments(Environment.dev);
  mainDelegateForEnvironments();
}