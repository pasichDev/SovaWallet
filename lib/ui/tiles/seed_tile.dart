import 'package:flutter/material.dart';
import 'package:noso_dart/models/noso/seed.dart';
import 'package:sovawallet/ui/theme/style/icons_style.dart';
import 'package:sovawallet/ui/theme/style/text_style.dart';

import '../../configs/network_config.dart';
import '../../utils/enum.dart';
import '../common/widgets/custom/shimmer.dart';
import '../common/widgets/node_status.dart';
import '../config/responsive.dart';

class SeedListItem extends StatelessWidget {
  final Seed seed;
  final StatusConnectNodes statusConnected;

  const SeedListItem({
    super.key,
    required this.seed,
    this.statusConnected = StatusConnectNodes.searchNode,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppIconsStyle.icon3x2(
          CheckConnect.getStatusConnected(statusConnected)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (statusConnected == StatusConnectNodes.searchNode ) //statusConnected == StatusConnectNodes.sync || || statusConnected == StatusConnectNodes.consensus
                Container(
                  margin: EdgeInsets.zero,
                  child: ShimmerPro.sized(
                    depth: 16,
                    scaffoldBackgroundColor:
                        Colors.grey.shade100.withOpacity(0.5),
                    width: 110,
                    borderRadius: 3,
                    height: 16,
                  ),
                )
              else
                Column(
                  children: [
                    Text(
                      seed.toTokenizer,
                      style: AppTextStyles.walletHash,
                    ),
                  ],
                ),
              if (Responsive.isMobile(context)) ...[
                NodeStatusUi.getNodeDescription(context, statusConnected, seed)
              ],
            ],
          ),
        ],
      ),
      onTap: null,
    );
  }
}
