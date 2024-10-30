import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:teach/features/profile/presentation/model/task_model.dart';
import 'package:teach/router/app_routes.dart';
import 'package:teach/service/auth_service.dart';

import '../../../../../constants/image_constants.dart';
import '../../../../../core/colors/app_colors.dart';
class HomeItemsWidget extends StatelessWidget {
  const HomeItemsWidget({super.key, required this.lesson,required this.id, this.onTap,this.onUpload,this.onDownload});

  final TaskModel lesson;
  final String id;
  final VoidCallback? onTap;
  final VoidCallback? onUpload;
  final VoidCallback? onDownload;

  @override
  Widget build(BuildContext context) => InkWell(
    highlightColor: AppColors.opacity,
    onTap: () async {},
    child: Column(
      children: [
        SizedBox(
          height: 106,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: double.infinity,
                    decoration:  BoxDecoration(
                        color: AppColors.baseColor,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  SizedBox(width: 8,),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              lesson.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColors.activeTestButton,
                                letterSpacing: 0.2,
                              ),
                            ),
                            Text(
                              lesson.description,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.baseGray,
                                letterSpacing: 0.2,
                              ),
                            ),
                            Container(
                              padding:  const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: AppColors.baseColor.withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                children: [
                                  SvgPicture.asset(SvgIcons.icLeadIcon),
                                  const SizedBox(width: 8,),
                                  const Text(
                                    "12",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.black,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              //DateFormat.yMMMMd().format(DateTime.parse(lesson.dateTime))
                              lesson.dateTime,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.black,
                                  letterSpacing: 0.2),
                            ),
                            const Text(
                            '1212',
                             // "${DateFormat("HH:mm").parse(lesson.startTime).hour}:${DateFormat("HH:mm").parse(lesson.startTime).minute}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.activeTestButton,
                                  letterSpacing: 0.2),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
     localSource.type=='Teacher'?  InkWell(
         highlightColor: AppColors.opacity,
         splashColor: AppColors.opacity,
         onTap: onTap,
         child: Container(
           width: double.infinity,
           alignment: Alignment.center,
           margin: EdgeInsets.symmetric(horizontal: 14,vertical: 11),
           padding: EdgeInsets.all(9),
           decoration: BoxDecoration(
             color: AppColors.baseColor,
             borderRadius: BorderRadius.circular(12)
           ),
           child: const Text('Delete Task',style: TextStyle(color: Colors.white),),
         ),
       ):
        Row(
          children: [
            Expanded(
              child: InkWell(
                highlightColor: AppColors.opacity,
                splashColor: AppColors.opacity,
                onTap: onUpload,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 14,vertical: 11),
                  padding: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      color: AppColors.baseColor,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: const Text('Upload',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            SizedBox(width: 12,),
            Expanded(
              child: InkWell(
                highlightColor: AppColors.opacity,
                splashColor: AppColors.opacity,
                onTap: onDownload,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 14,vertical: 11),
                  padding: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      color: AppColors.baseColor,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: const Text('Download',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        )

      ],
    ),
  );
}
