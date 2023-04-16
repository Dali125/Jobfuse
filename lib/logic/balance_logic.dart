import 'package:cloud_firestore/cloud_firestore.dart';

class MyBalance{
  final String uid;
  final int amount;
  final int apiaccepted;
  
  
  
  
  MyBalance({required this.amount, required this.apiaccepted, required this.uid});
  
  //The function , or go ahead function to increase the wallet balance, if the success code of 200
  //is observed
  //Increased meaning the user has received the amount, or is adding their own
  Future increaseBalance() async{
    
    //Update the balance, but not in the database
    int newAmount = amount + apiaccepted;
    
    try{
      //Query the database for the current user, and then update the balance that is there
       await FirebaseFirestore.instance.collection('wallet').where(
     
        //This is where the matching will take place
        'Userid', isEqualTo: uid).get().then((snapshot) => 
          snapshot.docs.forEach((element) { 
      
             element.reference.update({
            //Map of the data that we want to update
            'balance' : newAmount
      
      
      });
    })
    
    );
  }
  catch (e){
      //
  }
  
  }
  
  //The function , or go ahead function to deduct the wallet balance, if the success code of 200

  //is observed

  //Decreased either  means the user is withdrawing, or sending money
  Future decreaseBalance() async{
    int newAmount = amount - apiaccepted;

    //Try to execute function
    try{
      await FirebaseFirestore.instance.collection('wallet').
      where('Userid', isEqualTo: uid).get().
      then((value) =>

          value.docs.forEach((element) {

            element.reference.update({

              'balance' : newAmount

            });
          }));
      
    }catch(e){

      //

    }
  }
}