import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final textEditingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var _image;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openGallery(),
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('새 게시물'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.send),
          tooltip: '다음',
          onPressed: () {
            _uploadPost();
          },
        )
      ],
    );
  }

  Future<void> _uploadPost() async {
    final navigator = Navigator.of(context);

    // Create the file metadata
    final metadata = SettableMetadata(contentType: "image/jpeg");

    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

    // imagesRef
    final imagesRef = storageRef
        .child('post')
        .child('${DateTime.now().millisecondsSinceEpoch}.png');

    final uploadTask = imagesRef.putFile(_image, metadata);

    // Listen for state changes, errors, and completion of the upload.
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          // ...
          break;
      }
    });

    final url = await (await uploadTask).ref.getDownloadURL();

    final doc = FirebaseFirestore.instance.collection('post').doc();
    await doc.set({
      'id': doc.id,
      'photoUrl': url.toString(),
      'contents': textEditingController.text,
      'email': widget._user.email,
      'displayName': widget._user.displayName,
      'userPhotoUrl': widget._user.photoURL
    });

    // Move to the previous page on completion
    navigator.pop();
  }

  Widget _buildBody() {
    return Column(
      children: [
        _image == null ? Text('No Image') : Image.file(_image),
        TextField(
          decoration: InputDecoration(hintText: '내용을 입력하세요'),
          controller: textEditingController,
        )
      ],
    );
  }

  Future _openGallery() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    } else {
      // 사진 미선택시 처리
    }
  }
}
