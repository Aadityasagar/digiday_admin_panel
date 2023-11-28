import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfilePic extends StatelessWidget {
  //final AccountController _accountController=Get.find<AccountController>();


  ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 150,
      width: 150,
      child:Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          // _accountController.getCurrentUser?.photo==null ? const CircleAvatar(
          //   backgroundImage:  AssetImage("images/ProfileImage.png"),
          // ):
          // _accountController.profilePicUrl.value!=""? CircleAvatar(
          //   backgroundImage:  NetworkImage(_accountController.profilePicUrl.value),
          // ):SizedBox(),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: (){
                  //_accountController.selectProfilePic()
                },
                child: SvgPicture.asset("icons/CameraIcon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
