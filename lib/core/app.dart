import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skuadchallengue/modules/home/presentation/bloc/home_bloc.dart';
import 'package:skuadchallengue/modules/home/presentation/page/home_page.dart';

import 'bootstrapper.dart';

class App extends StatefulWidget {
  App({
    required this.bootstrapper,
    Key? key,
  }) : super(key: key);

  final Bootstrapper bootstrapper;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.bootstrapper.bootstrap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<InitializationStatus>(
      initialData: InitializationStatus.initializing,
      stream: widget.bootstrapper.initializationStream,
      builder: (_, snapshot) {
        Widget result;
        switch (snapshot.data) {
          case InitializationStatus.initialized:
            result = MultiBlocProvider(
              providers: [
                BlocProvider<HomeBloc>(
                  create: (_) => widget.bootstrapper.homeBloc,
                )
              ],
              child: const MaterialApp(
                home: HomePage(),
              ),
            );
            break;
          case InitializationStatus.error:
            result = const SizedBox.shrink();
            break;
          case InitializationStatus.initializing:
            result = const SizedBox.shrink();
            break;
          case InitializationStatus.unsafeDevice:
            result = const SizedBox.shrink();
            break;
          case InitializationStatus.disposed:
            result = const SizedBox.shrink();
            break;
          case null:
            result = const SizedBox.shrink();
        }
        return result;
      },
    );
  }
}
