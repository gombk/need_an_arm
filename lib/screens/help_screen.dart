import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = '/help-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Como usar/Sobre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Ajuda\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    TextSpan(
                      text:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus faucibus turpis et sagittis congue. Nullam eros mi, hendrerit vitae mi ac, efficitur sagittis urna.\n\n',
                    ),
                    TextSpan(
                      text:
                          'Duis tempus nunc vitae nibh elementum vehicula. Cras consequat libero bibendum dui sollicitudin egestas. Morbi eu leo et augue semper consectetur a non dui. Mauris porttitor quis sapien vitae placerat. Etiam facilisis posuere molestie.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text:
                          '\n\nIn hac habitasse platea dictumst. Quisque pellentesque est et porta interdum. Duis viverra fringilla congue. Donec odio enim, eleifend eu ipsum ut, pharetra rhoncus sem. Donec nunc purus, rhoncus non dapibus sit amet, congue commodo nisi. Mauris eros justo, placerat quis arcu eu, accumsan varius nibh. \nOrci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Phasellus tincidunt consequat viverra.\n\n',
                    ),
                    TextSpan(
                      text: 'Phasellus ullamcorper felis id ligula tempus, at posuere risus vulputate. Sed hendrerit nisl vel ex ultrices consequat. Nullam placerat sem vel nisl rhoncus, in viverra nulla maximus. Morbi dui lorem, pharetra finibus rhoncus a, efficitur non tellus. In rutrum egestas erat, vel gravida dui consectetur non. Quisque tempor lorem tortor, et facilisis metus scelerisque sed. In ullamcorper malesuada tortor. Phasellus pharetra odio dui, ultricies mollis leo convallis ut. Aenean elementum lorem non lectus aliquam, a cursus risus vulputate. Donec felis nisl, egestas quis dapibus tincidunt, sollicitudin eu enim. Vestibulum feugiat quam nec nunc cursus, vitae sollicitudin dolor imperdiet. Mauris nec dui in neque malesuada egestas sed at magna.\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '\nSobre\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    TextSpan(
                      text: 'Aplicativo mobile Need an Arm:\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.0),
                    ),
                    TextSpan(text: 'Lucas Zenaro'),
                    TextSpan(
                      text: '\n\nLógica ESP-32 para o braço robótico:\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.0),
                    ),
                    TextSpan(text: 'Matheus Fenólio do Prado'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
