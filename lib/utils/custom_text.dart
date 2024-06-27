import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  final String text;
  final double? size;
  final FontWeight? fw;
  final TextAlign? align;
  final Color? color;

  const CustomText({super.key,  required this.text, this.size, this.fw, this.align, this.color});

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text,style: TextStyle(color:widget.color,fontSize:widget.size,fontWeight: widget.fw,fontFamily:"Roboto"  ),
    textAlign:widget.align,);
  }
}
