import 'package:dropdown_selection/dropdown_selection.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_drop_down.dart';
import '../../../constant.dart';
import '../../../providers/country_data.dart';

class CountryDropDown extends StatelessWidget {
  final String? selectItems;
  final Function(String?)? onChanged;
  const CountryDropDown({Key? key, this.onChanged, this.selectItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = CountryData.countryInfo;
    return SizedBox(
      height: 45,
      child: CustomDropDown(
        items: data.keys.toList(),
        labelText: 'Country',
        showSearchBox: true,
        mode: Mode.DIALOG,
        maxHeight: 500,
        contentPadding: const EdgeInsets.only(left: 20, top: 10),
        popupItemBuilder: (context, s, b) => Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kDefaultPadding,
              ),
              Text(s.toString(), style: const TextStyle(color: kPrimaryColor))
            ],
          ),
        ),
        onChanged: onChanged,
        dropdownBuilder: (selectItems==null || selectItems!.isEmpty)
            ? null
            : (context, String, string) {
          return Text(string,style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: kInputTextColor),
              textAlign: TextAlign.center);
        },
      ),
    );
  }
}