import 'package:flutter/material.dart';

class Persona {
  String nombre;
  String apellido;
  int? edad;

  Persona({required this.nombre, required this.apellido, this.edad});

  factory Persona.conEdad(
      {required String nombre, required String apellido, int? edad}) {
    Persona p = Persona(nombre: nombre, apellido: apellido);
    p.edad = edad;
    return p;
  }

  @override
  String toString() {
    return '$nombre $apellido${edad != null ? ', $edad años' : ''}';
  }
}

class PersonaWidget extends StatelessWidget {
  final Persona persona;

  const PersonaWidget({Key? key, required this.persona}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          persona.toString(),
          style: const TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List<Persona> students = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Examen Programacion Movil')),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return PersonaWidget(persona: students[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final TextEditingController nombreController =
              TextEditingController();
          final TextEditingController apellidoController =
              TextEditingController();
          final TextEditingController edadController = TextEditingController();
          final ValueNotifier<bool> isAgeValid = ValueNotifier<bool>(true);

          edadController.addListener(() {
            isAgeValid.value = int.tryParse(edadController.text) != null;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ValueListenableBuilder<bool>(
                valueListenable: isAgeValid,
                builder: (context, isValid, child) {
                  return AlertDialog(
                    title: const Text('Anadir nuevo estudiante'),
                    content: SingleChildScrollView(
                        child: ListBody(
                      children: [
                        TextField(
                          controller: nombreController,
                          decoration: const InputDecoration(
                              hintText: "Ingrese el Nombre"),
                        ),
                        TextField(
                          controller: apellidoController,
                          decoration: const InputDecoration(
                              hintText: "Ingrese el Apellido"),
                        ),
                        TextField(
                          controller: edadController,
                          decoration: InputDecoration(
                            hintText: "Ingrese la Edad",
                            errorText: isValid ? null : "Ingrese un Numero",
                          ),
                        ),
                      ],
                    )),
                    actions: [
                      TextButton(
                        onPressed: isValid
                            ? () {
                                int? edad = int.tryParse(edadController.text);
                                Persona p = Persona.conEdad(
                                    nombre: nombreController.text,
                                    apellido: apellidoController.text,
                                    edad: edad);

                                setState(() {
                                  students.add(p);
                                });

                                Navigator.of(context).pop();
                              }
                            : null,
                        child: const Text('Agregar'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: MyApp()));
}
