import 'package:flutter_modular/flutter_modular.dart';

import 'view/pages/line_chart/line_chart_page.dart';

class LineChartModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const LineChartPage()),
  ];
}
