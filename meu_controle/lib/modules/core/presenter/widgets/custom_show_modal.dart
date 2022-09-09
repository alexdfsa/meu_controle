import 'package:flutter/material.dart';

class ShowModal {
  static show(BuildContext context, String title, List<Widget> children,
      VoidCallback save, VoidCallback cancel, VoidCallback close) {
    showModalBottomSheet(
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: Colors.yellow[200],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: buttomStyle(),
                        onPressed: save,
                        child: const Icon(Icons.save_alt),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: buttomStyle(),
                        onPressed: cancel,
                        child:
                            const Icon(Icons.settings_backup_restore_rounded),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: buttomStyle(),
                        onPressed: close,
                        child: const Icon(Icons.expand_more_outlined),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                ListView(
                  shrinkWrap: true,
                  controller: scrollController,
                  children: children,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

buttomStyle() {}
