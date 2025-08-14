# Instalação PostgreSQL, DBeaver e pgAdmin no Windows

## PostgreSQL

### Método 1: Instalador Oficial
1. Acesse o site oficial: https://www.postgresql.org/download/windows/
2. Clique em "Download the installer"
3. Baixe a versão mais recente (recomendado PostgreSQL 15 ou superior)
4. Execute o arquivo `.exe` baixado
5. Siga o assistente de instalação:
   - Escolha o diretório de instalação
   - Selecione os componentes (PostgreSQL Server, pgAdmin 4, Stack Builder, Command Line Tools)
   - Defina o diretório de dados
   - Configure a senha do usuário `postgres`
   - Defina a porta (padrão: 5432)
   - Escolha o locale (pt_BR.UTF-8 ou C)
6. Finalize a instalação

### Método 2: Chocolatey
```powershell
# Instalar Chocolatey (se não tiver)
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Instalar PostgreSQL
choco install postgresql
```

### Verificação da Instalação
```cmd
# Verificar versão
psql --version

# Conectar ao banco
psql -U postgres
```

## DBeaver

### Instalação
1. Acesse: https://dbeaver.io/download/
2. Baixe a versão "Community Edition" para Windows
3. Execute o instalador `.exe`
4. Siga o assistente de instalação
5. Aceite os termos de licença
6. Escolha o diretório de instalação
7. Finalize a instalação

### Configuração Inicial
1. Abra o DBeaver
2. Clique em "Nova Conexão" ou vá em `Database > New Database Connection`
3. Selecione "PostgreSQL"
4. Configure:
   - **Host**: localhost
   - **Port**: 5432
   - **Database**: postgres
   - **Username**: postgres
   - **Password**: (senha definida na instalação)
5. Teste a conexão
6. Clique em "Finish"

## pgAdmin

### Instalação
1. Acesse: https://www.pgadmin.org/download/pgadmin-4-windows/
2. Baixe a versão mais recente
3. Execute o instalador `.exe`
4. Siga o assistente de instalação
5. Finalize a instalação

### Configuração Inicial
1. Abra o pgAdmin
2. Configure uma senha master para o pgAdmin
3. Clique com botão direito em "Servers"
4. Selecione "Register > Server"
5. Na aba "General":
   - **Name**: Local PostgreSQL
6. Na aba "Connection":
   - **Host**: localhost
   - **Port**: 5432
   - **Username**: postgres
   - **Password**: (senha do PostgreSQL)
7. Clique em "Save"

## Solução de Problemas Comuns

### PostgreSQL não inicia
- Verifique se o serviço está rodando no "Services.msc"
- Procure por "postgresql-x64-XX" e inicie o serviço

### Erro de conexão
- Verifique se a porta 5432 não está sendo usada por outro processo
- Confirme se o firewall não está bloqueando a conexão
- Verifique o arquivo `pg_hba.conf` para configurações de autenticação

### Problemas de encoding
- Configure o locale como `pt_BR.UTF-8` durante a instalação
- Use `SET client_encoding = 'UTF8';` nas consultas se necessário