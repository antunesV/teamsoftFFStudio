# TeamSoft FF LocalRun — FlutterFlow Local Runner + Ambiente de Depuração Avançado

O **TeamSoft FF LocalRun** é uma ferramenta poderosa desenvolvida para desenvolvedores FlutterFlow que precisam de um ambiente de execução local estável, rápido e com ferramentas de depuração de nível profissional.

## 🚀 Recursos Principais

### 1. Execução Local de Alta Performance
Rode seus projetos FlutterFlow localmente sem depender exclusivamente do navegador, permitindo testes mais rápidos e integração com APIs locais.

### 2. Auto-Updater Client-Side (Novo!)
Integrado diretamente com GitHub Releases. O aplicativo verifica automaticamente se há novas versões disponíveis no início de cada execução, baixa o pacote de atualização (`app-update.zip`) e o aplica automaticamente.

### 3. State Inspector (Inspetor de Estado)
Monitore em tempo real o estado de todas as variáveis do seu aplicativo, incluindo Page State, App State e saídas de ações (Action Outputs). 

### 4. Widget Tree Inspector
Visualize a hierarquia completa de widgets do seu aplicativo para identificar problemas de layout e estrutura rapidamente.

### 5. Monitoramento de Rede e Logs
Acompanhe todas as requisições HTTP e logs do sistema em um painel centralizado, facilitando a identificação de erros de integração.

## 🛠️ Instalação e Configuração

### Pré-requisitos
- Node.js (>= 16.0.0)
- Flutter SDK (configurado e no PATH)
- Personal Access Token (PAT) do GitHub (para o Auto-Updater)

### Configuração do Auto-Updater
Para que o sistema de atualização automática funcione, você deve configurar seu token no arquivo:
`projects/resultados-app-er7l18-testbed/lib/updater.dart`

Substitua a constante `githubToken` pelo seu token de leitura do GitHub.

## 💻 Comandos Úteis

- **Iniciar Backend (Windows)**: Clique duas vezes em `start.bat` na raiz ou execute `npm start`
- **Iniciar App Desktop**: `npm run desktop`
- **Construir para Windows**: `npm run build:win`

## 📂 Estrutura do Projeto

- `/backend`: Servidor Node.js responsável pela orquestração e ferramentas de depuração.
- `/frontend`: Interface web do console de depuração.
- `/electron`: Wrapper desktop para o ambiente.
- `/projects`: Diretório onde os projetos FlutterFlow são exportados e executados.

---

Desenvolvido por **TeamSoft**.
