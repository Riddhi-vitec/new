import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/root_app.dart';

import '../imports/common.dart';


extractUrlToNavigate({required Uri deepLink}){
  String path = deepLink.path;
  //always check your path before calling navigator
  if(path == '/reset-password') {
    String token = deepLink.toString().split('token=').last.split('&').first;
    Navigator.pushNamedAndRemoveUntil(navigatorKey.currentState!.context, RouteName.routeResetPassword,(route) => false,
      arguments: token);
  }
}
class ResetPasswordDynamicLinkServices{
  //from a terminated state step 1: collect pending data and check if it is nul inside splash bloc for different userTypes
  static Future<PendingDynamicLinkData?> resetDynamicLinkFromTerminatedState() async {
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
      return initialLink;
    }
  //from a terminated state step 2-- if pending data is not null, call this
  static resetDynamicLinkObtainedFromTerminatedState({required Uri deepLink}){
     extractUrlToNavigate(deepLink: deepLink);
 }
  //open, or in the background -- here pending data is never null
  static resetDynamicLinkOnBackgroundOrForeground(){
    FirebaseDynamicLinks.instance.onLink.listen((pendingDynamicLinkData) async {
      final Uri deepLink =  pendingDynamicLinkData.link;
      extractUrlToNavigate(deepLink: deepLink);

    }, onError: (e)  {
      debugPrint('Error in dynamic link: $e');
    });

  }


}
