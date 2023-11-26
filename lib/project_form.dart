import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'entry.dart';
import 'app_state.dart';

typedef SubmitCallback = void Function(Entry);

class ProjectForm extends StatefulWidget {
  final SubmitCallback onSubmit;
  const ProjectForm({super.key, required this.onSubmit});

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  File? _imageFile;

  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  late String title;
  late String text;
  late String date;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  title = value;
                  return null;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Date (DD/MM/YYYY):'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  date = value;
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Text'),
                maxLines: 10,
                minLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  text = value;
                  return null;
                },
              ),
              SizedBox(height: 10),
              FilledButton(
                onPressed: _getImageFromGallery,
                child: Icon(Icons.add_a_photo),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Center(
                  child: _imageFile == null
                      ? Text('No image selected.')
                      : Image.file(_imageFile!),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: FilledButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        final entry = Entry(
                          title: title,
                          text: text,
                          date: date,
                          imageFile: _imageFile,
                        );

                        widget.onSubmit(entry);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
