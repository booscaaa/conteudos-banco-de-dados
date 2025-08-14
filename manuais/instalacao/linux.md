# Instalação PostgreSQL, DBeaver e pgAdmin no Linux

## PostgreSQL

### Ubuntu/Debian
```bash
# Atualizar repositórios
sudo apt update

# Instalar PostgreSQL
sudo apt install postgresql postgresql-contrib

# Iniciar e habilitar o serviço
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Configurar senha do usuário postgres
sudo -u postgres psql
\password postgres
\q
```

### CentOS/RHEL/Fedora
```bash
# CentOS/RHEL
sudo yum install postgresql-server postgresql-contrib
# ou para versões mais novas
sudo dnf install postgresql-server postgresql-contrib

# Fedora
sudo dnf install postgresql-server postgresql-contrib

# Inicializar o banco
sudo postgresql-setup initdb

# Iniciar e habilitar o serviço
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

### Arch Linux
```bash
# Instalar PostgreSQL
sudo pacman -S postgresql

# Inicializar o cluster de banco
sudo -u postgres initdb -D /var/lib/postgres/data

# Iniciar e habilitar o serviço
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

### Usando Repositório Oficial PostgreSQL
```bash
# Ubuntu/Debian
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
sudo apt update
sudo apt install postgresql-15 postgresql-contrib-15
```

### Verificação da Instalação
```bash
# Verificar versão
psql --version

# Verificar status do serviço
sudo systemctl status postgresql

# Conectar ao banco
sudo -u postgres psql
```

## DBeaver

### Método 1: Download Direto (.deb/.rpm)
```bash
# Ubuntu/Debian
wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo dpkg -i dbeaver-ce_latest_amd64.deb
sudo apt-get install -f  # Resolver dependências se necessário

# CentOS/RHEL/Fedora
wget https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm
sudo rpm -ivh dbeaver-ce-latest-stable.x86_64.rpm
```

### Método 2: Snap
```bash
sudo snap install dbeaver-ce
```

### Método 3: Flatpak
```bash
flatpak install flathub io.dbeaver.DBeaverCommunity
```

### Método 4: AppImage
```bash
# Baixar AppImage do site oficial
wget https://dbeaver.io/files/dbeaver-ce-latest-linux.gtk.x86_64.tar.gz
tar -xzf dbeaver-ce-latest-linux.gtk.x86_64.tar.gz
cd dbeaver
./dbeaver
```

### Configuração Inicial
1. Abra o DBeaver
2. Clique em "Nova Conexão" ou pressione `Ctrl+Shift+N`
3. Selecione "PostgreSQL"
4. Configure:
   - **Host**: localhost
   - **Port**: 5432
   - **Database**: postgres
   - **Username**: postgres
   - **Password**: (senha definida)
5. Teste a conexão
6. Clique em "Finish"

## pgAdmin

### Método 1: Repositório Oficial
```bash
# Ubuntu/Debian
curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'
sudo apt update

# Instalar versão desktop
sudo apt install pgadmin4-desktop

# Ou instalar versão web
sudo apt install pgadmin4-web
sudo /usr/pgadmin4/bin/setup-web.sh
```

### Método 2: Python pip
```bash
# Instalar dependências
sudo apt install python3-pip python3-venv

# Criar ambiente virtual
python3 -m venv pgadmin4
source pgadmin4/bin/activate

# Instalar pgAdmin
pip install pgadmin4

# Executar
pgadmin4
```

### Método 3: Docker
```bash
# Executar pgAdmin em container
docker run -p 80:80 \
    -e 'PGADMIN_DEFAULT_EMAIL=user@domain.com' \
    -e 'PGADMIN_DEFAULT_PASSWORD=SuperSecret' \
    -d dpage/pgadmin4
```

### Configuração Inicial (Desktop)
1. Abra o pgAdmin
2. Configure uma senha master
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

## Configurações Adicionais

### Configurar PostgreSQL para Conexões Externas
```bash
# Editar postgresql.conf
sudo nano /etc/postgresql/15/main/postgresql.conf

# Alterar linha:
listen_addresses = 'localhost'
# Para:
listen_addresses = '*'

# Editar pg_hba.conf
sudo nano /etc/postgresql/15/main/pg_hba.conf

# Adicionar linha para permitir conexões:
host    all             all             0.0.0.0/0               md5

# Reiniciar PostgreSQL
sudo systemctl restart postgresql
```

### Criar Usuário e Banco
```bash
# Conectar como postgres
sudo -u postgres psql

# Criar usuário
CREATE USER meuusuario WITH PASSWORD 'minhasenha';

# Criar banco
CREATE DATABASE meubanco OWNER meuusuario;

# Conceder privilégios
GRANT ALL PRIVILEGES ON DATABASE meubanco TO meuusuario;

# Sair
\q
```

### Comandos Úteis
```bash
# Iniciar/Parar/Reiniciar PostgreSQL
sudo systemctl start postgresql
sudo systemctl stop postgresql
sudo systemctl restart postgresql

# Verificar logs
sudo journalctl -u postgresql

# Backup de banco
pg_dump -U postgres -h localhost meubanco > backup.sql

# Restaurar backup
psql -U postgres -h localhost meubanco < backup.sql
```

## Solução de Problemas Comuns

### Erro "peer authentication failed"
```bash
# Editar pg_hba.conf
sudo nano /etc/postgresql/15/main/pg_hba.conf

# Alterar linha:
local   all             postgres                                peer
# Para:
local   all             postgres                                md5

# Reiniciar PostgreSQL
sudo systemctl restart postgresql
```

### PostgreSQL não inicia
```bash
# Verificar status
sudo systemctl status postgresql

# Verificar logs
sudo journalctl -u postgresql -f

# Verificar se a porta está em uso
sudo netstat -tlnp | grep 5432
```

### Problemas de permissão
```bash
# Verificar proprietário dos arquivos
sudo ls -la /var/lib/postgresql/

# Corrigir permissões se necessário
sudo chown -R postgres:postgres /var/lib/postgresql/
```

### Firewall bloqueando conexões
```bash
# Ubuntu (ufw)
sudo ufw allow 5432

# CentOS/RHEL (firewalld)
sudo firewall-cmd --permanent --add-port=5432/tcp
sudo firewall-cmd --reload
```