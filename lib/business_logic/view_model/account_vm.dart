import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/account_m.dart';
 import 'package:sbterp/data_layer/accounts/account.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
class AccountVM extends ChangeNotifier{

String? userDetails;
String? userCash;
String? userStor;
UserM? user;
AccountRep accountRep=AccountRep();
SavedLocalData savedLocalData=SavedLocalData();


void removeLocalData(String key)async{
await savedLocalData.removeKey(key);
userDetails=null;
userCash=null;
userStor=null;
notifyListeners();
}
void LoadUserData()async{
userDetails=await savedLocalData.getUserName();
userCash=await savedLocalData.getcashboxe();
userStor=await savedLocalData.getUserName();
notifyListeners();
}
void keepLogin(String userName,String cashBox, String storId)async{
   await savedLocalData.saveUserLogin(userName,cashBox,storId);

   userDetails=await savedLocalData.getUserName();
   userCash=await savedLocalData.getcashboxe();
   userStor=await savedLocalData.getstor();
   notifyListeners();

}

Future<dynamic> CreateAccount(UserM userM)async{



var result= await accountRep.CreateAccount(userM);
return result;
}
Future<UserM?> login(String userName)async{

var result= await accountRep.login(userName);
user = result;
return result;
}




} 
