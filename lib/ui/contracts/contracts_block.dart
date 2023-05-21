import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/constant_widget/top_bar.dart';

import '../colors/colors.dart';

class ExpandedContract extends StatefulWidget {
  const ExpandedContract({Key? key, required this.contractInfo,
    required this.currentUser,
    required this.otherUser,
    required this.status,
    required this.begindate,
    required this.experienceLevel,
    required this.contractDuration,
    required this.Budget,
    required this.projectOwnerName}) : super(key: key);

  //The info about the contract
  final contractInfo;
  final String currentUser;
  final String otherUser;
  final String status;
  final String begindate;
  final String experienceLevel;
  final String contractDuration;
  final int Budget;
  final String projectOwnerName;

  @override
  State<ExpandedContract> createState() => _ExpandedContractState();
}

class _ExpandedContractState extends State<ExpandedContract> {

  @override
  Widget build(BuildContext context) {
    //The Height of the device
    double height = MediaQuery.of(context).size.height;


    return Scaffold(


        body: CustomScrollView(

          slivers: [

//The sliver appbar,for the title of the component
            SliverAppBar(
              expandedHeight: 120,
              backgroundColor: AppColors.logColor,
              flexibleSpace: const Center(

                child: Text(
                  'Contract Details',
                  style: TextStyle(

                    fontSize: 30
                  ),
                ),
              ),
            ),

            //The contract details go here
            SliverToBoxAdapter(



              child: StreamBuilder(

                stream: FirebaseFirestore.instance.collection('users').
                  where('Userid', isEqualTo: widget.otherUser).snapshots(),
                builder: (context, snapshot) {

                  if(snapshot.hasData) {
                    return Container(
                      height: height,


                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var username = snapshot.data!.docs[index];

                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(15),
                                elevation: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4
                                      ),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [

                                        Text(
                                          '  This Freelance Service Contract is made and entered into as of ${widget
                                              .begindate} by and between ${widget.projectOwnerName.toString()},'
                                              ' with NRC NUMBER [Freelancer Address], and ${username['First_name']} ${username['Last_name']},'
                                              ' with NRC NUMBER ${username['NRC_NUMBER']}.\n',

                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          '1). Scope of Services\n'
                                              '     Freelancer agrees to provide the following services  to Client:\n'
                                              '   -  ${widget.contractInfo}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),

                                        Text(
                                          '2). Payment\n'
                                              '     Client agrees to pay Freelancer the following compensation for the Services:\n'
                                              '    - K ${widget.Budget
                                              .toString()}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          '3). Term\n'
                                              '     This Agreement shall begin on the Effective Date'
                                              'and shall continue until the Services have been completed, unless otherwise terminated by either Party.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          '4). Termination\n'
                                              '    Either Party may terminate this Agreement at any time upon written notice to the other Party.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),),
                                        const SizedBox(
                                          height: 30,
                                        ),


                                        const Text(
                                          '5). Confidentiality\n'
                                              '     Freelancer agrees to keep all Client information confidential and not to disclose any information to any third party.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          '6). Ownership of Work Product\n'
                                              '      Freelancer agrees that all work product produced for Client under this Agreement is the property of Client.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),

                                        const Text(
                                          '7). Independent Contractor\n'
                                              '      Freelancer is an independent contractor and not an employee of Client. Freelancer is responsible for all taxes '
                                              'and other obligations arising from its status as an independent contractor.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          '8). Indemnification\n'
                                              ' Freelancer agrees to indemnify and hold harmless Client from any and all claims, damages, and expenses arising from Freelancer\'s breach of this Agreement.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          '9). Governing Law\n'
                                              'This Agreement shall be governed by and construed in accordance with the laws of Zambia.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),

                                        const Text(
                                          '10). Entire Agreement'
                                              '    This Agreement constitutes the entire agreement '
                                              'between the Parties with respect to the subject matter hereof and supersedes all prior negotiations, understandings, and agreements between the Parties.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),

                                        const Text(
                                          '11). Amendments\n'
                                              'This Agreement may not be amended except in writing signed by both Parties.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),

                                        const Text(
                                          'IN WITNESS WHEREOF, the Parties have executed this Agreement as of the Effective Date.'
                                          ,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          'Freelancer:\n'
                                              '[Freelancer Name]',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Text(
                                          'Client:\n'
                                              '${username['First_name']} ${username['Last_name']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 80,
                                        ),


                                      ],
                                    ),
                                  ),
                                )
                                ,
                              )
                              ,
                            );
                          }
                      ),
                    );
                  }else{

                    return const Center(child: CircularProgressIndicator(),);
                  }
                }
              ),
            )

          ],
        )
,floatingActionButton:
    //The Custom Floating Button
    InkWell(
      splashColor: Colors.white,
      onTap: (){


        print('Print Contract');
      },
      child: Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 3,

          )
        ),
              height: 80,
              width: 160,
              child: Center(
                child: Text(
                  'Print Contract'
                      ,style: TextStyle(
                  color: Colors.white
                ),
                ),
              ),
            ),
  ),
),
    ),



    );
  }

}
