import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/app_button.dart';
import '../../../constant.dart';
import 'day_chip.dart';


class AlarmSheet extends StatefulWidget {
  const AlarmSheet({Key? key}) : super(key: key);

  @override
  State<AlarmSheet> createState() => _AlarmSheetState();
}

class _AlarmSheetState extends State<AlarmSheet>{
  final TextEditingController _reminderText=TextEditingController();
  int _hours=0;
  int _mins=0;

  final TextStyle _headingText=const TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w700);
  final List<String> _selectedDaysName=[];
  final List<int> _selectedDayNum=[];
  final List<Map<String,int>> _weekDays=[
    {'Mon':2},
    {'tue':3},
    {'Wed':4},
    {'Thu':5},
    {'Fri':6},
    {'Sat':7},
    {'Sun':1}
  ];

  bool get _isEmpty=>_selectedDaysName.isEmpty;
  bool get _isFull=>_selectedDaysName.length==7;

  void _addAndRemoveDay(String name,int num){
    if (_selectedDaysName.contains(name)){
      _selectedDaysName.removeWhere((dayName) => dayName==name);
      _selectedDayNum.removeWhere((dayNum) => dayNum==num);
      setState(() {});
    }else{
      _selectedDaysName.add(name);
      _selectedDayNum.add(num);
      setState(() {});
    }

  }

  Future<void> _setAlarm()async{
    final AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.SET_ALARM',
      arguments: <String, dynamic>{
        'android.intent.extra.alarm.DAYS': _selectedDayNum,
        'android.intent.extra.alarm.HOUR': _hours,
        'android.intent.extra.alarm.MINUTES': _mins,
        'android.intent.extra.alarm.SKIP_UI': true,
        'android.intent.extra.alarm.MESSAGE': _reminderText.text.isEmpty?'Medical Assistant':_reminderText.text,
      },
    );
    await intent.launch();

  }



  @override
  void dispose() {
        super.dispose();
        _reminderText.dispose();
  }

  @override
  Widget build(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Container(
      height: size.height*0.7,
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _addMessage(),
            _selectTime(),
            _selectDays(),

          ],
        ),
      ),
    );
  }

  Widget _addMessage(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add Message:',style:_headingText,),
        const SizedBox(height: 5),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding+10),
          child: TextFormField(
            cursorColor: kPrimaryColor,
            controller: _reminderText,
            cursorWidth: 1,
            cursorHeight: 15,
            style: const TextStyle(color: kPrimaryColor,),
            decoration:  InputDecoration(
              hintText:'e.g\t Evening Medication',
              hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.4)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border:const OutlineInputBorder(borderSide: BorderSide(color: kSecondaryColor,width: 2),borderRadius: BorderRadius.only(topLeft:  Radius.circular(20),bottomLeft: Radius.circular(20))),
              enabledBorder:const OutlineInputBorder(borderSide: BorderSide(color: kSecondaryColor,width: 2),borderRadius: BorderRadius.only(topLeft:  Radius.circular(20),bottomLeft: Radius.circular(20))),
              focusedBorder:const OutlineInputBorder(borderSide: BorderSide(color: kSecondaryColor,width: 2),borderRadius: BorderRadius.only(topLeft:  Radius.circular(10),bottomLeft: Radius.circular(10))),
            ),
          ),
        ),
        const SizedBox(height: kDefaultHeight),
      ],
    );

  }
  Widget _selectTime(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Time:',style: _headingText),
        const SizedBox(height: kDefaultHeight/2),
        SizedBox(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(child: Text('Hours',style: TextStyle(color: kPrimaryColor,fontSize: 17),)),
              Flexible(
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                      scaffoldBackgroundColor: Colors.purple,
                      brightness: Brightness.light,
                      barBackgroundColor: Colors.green,
                      textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(color: kHeading1Color,fontSize: 25,fontFamily: 'Comfortaa'),
                          tabLabelTextStyle: TextStyle(color: Colors.purple)
                      )
                  ),
                  child: CupertinoDatePicker(
                      use24hFormat: true,
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (v){
                        _mins=v.minute;
                        _hours=v.hour;
                        setState(() {});
                      }
                  ),
                ),
              ),
              const Flexible(child: Text('Minutes',style: TextStyle(color: kPrimaryColor,fontSize: 17),)),

            ],
          ),
        ),
        const SizedBox(height: kDefaultHeight),
      ],
    );
  }
  Widget _selectDays(){
    final List<DayChip> _days=[];
    for (var day in _weekDays){
      day.forEach((dayKey, dayValue){
        _days.add(
            DayChip(
              day: dayKey,
              onTap: () {
                _addAndRemoveDay(dayKey, dayValue);},
              isSelected:_selectedDaysName.contains(dayKey),));
      });
    }
    return Column(
      children: [
        Row(
          children: [
            Text('Repeat:',style: _headingText,),
            const Spacer(),
            Text(_isEmpty?'None':_isFull?'Everyday':'Selected day',style:_headingText.copyWith(color: kSecondaryColor),)
          ],
        ),
        const SizedBox(height: kDefaultHeight),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _days
        ),
        const SizedBox(height: kDefaultHeight),
        AppButton(height: 40, width: 150, onPressed: ()async{
          await _setAlarm();
          Navigator.of(context).pop();
    },
          text: 'Add Alarm',
          textSize: 15, defaultLinearGradient: true,buttonIcon:Icons.alarm,showIcon: true,)

      ]
    );
  }


}
