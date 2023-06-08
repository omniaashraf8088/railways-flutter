import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/model/train.dart';

class TrainItem extends StatefulWidget {
  final ITrain train;
  const TrainItem(this.train, {Key? key}) : super(key: key);

  @override
  State<TrainItem> createState() => _TrainItemState();
}

class _TrainItemState extends State<TrainItem> {
  bool _isExpanded = false;

  Future<bool?> _showConfirmDelete(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Delete Train'),
          content: const Text(
            'Are you sure you want to delete this train?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                // Provider.of<Trains>(context, listen: false)
                //     .deleteTrain(widget.train.id);
                // Navigator.of(ctx).pop(true);
                // showSnackBar(context, 'Deleted successfully', Colors.green);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _navigateToEditTrain(BuildContext context) async {
    final result =
        await Navigator.pushNamed(context, Routes.manageTrain) as bool?;
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.train.id),
      background: Container(
        color: Theme.of(context).errorColor,
        padding: const EdgeInsets.only(left: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        alignment: Alignment.centerLeft,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 30,
        ),
      ),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) => direction == DismissDirection.endToStart
          ? _navigateToEditTrain(context)
          : _showConfirmDelete(context),
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(widget.train.name),
              subtitle: Text(
                '${DateFormat('dd/MM/yyyy').format(widget.train.date)} ${widget.train.time}',
              ),
              trailing: IconButton(
                icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
            if (_isExpanded)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: 80,
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Text(widget.train.from),
                        const Text(
                          ' to ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(widget.train.to),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Text('Category: '),
                        Text(widget.train.category),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Text('Available Seats: '),
                        Text(widget.train.availableSeats.toString()),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Text('Stand Stations: '),
                        Text(widget.train.standStations.toString()),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
