import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../../core/salon_data.dart';

const navItems = <(String, String)>[('HOME','home'),('CONCEPT','concept'),('MENU','menu'),('STYLE','style'),('STAFF','staff'),('ACCESS','access'),('CONTACT','contact')];

class Header extends StatefulWidget {
  const Header({required this.onMenuPressed, required this.onNavigate, required this.scrollController, super.key});
  final VoidCallback onMenuPressed; final ValueChanged<String> onNavigate; final ScrollController scrollController;
  @override State<Header> createState() => _HeaderState();
}
class _HeaderState extends State<Header> {
  bool scrolled=false;
  @override void initState(){super.initState();widget.scrollController.addListener(onScroll);}
  void onScroll(){final value=widget.scrollController.hasClients&&widget.scrollController.offset>30;if(value!=scrolled)setState(()=>scrolled=value);}
  @override void dispose(){widget.scrollController.removeListener(onScroll);super.dispose();}
  @override Widget build(BuildContext context)=>SliverAppBar(
    pinned:true, toolbarHeight:context.isMobile?68:82, automaticallyImplyLeading:false, surfaceTintColor:Colors.transparent,
    backgroundColor: scrolled?AppColors.white.withValues(alpha:.96):AppColors.ivory,
    shadowColor:const Color(0x18292724), elevation:scrolled?3:0,
    title:Center(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:Breakpoints.maxContent),child:Padding(padding:EdgeInsets.symmetric(horizontal:context.horizontalPadding),child:Row(children:[
      _Logo(onTap:()=>widget.onNavigate('home')), const Spacer(),
      if(context.isDesktop)...[for(final item in navItems.skip(1)) TextButton(onPressed:()=>widget.onNavigate(item.$2),style:TextButton.styleFrom(foregroundColor:AppColors.charcoal,padding:const EdgeInsets.symmetric(horizontal:10)),child:Text(item.$1,style:const TextStyle(fontSize:11,letterSpacing:1.3))),const SizedBox(width:12),FilledButton(onPressed:()=>widget.onNavigate('contact'),child:const Text('RESERVATION'))]
      else IconButton(onPressed:widget.onMenuPressed,tooltip:'メニューを開く',icon:const Icon(Icons.menu_rounded,size:29)),
    ])))),
  );
}
class _Logo extends StatelessWidget {const _Logo({this.onTap}); final VoidCallback? onTap;
  @override Widget build(BuildContext context)=>InkWell(onTap:onTap,child:const Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisSize:MainAxisSize.min,children:[Text(SalonData.name,style:TextStyle(fontSize:20,fontWeight:FontWeight.w500,letterSpacing:2.2,color:AppColors.charcoal)),Text('HAIR & LIFESTYLE',style:TextStyle(fontSize:8,letterSpacing:2.4,color:AppColors.taupe))]));}
class SalonDrawer extends StatelessWidget {const SalonDrawer({required this.onNavigate,super.key});final ValueChanged<String> onNavigate;
 @override Widget build(BuildContext context)=>NavigationDrawer(backgroundColor:AppColors.ivory,children:[const Padding(padding:EdgeInsets.fromLTRB(28,32,24,20),child:_Logo()),const Divider(),for(final item in navItems)ListTile(contentPadding:const EdgeInsets.symmetric(horizontal:28,vertical:4),title:Text(item.$1,style:const TextStyle(letterSpacing:1.8,fontSize:13)),onTap:()=>onNavigate(item.$2)),Padding(padding:const EdgeInsets.all(28),child:FilledButton(onPressed:()=>onNavigate('contact'),child:const Text('WEB RESERVATION')))]);}
