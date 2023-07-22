import 'package:cinema_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreferencesView extends ConsumerStatefulWidget {
  const PreferencesView({super.key});

  @override
  PreferencesViewState createState() => PreferencesViewState();
}

class PreferencesViewState extends ConsumerState<PreferencesView> {
  @override
  Widget build(BuildContext context) {
    bool isDarkmode = ref.watch(themeNotifierProvider).isDarkmode;
    return Scaffold(
        body: ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: SwitchListTile(
            title: const Text("Cambiar de tema"),
            subtitle: isDarkmode
                ? const Text("A tema claro")
                : const Text("A tema oscuro"),
            value: isDarkmode,
            onChanged: (value) {
              ref.read(themeNotifierProvider.notifier).toggleDarkmode();
              setState(() {
                isDarkmode = !isDarkmode;
              });
            },
          ),
        )
      ],
    ));
  }
}
