import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';


class DropTextFieldForHours extends StatefulWidget {
  final controller;
  const DropTextFieldForHours({Key? key, this.controller}) : super(key: key);

  @override
  State<DropTextFieldForHours> createState() => _DropTextFieldForHoursState();
}

class _DropTextFieldForHoursState extends State<DropTextFieldForHours> {

  @override
  void initState(){
    super.initState();


  }


  var values = <DropDownValueModel>[

    const DropDownValueModel(name: 'Less than 12 hours', value: 0),
    const DropDownValueModel(name: 'Less than 24 hours', value: 1),
    const DropDownValueModel(name: 'Less than a week', value: 2),
    const DropDownValueModel(name: 'Less than 3 months', value: 3),
    const DropDownValueModel(name: 'Less than 6 months', value: 4),
    const DropDownValueModel(name: 'more than 6 months ', value: 5),


  ];


  @override
  Widget build(BuildContext context) {
    return

      Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: DropDownTextField(
          dropDownList: values,
          clearOption: true,
          dropDownItemCount: 6,
          dropdownColor: AppColors.logColor,
          controller: widget.controller,
          textFieldDecoration: InputDecoration(
              hintText: 'Select Duration',
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
