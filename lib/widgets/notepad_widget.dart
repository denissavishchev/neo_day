import 'package:flutter/material.dart';
import 'package:neo_day/main_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class NotepadWidget extends StatelessWidget {
  const NotepadWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Drawer(
            width: size.width * 0.8,
            backgroundColor: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
              decoration: BoxDecoration(
                  color: kGreen,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(18)
                  )
              ),
              child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 250,
                          height: 50,
                          color: kBlue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                  onPressed: () => data.switchNote(0),
                                  child: Text('1')
                              ),
                              TextButton(
                                  onPressed: () => data.switchNote(1),
                                  child: Text('2')
                              ),
                              TextButton(
                                  onPressed: () => data.switchNote(2),
                                  child: Text('3')
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => data.notesKey.currentState?.closeDrawer(),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.35,
                      child: PageView.builder(
                          controller: data.notesPageController,
                          itemCount: 3,
                          itemBuilder: (context, index){
                            return SizedBox(
                              width: size.width,
                              height: MediaQuery.viewInsetsOf(context).bottom == 0
                                  ? size.height * 0.68
                                  : size.height * 0.38,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 24, right: 12),
                                child: TextField(
                                  controller: index == 0
                                      ? data.notesTextControllerOne
                                      : index == 1
                                      ? data.notesTextControllerTwo
                                      : data.notesTextControllerThree,
                                  cursorColor: kRed,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  style: const TextStyle(color: kRed, fontWeight: FontWeight.w500),
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red)
                                    ),
                                  ),
                                  onChanged: (value) => data.saveNote(value, index),
                                ),
                              ),
                            );
                          }
                      ),
                    )
                  ]
              ),
            ),
          );
        }
    );
  }
}