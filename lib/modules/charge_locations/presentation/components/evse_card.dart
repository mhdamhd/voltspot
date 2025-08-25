import 'package:flutter/material.dart';
import 'package:voltspot/core/extensions/theme_extensions/text_theme_extension.dart';
import 'package:voltspot/modules/charge_locations/domain/entities/charge_location_entity.dart';

class EvseCard extends StatelessWidget {
  final EvseEntity evse;
  const EvseCard({super.key, required this.evse});

  String _statusLabel(EvseStatus status) {
    switch (status) {
      case EvseStatus.available:
        return 'Available';
      case EvseStatus.unavailable:
        return 'Unavailable';
      case EvseStatus.unknown:
      default:
        return 'Unknown';
    }
  }

  Color _getStatusColor(EvseStatus status) {
    switch (status) {
      case EvseStatus.available:
        return Colors.green;
      case EvseStatus.unavailable:
        return Colors.red;
      case EvseStatus.unknown:
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(EvseStatus status) {
    switch (status) {
      case EvseStatus.available:
        return Icons.electric_bolt;
      case EvseStatus.unavailable:
        return Icons.block;
      case EvseStatus.unknown:
      default:
        return Icons.help_outline;
    }
  }

  IconData _getConnectorIcon(String connectorType) {
    final type = connectorType.toLowerCase();
    if (type.contains('ccs')) {
      return Icons.power;
    } else if (type.contains('chademo')) {
      return Icons.electrical_services;
    } else if (type.contains('type2') || type.contains('type 2')) {
      return Icons.outlet;
    } else {
      return Icons.cable;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(evse.status);
    final statusIcon = _getStatusIcon(evse.status);
    final statusLabel = _statusLabel(evse.status);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: statusColor.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              statusColor.withOpacity(0.05),
              Colors.transparent,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with EVSE ID and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.charging_station,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            evse.evseId,
                            style: context.f16600!.copyWith(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(statusColor, statusIcon, statusLabel),
                ],
              ),

              const SizedBox(height: 16),

              // Connector and Power Information
              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      context,
                      icon: _getConnectorIcon(evse.connectorType),
                      label: 'Connector',
                      value: evse.connectorType,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInfoCard(
                      context,
                      icon: Icons.flash_on,
                      label: 'Power',
                      value: evse.powerType,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(Color color, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        required Color color,
      }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: color,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: context.f10400!.copyWith(color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}