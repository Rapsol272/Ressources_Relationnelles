import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/screens/pages/acceuil/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Container(
      width: 800,
      height: 600,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () async {
              final results = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                type: FileType.custom,
                allowedExtensions: ['png', 'jpg'],
              );

              if (results == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No file'),
                  ),
                );
                return null;
              }

              final path = results.files.single.path!;
              final fileName = results.files.single.name;

              storage
                  .uploadFile(
                    path,
                    fileName,
                  )
                  .then(
                    (value) => print('Done'),
                  );

              print(path);
              print(fileName);
            },
            child: Text('Upload file'),
          ),
          FutureBuilder(
            future: storage.listFiles(),
            builder: (BuildContext context,
                AsyncSnapshot<firebase_storage.ListResult> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  height: 100,
                  child: ListView.builder(
                      itemCount: snapshot.data!.items.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ElevatedButton(
                          onPressed: () {},
                          child: Text(snapshot.data!.items[index].name),
                        );
                      }),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return Loading();
              }
              return Container();
            },
          ),
          FutureBuilder(
            future: storage.downloadUrl('IMG_20220130_151000.jpg'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                    width: 300,
                    height: 250,
                    child: Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    ));
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return Loading();
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}



/* late File imageFile;
  late String url;
  bool created = false;

   Future<String> _openGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    File selected = File(pickedFile!.path);
    setState(() {
      imageFile = selected;
    });
    String fileName = imageFile.path;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);

    uploadTask.whenComplete(() async {
      String test = await firebaseStorageRef.getDownloadURL();
    });

    return test;
  }

  //Future uploadImageToFirebase(BuildContext context) async {

  //} */