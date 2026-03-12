import '/components/menu/horizontal/menu_horizonta_items/menu_horizonta_items_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'menu_horizonta_options_page_model.dart';
export 'menu_horizonta_options_page_model.dart';

class MenuHorizontaOptionsPageWidget extends StatefulWidget {
  const MenuHorizontaOptionsPageWidget({
    super.key,
    this.items,
  });

  final List<dynamic>? items;

  @override
  State<MenuHorizontaOptionsPageWidget> createState() =>
      _MenuHorizontaOptionsPageWidgetState();
}

class _MenuHorizontaOptionsPageWidgetState
    extends State<MenuHorizontaOptionsPageWidget> {
  late MenuHorizontaOptionsPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuHorizontaOptionsPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final dynamicItems = widget!.items?.toList() ?? [];

        return Wrap(
          spacing: 24.0,
          runSpacing: 0.0,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.horizontal,
          runAlignment: WrapAlignment.start,
          verticalDirection: VerticalDirection.down,
          clipBehavior: Clip.none,
          children: List.generate(dynamicItems.length, (dynamicItemsIndex) {
            final dynamicItemsItem = dynamicItems[dynamicItemsIndex];
            return MenuHorizontaItemsWidget(
              key: Key('Key7ri_${dynamicItemsIndex}_of_${dynamicItems.length}'),
              info: dynamicItemsItem,
            );
          }),
        );
      },
    );
  }
}
