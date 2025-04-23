import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main_provider.dart';
import 'flag_widget.dart';
import 'package:neo_day/widgets/languages/language.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return PopupMenuButton(
              offset: const Offset(0, -10),
              elevation: 0,
              color: Colors.transparent,
              constraints: BoxConstraints(
                maxWidth: 46,
              ),
            child: FlagWidget(
                country:
                    context.locale.toString() == 'en_US'
                    ? 'GB'
                    : context.locale.toString() == 'pl_PL'
                    ? 'PL'
                    : 'RU'
            ),
            onSelected: (value){
              data.setLanguage(value, context);
              if(value.language == 'English - UK'){
                context.setLocale(const Locale('en', 'US'));
              }else if(value.language == 'Polski - PL'){
                context.setLocale(const Locale('pl', 'PL'));
              }else if(value.language == 'Russian - Ru'){
                context.setLocale(const Locale('ru', 'RU'));
              }
            },
              itemBuilder: (context){
                return languageList.map<PopupMenuEntry<Language>>((valueLanguage){
                  return PopupMenuItem<Language>(
                    padding: EdgeInsets.zero,
                    height: 40,
                    value: valueLanguage,
                    child: FlagWidget(country: valueLanguage.countryCode));
                }).toList();
              });
        });
  }
}
