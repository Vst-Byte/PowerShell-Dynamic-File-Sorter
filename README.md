# 🛠️ Workstation Automation Toolkit

| Project Info | Details |
| :--- | :--- |
| **Version** | 1.2.0 |
| **Author** | Enchanted |
| **Language** | PowerShell |
| **Category** | SysAdmin / IT Support Operations |
| **Compatibility** | Windows 10, Windows 11, Windows Server |
| **License** | MIT |

> **Suíte de automação para diagnóstico, manutenção e padronização de estações de trabalho Windows.**

---

## 📋 Sobre o Projeto

O **Workstation Automation Toolkit** é uma ferramenta CLI (Command Line Interface) desenvolvida para técnicos de suporte e administradores de sistemas. Diferente de scripts simples de limpeza, este toolkit atua como um "Canivete Suíço" para diagnósticos de nível 1 e 2.

Ele centraliza rotinas de organização de arquivos, reparo de rede, coleta de dados de hardware e análise de logs de erro em um único menu interativo.

---

## 🚀 Funcionalidades (Toolkit)

### 1. 📂 Smart File Organizer
Organização inteligente baseada em extensões.
- Separa imagens em subpastas dedicadas.
- Cria diretórios dinamicamente para manter a pasta `Downloads` limpa.

### 2. 🧹 System Cleaner
Manutenção preventiva de disco.
- Varredura e remoção segura de arquivos temporários (`%TEMP%`).
- Ignora automaticamente arquivos bloqueados pelo sistema (sem erros visuais).

### 3. 🖥️ System Intelligence (Asset Management)
Coleta instantânea de dados para inventário e chamados.
- **Hardware:** CPU, RAM Livre/Total, Modelo da GPU.
- **Identificação:** Serial Number (BIOS/Tag de Ativo) e Hostname.
- **Rede:** Endereço IPv4 Local e Gateway.
- **Uptime:** Tempo exato que a máquina está ligada (para detectar falta de reinicialização).

### 4. 🌐 Network Doctor
Ferramenta de reparo rápido para problemas de conectividade.
- Limpeza de Cache DNS (`Clear-DnsClientCache`).
- Renovação de Lease DHCP (`ipconfig /renew`).
- Teste de latência (Ping).

### 5. 📜 Event Log Analyzer
Diagnóstico de falhas do sistema operacional.
- Varre o **Windows Event Viewer** em busca dos últimos 5 erros críticos.
- Exibe a fonte do erro e o timestamp, facilitando a identificação de "Telas Azuis" ou falhas de drivers.

---

## 🛠️ Instalação e Uso

### Pré-requisitos
* Windows PowerShell 5.1 ou superior.
* Permissões de Leitura/Escrita na pasta do usuário.

### Como executar
# 1. Clone este repositório
```powershell
git clone [https://github.com/SEU-USUARIO/Workstation-Automation-Toolkit.git](https://github.com/SEU-USUARIO/Workstation-Automation-Toolkit.git)
```
# 2. Acesse a pasta do projeto
```powershell
cd Workstation-Automation-Toolkit
```
# 3. Execute o script principal (Recomendado: Como Administrador)
```powershell
.\Invoke-Maintenance.ps1
```
