import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../di/di.dart';
import '../../../imports/common.dart';
import '../../../imports/services.dart';
import '../bloc/notification_bloc.dart';

class NotificationView extends StatefulWidget {
  NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}


class _NotificationViewState extends State<NotificationView> {
   NotificationBloc notificationBloc = instance<NotificationBloc>();

  @override
  void initState() {
    notificationBloc.listenToForegroundNotification(notificationBloc: notificationBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => notificationBloc..add(TriggerFetchNotificationList()),
      child: BlocListener<NotificationBloc, NotificationWithInitialState>(
        listener: (context, state) {
          if (state.isFailure && state.message.isNotEmpty) {
            Toast.nullableIconToast(
                message: state.message, isErrorBooleanOrNull: true);
          }
        },
        child: BlocBuilder<NotificationBloc, NotificationWithInitialState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColor.colorScaffold,
              appBar: const CustomAppBar(
                title: AppStrings.notification_screen_title,
                isLeading: true,
                centerTitle: false,
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenHPadding, vertical: screenVPadding),
                child: state.isLoading
                    ? CustomLoader(
                        child: buildNotificationList(state),
                      )
                    : buildNotificationList(state),
              ),
            );
          },
        ),
      ),
    );
  }

  ListView buildNotificationList(NotificationWithInitialState state) {
    return ListView.separated(
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              notificationBloc.add(
                TriggerReadNotification(
                    notificationID: state.notificationData[i].id!),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: cardHorizontalPadding,
                  vertical: cardVerticalPadding),
              height: 100.h,
              color: AppColor.colorPrimary,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: AppColor.colorPrimaryTextInverse,
                    child: CircleAvatar(
                      radius: 28.r,
                      backgroundColor: AppColor.colorPrimary,
                      child: Center(
                        child: Text(
                          state.notificationData[i].title![0].toString(),
                          style: Style.subTitleStyle(
                              color: AppColor.colorPrimaryTextInverse),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 2.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  state.notificationData[i].title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Style.subTitleStyle(
                                      color: AppColor.colorPrimaryTextInverse),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 3.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  state.notificationData[i].description!,
                                  style: Style.paragraphStyle(
                                      color: AppColor.colorPrimaryTextInverse),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          notificationTimeStamp(
                            state.notificationData[i].createdAt.toString()),
                          style: Style.paragraphStyle(
                              color: AppColor.colorPrimaryTextInverse),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, i) {
          return SizedBox(
            height: widgetBottomPadding,
          );
        },
        itemCount: state.notificationData.length);
  }
}
