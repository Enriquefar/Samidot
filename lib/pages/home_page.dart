import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  /// Termo válido já pesquisado (sem espaços nas pontas). Null = nenhuma pesquisa.
  String? _termoPesquisado;

  // Dados provisórios.
  static const _receitasDestaque = [
    _Receita('Ovo mexido', 'Fácil · 5 min', Icons.egg_alt),
    _Receita('Macarrão alho e óleo', 'Fácil · 15 min', Icons.ramen_dining),
    _Receita('Arroz soltinho', 'Fácil · 20 min', Icons.rice_bowl),
    _Receita('Bolo de caneca', 'Médio · 10 min', Icons.cake),
  ];

  static const _categorias = [
    'Café da manhã',
    'Almoço',
    'Lanches',
    'Sobremesas',
    'Sem fogão',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validarBusca(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Digite o nome de uma receita. Ex.: "bolo de cenoura".';
    }
    return null;
  }

  void _pesquisar() {
    // Valida; se inválido, mostra o erro e NÃO inicia a pesquisa.
    if (!_formKey.currentState!.validate()) {
      setState(() => _termoPesquisado = null);
      return;
    }
    // Remove espaços nas pontas e normaliza espaços repetidos no meio.
    final termo = _controller.text.trim().replaceAll(RegExp(r'\s+'), ' ');
    FocusScope.of(context).unfocus();
    setState(() => _termoPesquisado = termo);
  }

  void _limpar() {
    _controller.clear();
    _formKey.currentState?.reset();
    setState(() => _termoPesquisado = null);
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cores.primary,
        foregroundColor: cores.onPrimary,
        title: const Text('Mão na Massa'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Cabeçalho / boas-vindas
            Text('Bem-vindo à cozinha!', style: textos.headlineSmall),
            const SizedBox(height: 4),
            Text(
              'Receitas simples, passo a passo, para quem está começando.',
              style: textos.bodyMedium,
            ),
            const SizedBox(height: 20),

            // Busca
            Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (_) => _pesquisar(),
                      validator: _validarBusca,
                      decoration: const InputDecoration(
                        labelText: 'Nome da receita',
                        hintText: 'Ex.: macarrão',
                        prefixIcon: Icon(Icons.restaurant_menu),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: FilledButton.icon(
                      onPressed: _pesquisar,
                      icon: const Icon(Icons.search),
                      label: const Text('Pesquisar'),
                    ),
                  ),
                ],
              ),
            ),

            // Feedback da pesquisa válida
            if (_termoPesquisado != null) ...[
              const SizedBox(height: 12),
              Card(
                color: cores.secondaryContainer,
                child: ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: Text('Pesquisando por: "$_termoPesquisado"'),
                  subtitle: const Text(
                    'Resultados provisórios. Você pode corrigir o termo e pesquisar de novo.',
                  ),
                  trailing: IconButton(
                    tooltip: 'Limpar pesquisa',
                    icon: const Icon(Icons.close),
                    onPressed: _limpar,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),

            // Categorias
            Text('Categorias', style: textos.titleLarge),
            const SizedBox(height: 8),
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categorias.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => ActionChip(
                  label: Text(_categorias[i]),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Destaques
            Text('Receitas em destaque', style: textos.titleLarge),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                for (final r in _receitasDestaque) _ReceitaCard(receita: r),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Receita {
  final String nome;
  final String detalhe;
  final IconData icone;
  const _Receita(this.nome, this.detalhe, this.icone);
}

class _ReceitaCard extends StatelessWidget {
  final _Receita receita;
  const _ReceitaCard({required this.receita});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(receita.icone, size: 44, color: cores.primary),
              const SizedBox(height: 8),
              Text(
                receita.nome,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(receita.detalhe,
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
