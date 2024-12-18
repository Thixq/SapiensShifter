import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key});

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final List<String> _allStaff = [
    'John',
    'Jane',
    'Smith',
    'Lisa',
  ]; // Seçenekler

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>.multiSelect(
      items: _allStaff,
      decoration: CustomDropdownDecoration(
        listItemDecoration: const ListItemDecoration(),
        closedBorderRadius: context.border.normalBorderRadius,
        closedBorder: Border.all(),
        closedFillColor: Colors.transparent,
        hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
      ),
      onListChanged: (p0) {
        print(p0);
      },
    );
  }
}
