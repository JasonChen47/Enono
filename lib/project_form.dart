import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:textfield_tags/textfield_tags.dart';

import 'project.dart';
import 'app_state.dart';

typedef SubmitCallback = void Function(Project);

class ProjectForm extends StatefulWidget {
  final SubmitCallback onSubmit;
  const ProjectForm({super.key, required this.onSubmit});

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  File? _imageFile;
  late TextfieldTagsController _controller;
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;
  late List<String> skills;
  late String date;
  late double _distanceToField;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

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

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
  }

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
              // Field tags for Skills
              TextFieldTags(
                textSeparators: const [' ', ','],
                letterCase: LetterCase.normal,
                validator: (String tag) {
                  if (tag.isEmpty) {
                    return 'Please enter some text';
                  } else if (_controller.getTags!.contains(tag)) {
                    return 'you already entered that';
                  } else {
                    skills = _controller.getTags! + [tag];
                  }
                  return null;
                },
                textfieldTagsController: _controller,
                inputfieldBuilder:
                    (context, tec, fn, error, onChanged, onSubmitted) {
                  return ((context, sc, tags, onTagDelete) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: tec,
                        focusNode: fn,
                        decoration: InputDecoration(
                          isDense: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 74, 137, 92),
                              width: 3.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 74, 137, 92),
                              width: 3.0,
                            ),
                          ),
                          helperText: 'Enter language...',
                          helperStyle: const TextStyle(
                            color: Color.fromARGB(255, 74, 137, 92),
                          ),
                          hintText: _controller.hasTags ? '' : "Enter tag...",
                          errorText: error,
                          prefixIconConstraints:
                              BoxConstraints(maxWidth: _distanceToField * 0.74),
                          prefixIcon: tags.isNotEmpty
                              ? SingleChildScrollView(
                                  controller: sc,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: tags.map((String tag) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                        color: Color.fromARGB(255, 74, 137, 92),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Text(
                                              '$tag',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onTap: () {
                                              print("$tag selected");
                                            },
                                          ),
                                          const SizedBox(width: 4.0),
                                          InkWell(
                                            child: const Icon(
                                              Icons.cancel,
                                              size: 14.0,
                                              color: Color.fromARGB(
                                                  255, 233, 233, 233),
                                            ),
                                            onTap: () {
                                              onTagDelete(tag);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                                )
                              : null,
                        ),
                        onChanged: onChanged,
                        onSubmitted: onSubmitted,
                      ),
                    );
                  });
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
                  description = value;
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
                        final project = Project(
                          title: title,
                          description: description,
                          date: date,
                          skills: skills,
                          imageURL: _imageFile!.path,
                        );

                        widget.onSubmit(project);

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
