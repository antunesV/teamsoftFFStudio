import 'dart:ui';
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
  
  // Cores do Novo Tema
  final Color bgBlack = const Color(0xFF09090B);
  final Color panelGray = const Color(0xFF141417);
  final Color accentYellow = const Color(0xFFFFD600);
  final Color textPrimary = const Color(0xFFE4E4E7);
  final Color textSecondary = const Color(0xFFA1A1AA);

  // Estado do Inspecionador de Variáveis
  String? _selectedKey;
  dynamic _selectedValue;
  String? _selectedCategory;
  
  // Estado de Navegação e Custom Code
  int _currentTabIndex = 0;
  List<dynamic> _customCodeFiles = [];
  bool _isLoadingCode = false;
  Map<String, dynamic>? _selectedCodeFile;

  // Estado da Inteligência Artificial
  bool _isAnalyzingCode = false;
  String? _aiAnalysisResult;

  @override
  void initState() {
    super.initState();
    context.read<SocketService>().connect('auto');
  }

  Future<void> _fetchCustomCode() async {
    setState(() => _isLoadingCode = true);
    try {
      final res = await http.get(Uri.parse('http://localhost:3000/api/custom-code'));
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        setState(() {
          _customCodeFiles = body['files'] ?? [];
          if (_customCodeFiles.isNotEmpty && _selectedCodeFile == null) {
            _selectedCodeFile = _customCodeFiles.first;
          }
        });
      }
    } catch (e) {
      debugPrint('Erro ao buscar custom code: $e');
    }
    setState(() => _isLoadingCode = false);
  }

  Future<void> _analyzeCodeWithAI() async {
    if (_selectedCodeFile == null) return;
    
    setState(() {
      _isAnalyzingCode = true;
      _aiAnalysisResult = null;
    });

    try {
      final res = await http.post(
        Uri.parse('http://localhost:3000/api/analyze-code'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'code': _selectedCodeFile!['content']}),
      );
      
      if (res.statusCode == 200) {
        setState(() => _aiAnalysisResult = jsonDecode(res.body)['analysis']);
      } else {
        setState(() => _aiAnalysisResult = 'Erro do Servidor: ${jsonDecode(res.body)['error']}');
      }
    } catch (e) {
      setState(() => _aiAnalysisResult = 'Falha de conexão com o painel local: $e');
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
      width: 64,
      color: panelGray,
      child: Column(
        children: [
          const SizedBox(height: 24),
          Icon(Icons.hub_rounded, color: accentYellow, size: 28),
          const SizedBox(height: 32),
          _buildNavButton(0, Icons.data_object, 'Variáveis de Estado'),
          _buildNavButton(1, Icons.account_tree_rounded, 'Árvore de Widgets'),
          _buildNavButton(2, Icons.code_rounded, 'Custom Code Explorer'),
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
          if (index == 2 && _customCodeFiles.isEmpty) _fetchCustomCode();
        },
        child: Container(
          width: 64,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(border: Border(left: BorderSide(color: isSelected ? accentYellow : Colors.transparent, width: 3))),
          child: Icon(icon, color: isSelected ? accentYellow : textSecondary.withOpacity(0.5), size: 24),
        ),
      ),
    );
  }

  Widget _buildCurrentTabContent() {
    if (_currentTabIndex == 1) {
      return Center(child: Text('Árvore de Widgets / Rotas\n(Em breve)', style: TextStyle(color: textSecondary), textAlign: TextAlign.center));
    }
    if (_currentTabIndex == 2) return _buildCustomCodeTab();
    return _buildVariableInspectorTab();
  }

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
            ElevatedButton(
              onPressed: _fetchCustomCode,
              style: ElevatedButton.styleFrom(backgroundColor: panelGray),
              child: const Text('Recarregar Diretório', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      );
    }

    final Map<String, List<dynamic>> groupedFiles = {};
    for (var file in safeList) {
      final cat = file['category'] as String;
      groupedFiles.putIfAbsent(cat, () => []).add(file);
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
                      initiallyExpanded: true,
                      iconColor: accentYellow,
                      collapsedIconColor: textSecondary,
                      title: Text(entry.key.toUpperCase(), style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 12)),
                      children: entry.value.map((file) {
                        final isSelected = _selectedCodeFile?['path'] == file['path'];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedCodeFile = file;
                              _aiAnalysisResult = null;
                              _isAnalyzingCode = false;
                            });
                          },
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
                            child: SelectableText(
                              _selectedCodeFile!['content'],
                              style: const TextStyle(color: Color(0xFF9CDCFE), fontSize: 13, fontFamily: 'monospace', height: 1.5),
                            ),
                          ),
                        ),
                      ),
                      if (_isAnalyzingCode || _aiAnalysisResult != null)
                        Container(height: 1, color: accentYellow.withOpacity(0.3)),
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
                                      IconButton(
                                        icon: Icon(Icons.close, size: 16, color: textSecondary),
                                        onPressed: () => setState(() { _aiAnalysisResult = null; _isAnalyzingCode = false; }),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: _isAnalyzingCode 
                                    ? Center(child: CircularProgressIndicator(color: accentYellow))
                                    : SingleChildScrollView(
                                        padding: const EdgeInsets.all(20),
                                        child: SelectableText(
                                          _aiAnalysisResult!,
                                          style: TextStyle(color: textPrimary, fontSize: 13, height: 1.6),
                                        ),
                                      ),
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
        try {
          await http.post(Uri.parse('http://localhost:3000/api/open-editor'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({'filePath': _selectedCodeFile!['path'], 'editor': editor}));
        } catch (e) {}
      },
    );
  }

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
                Text(_currentTabIndex == 0 ? 'State Inspector' : _currentTabIndex == 1 ? 'Widget Tree' : 'Custom Code Explorer', style: TextStyle(color: textPrimary, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
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
}
