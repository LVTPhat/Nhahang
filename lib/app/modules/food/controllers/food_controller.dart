import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:sora_manager/app/data/models/dish.dart';

class FoodController extends GetxController {
  List<String> listType = [];
  // Uint8List image = new Uint8List(0);
  // File? file;
  String? newDishName, newDishType = 'Món khác', newDishUrlImage;
  // int totalOfQuantity = 0, totalOfRevenue = 0, maxQuantity = 0, maxRevenue = 0;
  int? newDishPrice;

  RxBool _isLoadListDish = true.obs;
  bool get isLoadListDish => _isLoadListDish.value;
  set isLoadListDish(value) => _isLoadListDish.value = value;

  RxBool _isNullDish = true.obs;
  bool get isNullDish => _isNullDish.value;
  set isNullDish(value) => _isNullDish.value = value;

  RxBool _isLoadCurrentDish = true.obs;
  bool get isLoadCurrentDish => _isLoadCurrentDish.value;
  set isLoadCurrentDish(value) => _isLoadCurrentDish.value = value;

  Rx<Uint8List> _image = new Uint8List(0).obs;
  Uint8List get image => _image.value;
  set image(value) => _image.value = value;

  Rx<int> _totalOfQuantity = 0.obs;
  int get totalOfQuantity => _totalOfQuantity.value;
  set totalOfQuantity(value) => _totalOfQuantity.value = value;

  Rx<int> _numberOfDish = 2.obs;
  int get numberOfDish => _numberOfDish.value;
  set numberOfDish(value) => _numberOfDish.value = value;

  Rx<int> _totalOfRevenue = 0.obs;
  int get totalOfRevenue => _totalOfRevenue.value;
  set totalOfRevenue(value) => _totalOfRevenue.value = value;

  Rx<int> _chooseIndex = 0.obs;
  int get chooseIndex => _chooseIndex.value;
  set chooseIndex(value) => _chooseIndex.value = value;

  Rx<int> _maxQuantity = 0.obs;
  int get maxQuantity => _maxQuantity.value;
  set maxQuantity(value) => _maxQuantity.value = value;

  Rx<int> _maxRevenue = 0.obs;
  int get maxRevenue => _maxRevenue.value;
  set maxRevenue(value) => _maxRevenue.value = value;

  Rx<String> _typeOfDish = 'Tất cả'.obs;
  String get typeOfDish => _typeOfDish.value;
  set typeOfDish(value) => _typeOfDish.value = value;

  Rx<String> _nameOfMaxRevenue = 'Tất cả'.obs;
  String get nameOfMaxRevenue => _nameOfMaxRevenue.value;
  set nameOfMaxRevenue(value) => _nameOfMaxRevenue.value = value;

  Rx<DishModel> _currentDish = new DishModel().obs;
  DishModel get currentDish => _currentDish.value;
  set currentDish(value) => _currentDish.value = value;

  late Rx<File> _file = new File('thien').obs;
  File get file => _file.value;
  set file(value) => _file.value = value;

  Rx<String> _nameOfMaxQuantity = 'Tất cả'.obs;
  String get nameOfMaxQuantity => _nameOfMaxQuantity.value;
  set nameOfMaxQuantity(value) => _nameOfMaxQuantity.value = value;

  RxString _hint = 'Món khác'.obs;
  String get hint => _hint.value;
  set hint(value) => _hint.value = value;

  Rx<String> _searchDishName = ''.obs;
  String get searchDishName => _searchDishName.value;
  set searchDishName(value) => _searchDishName.value = value;

  Stream<List<DishModel>> getDish(String searchName) async* {
    var dishStream = FirebaseFirestore.instance.collection('food').snapshots();
    List<DishModel> dishs = [];
    await for (var dishSnap in dishStream) {
      maxQuantity = 0;
      maxRevenue = 0;
      totalOfQuantity = 0;
      totalOfRevenue = 0;
      numberOfDish = 0;
      dishs.clear();
      isLoadListDish = true;
      for (var dishDoc in dishSnap.docs) {
        var dishMap = dishDoc.data() as Map<String, dynamic>;
        dishMap['dishid'] = dishDoc.id;
        var dish = DishModel.fromJson(dishMap);
        if (dish.soldQuantity! > maxQuantity) {
          maxQuantity = dish.soldQuantity!;
          nameOfMaxQuantity = dish.name;
        }
        if (dish.soldQuantity! * dish.price! > maxRevenue) {
          maxRevenue = dish.soldQuantity! * dish.price!;
          nameOfMaxRevenue = dish.name;
        }
        totalOfQuantity += dish.soldQuantity!;
        totalOfRevenue += dish.soldQuantity! * dish.price!;
        numberOfDish += 1;
        String dishNameLower = dish.name!.toLowerCase();
        String searchDishNameLower = searchName.toLowerCase();
        // xet ten cua mon an
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

      isLoadListDish = false;
      yield dishs;
    }
  }

  resetImage() {
    image = new Uint8List(0);
  }

  initType() {
    listType.clear();
    listType.add('Món nướng');
    listType.add('Món chiên');
    listType.add('Món hấp');
    listType.add('Món xào');
    listType.add('Món khác');
    listType.add('Thức uống');
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

  Future<bool> checkIsOder(String dishId) async {
    var tableSnap =
        await FirebaseFirestore.instance.collection('dinnertables').get();
    for (var tableDoc in tableSnap.docs) {
      var foodSnap = await tableDoc.reference.collection('food').get();
      for (var dishDoc in foodSnap.docs) {
        var dishMap = dishDoc.data() as Map<String, dynamic>;
        DocumentReference dishRef = dishMap['dish'];
        String id = dishRef.id;
        if (id.compareTo(dishId) == 0) return true;
      }
    }
    return false;
  }

  Future uploadImage(bool isAdd) async {
    String nameImage = DateTime.now().millisecondsSinceEpoch.toString();

    Reference _reference =
        FirebaseStorage.instance.ref().child('imageofdishs/$nameImage');
    await _reference
        .putData(
      image,
      SettableMetadata(contentType: 'image/jpeg'),
    )
        .whenComplete(() async {
      await _reference.getDownloadURL().then((value) {
        newDishUrlImage = value;
        if (isAdd) {
          addDish();
          if (isNullDish) {
            getFirstDish();
          }
        }
      });
    });
    image = new Uint8List(0);
  }

  Future pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result?.files.first != null) {
      image = result!.files.first.bytes!;
    } else {
      throw "Cancelled File Picker";
    }
  }

  addDish() {
    Map<String, dynamic> newDish = {
      'name': this.newDishName,
      'price': this.newDishPrice,
      'type': this.newDishType,
      'urlofimage': this.newDishUrlImage,
      'soldquantity': 0
    };
    FirebaseFirestore.instance.collection('food').add(newDish);
  }

  deleteDishImage(String url) {
    FirebaseStorage.instance.refFromURL(url).delete().then((value) {});
  }

  Future<Null> deleteDish() async {
    if (currentDish.urlOfImage != null) {
      deleteDishImage(currentDish.urlOfImage!);
    }

    FirebaseFirestore.instance
        .collection('food')
        .doc(currentDish.dishID)
        .delete()
        .then((value) {
      getFirstDish();
    });
  }

  getFirstDish() {
    FirebaseFirestore.instance.collection('food').limit(1).get().then((value) {
      if (value.docs[0].exists) {
        var dishMap = value.docs[0].data() as Map<String, dynamic>;
        dishMap['dishid'] = value.docs[0].id;
        currentDish = DishModel.fromJson(dishMap);
        isLoadCurrentDish = false;
        isNullDish = false;
      }
    }).catchError((error) {
      isLoadCurrentDish = false;
      isNullDish = true;
    });
  }

  initValue() {
    newDishPrice = currentDish.price;
    newDishType = currentDish.type;
    newDishName = currentDish.name;
    hint = currentDish.type;
    newDishUrlImage = currentDish.urlOfImage;
  }

  updateDish() async {
    if (image.length != 0) {
      if (currentDish.urlOfImage != null)
        await deleteDishImage(currentDish.urlOfImage!);
      await uploadImage(false);
    }
    await FirebaseFirestore.instance
        .collection('food')
        .doc(currentDish.dishID)
        .update({
      'name': this.newDishName,
      'type': this.newDishType,
      'price': this.newDishPrice,
      'urlofimage': this.newDishUrlImage
    }).then((value) {
      DishModel newDish = new DishModel();
      newDish.price = newDishPrice;
      newDish.name = newDishName;
      newDish.type = newDishType;
      newDish.urlOfImage = newDishUrlImage;
      newDish.dishID = currentDish.dishID;
      newDish.soldQuantity = currentDish.soldQuantity;
      currentDish = newDish;
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
