import 'dart:io';

import 'package:expense_tracker/core/config/constants.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String? path;
  final File? file;

  const Avatar({super.key, this.size = 40.0, this.path, this.file});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(256),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).chipTheme.backgroundColor,
          ),
          child: _getChild(),
        ),
      ),
    );
  }

  Widget _getChild() {
    if (file != null) {
      return Image.file(file!, fit: BoxFit.cover);
    }

    if (path != null) {
      return Image.network(
        '$baseUrl/$path',
        fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
              return Image.asset('assets/images/avatar.png', fit: BoxFit.cover);
            },
      );
    }

    return Image.asset('assets/images/avatar.png', fit: BoxFit.cover);
  }
}
