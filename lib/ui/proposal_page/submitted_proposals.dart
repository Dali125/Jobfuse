import 'package:flutter/material.dart';

class SubmittedProposals extends StatefulWidget {
  const SubmittedProposals({Key? key}) : super(key: key);

  @override
  State<SubmittedProposals> createState() => _SubmittedProposalsState();
}

class _SubmittedProposalsState extends State<SubmittedProposals> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      color: Colors.green,



    );
  }
}
