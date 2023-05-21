import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/proposal_page/recieved_proposal.dart';
import 'package:jobfuse/ui/proposal_page/submitted_proposals.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../colors/colors.dart';
import '../drawer/my_drawer.dart';




class Proposals extends StatefulWidget {
  const Proposals({Key? key}) : super(key: key);

  @override
  State<Proposals> createState() => _ProposalsState();
}

class _ProposalsState extends State<Proposals> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: ScaffoldGradientBackground(


        gradient: LinearGradient(
          tileMode: TileMode.repeated,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.logColor,
              Colors.white70,
            ]),

        appBar: AppBar(

          backgroundColor: Colors.transparent,
          elevation: 0,

          title: DelayedDisplay(delay: Duration(milliseconds: 200)
              ,child: const Text('Proposals')),
          centerTitle: true,
          bottom: const TabBar(

            tabs: [
              DelayedDisplay(delay: Duration(milliseconds: 200),
                child: Tab(
                  text: 'Received Proposals',),
              ),
              DelayedDisplay(
               delay: Duration(milliseconds: 200), child: Tab(
                  text: 'Submitted Proposals',),
              ),




            ],
          ),

          

        ),
        body: TabBarView(
          children: [

           ReceivedProposal(),

            SubmittedProposals()

          ],
        ),
        drawer: MyDrawer(),

      ),
    );
  }
}
