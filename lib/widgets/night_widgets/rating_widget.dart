import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i){
              return GestureDetector(
                onTap: () => isActive ? data.selectStars(i) : null,
                child: Icon(Icons.star,
                    color: i < data.selectedStars ? kTangerine : kWhite,
                    size: 50,
                    shadows: [
                      BoxShadow(
                          color: i < data.selectedStars ? kWhite : kTangerine,
                          blurRadius: 9,
                          spreadRadius: 6,
                          offset: Offset(1, 1)
                      ),
                    ]),
              );
            }),
          );
        }
    );
  }
}