import 'package:flutter/material.dart';

import '../model/model.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    DBAnimal args = ModalRoute.of(context)!.settings.arguments as DBAnimal;
    return Scaffold(
      appBar: AppBar(
        title: Text("Animal Detail"),
        centerTitle: true,
        backgroundColor: Colors.brown.shade400,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_outlined)),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              alignment: Alignment.center,
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: MemoryImage(args.image, scale: 1))),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              args.name,
              style: const TextStyle(
                  fontSize: 40,
                  color: Colors.brown,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              args.description,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.brown.shade500,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
