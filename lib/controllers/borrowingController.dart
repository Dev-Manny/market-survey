import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey/controllers/controllers.dart';
import 'package:survey/models/borrowing.dart';
import 'package:survey/routes/routes.dart';
import 'package:survey/service/services.dart';

class BorrowingController extends GetxController {
  AuthController _auth = AuthController();
  BorrowingService _borrowingService = BorrowingService();
  final customerType = 'Borrowing';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController surnameController,
      otherNamesController,
      customerTypeController,
      bvnController,
      otherNumberController,
      dateOfBirthController,
      addressController,
      alternativeSurnameController,
      alternativeOtherNameController,
      alternativePhoneController,
      alternativeSecondPhoneController,
      phoneTypeController,
      deviceSerialController,
      serviceCenterController,
      sellingDSRController,
      dsrNameController,
      responderLocationController;

  RxBool isCustomerType = false.obs;

  RxString customerTypeHintText = ''.obs;
  RxString selectedCustomerIDImagePath = ''.obs;
  RxString selectedCustomerIDImageSize = ''.obs;
  RxString selectedCustomerPhotoImagePath = ''.obs;
  RxString selectedCustomerPhotoImageSize = ''.obs;

  RxString surname = ''.obs;
  RxString otherNames = ''.obs;
  RxString customerTypeLabel = ''.obs;
  RxString customerTypeID = ''.obs;
  RxString bvn = ''.obs;
  RxString otherNumber = ''.obs;
  RxString dateOfBirth = ''.obs;
  RxString gender = ''.obs;
  RxString maritalStatus = ''.obs;
  RxString address = ''.obs;
  RxString alternativeSurname = ''.obs;
  RxString alternativeOtherName = ''.obs;
  RxString alternativePhone = ''.obs;
  RxString alternativeSecondPhone = ''.obs;
  RxString alternativeContactRelationship = ''.obs;
  RxString phoneType = ''.obs;
  RxString serviceCenter = ''.obs;
  RxString paymentPlan = ''.obs;
  RxString deviceSerial = ''.obs;
  RxString sellingDSR = ''.obs;
  RxString dsrName = ''.obs;
  RxString responserLocation = ''.obs;

  RxnString surnameErrorText = RxnString(null);
  RxnString otherNamesErrorText = RxnString(null);
  RxnString customerTypeErrorText = RxnString(null);
  RxnString customerTypeIDErrorText = RxnString(null);
  RxnString bvnErrorText = RxnString(null);
  RxnString otherNumberErrorText = RxnString(null);
  RxnString addressErrorText = RxnString(null);
  RxnString alternativeSurnameErrorText = RxnString(null);
  RxnString alternativeOtherNameErrorText = RxnString(null);
  RxnString alternativePhoneErrorText = RxnString(null);
  RxnString alternativeSecondPhoneErrorText = RxnString(null);
  RxnString phoneTypeErrorText = RxnString(null);
  RxnString serviceCenterErrorText = RxnString(null);
  RxnString paymentPlanErrorText = RxnString(null);
  RxnString deviceSerialErrorText = RxnString(null);
  RxnString sellingDSRErrorText = RxnString(null);
  RxnString dsrNameErrorText = RxnString(null);
  RxnString responserLocationErrorText = RxnString(null);
  // Rxn<Function> submitFunc = Rxn<Function>(null);

  RxBool surnameValidation = false.obs;

  @override
  void onInit() async {
    super.onInit();
    surnameController = TextEditingController();
    otherNamesController = TextEditingController();
    customerTypeController = TextEditingController();
    bvnController = TextEditingController();
    otherNumberController = TextEditingController();
    dateOfBirthController = TextEditingController();
    addressController = TextEditingController();
    alternativeSurnameController = TextEditingController();
    alternativeOtherNameController = TextEditingController();
    alternativePhoneController = TextEditingController();
    alternativeSecondPhoneController = TextEditingController();
    phoneTypeController = TextEditingController();
    deviceSerialController = TextEditingController();
    serviceCenterController = TextEditingController();
    sellingDSRController = TextEditingController();
    dsrNameController = TextEditingController();
    responderLocationController = TextEditingController();
  }

  String? validateGender(String value) {
    if (value.isEmpty) {
      return "Gender is required";
    }
    return null;
  }

  String? validateDateOfBirth(String value) {
    if (value.isEmpty) {
      return "Date of birth is required";
    }
    return null;
  }

  String? validateBVN(String value) {
    if (value.isNotEmpty && (value.length != 10)) {
      return "Wrong BVN number";
    }
    return null;
  }

  String? validatecustomerTypeID(String value) {
    if (value.isEmpty) {
      return "ID number is required";
    }
    return null;
  }

  String? validatecustomerTypeLabel(String value) {
    if (value.isEmpty) {
      return "Select a customer ID type";
    }
    return null;
  }

  String? validateSurname(String value) {
    print(value);
    if (value.isEmpty) {
      return "Surname is requried";
    }
    print('here');
    return null;
  }

  String? validateotherNames(String value) {
    if (value.isEmpty) {
      return "Other names are required";
    }
    return null;
  }

  void getCustomerPhotoImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      selectedCustomerPhotoImagePath.value = pickedFile.path;
      selectedCustomerPhotoImageSize.value =
          ((File(selectedCustomerPhotoImagePath.value)).lengthSync() /
                      1024 /
                      1024)
                  .toStringAsFixed(2) +
              " Mb";
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void getCustomerIDImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      selectedCustomerIDImagePath.value = pickedFile.path;
      selectedCustomerIDImageSize.value =
          ((File(selectedCustomerIDImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void surnameChanged(String val) => surname.value = val;
  void otherNamesChanged(String val) => otherNames.value = val;
  void customerTypeChanged(bool val) => isCustomerType.value = val;
  void customerTypeIDChanged(String val) => customerTypeID.value = val;
  void bvnChanged(String val) => bvn.value = val;
  void otherNumberChanged(String val) => otherNumber.value = val;
  void dateOfBirthChanged(String val) => dateOfBirth.value = val;
  void genderChanged(String val) => gender.value = val;
  void maritalStatusChanged(String val) => maritalStatus.value = val;
  void addressChanged(String val) => address.value = val;
  void alternativeSurnameChanged(String val) => alternativeSurname.value = val;
  void alternativeOtherNameChanged(String val) =>
      alternativeOtherName.value = val;
  void alternativePhoneChanged(String val) => alternativePhone.value = val;
  void alternativeSecondPhoneChanged(String val) =>
      alternativeSecondPhone.value = val;
  void alternativeContactRelationshipChanged(String val) =>
      alternativeContactRelationship.value = val;
  void phoneTypeChanged(String val) => phoneType.value = val;
  void serviceCenterChanged(String val) => serviceCenter.value = val;
  void paymentPlanChanged(String val) => paymentPlan.value = val;
  void deviceSerialChanged(String val) => deviceSerial.value = val;
  void sellingDSRChanged(String val) => sellingDSR.value = val;
  void dsrNameChanged(String val) => dsrName.value = val;
  void responserLocationChanged(String val) => responserLocation.value = val;

  void customerTypeLabelChanged(String val) => customerTypeLabel.value = val;
  void customerTypeHintTextChanged(String val) =>
      customerTypeHintText.value = val;

  submitFunction() async {
    if (surnameValidation.value) {
      try {
        BorrowingModel data = BorrowingModel(
            uid: _auth.getUser.uid,
            surname: surname.value,
            otherNames: otherNames.value,
            customerTypeLabel: customerTypeLabel.value,
            customerTypeID: customerTypeID.value,
            customerType: customerType,
            bvn: bvn.value,
            otherNumber: otherNumber.value,
            dateOfBirth: dateOfBirth.value,
            gender: gender.value,
            maritalStatus: maritalStatus.value,
            address: address.value,
            alternativeSurname: alternativeSurname.value,
            alternativeOtherName: alternativeOtherName.value,
            alternativePhone: alternativePhone.value,
            alternativeSecondPhone: alternativeSecondPhone.value,
            alternativeContactRelationship:
                alternativeContactRelationship.value,
            phoneType: phoneType.value,
            deviceSerial: deviceSerial.value,
            serviceCenter: serviceCenter.value,
            paymentPlan: paymentPlan.value,
            sellingDSR: sellingDSR.value,
            dsrName: dsrName.value,
            responserLocation: responserLocation.value);
        if (await _borrowingService.createSurvery(data)) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('Entry submitted!');
          update();
        }
        EasyLoading.dismiss();
      } catch (error) {
        EasyLoading.dismiss();
        Get.snackbar("Could not save", error.toString(),
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 7),
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }
    } else {}
  }

  void checkFormValidation() async {
    try {
      EasyLoading.show(status: 'loading...');
      final isValid = formKey.currentState!.validate();

      if (!isValid) {
        EasyLoading.showError('Fill in required fields');
        return;
      }
      formKey.currentState!.save();

      BorrowingModel data = BorrowingModel(
          uid: _auth.getUser.uid,
          surname: surname.value,
          otherNames: otherNames.value,
          customerTypeLabel: customerTypeLabel.value,
          customerTypeID: customerTypeID.value,
          customerType: customerType,
          bvn: bvn.value,
          otherNumber: otherNumber.value,
          dateOfBirth: dateOfBirth.value,
          gender: gender.value,
          maritalStatus: maritalStatus.value,
          address: address.value,
          alternativeSurname: alternativeSurname.value,
          alternativeOtherName: alternativeOtherName.value,
          alternativePhone: alternativePhone.value,
          alternativeSecondPhone: alternativeSecondPhone.value,
          alternativeContactRelationship: alternativeContactRelationship.value,
          phoneType: phoneType.value,
          deviceSerial: deviceSerial.value,
          serviceCenter: serviceCenter.value,
          paymentPlan: paymentPlan.value,
          sellingDSR: sellingDSR.value,
          dsrName: dsrName.value,
          responserLocation: responserLocation.value);
      if (await _borrowingService.createSurvery(data)) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Entry submitted!');

        Get.offAllNamed(Routes.DASHBOARD);
        update();
      }
      EasyLoading.dismiss();
    } catch (error) {
      EasyLoading.dismiss();
      Get.snackbar("Could not save", error.toString(),
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 7),
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    surnameController.dispose();
    otherNamesController.dispose();
    customerTypeController.dispose();
    bvnController.dispose();
    otherNumberController.dispose();
    dateOfBirthController.dispose();
    addressController.dispose();
    alternativeSurnameController.dispose();
    alternativeOtherNameController.dispose();
    alternativePhoneController.dispose();
    alternativeSecondPhoneController.dispose();
    phoneTypeController.dispose();
    deviceSerialController.dispose();
    serviceCenterController.dispose();
    sellingDSRController.dispose();
    dsrNameController.dispose();
    responderLocationController.dispose();
    super.onClose();
  }
}