# Mão na Massa

Aplicativo Flutter de receitas simples para quem está começando na cozinha.

## Funcionalidades (até agora)
- Página principal com boas-vindas, categorias e receitas em destaque (dados provisórios).
- Campo rotulado "Nome da receita" com botão **Pesquisar** (também funciona pelo Enter do teclado).
- Consulta vazia ou só com espaços é recusada, sem iniciar pesquisa, com a mensagem:
  `Digite o nome de uma receita. Ex.: "bolo de cenoura".`
- Consulta válida: espaços nas pontas são removidos, espaços repetidos viram um só, e o termo é exibido num cartão de feedback. O usuário pode corrigir e pesquisar de novo ou limpar.

## Como rodar
```bash
flutter pub get
flutter run
```

## Estrutura
```
lib/
  main.dart
  pages/home_page.dart
```
