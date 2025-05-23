import 'package:flutter/material.dart';
import 'package:sovawallet/ui/pages/node/screens/body_stats_nodes.dart';
import 'package:sovawallet/ui/pages/node/screens/list_nodes.dart';
import 'package:sovawallet/ui/theme/style/text_style.dart';

import '../../../l10n/app_localizations.dart';
import '../../theme/decoration/only_color_gradient_decoration.dart';

class NodePage extends StatelessWidget {
  const NodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: null, body: NodeBody());
  }
}

class NodeBody extends StatelessWidget {
  const NodeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
            decoration: const OnlyColorGradientDecoration(),
            child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      child: Column(
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 30),
                              child: StatsNodesUser()),
                          Expanded(
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                                child: Container(
                                  color: Theme.of(context).colorScheme.surface,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                            top: 20.0,
                                            bottom: 10.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  AppLocalizations.of(context)!
                                                      .masternode,
                                                  style: AppTextStyles
                                                      .categoryStyle),
                                            ]),
                                      ),
                                      const ListNodes()
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ))),
            )));
  }
}
