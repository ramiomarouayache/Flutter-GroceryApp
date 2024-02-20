import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownMenu extends StatelessWidget {
  DropDownMenu({Key? key}) : super(key: key);

  final RxString dropdownvalue = '16-Alger'.obs;

  // List of items in our dropdown menu
  final List<String> wilayaList = [
    '16-Algiers',
    '23-Annaba',
    '25-Constantine',
    '31-Oran',
    '19-Sétif',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          DropdownMenu(
            textStyle: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            expandedInsets: EdgeInsets.all(0),
            menuStyle: Get.theme.dropdownMenuTheme.menuStyle,
            initialSelection: wilayaList[0],
            requestFocusOnTap: false,
            // hintText: "Location",
            width: 300,
            leadingIcon: const Icon(
              Icons.location_city_rounded,
              color: Color(0xff2382AA),
            ),
            onSelected: (String? value) {
              // This is called when the user selects an item.
              dropdownvalue.value = value!;
            },
            dropdownMenuEntries:
                wilayaList.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          )
        ],
      ),
    );
  }
}
