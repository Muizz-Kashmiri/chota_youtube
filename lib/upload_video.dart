import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadVideos extends StatefulWidget {
  const UploadVideos({Key? key}) : super(key: key);

  @override
  _UploadVideosState createState() => _UploadVideosState();
}

class _UploadVideosState extends State<UploadVideos> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  File? _selectedVideo;

  Widget _buildVideoThumbnail(File videoFile) {
    // Add logic here to generate a thumbnail from the video file
    // For demonstration, this is just a placeholder image
    return Image.asset(
      'assets/placeholder_thumbnail.png', // Placeholder image path
      width: 150,
      height: 150,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Videos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    setState(() {
                      _selectedVideo = File(result.files.single.path!);
                      print('Selected video: $_selectedVideo');
                    });
                  } else {
                    setState(() {
                      _selectedVideo = null;
                    });
                  }
                },
                icon: Icon(Icons.attach_file),
                label: Text('Select Video'),
              ),
              SizedBox(height: 16),
              if (_selectedVideo != null)
                Column(
                  children: [
                    _buildVideoThumbnail(_selectedVideo!),
                    SizedBox(height: 8),
                    Text(
                      'Selected Video: ${_selectedVideo!.path.split('/').last}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  print('Uploading video...');
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print('Title: $_title');
                    print('Description: $_description');
                    print('Video: $_selectedVideo');
                    // Add logic here to upload the video to Supabase
                  }
                },
                child: Text('Upload'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
