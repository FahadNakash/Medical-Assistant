import 'package:dropdown_selection/dropdown_selection.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_drop_down.dart';
import '../../../constant.dart';
import '../../../data/country_data.dart';

class CountryDropDown extends StatelessWidget {
  final String? selectItems;
  final Function(String?)? onChanged;
  const CountryDropDown({Key? key, this.onChanged, this.selectItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = CountryData.countryInfo;
    final size = MediaQuery.of(context).size;
    return Container(
      height: 45,
      child: CustomDropDown(
        items: data.keys.toList(),
        labelText: 'Country',
        showSearchBox: true,
        mode: Mode.DIALOG,
        maxHeight: 500,
        contentPadding: EdgeInsets.only(left: 20, top: 10),
        popupItemBuilder: (BuildContext, String, bool) => Container(
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kDefaultPadding,
              ),
              Text(String.toString(), style: TextStyle(color: kPrimaryColor))
            ],
          ),
        ),
        onChanged: onChanged,
        dropdownBuilder: (selectItems == null)
            ? null
            : (BuildContext, String, string) {
          return Text(string,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: kInputTextColor),
              textAlign: TextAlign.center);
        },
      ),
    );
  }
}