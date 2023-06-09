

import 'package:expense_proj/app_widgets/app_logo_widget.dart';
import 'package:expense_proj/app_widgets/bottom_onboard_stack_widget.dart';
import 'package:expense_proj/app_widgets/rounded_btn.dart';

import 'package:expense_proj/screens/user_onboard/signup_page.dart';
import 'package:expense_proj/ui_helper.dart';
import 'package:flutter/material.dart';


import '../../database/my_db_helper.dart';
import '../home/home_page.dart';

class Login_Page extends StatefulWidget {

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  late MediaQueryData mq;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     mq = MediaQuery.of(context);
    return Scaffold(
      body:mq.orientation == Orientation.portrait? _PortraitLay(context) : _LandscapeLay(context)  ,
    );
  }

  Widget _MainLay(BuildContext context){

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: mq.size.width*0.02),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Applogo_Widget(mq: mq),
            mHeightSpacer(mHeight: mq.size.height*0.05),

            FittedBox(
              fit: BoxFit.scaleDown,
                child: Text('Hello again, ',style: Theme.of(context).textTheme.displayLarge,)),
            FittedBox(
                fit : BoxFit.scaleDown,
                child: Text('start managing your expense in one click',style:Theme.of(context).textTheme.displaySmall)),
            mHeightSpacer(mHeight: mq.size.height*0.04),
            TextFormField(
              controller: emailController,
              validator: (value) {
                if(value!.isEmpty){
                  return 'Please fill the blank';
                }
              },
              decoration: mInputDec(mhint: 'enter your email', mlable: 'E-mail',mPrefixIcon: Icons.email_outlined),
            ),
            mHeightSpacer(mHeight: mq.size.height*0.01),
            TextFormField(
              controller: passController,
              validator: (value) {
                if(value!.isEmpty){
                  return 'Please fill the blank';
                }
              },
              decoration: mInputDec(mhint: 'enter your email', mlable: 'Password',mPrefixIcon: Icons.password_outlined,mSuffixIcon: Icons.visibility),
            ),
            mHeightSpacer(mHeight: mq.size.height*0.04),
            Rounded_Btn(title: 'Login', onPress: () async {
              if(formKey.currentState!.validate()){
                print('login starts');
                bool check = await  My_Db_Helper().LogIn(emailController.text.toString(),passController.text.toString());
                if(check){
                  print('logged in sucessfully');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_Page(),));
                }else{
                  print('username password mismatch');
                }
              }





            }),
            mHeightSpacer(mHeight: mq.size.height*0.03),
            Container(
              width: double.infinity,
              color: Colors.grey,
              height: 1,
            ),
            mHeightSpacer(mHeight: mq.size.height*0.03),
            Btm_OnBoard_Stack(onPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp_Page(),));
            },title: 'Don\'t have account, ', subtile: 'create one', ),


          ],



        ),
      ),
    );
  }

  Widget _PortraitLay(BuildContext context){
    return mq.size.height > 300 ?
    _MainLay(context) : Container();
  }

  Widget _LandscapeLay(BuildContext context){
    return Row(
      children: [
        Expanded(

            child: _MainLay(context)),
        Expanded(
         child: FittedBox(
             fit: BoxFit.scaleDown,
             child: Image.asset('assets/images/login_landscape_bg.png')),
        )
      ],
    );
  }
}
