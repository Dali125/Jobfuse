import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';


class SettingsHome extends StatefulWidget {
  const SettingsHome({Key? key}) : super(key: key);

  @override
  State<SettingsHome> createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
          color: AppColors.splashColor,),
          onPressed:(){

            Navigator.of(context).pop();

          },

        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            //The settings text at the top
            const Text('Settings', style: TextStyle(
              fontSize: 30
            ),),
            
            const SizedBox(height: 40,),


            //The Header goes here
            SizedBox(height: 40,
            child: Row(

              children: [
                Icon(Icons.person_outline,
                color: AppColors.splashColor2,),
              const SizedBox(width: 15,),
              const Text('Account',

              style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 18),),


              ],
            ),),
            const Divider(),
            const SizedBox(height: 25,),
            SizedBox(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Change Password',style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600
                ),

                ),
                Icon(Icons.arrow_forward_ios_rounded)
              ],),
            ),
            SizedBox(height: 15,),
            SizedBox(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('data'),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],),
            ),
            SizedBox(height: 15,),
            SizedBox(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('data'),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],),
            ),
            SizedBox(height: 15,),
            SizedBox(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Privacy and Security',style: TextStyle(
                      fontSize: 16
                  ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],),
            ),


            const SizedBox(height: 40,),

            //Header Here
            SizedBox(height: 40,
              child: Row(

                children: [
                  Icon(Icons.volume_up_outlined,
                    color: AppColors.splashColor2,),
                  SizedBox(width: 15,),
                  Text('Notifications',
                    style: TextStyle(fontWeight: FontWeight.bold),),


                ],
              ),),




          ],




        ),
      ),




    );
  }
}
