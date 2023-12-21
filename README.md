# Examen Flutter

Esta aplicación Flutter demuestra el uso de una clase personalizada `Persona` y un `PersonaWidget` para mostrar información sobre una persona de forma dinamica.

## Clase Persona

La clase `Persona` contiene `nombre`, `apellido` y opcionalmente una `edad`. Incluye un constructor de fábrica `Persona.conEdad` que permite crear una instancia de `Persona` con una edad.

```dart
class Persona {
  String nombre;
  String apellido;
  int? edad;

  Persona({required this.nombre, required this.apellido});

  factory Persona.conEdad({required String nombre, required String apellido, int? edad}) {
    Persona p = Persona(nombre: nombre, apellido: apellido);
    p.edad = edad;
    return p;
  }

  @override
  String toString() {
    return '$nombre $apellido${edad != null ? ', $edad años' : ''}';
  }
}
```

## PersonaWidget

`PersonaWidget` es un `StatelessWidget` que toma una instancia de `Persona` y se muestra en un widget `Text`. El texto se muestra en color azul y está centrado en un `Container` con un fondo blanco.

```dart
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
```