import 'package:flutter/material.dart';

class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool? showEditIcon;
  final VoidCallback? onEditPressed;
  final Color? iconColor;

  const ProfileInfoItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    this.showEditIcon,
    this.onEditPressed,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(value),
                ],
              ),
            ),
            if (showEditIcon ?? false)
              IconButton(
                onPressed: onEditPressed,
                icon: Icon(Icons.edit),
                color: Colors.blue,
              ),
          ],
        ),
        Divider(color: Colors.deepPurple[100]),
      ],
    );
  }
}
