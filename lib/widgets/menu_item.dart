import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  final double width;
  final double height;
  final IconData icon;
  final String title;
  final String content;
  final Function onPressed;
  final Color color;
  final double ratio;

  MenuItem({
    this.icon,
    this.onPressed,
    this.ratio,
    this.color,
    this.width,
    this.height = 150,
    this.title = 'Default Title',
    this.content = 'Default Content',
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  double width;
  double height;
  double ratio;
  String content;

  @override
  Widget build(BuildContext context) {
    this.ratio = widget.ratio ?? 1;

    this.height = widget.height;
    this.width = widget.width;

    this.width ??= this.height * this.ratio;
    this.height ??= this.width / this.ratio;

    this.content = reformat(widget.content, 25);

    return Container(
      height: this.height,
      width: this.width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        elevation: 16,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
          splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
          onTap: widget.onPressed ?? () => print('Callback not given'),
          child: this.ratio == 1 ? squareItem() : horizontalItem(),
        ),
      ),
    );
  }

  Widget squareItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Icon(
          widget.icon,
          size: 48,
          color: widget.color,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Container(height: 8),
              Text(this.content, softWrap: true, maxLines: 3, textAlign: TextAlign.center),
            ],
          ),
        ),
      ],
    );
  }

  Widget horizontalItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 64,
            color: widget.color,
          ),
          Container(width: 8.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                autoFitting(Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold))),
                autoFitting(Text(this.content, softWrap: true, maxLines: 3, textAlign: TextAlign.center)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget autoFitting(Widget child) => ListTile(dense: true, title: FittedBox(child: child));

  String reformat(String source, int maxLineLength) {
    if (source.length <= maxLineLength) return source;

    var spaceIndex = source.lastIndexOf(' ', maxLineLength);
    return (spaceIndex != -1) ? source.replaceFirst(' ', '\n', spaceIndex) : source;
  }
}
