// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:first/app/core/constants/colors.dart';
import 'package:first/app/core/model/region_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/colors.dart';

class SearchDropdown extends StatelessWidget {
  Region? selectedValue;
  String hint;
  String hintSearch;
  final TextEditingController textEditingSearchController;
  void Function(Region?)? onChanged;
  List<DropdownMenuItem<Region>>? items;

  // void Function(bool)? onMenuStateChange;

  SearchDropdown(
      {super.key,
      required this.textEditingSearchController,
      required this.hint,
      required this.selectedValue,
      required this.onChanged,
      required this.hintSearch,
      // required this.onMenuStateChange,
      required this.items});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Region>(
        // iconStyleData: const IconStyleData(
        //   icon: Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Icon(
        //       Icons.arrow_drop_down_outlined,
        //     ),
        //   ),
        //   iconSize: 25,
        // ),

        isExpanded: true,
        hint: Text(
          hint,
          style: TextStyle(
            fontSize: 11.sp,
            color: colorBlackHint,
          ),
        ),
        items: items,
        value: selectedValue,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsetsDirectional.only(start: 11, end: 10),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: colorBlackBorder,
            ),
            color: backGroundGrey,
          ),
          elevation: 2,
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 250,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 50,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingSearchController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 57,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: SizedBox(
              // height: 50,
              child: TextFormField(
                style: const TextStyle(color: colorBlack),
                expands: true,
                maxLines: null,
                controller: textEditingSearchController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: hintSearch,

                  hintStyle: const TextStyle(fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: colorBlackBorder, width: 1),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: colorBlackBorder, width: 1),
                    borderRadius: BorderRadius.circular(14.0),
                  ), // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(8),
                  // ),
                ),
                cursorColor: colorBlack,
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            if (items!.isNotEmpty) {
              return (item.value!.name.toString().contains(searchValue));
            }
            return false;
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingSearchController.clear();
          }
        },
      ),

    );
  }
}
