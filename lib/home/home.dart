import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:mdw_crew/components/dialog_c.dart';
import 'package:mdw_crew/components/home/bottom_c.dart';
import 'package:mdw_crew/components/text_c.dart';
import 'package:mdw_crew/home/pages/check.dart';
import 'package:mdw_crew/home/pages/checkout/check_out.dart';
import 'package:mdw_crew/home/pages/admission.dart';
import 'package:mdw_crew/provider/mdw_socket_p.dart';
import 'package:mdw_crew/registration/login.dart';
import 'package:mdw_crew/service/storage.dart';
import 'package:mdw_crew/tool/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:transition/transition.dart';

class Home extends StatefulWidget {
  
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final PageController controller = PageController();
  
  int? active = 0; 

  @override
  void initState() {

    controller.addListener(() {
      setState(() {
        
        active = controller.page!.toInt();
      });
    });
    super.initState();
  }

  Color? color = Colors.green.withOpacity(0.3);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppUtil.convertHexaColor("#F2F2F2"),
      body: SafeArea(
        child: PageView(
          controller: controller,
          onPageChanged: (value) {
            setState(() {
              active = controller.page!.toInt();

              if (controller.page!.toInt() == 0){
                color = Colors.blue.withOpacity(0.3);
              } else if ((controller.page!.toInt() == 1)){
                color = Colors.red.withOpacity(0.3);
              }
            });
          },
          children: [
            // Check(tabType: 'Check',),
            Admission(tabType: 'Admission'),
            const CheckOut(),
          ],
        ),
      ),
      bottomNavigationBar: bottomAppBarNoCheck(context: context, controller: controller, active: active)
    );
  }
}