import 'package:flutter/material.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/component_export_package.dart';

class PreviewOrderCard extends StatelessWidget {
  const PreviewOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padding.normal,
      decoration: BoxDecoration(
        border: Border.all(
          color: context.general.colorScheme.primary,
          width: 2,
        ),
        borderRadius: context.border.lowBorderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Masa 12',
                style: context.general.textTheme.titleMedium,
              ),
              const Text(
                '596₺',
              ),
            ],
          ),
          const Divider(
            color: Colors.blue,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
