import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';

class GratitudeWidget extends StatelessWidget {
  const GratitudeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return SizedBox(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: size.width,
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: TextFormField(

                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: data.isGratitude ? size.width : 48,
                  height: data.isGratitude ? 60 : 40,
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: EdgeInsets.only(left: data.isGratitude ? 8 : 0),
                  decoration: BoxDecoration(
                    color: kTangerine,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    children: [
                      Visibility(
                      visible: data.isGratitude,
                        child: Expanded(
                          child: Text('What can you thank this day for? Food, or good company also counts',
                            style: kTextStyle),
                        ),
                      ),
                      IconButton(
                          onPressed: data.switchIsGratitude,
                          icon: Icon(Icons.info_outline)
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}
