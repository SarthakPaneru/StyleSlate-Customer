import 'package:flutter/material.dart';

class DraggableScrollableSheetWidget extends StatelessWidget {
  final DraggableScrollableController sheetController;
  final String currentAddress;
  final String barberAddress;

  const DraggableScrollableSheetWidget({
    Key? key,
    required this.sheetController,
    required this.currentAddress,
    required this.barberAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: sheetController,
      builder: (BuildContext context, scrollController) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 4,
                    width: 40,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    FilledButton.tonal(
                      onPressed: () {
                        sheetController.animateTo(
                          0.8,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceIn,
                        );
                      },
                      child: const Text('Scroll to 0.8'),
                    ),
                    ListTile(
                      title: Text(
                        'Loction : $currentAddress',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Brber Location : $barberAddress',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
