import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelancer_system/constants/controller.dart';
import 'package:freelancer_system/services/UserService.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/global.dart';
import '../../../models/User.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  FreeLanceUser user = authController.freelanceUser.value;
  @override
  void initState() {
    super.initState();
    inti(user);
  }

  void inti(FreeLanceUser user) {
    phoneCtl.text = user.phonenumber.toString();
    addrCtl.text = user.address.toString();
    descCtl.text = user.description.toString();
  }

  void update() {
    authController.freelanceUser.value = user.copyWith(
      phonenumber: phoneCtl.text,
      address: addrCtl.text,
      description: descCtl.text,
    );
    UserService().update(
      user.id.toString(),
      authController.freelanceUser.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isEdit = authController.isEditable.value;
      return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: authController.key.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                child: Text(
                  user.displayname.toString(),
                  style: GoogleFonts.kanit(fontSize: 40),
                ),
              ),
              FittedBox(
                child: Text(
                  user.email.toString(),
                  style: GoogleFonts.kanit(fontSize: 30),
                ),
              ),
              FittedBox(
                child: Text(
                  user.majorId.toString().isEmpty
                      ? 'No Major'
                      : user.majorId.toString(),
                  style: GoogleFonts.kanit(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  onSaved: (v) {
                    update();
                  },
                  validator: (value) {
                    if (value == null || !GetUtils.isPhoneNumber(value)) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  enabled: isEdit,
                  controller: phoneCtl,
                  style: GoogleFonts.kanit(fontSize: 20),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(FontAwesomeIcons.phone),
                    labelText: 'Phone Number',
                    suffixIcon: !isEdit
                        ? null
                        : IconButton(
                            onPressed: () => phoneCtl.clear(),
                            icon: const Icon(Icons.clear)),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.red),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.grey),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Colors.greenAccent),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  onSaved: (v) {
                    update();
                  },
                  controller: addrCtl,
                  enabled: isEdit,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.isNumericOnly) {
                      return 'Please enter your Address';
                    }
                    return null;
                  },
                  style: GoogleFonts.kanit(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: 'Address',
                    prefixIcon: const Icon(FontAwesomeIcons.addressCard),
                    suffixIcon: !isEdit
                        ? null
                        : IconButton(
                            onPressed: () => addrCtl.clear(),
                            icon: const Icon(Icons.clear)),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.red),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.grey),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Colors.greenAccent),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  onSaved: (v) {
                    update();
                  },
                  controller: descCtl,
                  enabled: isEdit,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.isNumericOnly) {
                      return 'Please enter your Description';
                    }
                    return null;
                  },
                  style: GoogleFonts.kanit(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: 'Short Description',
                    prefixIcon: const Icon(Icons.description),
                    suffixIcon: !isEdit
                        ? null
                        : IconButton(
                            onPressed: () => descCtl.clear(),
                            icon: const Icon(Icons.clear)),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.red),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.grey),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Colors.greenAccent),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
