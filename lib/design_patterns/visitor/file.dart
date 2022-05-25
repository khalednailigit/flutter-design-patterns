import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../helpers/file_size_converter.dart';
import 'ifile.dart';

abstract class File extends StatelessWidget implements IFile {
  final String title;
  final String fileExtension;
  final int size;
  final IconData icon;

  const File(this.title, this.fileExtension, this.size, this.icon);

  @override
  int getSize() {
    return size;
  }

  @override
  Widget render(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: LayoutConstants.paddingS),
      child: ListTile(
        title: Text(
          '$title.$fileExtension',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        leading: Icon(icon),
        trailing: Text(
          FileSizeConverter.bytesToString(size),
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.black54),
        ),
        dense: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return render(context);
  }
}
