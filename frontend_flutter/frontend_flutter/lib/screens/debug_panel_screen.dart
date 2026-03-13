import 'dart:ui';
import 'dart:async'; // 🚀 ADICIONE ESTA LINHA AQUI!
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/socket_service.dart';

class DebugPanelScreen extends StatefulWidget {
  const DebugPanelScreen({super.key});

  @override
  State<DebugPanelScreen> createState() => _DebugPanelScreenState();
}

class _DebugPanelScreenState extends State<DebugPanelScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  final Color bgBlack = const Color(0xFF09090B);
  final Color panelGray = const Color(0xFF141417);
  final Color accentYellow = const Color(0xFFFFD600);
  final Color textPrimary = const Color(0xFFE4E4E7);
  final Color textSecondary = const Color(0xFFA1A1AA);

  // Variáveis
  String? _selectedKey;
  dynamic _selectedValue;
  String? _selectedCategory;
  
  // Custom Code
  int _currentTabIndex = 0;
  List<dynamic> _customCodeFiles = [];
  bool _isLoadingCode = false;
  Map<String, dynamic>? _selectedCodeFile;

  // IA
  bool _isAnalyzingCode = false;
  String? _aiAnalysisResult;

// 🚀 Árvore de Páginas, Componentes e Rotas
  List<dynamic> _pagesTree = [];
  List<dynamic> _componentsTree = [];
  String? _selectedRoute;

  // 🚀 Monitor do Console & Sandin AI
  List<String> _consoleLogs = [];
  List<Map<String, dynamic>> _chatHistory = [];
  final ScrollController _consoleScroll = ScrollController();
  final ScrollController _chatScroll = ScrollController();
  final TextEditingController _chatInputController = TextEditingController();
  bool _isSandinThinking = false;
  String _currentErrorContext = '';
  Timer? _errorDebounceTimer;

  // Variável do Network
  Map<String, dynamic>? _selectedNetworkCall;

  @override
  void initState() {
    super.initState();
    final socketService = context.read<SocketService>();
    socketService.connect('auto');
    _fetchPagesTree();
    
    // 🚀 O VIGILANTE: Escuta o console e procura por erros!
    socketService.logStream.listen((logStr) {
      setState(() {
        _consoleLogs.add(logStr);
        if (_consoleLogs.length > 300) _consoleLogs.removeAt(0); // Mantém limite de linhas
      });
      
      // Desce o scroll automaticamente
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_consoleScroll.hasClients) _consoleScroll.jumpTo(_consoleScroll.position.maxScrollExtent);
      });

      // LÓGICA DE INTERCEPTAÇÃO: Se for um erro, o Sandin entra em ação!
      if (logStr.contains('EXCEPTION CAUGHT') || logStr.contains('Error:') || logStr.contains('Exception:')) {
        _currentErrorContext += logStr + '\n';
        _triggerAutoAnalyzeError();
      } else if (_currentErrorContext.isNotEmpty) {
        _currentErrorContext += logStr + '\n';
        _triggerAutoAnalyzeError();
      }
    });
  }

  // Agrupa as linhas do erro (Stack Trace) antes de enviar para a IA
  void _triggerAutoAnalyzeError() {
    _errorDebounceTimer?.cancel();
    _errorDebounceTimer = Timer(const Duration(milliseconds: 1500), () async {
      final errorToAnalyze = _currentErrorContext;
      _currentErrorContext = ''; // Reseta
      if (errorToAnalyze.trim().isEmpty) return;

      setState(() {
        _chatHistory.add({'role': 'system', 'text': '🚨 Erro crítico interceptado no console. O Sandin está investigando o código fonte...'});
        _isSandinThinking = true;
      });

      try {
        final res = await http.post(Uri.parse('http://localhost:3000/api/chat'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({'errorLog': errorToAnalyze}));
        setState(() {
          _chatHistory.add({'role': 'ai', 'text': jsonDecode(res.body)['analysis']});
          _isSandinThinking = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) { if (_chatScroll.hasClients) _chatScroll.jumpTo(_chatScroll.position.maxScrollExtent); });
      } catch (e) {
        setState(() { _chatHistory.add({'role': 'system', 'text': 'Falha ao acionar Sandin AI: $e'}); _isSandinThinking = false; });
      }
    });
  }

  Future<void> _sendManualChatMessage() async {
    final text = _chatInputController.text.trim();
    if (text.isEmpty) return;
    _chatInputController.clear();
    setState(() { _chatHistory.add({'role': 'user', 'text': text}); _isSandinThinking = true; });
    WidgetsBinding.instance.addPostFrameCallback((_) { if (_chatScroll.hasClients) _chatScroll.jumpTo(_chatScroll.position.maxScrollExtent); });
    
    try {
      final res = await http.post(Uri.parse('http://localhost:3000/api/chat'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({'message': text}));
      setState(() { _chatHistory.add({'role': 'ai', 'text': jsonDecode(res.body)['analysis']}); _isSandinThinking = false; });
      WidgetsBinding.instance.addPostFrameCallback((_) { if (_chatScroll.hasClients) _chatScroll.jumpTo(_chatScroll.position.maxScrollExtent); });
    } catch (e) {
      setState(() { _isSandinThinking = false; });
    }
  }

  Future<void> _fetchPagesTree() async {
    try {
      final res = await http.get(Uri.parse('http://localhost:3000/api/pages-tree'));
      if (res.statusCode == 200) {
        setState(() {
          _pagesTree = jsonDecode(res.body)['pages'] ?? [];
          _componentsTree = jsonDecode(res.body)['components'] ?? [];
        });
      }
    } catch (e) {
      debugPrint('Erro ao buscar pages tree: $e');
    }
  }

  Future<void> _fetchCustomCode() async {
    setState(() => _isLoadingCode = true);
    try {
      final res = await http.get(Uri.parse('http://localhost:3000/api/custom-code'));
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        setState(() {
          _customCodeFiles = body['files'] ?? [];
          if (_customCodeFiles.isNotEmpty && _selectedCodeFile == null) _selectedCodeFile = _customCodeFiles.first;
        });
      }
    } catch (e) {}
    setState(() => _isLoadingCode = false);
  }

  Future<void> _analyzeCodeWithAI() async {
    if (_selectedCodeFile == null) return;
    setState(() { _isAnalyzingCode = true; _aiAnalysisResult = null; });
    try {
      final res = await http.post(Uri.parse('http://localhost:3000/api/analyze-code'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({'code': _selectedCodeFile!['content']}));
      setState(() => _aiAnalysisResult = res.statusCode == 200 ? jsonDecode(res.body)['analysis'] : 'Erro: ${jsonDecode(res.body)['error']}');
    } catch (e) {
      setState(() => _aiAnalysisResult = 'Falha local: $e');
    } finally {
      setState(() => _isAnalyzingCode = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      body: Row(
        children: [
          _buildSideNav(),
          Expanded(
            child: Column(
              children: [
                _buildGlassHeader(context),
                Expanded(child: _buildCurrentTabContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideNav() {
    return Container(
      width: 64, color: panelGray,
      child: Column(
        children: [
          const SizedBox(height: 24),
          Icon(Icons.hub_rounded, color: accentYellow, size: 28),
          const SizedBox(height: 32),
          _buildNavButton(0, Icons.data_object, 'Variáveis de Estado'),
          _buildNavButton(1, Icons.account_tree_rounded, 'Árvore de Páginas/Widgets'),
          _buildNavButton(2, Icons.code_rounded, 'Custom Code Explorer'),
          _buildNavButton(3, Icons.terminal_rounded, 'Console & Sandin AI Copilot'),
          _buildNavButton(4, Icons.wifi_tethering_rounded, 'Network Inspector'), // NOVO!
        ],
      ),
    );
  }

  Widget _buildNavButton(int index, IconData icon, String tooltip) {
    final isSelected = _currentTabIndex == index;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () {
          setState(() => _currentTabIndex = index);
          if (index == 1 && _pagesTree.isEmpty) _fetchPagesTree();
          if (index == 2 && _customCodeFiles.isEmpty) _fetchCustomCode();
        },
        child: Container(
          width: 64, padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(border: Border(left: BorderSide(color: isSelected ? accentYellow : Colors.transparent, width: 3))),
          child: Icon(icon, color: isSelected ? accentYellow : textSecondary.withOpacity(0.5), size: 24),
        ),
      ),
    );
  }

Widget _buildCurrentTabContent() {
    if (_currentTabIndex == 1) return _buildWidgetTreeTab();
    if (_currentTabIndex == 2) return _buildCustomCodeTab();
    if (_currentTabIndex == 3) return _buildConsoleAndAITab();
    if (_currentTabIndex == 4) return _buildNetworkTab(); // A NOVA ABA!
    return _buildVariableInspectorTab();
  }

  // ==========================================
  // 🚀 ABA 2: WIDGET TREE & ROUTE INSPECTOR
  // ==========================================
  Widget _buildWidgetTreeTab() {
    return StreamBuilder<Map<String, dynamic>>(
      stream: context.watch<SocketService>().stateStream,
      builder: (context, snapshot) {
        if (_pagesTree.isEmpty && _componentsTree.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: accentYellow),
                const SizedBox(height: 16),
                Text('Mapeando as páginas do seu projeto...', style: TextStyle(color: textSecondary)),
              ]
            )
          );
        }

        final data = snapshot.data ?? {};
        final activePageStr = data['active_page'] ?? '';
        final activeRouteName = activePageStr.replaceAll('Model', '').replaceAll('Widget', '');
        
        final displayRoute = _selectedRoute ?? (activeRouteName.isNotEmpty ? activeRouteName : (_pagesTree.isNotEmpty ? _pagesTree.first['route'] : ''));
        
        // Busca a árvore na lista de páginas ou de componentes
        Map<String, dynamic>? selectedPageData;
        try { selectedPageData = _pagesTree.firstWhere((p) => p['route'] == displayRoute); } 
        catch (_) {
          try { selectedPageData = _componentsTree.firstWhere((p) => p['route'] == displayRoute); } 
          catch (_) { selectedPageData = _pagesTree.isNotEmpty ? _pagesTree.first : null; }
        }
        
        final treeNodes = selectedPageData?['tree'] as List<dynamic>? ?? [];

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PAINEL ESQUERDO: LISTA SEPARADA DE PÁGINAS E COMPONENTES
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(color: panelGray, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.05))),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        color: Colors.black.withOpacity(0.2),
                        child: Row(
                          children: [
                            Icon(Icons.route_rounded, color: accentYellow, size: 18),
                            const SizedBox(width: 8),
                            Text('Estrutura do App', style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          children: [
                            if (_pagesTree.isNotEmpty)
                              _buildRouteGroup('Páginas', _pagesTree, activeRouteName, displayRoute, Icons.web_asset_rounded),
                            if (_componentsTree.isNotEmpty)
                              _buildRouteGroup('Componentes', _componentsTree, activeRouteName, displayRoute, Icons.extension_rounded),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // PAINEL DIREITO: A WIDGET TREE COM SCROLL DUPLO (2D)
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(color: panelGray, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.05))),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        color: Colors.black.withOpacity(0.2),
                        child: Row(
                          children: [
                            Icon(Icons.account_tree_rounded, color: accentYellow, size: 18),
                            const SizedBox(width: 8),
                            Text('Widget Tree real: ', style: TextStyle(color: textSecondary, fontSize: 13)),
                            Text(displayRoute, style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'monospace')),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: bgBlack.withOpacity(0.3),
                          child: treeNodes.isEmpty 
                          ? Center(child: Text('Nenhuma árvore de widgets detectada.', style: TextStyle(color: textSecondary)))
                          // 🚀 O SEGREDO DO SCROLL 2D: Um scroll vertical englobando um scroll horizontal
                          : SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: treeNodes.map((node) {
                                    return _buildTreeNode(node['name'], node['depth']);
                                  }).toList(),
                                ),
                              ),
                            ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // Helper para construir as pastas da lateral
  Widget _buildRouteGroup(String title, List<dynamic> items, String activeRouteName, String displayRoute, IconData folderIcon) {
    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        iconColor: accentYellow,
        collapsedIconColor: textSecondary,
        title: Text(title.toUpperCase(), style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 12)),
        children: items.map((page) {
          final isSelected = page['route'] == displayRoute;
          final isLiveActive = page['route'] == activeRouteName;

          return InkWell(
            onTap: () => setState(() => _selectedRoute = page['route']),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? accentYellow.withOpacity(0.05) : Colors.transparent,
                border: Border(left: BorderSide(color: isSelected ? accentYellow : Colors.transparent, width: 3))
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Icon(folderIcon, size: 14, color: isSelected ? accentYellow : textSecondary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(page['route'], style: TextStyle(
                      color: isSelected ? textPrimary : textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13
                    )),
                  ),
                  if (isLiveActive)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                      child: const Text('LIVE', style: TextStyle(color: Colors.green, fontSize: 9, fontWeight: FontWeight.bold)),
                    )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 🚀 AQUI ESTÁ A CORREÇÃO DO ERRO DE RENDER FLEX!
  Widget _buildTreeNode(String name, int depth) {
    IconData icon = Icons.widgets_outlined;
    if (name.contains('Container')) icon = Icons.check_box_outline_blank;
    else if (name.contains('Text')) icon = Icons.text_fields;
    else if (name.contains('Column')) icon = Icons.view_column;
    else if (name.contains('Row')) icon = Icons.table_rows;
    else if (name.contains('Image')) icon = Icons.image;
    else if (name.contains('ListView') || name.contains('PageView')) icon = Icons.format_list_bulleted;
    else if (name.contains('Scaffold')) icon = Icons.crop_free_rounded;
    else if (name.contains('Padding')) icon = Icons.padding;

    return Padding(
      padding: EdgeInsets.only(left: depth * 16.0, top: 4, bottom: 4), 
      child: Row(
        // CORREÇÃO: mainAxisSize.min permite que a Row cresça para a direita no scroll horizontal sem quebrar
        mainAxisSize: MainAxisSize.min, 
        children: [
          Icon(icon, size: 14, color: textSecondary.withOpacity(0.7)),
          const SizedBox(width: 8),
          // CORREÇÃO: Tiramos o Expanded para que o texto possa empurrar o limite da tela para o scroll!
          Text(name, style: TextStyle(color: textPrimary, fontFamily: 'monospace', fontSize: 13)),
        ],
      ),
    );
  }

  // ==========================================
  // ABA 3: CUSTOM CODE EXPLORER COM IA
  // ==========================================
  Widget _buildCustomCodeTab() {
    if (_isLoadingCode) return Center(child: CircularProgressIndicator(color: accentYellow));
    final List<dynamic> safeList = _customCodeFiles; 
    
    if (safeList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.code_off_rounded, size: 48, color: Colors.white.withOpacity(0.1)),
            const SizedBox(height: 16),
            Text('Nenhum Custom Code encontrado no projeto.', style: TextStyle(color: textSecondary)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _fetchCustomCode, style: ElevatedButton.styleFrom(backgroundColor: panelGray), child: const Text('Recarregar Diretório', style: TextStyle(color: Colors.white)))
          ],
        ),
      );
    }

    final Map<String, List<dynamic>> groupedFiles = {};
    for (var file in safeList) {
      groupedFiles.putIfAbsent(file['category'] as String, () => []).add(file);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(color: panelGray, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.05))),
              clipBehavior: Clip.antiAlias,
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                children: groupedFiles.entries.map((entry) {
                  return Theme(
                    data: ThemeData(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      initiallyExpanded: true, iconColor: accentYellow, collapsedIconColor: textSecondary,
                      title: Text(entry.key.toUpperCase(), style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 12)),
                      children: entry.value.map((file) {
                        final isSelected = _selectedCodeFile?['path'] == file['path'];
                        return InkWell(
                          onTap: () => setState(() { _selectedCodeFile = file; _aiAnalysisResult = null; _isAnalyzingCode = false; }),
                          child: Container(
                            decoration: BoxDecoration(color: isSelected ? accentYellow.withOpacity(0.05) : Colors.transparent, border: Border(left: BorderSide(color: isSelected ? accentYellow : Colors.transparent, width: 3))),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.description_rounded, size: 14, color: isSelected ? accentYellow : textSecondary),
                                const SizedBox(width: 8),
                                Expanded(child: Text(file['name'], style: TextStyle(color: isSelected ? textPrimary : textSecondary, fontSize: 13))),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(color: panelGray, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.05))),
              clipBehavior: Clip.antiAlias,
              child: _selectedCodeFile == null 
                ? Center(child: Text('Selecione um arquivo', style: TextStyle(color: textSecondary)))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05)))),
                        child: Row(
                          children: [
                            Icon(Icons.file_present_rounded, color: accentYellow, size: 18),
                            const SizedBox(width: 8),
                            Expanded(child: Text(_selectedCodeFile!['name'], style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold))),
                            ElevatedButton.icon(
                              icon: Icon(Icons.auto_awesome, size: 14, color: bgBlack),
                              label: Text('Code Review IA', style: TextStyle(color: bgBlack, fontWeight: FontWeight.bold, fontSize: 12)),
                              style: ElevatedButton.styleFrom(backgroundColor: accentYellow, padding: const EdgeInsets.symmetric(horizontal: 12), minimumSize: const Size(0, 32)),
                              onPressed: _isAnalyzingCode ? null : _analyzeCodeWithAI,
                            ),
                            const SizedBox(width: 12),
                            Container(width: 1, height: 20, color: Colors.white.withOpacity(0.1)),
                            const SizedBox(width: 12),
                            _buildEditorButton('VS Code', 'vscode', Icons.code),
                            const SizedBox(width: 8),
                            _buildEditorButton('Cursor', 'cursor', Icons.edit_note),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: bgBlack.withOpacity(0.5),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(20),
                            child: SelectableText(_selectedCodeFile!['content'], style: const TextStyle(color: Color(0xFF9CDCFE), fontSize: 13, fontFamily: 'monospace', height: 1.5)),
                          ),
                        ),
                      ),
                      if (_isAnalyzingCode || _aiAnalysisResult != null) Container(height: 1, color: accentYellow.withOpacity(0.3)),
                      if (_isAnalyzingCode || _aiAnalysisResult != null)
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: accentYellow.withOpacity(0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                  color: accentYellow.withOpacity(0.05),
                                  child: Row(
                                    children: [
                                      Icon(Icons.psychology_alt_rounded, color: accentYellow, size: 18),
                                      const SizedBox(width: 8),
                                      Text('Sandin IA Analyst', style: TextStyle(color: accentYellow, fontWeight: FontWeight.bold, fontSize: 13)),
                                      const Spacer(),
                                      IconButton(icon: Icon(Icons.close, size: 16, color: textSecondary), onPressed: () => setState(() { _aiAnalysisResult = null; _isAnalyzingCode = false; }))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: _isAnalyzingCode 
                                    ? Center(child: CircularProgressIndicator(color: accentYellow))
                                    : SingleChildScrollView(padding: const EdgeInsets.all(20), child: SelectableText(_aiAnalysisResult!, style: TextStyle(color: textPrimary, fontSize: 13, height: 1.6))),
                                )
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorButton(String label, String editor, IconData icon) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 14, color: textPrimary),
      label: Text(label, style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 12)),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.1), padding: const EdgeInsets.symmetric(horizontal: 12), minimumSize: const Size(0, 32)),
      onPressed: () async {
        try { await http.post(Uri.parse('http://localhost:3000/api/open-editor'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({'filePath': _selectedCodeFile!['path'], 'editor': editor})); } catch (e) {}
      },
    );
  }

  // ==========================================
  // ABA 1: STATE INSPECTOR (Variáveis)
  // ==========================================
  Widget _buildVariableInspectorTab() {
    return StreamBuilder<Map<String, dynamic>>(
      stream: context.watch<SocketService>().stateStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) return _buildLoadingState();
        if (!snapshot.hasData) return _buildEmptyState();
        final data = snapshot.data!;
        if (_selectedCategory != null && _selectedKey != null) {
          final catData = data[_selectedCategory];
          if (catData != null && catData is Map && catData.containsKey(_selectedKey)) _selectedValue = catData[_selectedKey];
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(color: panelGray, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.05)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 4))]),
                  clipBehavior: Clip.antiAlias,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    children: [
                      _buildCategoryList('APPLICATION STATE', data['APPLICATION STATE']),
                      _buildCategoryList('AUTHENTICATION', data['AUTHENTICATION']),
                      _buildCategoryList('WIDGET STATE', data['WIDGET STATE']),
                      _buildCategoryList('PAGE STATE', data['PAGE STATE']),
                      _buildCategoryList('ACTION OUTPUTS', data['ACTION OUTPUTS']),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(color: panelGray, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.05)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 4))]),
                  clipBehavior: Clip.antiAlias,
                  child: _buildRightPanel(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildGlassHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, spreadRadius: -5)]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.03), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.08)), gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white.withOpacity(0.08), Colors.white.withOpacity(0.01)])),
            child: Row(
              children: [
                Text(_currentTabIndex == 0 ? 'State Inspector' : _currentTabIndex == 1 ? 'Widget Tree Explorer' : 'Custom Code Explorer', style: TextStyle(color: textPrimary, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                const SizedBox(width: 32),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white.withOpacity(0.05))),
                    child: TextField(controller: _searchController, style: TextStyle(color: textPrimary, fontSize: 14), decoration: InputDecoration(hintText: 'Buscar...', hintStyle: TextStyle(color: textSecondary.withOpacity(0.5)), prefixIcon: Icon(Icons.search_rounded, size: 18, color: accentYellow.withOpacity(0.7)), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 11))),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(icon: Icon(Icons.sync_rounded, color: accentYellow), tooltip: 'Sincronizar', style: IconButton.styleFrom(backgroundColor: accentYellow.withOpacity(0.1), hoverColor: accentYellow.withOpacity(0.2)), onPressed: () => context.read<SocketService>().requestRefresh()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList(String title, dynamic data) {
    if (data == null || (data is Map && data.isEmpty)) return const SizedBox.shrink();
    final Map<String, dynamic> mapData = (data is Map) ? Map<String, dynamic>.from(data) : {};
    mapData.removeWhere((key, value) => key.startsWith('_ts_'));
    if (mapData.isEmpty) return const SizedBox.shrink();
    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true, iconColor: accentYellow, collapsedIconColor: textSecondary, tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0), leading: Icon(Icons.folder_copy_rounded, color: accentYellow.withOpacity(0.8), size: 18),
        title: Row(children: [Expanded(child: Text(title, style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5), overflow: TextOverflow.ellipsis)), const SizedBox(width: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Text('${mapData.length}', style: TextStyle(color: textSecondary, fontSize: 10, fontWeight: FontWeight.bold)))]),
        children: mapData.entries.map((e) => _buildListItem(title, e.key, e.value)).toList(),
      ),
    );
  }

  Widget _buildListItem(String category, String key, dynamic value) {
    final isSelected = _selectedKey == key && _selectedCategory == category;
    return InkWell(
      onTap: () => setState(() { _selectedKey = key; _selectedValue = value; _selectedCategory = category; }),
      hoverColor: Colors.white.withOpacity(0.02),
      child: Container(
        decoration: BoxDecoration(color: isSelected ? accentYellow.withOpacity(0.05) : Colors.transparent, border: Border(left: BorderSide(color: isSelected ? accentYellow : Colors.transparent, width: 3))),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(children: [const SizedBox(width: 14), _getTypeBadge(value), const SizedBox(width: 12), Expanded(child: Text(key, style: TextStyle(color: isSelected ? accentYellow : textSecondary, fontSize: 13, fontFamily: 'monospace', fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal), maxLines: 1, overflow: TextOverflow.ellipsis)), if (isSelected) Icon(Icons.chevron_right_rounded, size: 16, color: accentYellow.withOpacity(0.5))]),
      ),
    );
  }

  Widget _getTypeBadge(dynamic value) {
    String typeStr = 'null'; Color badgeColor = Colors.grey[700]!;
    if (value != null) {
      if (value is String) { typeStr = 'str'; badgeColor = const Color(0xFF4EC9B0); } 
      else if (value is bool) { typeStr = 'bool'; badgeColor = const Color(0xFFC586C0); } 
      else if (value is int || value is double || num.tryParse(value.toString()) != null) { typeStr = 'num'; badgeColor = const Color(0xFFB5CEA8); } 
      else if (value is List) { typeStr = 'list'; badgeColor = const Color(0xFF4CA1FE); } 
      else if (value is Map) { typeStr = 'map'; badgeColor = accentYellow; } 
      else { typeStr = 'obj'; badgeColor = Colors.orangeAccent; }
    }
    return Container(width: 40, padding: const EdgeInsets.symmetric(vertical: 3), decoration: BoxDecoration(color: badgeColor.withOpacity(0.15), borderRadius: BorderRadius.circular(6), border: Border.all(color: badgeColor.withOpacity(0.3))), alignment: Alignment.center, child: Text(typeStr, style: TextStyle(color: badgeColor, fontSize: 10, fontWeight: FontWeight.w700, fontFamily: 'monospace')));
  }

  Widget _buildRightPanel() {
    if (_selectedKey == null) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.data_exploration_rounded, size: 48, color: Colors.white.withOpacity(0.05)), const SizedBox(height: 16), Text('Selecione uma variável para inspecionar', style: TextStyle(color: textSecondary))]));
    String displayValue = '';
    if (_selectedValue is Map || _selectedValue is List) displayValue = const JsonEncoder.withIndent('  ').convert(_selectedValue); else displayValue = _selectedValue.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05)))),
          child: Row(children: [_getTypeBadge(_selectedValue), const SizedBox(width: 12), Expanded(child: Text(_selectedKey!, style: TextStyle(color: textPrimary, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'monospace'))), Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: accentYellow.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Text(_selectedCategory!, style: TextStyle(color: accentYellow, fontSize: 10, fontWeight: FontWeight.bold)))]),
        ),
        Expanded(child: Container(color: bgBlack.withOpacity(0.5), child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: SelectableText(displayValue, style: const TextStyle(color: Color(0xFFCE9178), fontSize: 13, fontFamily: 'monospace', height: 1.6, letterSpacing: 0.3))))),
      ],
    );
  }

  Widget _buildLoadingState() => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: accentYellow), const SizedBox(height: 16), Text('Aguardando sincronização com o App...', style: TextStyle(color: textSecondary))]));
  Widget _buildEmptyState() => Center(child: Text('Nenhuma variável encontrada no escopo atual.', style: TextStyle(color: textSecondary)));

// ==========================================
  // 🚀 ABA 4: CONSOLE (Chrome Style) & SANDIN AI
  // ==========================================
  
  // Função que filtra os logs do nosso próprio sistema para não sujar o terminal do usuário
  bool _isSystemLog(String log) {
    final l = log.toLowerCase();
    return l.contains('[loginjector]') || 
           l.contains('protocol buffers') || 
           l.contains('vm info:') || 
           l.contains('attached to isolate') || 
           l.contains('connected to dart vm') ||
           l.contains('debug service listening') ||
           l.contains('this app is linked to');
  }

  // Envia a mensagem pro Sandin (agora aceita um contexto oculto, como a linha do log)
  Future<void> _sendManualChatMessage({String? prefixContext}) async {
    final text = _chatInputController.text.trim();
    if (text.isEmpty && prefixContext == null) return;
    
    final displayMessage = text.isNotEmpty ? text : 'Analise este log do console.';
    final promptToSend = prefixContext != null ? "$prefixContext\n\n$text" : text;
    
    _chatInputController.clear();
    setState(() { 
      _chatHistory.add({'role': 'user', 'text': displayMessage}); 
      _isSandinThinking = true; 
    });
    
    WidgetsBinding.instance.addPostFrameCallback((_) { if (_chatScroll.hasClients) _chatScroll.jumpTo(_chatScroll.position.maxScrollExtent); });
    
    try {
      final res = await http.post(
        Uri.parse('http://localhost:3000/api/chat'), 
        headers: {'Content-Type': 'application/json'}, 
        body: jsonEncode({'message': promptToSend})
      );
      setState(() { 
        _chatHistory.add({'role': 'ai', 'text': jsonDecode(res.body)['analysis']}); 
        _isSandinThinking = false; 
      });
      WidgetsBinding.instance.addPostFrameCallback((_) { if (_chatScroll.hasClients) _chatScroll.jumpTo(_chatScroll.position.maxScrollExtent); });
    } catch (e) {
      setState(() { _isSandinThinking = false; });
    }
  }

  // Abre o Menu de Botão Direito (Context Menu)
  void _showLogContextMenu(BuildContext context, Offset position, String logLine) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx, position.dy),
      color: panelGray,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.white.withOpacity(0.1))),
      items: [
        PopupMenuItem(
          value: 'copy',
          child: Row(children: [Icon(Icons.copy, size: 16, color: textPrimary), const SizedBox(width: 8), Text('Copiar Linha', style: TextStyle(color: textPrimary, fontSize: 13))]),
        ),
        PopupMenuItem(
          value: 'ask',
          child: Row(children: [Icon(Icons.psychology, size: 16, color: accentYellow), const SizedBox(width: 8), Text('Perguntar ao Sandin', style: TextStyle(color: accentYellow, fontSize: 13, fontWeight: FontWeight.bold))]),
        ),
      ],
    ).then((value) {
      if (value == 'copy') {
        Clipboard.setData(ClipboardData(text: logLine));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Linha copiada!', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: accentYellow, duration: const Duration(seconds: 2)));
      } else if (value == 'ask') {
        _sendManualChatMessage(prefixContext: "Por favor, explique e me ajude a resolver este log que apareceu no meu console do Flutter:\n\n```text\n$logLine\n```");
      }
    });
  }

  Widget _buildConsoleAndAITab() {
    // Filtra os logs para exibir apenas o que interessa
    final displayLogs = _consoleLogs.where((log) => !_isSystemLog(log)).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PAINEL ESQUERDO: TERMINAL (CHROME DEVTOOLS STYLE)
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.1))),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    color: panelGray,
                    child: Row(
                      children: [
                        Icon(Icons.terminal_rounded, color: const Color(0xFF4AF626), size: 18),
                        const SizedBox(width: 8),
                        Text('Console do Projeto', style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
                        const Spacer(),
                        // NOVO: Botão Copiar Todo o Console
                        IconButton(
                          icon: Icon(Icons.copy_all_rounded, color: textSecondary, size: 18), 
                          tooltip: 'Copiar Console Inteiro',
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: displayLogs.join('\n')));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Console inteiro copiado!', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: accentYellow));
                          }
                        ),
                        // Botão Limpar
                        IconButton(icon: Icon(Icons.delete_sweep_rounded, color: textSecondary, size: 18), tooltip: 'Limpar', onPressed: () => setState(() => _consoleLogs.clear()))
                      ],
                    ),
                  ),
                  Expanded(
                    child: displayLogs.isEmpty 
                    ? Center(child: Text('Aguardando logs do Flutter...', style: TextStyle(color: textSecondary.withOpacity(0.5), fontFamily: 'monospace')))
                    : ListView.builder(
                      controller: _consoleScroll,
                      padding: EdgeInsets.zero,
                      itemCount: displayLogs.length,
                      itemBuilder: (context, index) {
                        final log = displayLogs[index];
                        final isError = log.toLowerCase().contains('error') || log.contains('EXCEPTION') || log.contains('Failed to');
                        final isWarning = log.toLowerCase().contains('warning');
                        
                        Color textColor = const Color(0xFFCCCCCC);
                        Color bgColor = index % 2 == 0 ? Colors.transparent : Colors.white.withOpacity(0.02);
                        
                        if (isError) {
                          textColor = const Color(0xFFFF8080);
                          bgColor = Colors.redAccent.withOpacity(0.05);
                        } else if (isWarning) {
                          textColor = const Color(0xFFFFD600);
                          bgColor = Colors.amber.withOpacity(0.05);
                        }

                        return GestureDetector(
                          // Captura o clique com o BOTÃO DIREITO do mouse
                          onSecondaryTapDown: (details) => _showLogContextMenu(context, details.globalPosition, log),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: bgColor,
                              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isError) const Padding(padding: EdgeInsets.only(right: 8, top: 2), child: Icon(Icons.cancel, color: Color(0xFFFF8080), size: 12)),
                                if (isWarning) const Padding(padding: EdgeInsets.only(right: 8, top: 2), child: Icon(Icons.warning, color: Color(0xFFFFD600), size: 12)),
                                Expanded(
                                  child: SelectableText(
                                    log, 
                                    style: TextStyle(color: textColor, fontFamily: 'monospace', fontSize: 12, height: 1.4)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // PAINEL DIREITO: SANDIN AI CHAT
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(color: panelGray, borderRadius: BorderRadius.circular(16), border: Border.all(color: accentYellow.withOpacity(0.3))),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(color: accentYellow.withOpacity(0.1), border: Border(bottom: BorderSide(color: accentYellow.withOpacity(0.2)))),
                    child: Row(
                      children: [
                        Icon(Icons.psychology_rounded, color: accentYellow, size: 20),
                        const SizedBox(width: 8),
                        Text('Sandin AI Copilot', style: TextStyle(color: accentYellow, fontWeight: FontWeight.bold, fontSize: 14)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                          child: const Text('MONITORANDO ERROS', style: TextStyle(color: Colors.green, fontSize: 9, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _chatScroll,
                      padding: const EdgeInsets.all(16),
                      itemCount: _chatHistory.length,
                      itemBuilder: (context, index) {
                        final msg = _chatHistory[index];
                        final isUser = msg['role'] == 'user';
                        final isSystem = msg['role'] == 'system';
                        
                        return Align(
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isUser ? accentYellow.withOpacity(0.1) : (isSystem ? Colors.redAccent.withOpacity(0.1) : Colors.black.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: isUser ? accentYellow.withOpacity(0.3) : (isSystem ? Colors.redAccent.withOpacity(0.5) : Colors.white.withOpacity(0.05)))
                            ),
                            child: SelectableText(
                              msg['text'],
                              style: TextStyle(color: isSystem ? Colors.redAccent : textPrimary, fontSize: 13, height: 1.5, fontFamily: isSystem ? 'monospace' : null),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (_isSandinThinking)
                    Padding(padding: const EdgeInsets.all(8.0), child: CircularProgressIndicator(color: accentYellow, strokeWidth: 2)),
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.black.withOpacity(0.2),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _chatInputController,
                            style: TextStyle(color: textPrimary, fontSize: 13),
                            onSubmitted: (_) => _sendManualChatMessage(),
                            decoration: InputDecoration(
                              hintText: 'Pergunte ao Sandin...',
                              hintStyle: TextStyle(color: textSecondary),
                              filled: true, fillColor: bgBlack,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: Icon(Icons.send_rounded, color: accentYellow),
                          onPressed: _isSandinThinking ? null : () => _sendManualChatMessage(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // ==========================================
  // 🚀 ABA 5: NETWORK INSPECTOR (Chrome Style)
  // ==========================================
  Widget _buildNetworkTab() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: context.watch<SocketService>().networkStream,
      initialData: context.read<SocketService>().networkHistory,
      builder: (context, snapshot) {
        final calls = snapshot.data ?? [];

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PAINEL ESQUERDO: LISTA DE REQUESTS
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(color: panelGray, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.05))),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        color: Colors.black.withOpacity(0.2),
                        child: Row(
                          children: [
                            Icon(Icons.swap_vert_rounded, color: accentYellow, size: 18),
                            const SizedBox(width: 8),
                            Text('Network Log', style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                              child: Text('${calls.length} requests', style: TextStyle(color: textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                      // CABEÇALHO DA TABELA
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.02), border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05)))),
                        child: Row(
                          children: [
                            SizedBox(width: 40, child: Text('Status', style: TextStyle(color: textSecondary, fontSize: 11, fontWeight: FontWeight.bold))),
                            Expanded(child: Text('Endpoint (API Call)', style: TextStyle(color: textSecondary, fontSize: 11, fontWeight: FontWeight.bold))),
                            SizedBox(width: 60, child: Text('Time', style: TextStyle(color: textSecondary, fontSize: 11, fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),
                      Expanded(
                        child: calls.isEmpty 
                        ? Center(child: Text('Aguardando chamadas de API...', style: TextStyle(color: textSecondary.withOpacity(0.5))))
                        : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: calls.length,
                          itemBuilder: (context, index) {
                            final call = calls[index];
                            final status = call['status'] ?? 0;
                            final isError = status >= 400 || status == 0;
                            final isSelected = _selectedNetworkCall == call;

                            return InkWell(
                              onTap: () => setState(() => _selectedNetworkCall = call),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected ? accentYellow.withOpacity(0.05) : (index % 2 == 0 ? Colors.transparent : Colors.white.withOpacity(0.01)),
                                  border: Border(left: BorderSide(color: isSelected ? accentYellow : Colors.transparent, width: 3), bottom: BorderSide(color: Colors.white.withOpacity(0.02)))
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 40, 
                                      child: Text('$status', style: TextStyle(color: isError ? Colors.redAccent : Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'monospace'))
                                    ),
                                    Expanded(
                                      child: Text(call['endpoint'] ?? 'Unknown', style: TextStyle(color: isSelected ? textPrimary : (isError ? Colors.redAccent : textSecondary), fontSize: 13, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal), overflow: TextOverflow.ellipsis),
                                    ),
                                    SizedBox(
                                      width: 60, 
                                      child: Text('${call['duration']}ms', style: TextStyle(color: textSecondary, fontSize: 11, fontFamily: 'monospace'))
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // PAINEL DIREITO: DETALHES (HEADERS & RESPONSE)
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(color: panelGray, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.05))),
                  clipBehavior: Clip.antiAlias,
                  child: _selectedNetworkCall == null 
                  ? Center(child: Text('Selecione uma requisição para ver os detalhes', style: TextStyle(color: textSecondary)))
                  : DefaultTabController(
                      length: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            color: Colors.black.withOpacity(0.2),
                            child: TabBar(
                              indicatorColor: accentYellow,
                              labelColor: accentYellow,
                              unselectedLabelColor: textSecondary,
                              tabs: const [Tab(text: 'Response Body'), Tab(text: 'Headers')],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                // TAB 1: RESPONSE BODY (Formatado)
                                Container(
                                  color: bgBlack.withOpacity(0.5),
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.all(20),
                                    child: SelectableText(
                                      _formatJson(_selectedNetworkCall!['response']), 
                                      style: const TextStyle(color: Color(0xFFCE9178), fontSize: 13, fontFamily: 'monospace', height: 1.6)
                                    ),
                                  ),
                                ),
                                // TAB 2: HEADERS
                                Container(
                                  color: bgBlack.withOpacity(0.5),
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.all(20),
                                    child: SelectableText(
                                      _formatJson(_selectedNetworkCall!['headers']), 
                                      style: const TextStyle(color: Color(0xFF9CDCFE), fontSize: 13, fontFamily: 'monospace', height: 1.6)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // Tenta formatar string para JSON bonito, se falhar, retorna o texto puro
  String _formatJson(dynamic input) {
    if (input == null) return 'null';
    if (input is Map || input is List) return const JsonEncoder.withIndent('  ').convert(input);
    try {
      final decoded = jsonDecode(input.toString());
      return const JsonEncoder.withIndent('  ').convert(decoded);
    } catch (_) {
      return input.toString(); // Retorna texto puro (HTML ou erro bizarro)
    }
  }
}