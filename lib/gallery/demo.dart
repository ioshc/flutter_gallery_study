import 'package:flutter/material.dart';

class ComponentDemoTabData {
  ComponentDemoTabData(
      {this.demoWidget, this.exampleCodeTag, this.description, this.tabName});

  final Widget demoWidget;
  final String exampleCodeTag;
  final String description;
  final String tabName;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    final ComponentDemoTabData typedOther = other;
    return typedOther.tabName == tabName &&
        typedOther.description == description;
  }

  @override
  int get hashCode => hashValues(tabName.hashCode, description.hashCode);
}

class TabbedComponentDemoScaffold extends StatelessWidget {
  const TabbedComponentDemoScaffold({
    this.title,
    this.demos,
    this.actions,
  });

  final List<ComponentDemoTabData> demos;
  final String title;
  final List<Widget> actions;

  void _showExampleCode(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: demos.length,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
          actions: (actions ?? <Widget>[])
            ..addAll(
              <Widget>[
                new IconButton(
                  icon: const Icon(Icons.description),
                  tooltip: 'Show example code',
                  onPressed: () {
                    _showExampleCode(context);
                  },
                ),
              ],
            ),
          bottom: new TabBar(
            isScrollable: true,
            tabs: demos
                .map((ComponentDemoTabData data) => new Tab(text: data.tabName))
                .toList(),
          ),
        ),
        body: new TabBarView(
          children: demos.map((ComponentDemoTabData demo) {
            return new SafeArea(
                top: false,
                bottom: false,
                child: new Column(
                  children: <Widget>[
                    new Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new Text(demo.description,
                            style: Theme.of(context).textTheme.subhead)),
                    new Expanded(child: demo.demoWidget)
                  ],
                ));
          }).toList(),
        ),
      ),
    );
  }
}
