import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';

class DateInput extends StatefulWidget {

  final String label;
  final void Function(DateTime) onSave;
  DateInput({Key? key, required this.label, required this.onSave}) : super(key: key);

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  TextEditingController dateCtl = TextEditingController();
  DateTime? _dateTime;
  final DateFormat dateFormat = DateFormat.yMMMd();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (themeContext, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                widget.label,
                style: Theme.of(themeContext).textTheme.overline,
              ),
            ),
            TextFormField(
              controller: dateCtl,
              onSaved: (item) {
                widget.onSave(dateFormat.parse(item!));
                
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Theme.of(themeContext).cardColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: Theme.of(themeContext).cardColor)),
              ),
              style: Theme.of(themeContext).textTheme.headline2,
              cursorColor: Theme.of(themeContext).splashColor,
              onTap: () {
                FocusScope.of(themeContext).requestFocus(FocusNode());

                final now = DateTime.now();
                showDatePicker(
                  context: themeContext, 
                  initialDate: now, 
                  firstDate: now, 
                  lastDate: DateTime(now.year + 10, now.month, now.day)
                ).then((value) {
                    dateCtl.text = dateFormat.format(value ?? DateTime.now());
                });

              },
              validator: (value) => value == null || value.isEmpty ? "Please, select a drop date" : null,
            ),
          ],
        );
      },
    );
  }
}
