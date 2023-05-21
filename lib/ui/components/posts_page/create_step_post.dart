import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/components/ui-rands/my_button.dart';

import '../../../logic/make_post.dart';
import '../home/main_home.dart';

class StepPost extends StatefulWidget {
  const StepPost({Key? key}) : super(key: key);

  @override
  State<StepPost> createState() => _StepPostState();
}



class _StepPostState extends State<StepPost> {

  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 5.
  ////Form Variables
  String name = '';
  String category = '';
  String budget = '';
  String experienceLevel = '';
  String duration = '';

  int upperBound = 6; // upperBound MUST BE total number of icons minus 1.
  int characterLimit = 5000;
  int characterCount = 5000;
  TextEditingController description = TextEditingController();
  TextEditingController title = TextEditingController();

  double changers = 18;
  double unchangers = 18;

  @override
  void initState() {
    super.initState();
    description.addListener(updateCharacterCount);
  }

  void updateCharacterCount() {
    setState(() {
      characterCount = characterLimit - description.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              NumberStepper(
                activeStepBorderColor: AppColors.splashColor,
                activeStepColor: AppColors.logColor,
                numbers: const [
                 1,
                  2,
                  3,
                  4,
                  5,
                  6,
                  7
                ],

                // activeStep property set to activeStep variable defined above.
                activeStep: activeStep,

                // This ensures step-tapping updates the activeStep.
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              FadeInLeft(child: header()),

              Expanded(
                  child: stepWidgets()

              ),
              if (activeStep < 5) Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  previousButton(),
                  nextButton(),
                ],
              ) else if(activeStep == 5)FadeInUp(child: MyButton(onTap: (){

                setState(() {
                  activeStep = activeStep + 1;
                });

              }, buttonText: 'Continue'))
              else FadeInUp(child: MyButton(onTap: (){
                  showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          // false = user must tap button, true = tap outside dialog
                          builder: (BuildContext dialogContext) {
                            return CupertinoAlertDialog(
                              title: const Text('Create Post'),
                              content: const Text('Are you Sure you want to proceed?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () {

                                    try{


                                      MakePost makepost =
                                      MakePost(budget: budget,
                                          duration: duration,
                                          title: title.text.trim(), clientID: FirebaseAuth.instance.currentUser!.uid.toString() ,
                                          description: description.text.trim(),
                                          experienceLevel: experienceLevel,
                                          category: category,
                                          taskType: name,



                                      );

                                      //uploading a post, Hopefully
                                      makepost.UploadPost();




                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));


                                    }catch(e){



                                      //

                                      //
                                    }


























                                    Navigator.of(dialogContext)
                                        .pop(); // Dismiss alert dialog
                                  },
                                ),
                                TextButton(
                                  child: const Text('No'),
                                  onPressed: () {
                                    Navigator.of(dialogContext)
                                        .pop(); // Dismiss alert dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }, buttonText: 'Post Job'))

            ],
          ),
        ),
      );

  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: const Text('Next'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: const Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Category';

      case 2:
        return 'Budget';

      case 3:
        return 'Experience Level';

      case 4:
        return 'Duration';

      case 5:
        return 'Description';

      case 6:
        return 'Finalize';

      default:
        return 'Task Type';
    }
  }
  Widget stepWidgets(){
    double height = MediaQuery.of(context).size.height;

    switch(activeStep){

      case 1:
        return SingleChildScrollView(
          child: Column(
            children: [
              
              name == 'Offsite' ? const Text('data')

                  : 

                  //The onsite stuff will be displayed here
                        SingleChildScrollView(
                          child:

                              SizedBox(height: height,
                                child: StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('offsite_categories').snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return
                                        ListView.builder(
                                            itemCount: snapshot.data?.docs.length,
                                            itemBuilder: (context, index){

                                              var onsiteData = snapshot.data?.docs[index];

                                              return  FadeInUp(
                                                child: ListTile(
                                                  title: Text(onsiteData?['title']),
                                                  subtitle: Text(onsiteData?['subtitle']),
                                                  trailing: const Icon(Icons.arrow_forward_ios),
                                                  onTap: (){
                                                    setState(() {
                                                      category = onsiteData?['title'];
                                                      activeStep = activeStep + 1;
                                                    });
                                                  },
                                                ),
                                              );

                                        });
                                  } else if (snapshot.hasError) {
                                    return const Icon(Icons.error_outline);
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                }),
                              )


    ),




            ],
          ),
        );
//The budget goes here
      case 2:
        return Column(
          children: [

            ListTile(
              title: const Center(child: Text('20 - 100')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                  budget = '20 - 100';
                  activeStep = activeStep + 1;
                });
              },
            ),

            const Divider(),
            ListTile(
              title: const Center(child: Text('100 - 500')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                  budget = '100 - 500';
                  activeStep = activeStep + 1;
                });
              },
            ),
            const Divider(),
            ListTile(
              title: const Center(child: Text('500 - 1000')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                  budget = '500 - 1000';
                  activeStep = activeStep + 1;
                });
              },
            ),
            const Divider(),
            ListTile(
              title: const Center(child: Text('1000 - 3000')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                  budget = '1000 - 3000';
                  activeStep = activeStep + 1;
                });
              },
            ),
            const Divider(),
            ListTile(
              title: const Center(child: Text('over 3000')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                  budget = 'over 3000';
                  activeStep = activeStep + 1;
                });
              },
            ),



          ],
        );
//Expeience Level goes here
      case 3:
        return Column(
          children: [

            ListTile(
              title: const Center(child: Text('Easy')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                 experienceLevel = 'Easy';
                  activeStep = activeStep + 1;
                });
              },
            ),

            const Divider(),
            ListTile(
              title: const Center(child: Text('Intermediate')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                  experienceLevel = 'Intermediate';
                  activeStep = activeStep + 1;
                });
              },
            ),
            const Divider(),
            ListTile(
              title: const Center(child: Text('Expert')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                  experienceLevel = 'Expert';
                  activeStep = activeStep + 1;
                });
              },
            ),




          ],
        );

        //Project Duration
      case 4:
        return Column(
          children: [

            ListTile(
              title: const Center(child: Text('less than 12 hours')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                  duration = 'lessthan 12 hours';
                  activeStep = activeStep + 1;
                });
              },
            ),

            const Divider(),
            ListTile(
              title: const Center(child: Text('less than 24 hours')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                  duration = 'Less than 24 hours';
                  activeStep = activeStep + 1;
                });
              },
            ),
            const Divider(),
            ListTile(
              title: const Center(child: Text('Less than a week')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                  duration = 'Less than a week';
                  activeStep = activeStep + 1;
                });
              },
            ),
            const Divider(),
            ListTile(
              title: const Center(child: Text('Less than 3 months')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                  duration = 'Less than 3 months';
                  activeStep = activeStep + 1;
                });
              },
            ),
            const Divider(),
            ListTile(
              title: const Center(child: Text('Less than 6 months')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                  duration = 'Less than 6 months';
                  activeStep = activeStep + 1;
                });
              },
            ),
            const Divider(),
            ListTile(
              title: const Center(child: Text('More than 6 months')),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){
                setState(() {
                  duration = 'More than 6 months';
                  activeStep = activeStep + 1;
                });
              },
            ),



          ],
        );

        //Project Description
      case 5:
        return  SingleChildScrollView(
          child: Column(

            children: [

            TextField(
            controller: description,
            maxLength: characterLimit,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Enter Description',
              counterText: '$characterCount characters left',
            ),),

              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: title,
                maxLength: 30,
                maxLines: 1,
                decoration: const InputDecoration(
                  labelText: 'Enter Job Title'
                ),
              )

            ],
          ),
        );

        //post summary
      case 6:
        return Column(
          children: [

            ListTile(leading:  Text('Task Type', style: TextStyle(fontSize:unchangers, fontWeight: FontWeight.normal),),trailing: Text(name.toString(), style: TextStyle(fontSize: changers, fontWeight: FontWeight.bold),)),
            ListTile(leading:  Text('Category', style: TextStyle(fontSize: unchangers),),trailing: Text(category.toString(), style: TextStyle(fontSize: changers, fontWeight: FontWeight.bold),),),
            ListTile(leading:  Text('Experience Level', style: TextStyle(fontSize: unchangers),),trailing: Text(experienceLevel.toString(), style: TextStyle(fontSize: changers, fontWeight: FontWeight.bold),),),
            ListTile(leading:  Text('Budget', style: TextStyle(fontSize: unchangers),),trailing: Text(budget.toString(), style: TextStyle(fontSize: changers, fontWeight: FontWeight.bold),),),
            ListTile(leading:  Text('Duration', style: TextStyle(fontSize: unchangers),),trailing: Text(duration.toString(), style: TextStyle(fontSize: changers, fontWeight: FontWeight.bold),),),
            ListTile(leading:  Text('Description', style: TextStyle(fontSize: unchangers),overflow: TextOverflow.clip,),subtitle: Text(description.text.trim(),maxLines: 1, style: TextStyle(fontSize: changers, fontWeight: FontWeight.bold),),),
            ListTile(leading:  Text('Title', style: TextStyle(fontSize: unchangers),),trailing: Text(title.text.toString(), style: TextStyle(fontSize: changers, fontWeight: FontWeight.bold),),),






          ],
        );



        //What to show when selecting the task type
      default:
        return Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
           [

             const Padding(
               padding: EdgeInsets.only(left:10.0),
               child: Text('Select an option below'),
             ),
         ListTile(
           title: const Text('OnSite'),
           subtitle: const Text('Task involves freelancer to be present'),
           trailing: const Icon(Icons.arrow_forward_ios),
           onTap: (){
             setState(() {
               name = 'Onsite';
               activeStep = activeStep + 1;
             });
           },
         ),
            const Divider(),
            ListTile(
              title: const Text('Offsite'),
              subtitle: const Text('Task can be done remotely by freelancer'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: (){

                setState(() {
                  name = 'Offsite';
                  activeStep = activeStep + 1;
                });
              },


            ),



          ],

        );



    }


  }
}