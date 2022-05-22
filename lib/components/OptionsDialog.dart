import 'package:flutter/material.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';

class OptionsDialog extends StatefulWidget {
  const OptionsDialog({Key? key, required this.options, required this.selected})
      : super(key: key);
  final List<String> options;
  final List<String> selected;

  @override
  _OptionsDialogState createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {

  addOption(String o){
    if(widget.selected.contains(o)) return;
    setState(() {
      widget.selected.add(o);
    });

  }
  removeOption(String o){
    if(!widget.selected.contains(o)) return;
    setState(() {
      widget.selected.remove(o);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(expand: false,
      maxChildSize: 0.75,
      initialChildSize: 0.75,
      minChildSize: 0.5,
      builder: (BuildContext context, ScrollController scrollController) {

        return  SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: widget.options
                  .map((e) => GestureDetector(
                    onTap: (){
                  if(!widget.selected.contains(e)) {
                    addOption(e);
                  } else {
                    removeOption(e);
                  }
                  },
                    child: Container(
                      decoration: BoxDecoration(color: AppColor.optionBg, borderRadius: BorderRadius.circular(40)),
                      child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: AppColor.primary,
                        value: widget.selected.contains(e),
                        onChanged: (v){
                        if(v==null) return;
                          if(v) {
                            addOption(e);
                          } else {
                            removeOption(e);
                          }
                        }
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(e),
                      )
                    ],
                  ),
                    ),
                  ))
                  .toList(),
            ),
          ),
        );

      },
    );
  }
}
