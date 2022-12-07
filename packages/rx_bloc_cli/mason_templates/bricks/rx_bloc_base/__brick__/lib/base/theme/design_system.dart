{{> licence.dart }}

import 'package:flutter/material.dart';

import 'design_system/design_system_colors.dart';
import 'design_system/design_system_icons.dart';
import 'design_system/design_system_images.dart';
import 'design_system/design_system_typography.dart';

@immutable
class DesignSystem extends ThemeExtension<DesignSystem> {
  const DesignSystem({
    required this.colors,
    required this.icons,
    required this.typography,
    required this.images,
  });

  DesignSystem.light()
      : colors = const DesignSystemColors.light(),
        icons = const DesignSystemIcons(),
        images = const DesignSystemImages(),
        typography =
            DesignSystemTypography.withColor(const DesignSystemColors.light());

  DesignSystem.dark()
      : colors = const DesignSystemColors.dark(),
        icons = const DesignSystemIcons(),
        images = const DesignSystemImages(),
        typography =
            DesignSystemTypography.withColor(const DesignSystemColors.dark());

  final DesignSystemColors colors;
  final DesignSystemIcons icons;
  final DesignSystemTypography typography;
  final DesignSystemImages images;

  @override
  ThemeExtension<DesignSystem> copyWith({
    DesignSystemColors? colors,
    DesignSystemIcons? icons,
    DesignSystemTypography? typography,
    DesignSystemImages? images,
  }) =>
      DesignSystem(
        colors: colors ?? this.colors,
        icons: icons ?? this.icons,
        typography: typography ?? this.typography,
        images: images ?? this.images,
      );

  @override
  ThemeExtension<DesignSystem> lerp(
          ThemeExtension<DesignSystem>? other, double t) =>
      t < 1.0 ? this : (other ?? this);
}

/// Extension to enable quick access of design system via a build context
extension DesignSystemContextExtension on BuildContext {
  /// Returns a reference to the [DesignSystem] theme extension of the current [Theme]
  DesignSystem get designSystem => Theme.of(this).extension<DesignSystem>()!;
}
