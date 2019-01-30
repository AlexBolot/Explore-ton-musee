import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  // ----- Static area ----- //

  static ListView listView(List<Widget> children) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: children,
    );
  }

  static Row row(List<Widget> children) {
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

  static Color get yellow => Colors.yellow[600];

  static Color get turquoise => Colors.teal;

  // ------ non-static ----- //

  final Color color;
  final IconData icon;

  final double height;
  final double width;

  final String title;
  final String content;
  final TextAlign titleAlign;
  final TextAlign contentAlign;
  final bool contentFormatted;

  final double iconSize;
  final double titleSize;
  final double contentSize;

  final Function onPressed;

  final bool _isVertical;

  MenuItem.vertical({
    this.color,
    this.icon,
    this.title = '',
    this.content = '',
    this.titleAlign,
    this.contentAlign,
    this.contentFormatted = false,
    this.onPressed,
    this.height = 150,
    this.width,
  })  : iconSize = 48,
        titleSize = 18,
        contentSize = 14,
        _isVertical = true;

  MenuItem.horizontal({
    this.color,
    this.icon,
    this.title = '',
    this.content = '',
    this.titleAlign,
    this.contentAlign,
    this.contentFormatted = false,
    this.onPressed,
    this.height = 150,
    this.width,
  })  : iconSize = 64,
        titleSize = 22,
        contentSize = 16,
        _isVertical = false;

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    this.height = widget.height;
    this.width = widget.width;

    width ??= (widget._isVertical) ? height : 2 * height;

    return widget._isVertical ? buildVertical() : buildHorizontal();
  }

  Widget buildVertical() {
    return Container(
      height: this.height,
      width: this.width,
      child: _wrapInCard(Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _createIcon(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: _createTextArea(TextAlign.center),
            ),
          ),
        ],
      )),
    );
  }

  Widget buildHorizontal() {
    return Container(
      height: this.height,
      width: this.width,
      child: _wrapInCard(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _createIcon(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: _createTextArea(TextAlign.start),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget _wrapInCard(Widget child) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      elevation: 16,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
        onTap: widget.onPressed ?? () => print('Callback not given'),
        child: child,
      ),
    );
  }

  Widget _createIcon() => Icon(widget.icon, size: widget.iconSize, color: widget.color);

  List<Widget> _createTextArea(TextAlign titleAlign) {
    List<Widget> textArea = [];

    textArea.add(Container(
      width: double.infinity,
      child: Text(
        widget.title,
        softWrap: true,
        textAlign: titleAlign,
        style: TextStyle(fontSize: widget.titleSize, fontWeight: FontWeight.bold),
      ),
    ));

    if (widget.content.isNotEmpty) {
      textArea.add(Container(height: 8));
      textArea.add(Text(
        widget.content,
        softWrap: true,
        textAlign: widget.contentAlign ?? TextAlign.center,
        style: TextStyle(fontSize: widget.contentSize),
      ));
    }

    return textArea;
  }
}
