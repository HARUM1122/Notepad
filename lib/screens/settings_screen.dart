import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/radio/radio.dart';
class SettingsScreen extends StatefulWidget {
  final SettingsProvider settingsProvider;
  const SettingsScreen({required this.settingsProvider,super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:16,top:10,right:16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Appearance",
              style:Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 16
              )
            ),
            const SizedBox(height:10),
            GestureDetector(
              onTap:widget.settingsProvider.changeBool,
              child: Container(
                width:double.infinity,
                height:65,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(4),
                  color:Theme.of(context).cardColor
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width:10),
                    Icon(
                      Icons.palette_outlined,
                      size:30,
                      color:Theme.of(context).textTheme.titleLarge!.color
                    ),
                    const SizedBox(width:6),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height:10),
                          Text(
                            "App theme",
                            style:Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          const Spacer(),
                          Text(
                            "Select which app theme to display",
                            style:Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height:10)
                        ],
                      ),
                    ),
                    Consumer<SettingsProvider>(
                      builder:(context,settingsProv,child)=>AnimatedRotation(
                        turns: settingsProv.turns,
                        duration:const Duration(milliseconds: 60),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color:Theme.of(context).textTheme.titleLarge!.color
                        ),
                      ),
                    ),
                    const SizedBox(width:10)
                  ],
                )
              ),
            ),
            Consumer<SettingsProvider>(
              builder:(context,settingsProv,child)=>
              AnimatedContainer(
                margin:const EdgeInsets.only(top:1),
                padding:const EdgeInsets.only(left:40),
                duration:const Duration(milliseconds: 150),
                width:double.infinity,
                height:settingsProv.isOpened?150:0,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(4),
                  color:Theme.of(context).cardColor
                ),
                child:Consumer<ThemeProvider>(
                  builder: (context,themeProv,child)=>
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height:20),
                        CustomRadio(
                          title:"Light theme",
                          pressed: ()=>themeProv.changeTheme(ThemeMode.light),
                          selected:themeProv.themeMode==ThemeMode.light
                        ),
                        const SizedBox(height:20),
                        CustomRadio(
                          title:"Dark theme",
                          pressed: ()=>themeProv.changeTheme(ThemeMode.dark),
                          selected:themeProv.themeMode==ThemeMode.dark
                        ),
                        const SizedBox(height:20),
                        CustomRadio(
                          title:"System theme",
                          pressed: ()=>themeProv.changeTheme(ThemeMode.system),
                          selected:themeProv.themeMode==ThemeMode.system
                        ),
                      ],
                    ),
                  ),
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Current view",
                style:Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 16
                )
              ),
            ),
            Consumer<SettingsProvider>(
              builder:(context,settingsProv,_)=>
              Row(
                children: [
                  ViewRadioButton(
                    title: "List view",
                    pressed: ()=>settingsProv.changeView("ListView"),
                    selected: settingsProv.currentView=="ListView",
                    child:ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 30,
                      itemBuilder:(context,index)=>Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:Theme.of(context).cardColor,
                        ),
                        margin:const EdgeInsets.all(4),
                        height:30
                      )
                    ),
                  ),
                  const SizedBox(width:10),
                  ViewRadioButton(
                    title: "Grid view",
                    pressed: ()=>settingsProv.changeView("GridView"),
                    selected: settingsProv.currentView=="GridView",
                    child:GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: 30,
                      itemBuilder:(context,index)=>Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:Theme.of(context).cardColor,
                        ),
                        margin:const EdgeInsets.all(4),
                        height:30
                      )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}