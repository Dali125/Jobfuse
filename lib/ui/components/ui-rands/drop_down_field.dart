import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import '../../colors/colors.dart';


class DropTextField extends StatefulWidget {
  final controller;
  const DropTextField({Key? key, this.controller}) : super(key: key);

  @override
  State<DropTextField> createState() => _DropTextFieldState();
}

class _DropTextFieldState extends State<DropTextField> {

  @override
  void initState(){
    super.initState();


  }


  var values = <DropDownValueModel>[

    const DropDownValueModel(name: 'Easy', value: 0),
    const DropDownValueModel(name: 'Intermediate', value: 1),
    const DropDownValueModel(name: 'Expert', value: 2),

  ];


  @override
  Widget build(BuildContext context) {
    return

      Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: DropDownTextField(
          dropDownList: values,
        clearOption: true,
          dropdownColor: AppColors.logColor,
          dropDownItemCount: 3,
          controller: widget.controller,
          textFieldDecoration: InputDecoration(
            hintText: 'Select Level',
                enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(

          color: Colors.white),
        ), focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[500])



          ),
        ),
      );
  }
}
