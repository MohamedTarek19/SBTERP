 
import 'package:shared_preferences/shared_preferences.dart';
class SavedLocalData{

    var sharedPreferences= SharedPreferences.getInstance();
 Future<void> removeKey(String key)async{
var pref=await sharedPreferences;

await pref.remove(key);


}
 Future<void> saveUserLogin(String userName, String cashBox,String storId)async{
var pref=await sharedPreferences;

await pref.setString("userName", userName);
await pref.setString("cashBox", cashBox);
await pref.setString("storId", storId);


}
Future<String?> getUserName()async{
 var pref=await sharedPreferences;

var data= pref.getString("userName");

return  data;

}
 Future<String?> getcashboxe()async{
     var pref=await sharedPreferences;

     var data= pref.getString("cashBox");

     return  data;

    }
    Future<String?> getstor()async{
      var pref=await sharedPreferences;

      var data= pref.getString("storId");

      return  data;

    }
 Future<void> setTipsViewed(bool isVisited)async{
var pref=await sharedPreferences;

await pref.setBool("tips", isVisited);


}
Future<bool?> getIsTipsViewd()async{
 var pref=await sharedPreferences;

var data= pref.getBool("tips");
return  data;
 
}


}