import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  // ----- Static area ----- //

  static Row group(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: children,
    );
  }

  static Color get blue => Colors.lightBlue;

  static Color get purple => Colors.deepPurpleAccent.withOpacity(0.8);

  static Color get green => Colors.green;

  static Color get orange => Colors.orange;

  static Color get turquoise => Colors.teal;

  // ------ non-static ----- //

  final double width;
  final double height;
  final IconData icon;
  final String title;
  final String content;
  final Function onPressed;
  final Color color;
  final double ratio;
  final TextAlign titleAlign;
  final TextAlign contentAlign;
  final bool contentFormatted;

  MenuItem({
    this.icon,
    this.onPressed,
    this.ratio,
    this.color,
    this.width,
    this.height = 150,
    this.titleAlign = TextAlign.center,
    this.contentAlign = TextAlign.center,
    this.title = 'Default Title',
    this.content = 'Default Content',
    this.contentFormatted = false,
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
    this.content = widget.content;

    this.width ??= this.height * this.ratio;
    this.height ??= this.width / this.ratio;

    if (widget.contentFormatted == false) this.content = reformat(widget.content, 25);

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
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                softWrap: true,
                textAlign: widget.titleAlign,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(height: 8),
              Text(
                this.content,
                softWrap: true,
                maxLines: 3,
                textAlign: widget.contentAlign,
              ),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.title,
                  softWrap: true,
                  textAlign: widget.titleAlign,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(height: 8),
                Text(
                  this.content,
                  softWrap: true,
                  textAlign: widget.contentAlign,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String reformat(String source, int maxLineLength) {
    if (source.length <= maxLineLength) return source;

    var spaceIndex = source.lastIndexOf(' ', maxLineLength);

    if (spaceIndex == -1) return source;

    String firstLine = source.substring(0, spaceIndex);
    String rest = source.substring(spaceIndex + 1);

    return firstLine + '\n' + reformat(rest, maxLineLength);
  }
}
