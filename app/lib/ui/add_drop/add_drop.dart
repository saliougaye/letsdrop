import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsdrop/blocs/drops/drops_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/models/artist.dart';
import 'package:letsdrop/models/country.dart';
import 'package:letsdrop/models/drop.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';
import 'package:letsdrop/widgets/add_drop_form.dart';
import 'package:letsdrop/widgets/appbar.dart';

class AddNewDropScreen extends StatefulWidget {
  const AddNewDropScreen({Key? key}) : super(key: key);

  @override
  State<AddNewDropScreen> createState() => _AddNewDropScreenState();
}

class _AddNewDropScreenState extends State<AddNewDropScreen> {
  final _formKey = GlobalKey<FormState>();

  String? formAlbumName;
  Country? formCountry;
  List<Artist> formArtists = List.empty(growable: true);
  DateTime formDate = DateTime.now();

  _onSaveAlbumName(String? album) {
    formAlbumName = album;
  }

  _onSaveCountry(Country? country) {
    formCountry = country;
  }

  _onSaveArtists(Artist? artist) {
    if (artist != null) {
      formArtists.add(artist);
    }
  }

  _onSaveDate(DateTime? date) {
    if(date != null) {
      formDate = date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DropsBloc, DropsState>(
      listener: (context, state) {

        String message = "";

        if(state is DropsLoaded) {
          message = "Drop created";
        } 
        
        if (state is DropsCreationFailed) {
          message = "Sorry, drop not created";
        }

         ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));


      },
      child: BlocBuilder<DropsBloc, DropsState>(
        builder: (context, state) {
          return _addDropWidget(context);
        },
      ),
    );
  }

  BlocBuilder<ThemeBloc, ThemeState> _addDropWidget(BuildContext dropsContext) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Padding(
            padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  addVerticalSpace(20),
                  const Appbar(name: "Add Drop"),
                  addVerticalSpace(10),
                  Form(
                      key: _formKey,
                      child: AddDropForm(
                        onSaveAlbumName: _onSaveAlbumName,
                        onSaveCountry: _onSaveCountry,
                        onSaveArtist: _onSaveArtists,
                        onSaveDate: _onSaveDate,
                      ))
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _onSubmit(dropsContext),
            child: const Icon(Icons.check),
          ),
        );
      },
    );
  }

  void _onSubmit(BuildContext dropsContext) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();


      context.read<DropsBloc>().add(AddDrop(
          drop: Drop(
              id: "",
              album: formAlbumName!,
              dropDate: formDate,
              country: formCountry!,
              artists: formArtists)));

      context.read<DropsBloc>().add(LoadDrops());

      Navigator.pop(context);
    }
  }
}
