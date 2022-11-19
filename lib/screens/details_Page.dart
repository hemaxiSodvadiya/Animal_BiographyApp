// import 'package:flutter/material.dart';
//
// import '../model/model.dart';
// import '../style/strings.dart';
// import '../style/text_styles.dart';
//
// class DetailPage extends StatefulWidget {
//   const DetailPage({Key? key}) : super(key: key);
//
//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }
//
// class _DetailPageState extends State<DetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     List<WildAnimal> data =
//         ModalRoute.of(context)!.settings.arguments as List<WildAnimal>;
//
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 10,
//               bottom: 10,
//               right: 15,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: height * 0.26,
//                   width: width * 0.5,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(7),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 3,
//                       )
//                     ],
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: AssetImage("${data.first.image}"),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 2),
//                   child: Text(Strings.lifeWithATiger,
//                       style: TextStyle(fontSize: 20, color: Colors.black)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 2),
//                   child: Text(Strings.loremIpsum,
//                       style: TextStyle(fontSize: 20, color: Colors.black)),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
