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
                  color: kBlue,
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
                              NoteButton(index: 0,),
                              NoteButton(index: 1,),
                              NoteButton(index: 2,),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [kGreen.withValues(alpha: 0.55), kBlue.withValues(alpha: 0.4)],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft
                              ),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(18),
                                  bottomLeft: Radius.circular(18),
                              )
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: kWhite,),
                            onPressed: () => data.notesKey.currentState?.closeDrawer(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.35,
                      child: PageView.builder(
                          physics: NeverScrollableScrollPhysics(),
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
                                  cursorColor: kGreen,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  style: kTextStyle,
                                  decoration: textFieldDecoration,
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

class NoteButton extends StatelessWidget {
  const NoteButton({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: data.selectedNote == index ? kGreen : Colors.transparent, width: 2)
            ),
            child: TextButton(
                onPressed: () => data.switchNote(index),
                child: Text('${index + 1}', style: data.selectedNote == index ? kTangerineTextStyle : kTextStyle,)
            ),
          );
        }
    );
  }
}