// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:reservation_railway/constant/constant.dart';
// import 'package:reservation_railway/model/train.dart';
// import 'package:reservation_railway/providers/trains.dart';
// import 'package:reservation_railway/theme/theme.dart';
// import 'package:reservation_railway/utils/handle_error.dart';
// import 'package:reservation_railway/utils/notifications.dart';
// import 'package:reservation_railway/utils/validators.dart';

// class ManageTrainScreen extends StatefulWidget {
//   const ManageTrainScreen({Key? key}) : super(key: key);

//   @override
//   State<ManageTrainScreen> createState() => _ManageTrainScreenState();
// }

// class _ManageTrainScreenState extends State<ManageTrainScreen> {
//   DateTime _dateTime = DateTime.now();
//   TimeOfDay _selectedTime = TimeOfDay.now();
//   final _form = GlobalKey<FormState>();
//   final dateFormat = DateFormat('EEEE, dd MMM yyyy');
//   final List<String> _list = standStations;
//   Train _train = Train(
//     id: '',
//     name: '',
//     price: 0,
//     category: trainClasses.first,
//     from: standStations.first,
//     to: standStations.last,
//     date: DateTime.now(),
//     time: '',
//     standStations: 0,
//     availableSeats: 0,
//   );

//   void _selectDate() async {
//     await showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: DateTime.now(),
//             lastDate: DateTime(DateTime.now().year, DateTime.now().month,
//                 DateTime.now().day + 30))
//         .then((value) {
//       setState(() {
//         _dateTime = value!;
//       });
//     });
//   }

//   String getTimePeriod(TimeOfDay time) {
//     return time.period == DayPeriod.am ? 'AM' : 'PM';
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? newTime =
//         await showTimePicker(context: context, initialTime: _selectedTime);
//     if (newTime != null) {
//       setState(() {
//         _selectedTime = newTime;
//         _train = Train(
//           id: _train.id,
//           name: _train.name,
//           price: _train.price,
//           category: _train.category,
//           from: _train.from,
//           to: _train.to,
//           date: _train.date,
//           time: '${newTime.hour}:${newTime.minute} ${getTimePeriod(newTime)}',
//           standStations: _train.standStations,
//           availableSeats: _train.availableSeats,
//         );
//       });
//     }
//   }

//   Future<void> _save() async {
//     final isValid = _form.currentState!.validate();
//     if (isValid) {
//       _form.currentState!.save();
//       try {
//         await Provider.of<Trains>(context, listen: false)
//             .addTrain(_train)
//             .then((value) {
//           _form.currentState!.reset();
//           showSnackBar(context, 'Added successfully', Colors.green);
//           Navigator.pop(context);
//         });
//       } catch (error) {
//         handleUnknownError(context);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     _list.sort();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Manage Train'),
//         actions: [
//           IconButton(
//             onPressed: _save,
//             icon: const Icon(Icons.save),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           width: deviceSize.width,
//           height: deviceSize.height,
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Form(
//               key: _form,
//               child: ListView(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Train Number',
//                       ),
//                       textInputAction: TextInputAction.next,
//                       validator: (val) => requiredValidator(val),
//                       onSaved: (value) {
//                         if (value != null) {
//                           _train = Train(
//                             id: _train.id,
//                             name: value,
//                             price: _train.price,
//                             category: _train.category,
//                             from: _train.from,
//                             to: _train.to,
//                             date: _train.date,
//                             time: _train.time,
//                             standStations: _train.standStations,
//                             availableSeats: _train.availableSeats,
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Price',
//                       ),
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.number,
//                       validator: (val) => requiredValidator(val),
//                       onSaved: (value) {
//                         if (value != null) {
//                           _train = Train(
//                             id: _train.id,
//                             name: _train.name,
//                             price: int.parse(value),
//                             category: _train.category,
//                             from: _train.from,
//                             to: _train.to,
//                             date: _train.date,
//                             time: _train.time,
//                             standStations: _train.standStations,
//                             availableSeats: _train.availableSeats,
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Available Seats',
//                       ),
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.number,
//                       validator: (val) => requiredValidator(val),
//                       onSaved: (value) {
//                         if (value != null) {
//                           _train = Train(
//                             id: _train.id,
//                             name: _train.name,
//                             price: _train.price,
//                             category: _train.category,
//                             from: _train.from,
//                             to: _train.to,
//                             date: _train.date,
//                             time: _train.time,
//                             standStations: _train.standStations,
//                             availableSeats: int.parse(value),
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: SizedBox(
//                       width: deviceSize.width,
//                       child: DropdownButtonFormField<String>(
//                         value: _train.from,
//                         decoration: const InputDecoration(
//                           enabledBorder: OutlineInputBorder(),
//                           labelText: 'From',
//                         ),
//                         onChanged: (String? value) {
//                           if (value != null) {
//                             setState(() {
//                               _train = Train(
//                                 id: _train.id,
//                                 name: _train.name,
//                                 price: _train.price,
//                                 category: _train.category,
//                                 from: value,
//                                 to: _train.to,
//                                 date: _train.date,
//                                 time: _train.time,
//                                 standStations: _train.standStations,
//                                 availableSeats: _train.availableSeats,
//                               );
//                             });
//                           }
//                         },
//                         items: standStations
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(
//                               value,
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: SizedBox(
//                       width: deviceSize.width,
//                       child: DropdownButtonFormField<String>(
//                         value: _train.to,
//                         decoration: const InputDecoration(
//                           enabledBorder: OutlineInputBorder(),
//                           labelText: 'To',
//                         ),
//                         onChanged: (String? value) {
//                           if (value != null) {
//                             setState(() {
//                               _train = Train(
//                                 id: _train.id,
//                                 name: _train.name,
//                                 price: _train.price,
//                                 category: _train.category,
//                                 from: _train.from,
//                                 to: value,
//                                 date: _train.date,
//                                 time: _train.time,
//                                 standStations: _train.standStations,
//                                 availableSeats: _train.availableSeats,
//                               );
//                             });
//                           }
//                         },
//                         items:
//                             _list.map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(
//                               value,
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: SizedBox(
//                       width: deviceSize.width,
//                       child: DropdownButtonFormField<String>(
//                         value: _train.category,
//                         decoration: const InputDecoration(
//                           enabledBorder: OutlineInputBorder(),
//                           labelText: 'Category',
//                         ),
//                         onChanged: (String? value) {
//                           if (value != null) {
//                             setState(() {
//                               _train = Train(
//                                 id: _train.id,
//                                 name: _train.name,
//                                 price: _train.price,
//                                 category: value,
//                                 from: _train.from,
//                                 to: _train.to,
//                                 date: _train.date,
//                                 time: _train.time,
//                                 standStations: _train.standStations,
//                                 availableSeats: _train.availableSeats,
//                               );
//                             });
//                           }
//                         },
//                         items: trainClasses
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(
//                               value,
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: TextFormField(
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Stand Stations',
//                       ),
//                       textInputAction: TextInputAction.next,
//                       keyboardType: TextInputType.number,
//                       validator: (val) => requiredValidator(val),
//                       onSaved: (value) {
//                         if (value != null) {
//                           _train = Train(
//                             id: _train.id,
//                             name: _train.name,
//                             price: _train.price,
//                             category: _train.category,
//                             from: _train.from,
//                             to: _train.to,
//                             date: _train.date,
//                             time: _train.time,
//                             standStations: int.parse(value),
//                             availableSeats: _train.availableSeats,
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10, left: 10),
//                     child: Text(
//                       "Pick a date",
//                       style: subTitleTextStyle,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: InkWell(
//                       onTap: () {
//                         _selectDate();
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: primaryColor100, width: 2),
//                           color: lightBlue100,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const Icon(
//                               Icons.date_range_rounded,
//                               color: primaryColor500,
//                             ),
//                             const SizedBox(
//                               width: 8,
//                             ),
//                             Text(
//                               _dateTime == null
//                                   ? "date not selected.."
//                                   : dateFormat.format(_dateTime).toString(),
//                               style: normalTextStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10, left: 10),
//                     child: Text(
//                       "Pick a time",
//                       style: subTitleTextStyle,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       right: 10,
//                       left: 10,
//                       top: 10,
//                       bottom: 100,
//                     ),
//                     child: InkWell(
//                       onTap: () {
//                         _selectTime(context);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: primaryColor100, width: 2),
//                           color: lightBlue100,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const Icon(
//                               Icons.date_range_rounded,
//                               color: primaryColor500,
//                             ),
//                             const SizedBox(
//                               width: 8,
//                             ),
//                             Text(
//                               DateFormat('hh:mm a').format(
//                                 DateTime(
//                                   _train.date.year,
//                                   _train.date.month,
//                                   _train.date.day,
//                                   _selectedTime.hour,
//                                   _selectedTime.minute,
//                                 ),
//                               ),
//                               // _train.time == null
//                               //     ? "Time not selected.."
//                               //     : DateFormat('hh:mm a').format(
//                               //         DateTime(
//                               //           2023,
//                               //           01,
//                               //           22,
//                               //           // _train.date.year,
//                               //           // _train.date.month,
//                               //           // _train.date.day,
//                               //           _selectedTime.hour,
//                               //           _selectedTime.minute,
//                               //         ),
//                               //       ),
//                               style: normalTextStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
