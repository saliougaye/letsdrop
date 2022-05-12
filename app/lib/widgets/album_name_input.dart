import 'package:flutter/material.dart';

class AlbumNameInput extends StatelessWidget {
  final void Function(String?) onSave;

  const AlbumNameInput({Key? key, required this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Album Name',
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            TextFormField(
              onSaved: onSave,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Theme.of(context).cardColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Theme.of(context).cardColor)),
              ),
              style: Theme.of(context).textTheme.headline2,
              cursorColor: Theme.of(context).splashColor,
              validator: (value) => value == null || value.isEmpty
                  ? "Please insert the album name"
                  : null,
              
            )
          ],
        )
      ],
    );
  }
}
