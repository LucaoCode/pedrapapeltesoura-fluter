import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const JogoPPT());
}

class JogoPPT extends StatelessWidget {
  const JogoPPT({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const TelaJogo(),
    );
  }
}

class TelaJogo extends StatefulWidget {
  const TelaJogo({super.key});

  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  final Map<String, String> opcoes = {
    "pedra": "assets/pedra.png",
    "papel": "assets/papel.png",
    "tesoura": "assets/tesoura.png"
  };

  String imgUsuario = "assets/indefinido.png";
  String imgApp = "assets/indefinido.png";

  int pontosUsuario = 0;
  int pontosApp = 0;
  int empates = 0;

  Color corBordaUsuario = Colors.transparent;
  Color corBordaApp = Colors.transparent;

  String escolhaApp() {
    List<String> escolhas = opcoes.keys.toList();
    return escolhas[Random().nextInt(escolhas.length)];
  }

  void jogar(String escolhaUsuario) {
    String escolhaDoApp = escolhaApp();

    setState(() {
      imgUsuario = opcoes[escolhaUsuario]!;
      imgApp = opcoes[escolhaDoApp]!;

      if (escolhaUsuario == escolhaDoApp) {
        empates++;
        corBordaUsuario = Colors.orange;
        corBordaApp = Colors.orange;
      } else if ((escolhaUsuario == "pedra" && escolhaDoApp == "tesoura") ||
          (escolhaUsuario == "papel" && escolhaDoApp == "pedra") ||
          (escolhaUsuario == "tesoura" && escolhaDoApp == "papel")) {
        pontosUsuario++;
        corBordaUsuario = Colors.green;
        corBordaApp = Colors.transparent;
      } else {
        pontosApp++;
        corBordaUsuario = Colors.transparent;
        corBordaApp = Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedra, Papel e Tesoura"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Escolha sua jogada:", style: TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: opcoes.keys.map((opcao) {
                return GestureDetector(
                  onTap: () => jogar(opcao),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.deepPurple,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(opcoes[opcao]!, width: 80),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            const Text("Resultado da Rodada", style: TextStyle(fontSize: 22)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                JogadorBadge(borda: corBordaUsuario, imagem: imgUsuario),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("VS", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                JogadorBadge(borda: corBordaApp, imagem: imgApp),
              ],
            ),
            const SizedBox(height: 30),
            const Text("Placar", style: TextStyle(fontSize: 22)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Placar(nome: "Você", pontos: pontosUsuario),
                Placar(nome: "Empates", pontos: empates),
                Placar(nome: "App", pontos: pontosApp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class JogadorBadge extends StatelessWidget {
  final Color borda;
  final String imagem;

  const JogadorBadge({super.key, required this.borda, required this.imagem});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borda, width: 4),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image.asset(imagem, height: 120),
    );
  }
}

class Placar extends StatelessWidget {
  final String nome;
  final int pontos;

  const Placar({super.key, required this.nome, required this.pontos});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(nome, style: const TextStyle(fontSize: 18)),
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('$pontos', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
