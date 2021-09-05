// // create the illusion of a beautifully scrolling text box
// import 'package:flutter/material.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({ Key key }) : super(key: key);

//   @override
//   _TestScreenState createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   @override
//   Widget build(BuildContext context) {
   
// return new Container(
//     color: Colors.grey,
//   padding: new EdgeInsets.all(7.0),
 
//   child: new ConstrainedBox(
//     constraints: new BoxConstraints(
//       minWidth: _contextWidth(),
//       maxWidth: _contextWidth(),
//       minHeight: AppMeasurements.isLandscapePhone(context) ? 25.0 : 25.0,
//       maxHeight: 55.0,
//     ),

//     child: new SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       reverse: true,

//         // here's the actual text box
//         child: new TextField(
//           keyboardType: TextInputType.multiline,
//           maxLines: null, //grow automatically
//           focusNode: mrFocus,
//           controller: _textController,
//           onSubmitted: currentIsComposing ? _handleSubmitted : null,
//           decoration: new InputDecoration.collapsed(
//             hintText: ''Please enter a lot of text',
//           ),
//         ),
//         // ends the actual text box

//       ),
//     ),
//   );
// }
