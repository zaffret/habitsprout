import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:habit_sprout1/services/firebase_service.dart';

class ImageUploadPage extends StatefulWidget {
  static const routeName = '/image';

  final String userId;
  final String? imageUrl;

  const ImageUploadPage({required this.userId, this.imageUrl, super.key});

  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  final FirebaseService fbService = GetIt.instance<FirebaseService>();
  String? imageUrl;
  PlatformFile? pickedFile;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.imageUrl;
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        pickedFile = result.files.first;
        setState(() {});
      } else {
        _showSnackbar('No image selected.');
      }
    } catch (e) {
      _showSnackbar('Failed to pick image: $e');
    }
  }

  Future<void> uploadImage() async {
    if (pickedFile != null) {
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child('images/${pickedFile!.name}');
        UploadTask uploadTask = ref.putData(pickedFile!.bytes!);

        await uploadTask;

        String url = await ref.getDownloadURL();

        await fbService.updatePhoto(url, widget.userId);

        setState(() {
          imageUrl = url;
        });

        _showSnackbar('Image uploaded successfully.');
        Navigator.of(context).pop(url);
      } catch (e) {
        _showSnackbar('Failed to upload image: $e');
      }
    } else {
      _showSnackbar('No image selected.');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Profile Image'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                pickedFile != null
                    ? Image.memory(
                        pickedFile!.bytes!,
                        width: 300,
                        height: 300,
                        fit: BoxFit.fill,
                      )
                    : imageUrl != null
                        ? Image.network(
                            imageUrl!,
                            width: 300,
                            height: 300,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            'assets/images/crunchy-cat-luna-image.jpg',
                            width: 300,
                            height: 300,
                            fit: BoxFit.fill,
                          ),
                const SizedBox(height: 20),
                TextButton.icon(
                  icon: const Icon(Icons.image),
                  onPressed: pickImage,
                  label: const Text('Pick Image'),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: uploadImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(33, 47, 85, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fixedSize: const Size(357, 57),
                  elevation: 5,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                child: const Center(
                  child: Text(
                    'Upload Image',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
