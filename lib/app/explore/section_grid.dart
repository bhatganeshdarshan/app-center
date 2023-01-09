/*
 * Copyright (C) 2022 Canonical Ltd
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software/app/common/app_banner.dart';
import 'package:software/app/common/app_finding.dart';
import 'package:software/app/common/constants.dart';
import 'package:software/app/common/snap/snap_section.dart';
import 'package:software/app/explore/explore_model.dart';

class SectionGrid extends StatelessWidget {
  const SectionGrid({
    Key? key,
    required this.snapSection,
    this.animateBanners = false,
    this.padding,
    this.initSection = true,
    this.ignoreScrolling = true,
    required this.initialAmount,
  }) : super(key: key);

  final SnapSection snapSection;
  final bool animateBanners;
  final EdgeInsets? padding;
  final bool initSection;
  final int initialAmount;
  final bool ignoreScrolling;

  @override
  Widget build(BuildContext context) {
    final sections = context.select((ExploreModel m) {
      return m.sectionNameToSnapsMap[snapSection]?.take(initialAmount).toList();
    });
    if (sections == null || sections.isEmpty) return const SizedBox();

    return GridView.builder(
      physics: ignoreScrolling ? const NeverScrollableScrollPhysics() : null,
      padding: padding ??
          const EdgeInsets.only(
            bottom: kPagePadding - 5,
            left: kPagePadding - 5,
            right: kPagePadding - 5,
          ),
      shrinkWrap: true,
      gridDelegate: kGridDelegate,
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final snap = sections.elementAt(index);

        return AppBanner(
          appFinding: MapEntry<String, AppFinding>(
            snap.name,
            AppFinding(
              snap: snap,
              rating: 4.5,
              totalRatings: Random().nextInt(3000),
            ),
          ),
          showSnap: true,
          showPackageKit: false,
        );
      },
    );
  }
}