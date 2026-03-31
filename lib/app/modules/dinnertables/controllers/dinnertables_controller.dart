import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/models/dinner_table.dart';
import 'package:sora_manager/app/data/models/dish.dart';
import 'package:sora_manager/app/data/models/dish_on_table.dart';

class DinnertablesController extends GetxController {
  String newName = 'Bàn 1';
  int newCapacity = 5;
  String newTableStatus = 'Trống', choosedDishID = "";
  List<String> listType = [];
  bool isProcessing = false;
  bool isPrRR = false;
  List<DishOnTableModel> listDish = [];

  Rx<String> _searchDishName = ''.obs;
  String get searchDishName => _searchDishName.value;
  set searchDishName(value) => _searchDishName.value = value;

  Rx<int> _numOfDishOnTable = 0.obs;
  int get numOfDishOnTable => _numOfDishOnTable.value;
  set numOfDishOnTable(value) => _numOfDishOnTable.value = value;

  Rx<String> _searchTableName = ''.obs;
  String get searchTableName => _searchTableName.value;
  set searchTableName(value) => _searchTableName.value = value;

  Rx<DinnerTableModel> _currentTable = new DinnerTableModel().obs;
  DinnerTableModel get currentTable => _currentTable.value;
  set currentTable(value) => _currentTable.value = value;

  Rx<bool> _isLoadText = false.obs;
  bool get isLoadText => _isLoadText.value;
  set isLoadText(value) => _isLoadText.value = value;

  Rx<bool> _isBooked = false.obs;
  bool get isBooked => _isBooked.value;
  set isBooked(value) => _isBooked.value = value;

  Rx<bool> _isShowBottomSheet = false.obs;
  bool get isShowBottomSheet => _isShowBottomSheet.value;
  set isShowBottomSheet(value) => _isShowBottomSheet.value = value;

  RxBool _isLoadCurrentTable = true.obs;
  bool get isLoadCurrentTable => _isLoadCurrentTable.value;
  set isLoadCurrentTable(value) => _isLoadCurrentTable.value = value;

  RxBool _isNullTable = true.obs;
  bool get isNullTable => _isNullTable.value;
  set isNullTable(value) => _isNullTable.value = value;

  Rx<double> _newGuestNum = 0.0.obs;
  double get newGuestNum => _newGuestNum.value;
  set newGuestNum(value) => _newGuestNum.value = value;

  Rx<int> _currentTableTotalPice = 0.obs;
  int get currentTableTotalPice => _currentTableTotalPice.value;
  set currentTableTotalPice(value) => _currentTableTotalPice.value = value;

  Rx<int> _chooseIndex = 0.obs;
  int get chooseIndex => _chooseIndex.value;
  set chooseIndex(value) => _chooseIndex.value = value;

  Rx<String> _typeOfDish = 'Tất cả'.obs;
  String get typeOfDish => _typeOfDish.value;
  set typeOfDish(value) => _typeOfDish.value = value;

  Rx<String> _currentTableStatus = 'Trống'.obs;
  String get currentTableStatus => _currentTableStatus.value;
  set currentTableStatus(value) => _currentTableStatus.value = value;

  changeIsBooked() {
    isBooked = !isBooked;
    if (isBooked) {
      newTableStatus = 'Đã được đặt';
    } else {
      newTableStatus = 'Trống';
    }
  }

  initType() {
    listType.add('Món nướng');
    listType.add('Món chiên');
    listType.add('Món hấp');
    listType.add('Món khác');
    listType.add('Thức uống');
  }

  Future<Null> getFirstTable() async {
    if (Get.arguments != null) {
      String tableId = Get.arguments;
      var tableDoc = await FirebaseFirestore.instance
          .collection('dinnertables')
          .doc(tableId)
          .get();
      var tableMap = tableDoc.data() as Map<String, dynamic>;
      tableMap['tableid'] = tableDoc.id;
      currentTable = DinnerTableModel.fromJson(tableMap);
      currentTableTotalPice = currentTable.totalPrice;
      currentTableStatus = currentTable.tableStatus!;
      isLoadCurrentTable = false;
      isNullTable = false;
    } else {
      FirebaseFirestore.instance
          .collection('dinnertables')
          .limit(1)
          .get()
          .then((value) {
        if (value.docs[0].exists) {
          var tableMap = value.docs[0].data() as Map<String, dynamic>;
          tableMap['tableid'] = value.docs[0].id;
          currentTable = DinnerTableModel.fromJson(tableMap);
          currentTableTotalPice = currentTable.totalPrice;
          currentTableStatus = currentTable.tableStatus!;
          isLoadCurrentTable = false;
          isNullTable = false;
        }
      }).catchError((e) {
        currentTable.tableID = 'thien';
        isLoadCurrentTable = false;
        isNullTable = true;
      });
    }
  }

  Stream<List<DinnerTableModel>> getAllTable(String searchName) async* {
    var dinnerTableStream =
        FirebaseFirestore.instance.collection('dinnertables').snapshots();
    List<DinnerTableModel> dinnertables = [];
    await for (var dinnerTableSnap in dinnerTableStream) {
      dinnertables.clear();
      for (var dinnerTableDoc in dinnerTableSnap.docs) {
        var dinnerTableMap = dinnerTableDoc.data() as Map<String, dynamic>;
        dinnerTableMap['tableid'] = dinnerTableDoc.id;
        var dinnerTable = DinnerTableModel.fromJson(dinnerTableMap);
        // check du lieu

        if (currentTable.tableID != null) {
          if (dinnerTable.tableID!.compareTo(currentTable.tableID!) == 0) {
            newGuestNum = dinnerTable.guestNumber!;
          }
        }
        //kiem tra ten truoc khi add
        String tableNameLower = dinnerTable.tableName!.toLowerCase();
        String searchTableNameLower = searchName.toLowerCase();
        if (tableNameLower.contains(searchTableNameLower)) {
          dinnertables.add(dinnerTable);
        }
      }
      yield dinnertables;
    }
  }

  initValueOfTable() {
    newName = currentTable.tableName!;
    newCapacity = currentTable.capacity!;
    newTableStatus = currentTable.tableStatus!;
    isBooked = currentTable.tableStatus == 'Đã được đặt' ? true : false;
  }

  updateTable() async {
    await FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTable.tableID)
        .update({
      'tablename': newName,
      'tablestatus': newTableStatus,
      'capacity': newCapacity
    }).then((value) {
      DinnerTableModel newTable = new DinnerTableModel();
      newTable.capacity = newCapacity;
      newTable.tableName = newName;
      newTable.tableStatus = newTableStatus;
      newTable.guestNumber = currentTable.guestNumber;
      newTable.paymentStatus = currentTable.paymentStatus;
      newTable.tableID = currentTable.tableID;
      newTable.totalPrice = currentTable.totalPrice;
      currentTable = newTable;
    });
  }

  addDinnerTable() {
    Map<String, dynamic> newTable = {
      'tablename': this.newName,
      'capacity': this.newCapacity,
      'tablestatus': this.newTableStatus,
      'guestnumber': 0,
      'paymentstatus': 'Chưa thanh toán'
    };
    FirebaseFirestore.instance
        .collection('dinnertables')
        .add(newTable)
        .then((value) {
      if (isNullTable) {
        getFirstTable();
      }
    });
  }

  Future<Null> deleteDinnerTable() async {
    await deleteAllDishOnTable();
    FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTable.tableID)
        .delete()
        .then((value) {
      getFirstTable();
    });
  }

  deleteDishOnTable(String dishID) {
    FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTable.tableID)
        .collection('food')
        .doc(dishID)
        .delete();
  }

  Stream<List<DishOnTableModel>> getDish(String currentTableId) async* {
    int totalPrice = 0;
    var dishStream = FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTableId)
        .collection('food')
        .orderBy('timeadd', descending: true)
        .snapshots();

    List<DishOnTableModel> dishontables = [];
    await for (var dishontablesSnapshot in dishStream) {
      dishontables.clear();
      numOfDishOnTable = 0;
      totalPrice = 0;
      for (var dishontableDoc in dishontablesSnapshot.docs) {
        var dishontable = dishontableDoc.data() as Map<String, dynamic>;
        dishontable['id'] = dishontableDoc.id;

        /* Query doctor */
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
        dishontables.add(dishOnTableModel);
        numOfDishOnTable = dishontables.length;
        int price =
            dishOnTableModel.price != null ? dishOnTableModel.price! : 0;
        int amount =
            dishOnTableModel.amount != null ? dishOnTableModel.amount! : 0;
        totalPrice += price * amount;
      }
      updateTotalPriceOfTable(totalPrice);
      listDish = dishontables;
      yield dishontables;
    }
  }

  updateTotalPriceOfTable(int totalPrice) {
    FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTable.tableID)
        .update({'totalprice': totalPrice}).then((value) {
      currentTableTotalPice = totalPrice;
    });
  }

  setTypeOfList(int index) {
    switch (index) {
      case 0:
        typeOfDish = 'Tất cả';
        break;
      case 1:
        typeOfDish = 'Món nướng';
        break;
      case 2:
        typeOfDish = 'Món chiên';
        break;
      case 3:
        typeOfDish = 'Món hấp';
        break;
      case 4:
        typeOfDish = 'Món xào';
        break;
      case 5:
        typeOfDish = 'Món khác';
        break;
      case 6:
        typeOfDish = 'Thức uống';
        break;
      default:
        typeOfDish = 'Tất cả';
    }
  }

  Stream<List<DishModel>> getDishList(String searchName) async* {
    var dishStream = FirebaseFirestore.instance.collection('food').snapshots();
    List<DishModel> dishs = [];
    await for (var dishSnap in dishStream) {
      dishs.clear();
      for (var dishDoc in dishSnap.docs) {
        var dishMap = dishDoc.data() as Map<String, dynamic>;
        dishMap['dishid'] = dishDoc.id;
        dishMap['reference'] = dishDoc.reference;
        var dish = DishModel.fromJson(dishMap);
        String dishNameLower = dish.name!.toLowerCase();
        String searchDishNameLower = searchName.toLowerCase();
        if (dishNameLower.contains(searchDishNameLower)) {
          if (typeOfDish == 'Tất cả') {
            dishs.add(dish);
          } else {
            if (dish.type == typeOfDish) {
              dishs.add(dish);
            }
          }
        }
      }

      yield dishs;
    }
  }

  Future<Null> riseDishMount(String dishOnTableID, int amount) async {
    amount++;
    isPrRR = true;
    await FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTable.tableID)
        .collection('food')
        .doc(dishOnTableID)
        .update({'amount': amount});
    isPrRR = false;
  }

  Future<Null> reduceDishMount(String dishOnTableID, int amount) async {
    if (amount == 1) return;
    amount--;
    isPrRR = true;
    await FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTable.tableID)
        .collection('food')
        .doc(dishOnTableID)
        .update({'amount': amount});
    isPrRR = false;
  }

  Future<Null> changeDishMount(String dishOnTableID, int amount,
      TextEditingController controller) async {
    isLoadText = true;
    if (amount < 1) return;
    isPrRR = true;
    await FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTable.tableID)
        .collection('food')
        .doc(dishOnTableID)
        .update({'amount': amount}).then((value) {
      controller.clear();
    });
    isPrRR = false;
  }

  Future<Null> findDish(DocumentReference dishRef) async {
    isProcessing = true;
    await FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTable.tableID)
        .collection('food')
        .where('dish', isEqualTo: dishRef)
        .get()
        .then((value) {
      if (value.docs[0].exists) {
        var dish = value.docs[0].data() as Map<String, dynamic>;
        int amount = int.parse(dish['amount'].toString());
        increaseDish(value.docs[0].reference, amount);
      }
    }).catchError((onError) {
      addDishToDishList(dishRef);
    });
    isProcessing = false;
  }

  Future<Null> increaseDish(DocumentReference ref, int amount) async {
    amount++;
    await ref.update({'amount': amount});
  }

  Future<Null> addDishToDishList(DocumentReference dishRef) async {
    Timestamp timeAdd = Timestamp.fromDate(DateTime.now());
    Map<String, dynamic> newDishOnTable = {
      'amount': 1,
      'dish': dishRef,
      'timeadd': timeAdd
    };
    await FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTable.tableID)
        .collection('food')
        .add(newDishOnTable)
        .then((value) {});
  }

  Future<Null> updateGuestNum(int guestNum) async {
    FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTable.tableID)
        .update({'guestnumber': guestNum});
  }

  Future<Null> updateTableStatus(int guestNum) async {
    String temp = '';
    if (guestNum != 0) {
      temp = 'Đang sử dụng';
    } else {
      temp = 'Trống';
    }
    FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTable.tableID)
        .update({'tablestatus': temp}).then((value) {
      currentTableStatus = temp;
      currentTable.tableStatus = temp;
    });
  }

  Future<Null> deleteAllDishOnTable() async {
    FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTable.tableID)
        .collection('food')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  Future<Null> payForTable() async {
    print('Có gọi hàm');
    await FirebaseFirestore.instance
        .collection('dinnertables')
        .doc(currentTable.tableID)
        .collection('food')
        .get()
        .then((snapshot) async {
      for (DocumentSnapshot doc in snapshot.docs) {
        DocumentReference ref = doc['dish'] as DocumentReference;
        DocumentSnapshot dish = await ref.get();
        int soldquantity = dish['soldquantity'];
        int amount = doc['amount'];
        ref.update({'soldquantity': soldquantity + amount});
        doc.reference.delete();
      }
    }).then((value) async {
      updateTableStatus(0);
      await FirebaseFirestore.instance
          .collection('dinnertables')
          .doc(currentTable.tableID)
          .update({'guestnumber': 0, 'totalprice': 0}).then((value) {
        DinnerTableModel newTable = new DinnerTableModel();
        newTable.capacity = currentTable.capacity;
        newTable.tableName = currentTable.tableName;
        newTable.tableStatus = currentTable.tableStatus;
        newTable.guestNumber = 0;
        newTable.paymentStatus = currentTable.paymentStatus;
        newTable.tableID = currentTable.tableID;
        newTable.totalPrice = 0;
        currentTable = newTable;
      });
      currentTableTotalPice = 0;
    });
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
