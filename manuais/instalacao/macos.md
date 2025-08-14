# Instalação PostgreSQL, DBeaver e pgAdmin no macOS

## PostgreSQL

### Método 1: Homebrew (Recomendado)
```bash
# Instalar Homebrew (se não tiver)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar PostgreSQL
brew install postgresql@15

# Iniciar o serviço
brew services start postgresql@15

# Criar usuário e banco (opcional)
createdb $USER
```

### Método 2: Postgres.app
1. Acesse: https://postgresapp.com/
2. Baixe a versão mais recente
3. Arraste o Postgres.app para a pasta Applications
4. Abra o aplicativo
5. Clique em "Initialize" para criar um novo servidor
6. Configure o PATH (adicione ao ~/.zshrc ou ~/.bash_profile):
```bash
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
```

### Método 3: Instalador Oficial
1. Acesse: https://www.postgresql.org/download/macosx/
2. Baixe o instalador EDB
3. Execute o arquivo `.dmg`
4. Siga o assistente de instalação
5. Configure senha para o usuário `postgres`

### Verificação da Instalação
```bash
# Verificar versão
psql --version

# Conectar ao banco
psql postgres

# Se usando Postgres.app
psql
```

## DBeaver

### Método 1: Download Direto
1. Acesse: https://dbeaver.io/download/
2. Baixe a versão "Community Edition" para macOS
3. Abra o arquivo `.dmg`
4. Arraste o DBeaver para a pasta Applications
5. Abra o DBeaver (pode precisar autorizar nas Preferências de Segurança)

### Método 2: Homebrew
```bash
brew install --cask dbeaver-community
```

### Configuração Inicial
1. Abra o DBeaver
2. Clique em "Nova Conexão" ou `⌘+Shift+N`
3. Selecione "PostgreSQL"
4. Configure:
   - **Host**: localhost
   - **Port**: 5432
   - **Database**: postgres (ou seu usuário se usando Postgres.app)
   - **Username**: postgres (ou seu usuário se usando Postgres.app)
   - **Password**: (senha definida ou vazia se usando Postgres.app)
5. Teste a conexão
6. Clique em "Finish"

## pgAdmin

### Método 1: Download Direto
1. Acesse: https://www.pgadmin.org/download/pgadmin-4-macos/
2. Baixe a versão mais recente
3. Abra o arquivo `.dmg`
4. Arraste o pgAdmin para a pasta Applications
5. Abra o pgAdmin

### Método 2: Homebrew
```bash
brew install --cask pgadmin4
```

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
   - **Username**: postgres (ou seu usuário)
   - **Password**: (senha do PostgreSQL ou vazia)
7. Clique em "Save"

## Configurações Adicionais

### Configurar PATH para PostgreSQL (se necessário)
```bash
# Para Homebrew
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc

# Para instalação EDB
echo 'export PATH="/Library/PostgreSQL/15/bin:$PATH"' >> ~/.zshrc

# Recarregar o terminal
source ~/.zshrc
```

### Iniciar/Parar PostgreSQL
```bash
# Homebrew
brew services start postgresql@15
brew services stop postgresql@15
brew services restart postgresql@15

# Postgres.app - usar a interface gráfica

# Instalação EDB
sudo launchctl load /Library/LaunchDaemons/com.edb.launchd.postgresql-15.plist
sudo launchctl unload /Library/LaunchDaemons/com.edb.launchd.postgresql-15.plist
```

## Solução de Problemas Comuns

### Erro "psql: command not found"
- Verifique se o PATH está configurado corretamente
- Reinicie o terminal após configurar o PATH

### Erro de conexão
- Verifique se o PostgreSQL está rodando: `brew services list | grep postgresql`
- Para Postgres.app, verifique se o servidor está iniciado na interface

### Problemas de permissão
- Use `sudo` apenas quando necessário
- Verifique as permissões da pasta de dados do PostgreSQL

### Erro "database does not exist"
- Crie um banco com seu nome de usuário: `createdb $USER`
- Ou conecte diretamente ao banco postgres: `psql postgres`