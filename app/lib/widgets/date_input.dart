import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInput extends StatefulWidget {
  final String label;
  final void Function(DateTime) onSave;
  const DateInput({Key? key, required this.label, required this.onSave})
      : super(key: key);

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  TextEditingController dateCtl = TextEditingController();
  final DateFormat dateFormat = DateFormat.yMMMd();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.overline,
          ),
        ),
        TextFormField(
          controller: dateCtl,
          onSaved: (item) {
            widget.onSave(dateFormat.parse(item!));
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10, right: 10),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                    BorderSide(color: Theme.of(context).cardColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                    BorderSide(color: Theme.of(context).cardColor)),
          ),
          style: Theme.of(context).textTheme.headline2,
          cursorColor: Theme.of(context).splashColor,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());

            final now = DateTime.now();
            showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now,
                    lastDate: DateTime(now.year + 10, now.month, now.day))
                .then((value) {
              dateCtl.text = dateFormat.format(value ?? DateTime.now());
            });
          },
          validator: (value) => value == null || value.isEmpty
              ? "Please, select a drop date"
              : null,
        ),
      ],
    );
  }
}
