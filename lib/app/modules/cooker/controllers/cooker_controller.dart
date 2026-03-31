import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/helper/datetime_helpers.dart';
import 'package:sora_manager/app/data/models/dinner_table.dart';
import 'package:sora_manager/app/data/models/dish_on_table.dart';
import 'package:sora_manager/app/data/services/auth.dart';
import 'package:sora_manager/app/routes/app_pages.dart';

class CookerController extends GetxController {
  AuthMethods authMethods = new AuthMethods();
  int done = 0, amount = 0;
  String nameTable = '', nameDish = '';
  Rx<bool> _isHaveDish = false.obs;
  bool get isHaveDish => _isHaveDish.value;
  set isHaveDish(value) => _isHaveDish.value = value;

  Rx<bool> _isLoadCurrentDish = true.obs;
  bool get isLoadCurrentDish => _isLoadCurrentDish.value;
  set isLoadCurrentDish(value) => _isLoadCurrentDish.value = value;

  Rx<String> _currentTableId = 'J1XyY5dFLOxnzmLs3P1Y'.obs;
  String get currentTableId => _currentTableId.value;
  set currentTableId(value) => _currentTableId.value = value;

  Rx<String> _currentDishId = 'UOqvJxvhPRU8heiTlsAY'.obs;
  String get currentDishId => _currentDishId.value;
  set currentDishId(value) => _currentDishId.value = value;

  Stream<List<DishOnTableModel>> getDish() async* {
    List<DishOnTableModel> dishontables = [];
    var tableStream =
        FirebaseFirestore.instance.collection('dinnertables').snapshots();
    await for (var tableSnapshot in tableStream) {
      isHaveDish = false;
      isLoadCurrentDish = true;
      dishontables.clear();
      for (var tableDoc in tableSnapshot.docs) {
        var tableMap = tableDoc.data() as Map<String, dynamic>;
        String tableName = tableMap['tablename'];
        var dishontablesSnapshot =
            await tableDoc.reference.collection('food').get();
        for (var dishontableDoc in dishontablesSnapshot.docs) {
          var dishontable = dishontableDoc.data() as Map<String, dynamic>;
          dishontable['id'] = dishontableDoc.id;
          dishontable['tableid'] = tableDoc.id;
          dishontable['tablename'] = tableName;
          if (dishontable.containsKey('done')) {
            // khong lam gi
          } else {
            dishontable['done'] = 0;
          }
          if (dishontable.containsKey('dish')) {
            DocumentSnapshot dishRef = await dishontable['dish'].get();
            if (dishRef.exists) {
              final dishJson = dishRef.data() as Map<String, dynamic>;
              dishontable['name'] = dishJson['name'];
              dishontable['price'] = dishJson['price'];
              dishontable['type'] = dishJson['type'];
              dishontable['urlofimage'] = dishJson['urlofimage'];
            }
          }
          DishOnTableModel dishOnTableModel =
              DishOnTableModel.fromJson(dishontable);

          if (dishOnTableModel.done! < dishOnTableModel.amount! &&
              dishOnTableModel.type!.compareTo('Thức uống') != 0) {
            dishontables.add(dishOnTableModel);
            if (!isHaveDish) {
              isHaveDish = true;
              isLoadCurrentDish = false;
              currentTableId = dishOnTableModel.tableId;
              currentDishId = dishOnTableModel.id;
              amount = dishOnTableModel.amount!;
              done = dishOnTableModel.done!;
              nameDish = dishOnTableModel.name!;
              nameTable = dishOnTableModel.tableName!;
            }
          }
        }
      }
      isLoadCurrentDish = false;
      yield dishontables;
    }
  }

// bat dau quan sat ban an

  Stream<DinnerTableModel> getTable(String tableId) async* {
    var dinnerTableStream = FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(tableId)
        .snapshots();
    try {
      await for (var dinnerTableSnap in dinnerTableStream) {
        var tableMap = dinnerTableSnap.data() as Map<String, dynamic>;
        DinnerTableModel dinnerTable = DinnerTableModel.fromJson(tableMap);
        // table = dinnerTable;
        //  newGuestNum = dinnerTable.guestNumber!.toDouble();
        yield dinnerTable;
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<DishOnTableModel> getCurrentDish(
      String tableId, String dishId) async* {
    var dishOnTableStream = FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(tableId)
        .collection('food')
        .doc(dishId)
        .snapshots();
    await for (var dishSnap in dishOnTableStream) {
      var dishontable = dishSnap.data() as Map<String, dynamic>;
      dishontable['id'] = dishSnap.id;
      dishontable['tableid'] = tableId;
      if (dishontable.containsKey('done')) {
        // khong lam gi
      } else {
        dishontable['done'] = 0;
      }
      if (dishontable.containsKey('dish')) {
        DocumentSnapshot dishRef = await dishontable['dish'].get();
        if (dishRef.exists) {
          final dishJson = dishRef.data() as Map<String, dynamic>;
          dishontable['name'] = dishJson['name'];
          dishontable['price'] = dishJson['price'];
          dishontable['type'] = dishJson['type'];
          dishontable['urlofimage'] = dishJson['urlofimage'];
        }
      }
      DishOnTableModel dishOnTableModel =
          DishOnTableModel.fromJson(dishontable);
      yield dishOnTableModel;
    }
  }

  Future<Null> doneOneDish(String tableId, String dishId) async {
    done++;
    if (done <= amount) {
      FirebaseFirestore.instance
          .collection('dinnertables')
          .doc(tableId)
          .collection('food')
          .doc(dishId)
          .update({'done': done}).then((value) {
        if (done == amount) {
          refreshTable(tableId);
        }
        String content =
            'Một ' + nameDish + ' của ' + nameTable + ' đã được chế biến xong!';
        pushNotifiCation(content);
      });
    }
  }

//dung thong bao moi lan mon an xong
  Future<Null> pushNotifiCation(String content) async {
    Timestamp time = DateTimeHelpers.dateTimeNowToTimestamp();
    FirebaseFirestore.instance
        .collection('notifications')
        .add({'content': content, 'time': time, 'title': 'Thông báo từ bếp'});
  }

  void signOut() {
    authMethods.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<Null> refreshTable(String tableId) async {
    String refreshCode = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(tableId)
        .update({'refresh': refreshCode});
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
