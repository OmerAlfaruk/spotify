import 'package:flutter/material.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? title;
  final Widget? action;
  final bool hideBack;
  final Color?backgroundColor;
  const BasicAppBar({super.key, this.title, this.hideBack=false,this.action, this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: backgroundColor??Colors.transparent,
    title: title??Text(''),
    centerTitle: true,
    elevation: 0,

      leading: hideBack||!Navigator.canPop(context)?null:IconButton(onPressed: (){ if (Navigator.canPop(context)) {
        Navigator.of(context).maybePop();
      }}, icon: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(color:context.isDarkMode? Colors.white.withOpacity(0.03):Colors.black.withOpacity(0.03),
        shape: BoxShape.circle,),
        child: Icon(Icons.arrow_back_ios_new,
        color: context.isDarkMode?Colors.white:Colors.black,),
      ),
      ),
      actions: [
        action??Container()
      ],
    );
  }

  @override
 Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
