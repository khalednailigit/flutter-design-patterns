import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../design_patterns/visitor/visitor.dart';
import '../../platform_specific/platform_button.dart';
import 'files_dialog.dart';
import 'files_visitor_selection.dart';

class VisitorExample extends StatefulWidget {
  const VisitorExample();

  @override
  _VisitorExampleState createState() => _VisitorExampleState();
}

class _VisitorExampleState extends State<VisitorExample> {
  final List<IVisitor> visitorsList = [
    HumanReadableVisitor(),
    XmlVisitor(),
  ];

  late final IFile _rootDirectory;
  int _selectedVisitorIndex = 0;

  @override
  void initState() {
    super.initState();

    _rootDirectory = _buildMediaDirectory();
  }

  IFile _buildMediaDirectory() {
    final musicDirectory = Directory(
      title: 'Music',
      level: 1,
    );
    musicDirectory.addFile(
      const AudioFile('Darude - Sandstorm', 'Before the Storm', 'mp3', 2612453),
    );
    musicDirectory.addFile(
      const AudioFile('Toto - Africa', 'Toto IV', 'mp3', 3219811),
    );
    musicDirectory.addFile(
      const AudioFile(
        'Bag Raiders - Shooting Stars',
        'Bag Raiders',
        'mp3',
        3811214,
      ),
    );

    final moviesDirectory = Directory(
      title: 'Movies',
      level: 1,
    );
    moviesDirectory.addFile(
      const VideoFile('The Matrix', 'The Wachowskis', 'avi', 951495532),
    );
    moviesDirectory.addFile(
      const VideoFile('Pulp Fiction', 'Quentin Tarantino', 'mp4', 1251495532),
    );

    final catPicturesDirectory = Directory(
      title: 'Cats',
      level: 2,
    );
    catPicturesDirectory.addFile(
      const ImageFile('Cat 1', '640x480px', 'jpg', 844497),
    );
    catPicturesDirectory.addFile(
      const ImageFile('Cat 2', '1280x720px', 'jpg', 975363),
    );
    catPicturesDirectory.addFile(
      const ImageFile('Cat 3', '1920x1080px', 'png', 1975363),
    );

    final picturesDirectory = Directory(
      title: 'Pictures',
      level: 1,
    );
    picturesDirectory.addFile(catPicturesDirectory);
    picturesDirectory.addFile(
      const ImageFile('Not a cat', '2560x1440px', 'png', 2971361),
    );

    final mediaDirectory = Directory(
      title: 'Media',
      level: 0,
      isInitiallyExpanded: true,
    );
    mediaDirectory.addFile(musicDirectory);
    mediaDirectory.addFile(moviesDirectory);
    mediaDirectory.addFile(picturesDirectory);
    mediaDirectory.addFile(
      Directory(
        title: 'New Folder',
        level: 1,
      ),
    );
    mediaDirectory.addFile(
      const TextFile(
        'Nothing suspicious there',
        'Just a normal text file without any sensitive information.',
        'txt',
        430791,
      ),
    );
    mediaDirectory.addFile(
      const TextFile(
        'TeamTrees',
        'Team Trees, also known as #teamtrees, is a collaborative fundraiser that managed to raise 20 million U.S. dollars before 2020 to plant 20 million trees.',
        'txt',
        1042,
      ),
    );

    return mediaDirectory;
  }

  void _setSelectedVisitorIndex(int? index) {
    setState(() {
      _selectedVisitorIndex = index!;
    });
  }

  void _showFilesDialog() {
    final selectedVisitor = visitorsList[_selectedVisitorIndex];
    final filesText = _rootDirectory.accept(selectedVisitor);

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => FilesDialog(
        filesText: filesText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          children: [
            FilesVisitorSelection(
              visitorsList: visitorsList,
              selectedIndex: _selectedVisitorIndex,
              onChanged: _setSelectedVisitorIndex,
            ),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _showFilesDialog,
              text: 'Export files',
            ),
            const SizedBox(height: LayoutConstants.spaceL),
            _rootDirectory.render(context),
          ],
        ),
      ),
    );
  }
}
