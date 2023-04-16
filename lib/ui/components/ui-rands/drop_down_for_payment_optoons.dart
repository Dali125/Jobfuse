import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';


class DropTextFieldForPayment extends StatefulWidget {
  final controller;
  const DropTextFieldForPayment({Key? key, this.controller}) : super(key: key);

  @override
  State<DropTextFieldForPayment> createState() => _DropTextFieldForPaymentState();
}

class _DropTextFieldForPaymentState extends State<DropTextFieldForPayment> {

  @override
  void initState(){
    super.initState();


  }


  var values = <DropDownValueModel>[

    const DropDownValueModel(name: 'Debit Card', value: 0),
    const DropDownValueModel(name: 'Mobile Money', value: 1),
    const DropDownValueModel(name: 'PayPal', value: 2),
    const DropDownValueModel(name: 'RazorPay', value: 3),
    const DropDownValueModel(name: 'MTN Money', value: 4),
    const DropDownValueModel(name: 'Airtel Money ', value: 5),


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
              hintText: 'Select Payment method',
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
