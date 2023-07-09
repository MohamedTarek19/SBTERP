
import 'package:flutter/material.dart';
import 'package:sbterp/data_layer/custsetups/itstor.dart';

import '../../business_logic/model/itstor_m.dart';

class ItstorVM extends ChangeNotifier{
  List<ItstorM>? items = [];
  ItstorM? lctrsM;
  ItemStoreRepository accountReptra=ItemStoreRepository();

  Future<List<ItstorM>?> GetAllItems()async{
    var res= await accountReptra.GetAllItems();
    items = res;
    notifyListeners();
    return res;
  }
  Future<List<ItstorM>?> GetItemsByStoreId(int StoreId)async{
    var res= await accountReptra.GetItemsByStoreId(StoreId);
    items = res;
    notifyListeners();
    return res;
  }
Future<void> losttSearchBySerial(String mid, int storid)async{

    var res=await accountReptra.losttSearchBySerial(mid);
    lctrsM=res;
    notifyListeners();
  }

  Future<Object> CreateItem(ItstorM ItemM) async {
    var res = await accountReptra.CreateItem(ItemM);
    notifyListeners();
    return res;
  }

  Future<Object> deleteItem(int id) async {
    var res = await accountReptra.deleteItem(id);
    notifyListeners();
    return res;
  }
  Future<Object> EditItem(int id, ItstorM ItemM) async {
    var res = await accountReptra.EditGroup(id,ItemM);
    notifyListeners();
    return res;
  }

}
