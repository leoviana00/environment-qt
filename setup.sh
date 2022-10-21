
#!/bin/bash

#---------------------------------------------------------------#
# Objetivo: Prepara o ambiente para trabalhar             
# Ferramentas instaladas:
#---------------------------------------------------------------#
# - Update repositories
# - Compiladores C++
# - Drivers de conexão ao Sql Server e Postgresql
# - Stack Trace do compilador do C++
# - Bibliotecas para exibição gráficos
# - Softwares de Suporte
# - Icecc - Compilação distribuída
# - Git
# - Yakuake
# - Htop
# - OpenJDK 17
# - Maven
# - Open SSH
# - Wireguard
# - Docker
# - SMB Client
# - Driver ODBC
# - QT
# - Cowsay
# - Vim
# - Telnet
# - Netcat
# - Virtualbox
# - Vagrant
# - Ansible
#
#---------------------------------------------------------------

#colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
IYELLOW='\033[1;33m'
BWhite='\033[1;37m'

#variables
VERSION_QT=5.9.6

# Forçar o script ser utilizado com user root
if [[ ${EUID} -ne 0 ]]; then
    echo "Esse script deve ser executado como root." > /dev/stderr
    exit 1
fi

#log-aviso
function log() {
  echo -e "${GREEN}$(date +'%Y-%m-%dT%H:%M:%S')" "==> Success: Script install tools - $1${NC}"
}

#log-aviso-error
function log_err() {
  echo -e "${RED}$(date +'%Y-%m-%dT%H:%M:%S')" "==> Failure: Script install tools - $1${NC}"
}

#Cabeçalho
echo -e "${BWhite} ------------------------------------------------------------------------------- ${NC}"
echo -e "${BWhite}              INICIANDO SCRIPT DE INSTALAÇÃO PARA DESENVOLVEDORES                ${NC}"
echo -e "${BWhite} ------------------------------------------------------------------------------- ${NC}"
sleep 5

# --------------------------------------------------------------------
#                    ATUALIZAÇÃO DOS REPOSITÓRIOS
# --------------------------------------------------------------------

echo -e "${IYELLOW} TASK 01 - ATUALIZAÇÃO DO REPOSITÓRIO ...${NC}"
if ! sudo apt-get update -y >/dev/null 2>&1
then
    log_err "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    exit 1
fi
log "Atualização de repositório realizada com sucesso"

# --------------------------------------------------------------------
#                       COMPILADORES DO C++
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 02 - INSTALAÇÃO DOS COMPILADORES DO C++ ...${NC}"
if ! sudo apt-get install build-essential -y >/dev/null 2>&1
then
    log_err "Não foi possível instalar o pacote build-essential"
    exit 1
fi
log "Instalação dos compilador do c++ finalizada"

# --------------------------------------------------------------------
#          DRIVERS PARA CONECTAR AO SQL SERVER E POSTGRESQL
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 03 - INSTALAÇÃO DOS DRIVERS PARA CONECTAR AO SQL SERVER E POSTGRESQL ...${NC}"
if ! sudo apt-get install unixodbc unixodbc-dev freetds-dev freetds-bin tdsodbc postgresql-server-dev-all -y >/dev/null 2>&1
then
    log_err "Não foi possível instalar os drivers para conectar ao sql server, postgresql"
    exit 1
fi
log "Instalação dos drivers sqlserver, postgresql finalizada..."

# --------------------------------------------------------------------
#                    STACK TRACE DO COMPILADOR DO C++ 
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 04 - INSTALAÇÃO STACK TRACE DO COMPILADOR DO C++ ... ${NC}"
if ! sudo apt-get install libx11-xcb-dev libdw1 libdw-dev libgl-dev -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar as libs libdw1 libdw-dev libgl-dev "
  exit 1
fi
log "Instalação das libs libdw1 libdw-dev finalizada..."

# --------------------------------------------------------------------
#  BIBLIOTECAS PARA EXIBIÇÃO DE GRÁFICOS OPENGL PARA O CREATOR FUNCIONAR A COMPILAÇÃO
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 05 - INSTALAÇÃO DE BIBLIOTECAS PARA EXIBIÇÃO DE GRÁFICOS ${NC}"
if ! sudo apt-get install libgl1-mesa-dev qtdeclarative5-dev qml-module-qtquick-controls2 -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar as bibliotecas para exibição gráficas"
  exit 1
fi
log "Instalação das bibliotecas para exibição gráficas finalizada..."

# --------------------------------------------------------------------
#                        SOFTWARES DE SUPORTE     
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 06 - INSTALAÇÃO DE SOFTWARES DE SUPORTE ${NC}"
if ! sudo apt-get update >/dev/null 2>&1 && sudo apt-get install software-properties-common apt-transport-https ca-certificates curl wget gpg -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar basic software support"
  exit 1
fi
log "Instalação dos basic software support foi finalizada..."

# --------------------------------------------------------------------
#                     ICECC - COMPILAÇÃO DISTRIBUÍDA   
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 07 - INSTALAÇÃO DO ICECC - COMPILAÇÃO DISTRIBUÍDA ${NC}"
if ! sudo apt-get install icecc -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar o icecc"
  exit 1
fi
log "Instalação do icecc finalizada..."


# --------------------------------------------------------------------
#                    GIT - CONTROLE DE VERSÃO
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 09 - INSTALAÇÃO DO GIT - CONTROLE DE VERSÃO ${NC}"
if ! sudo apt-get install git-all -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar o git"
  exit 1
fi
log "Instalação do git finalizada..."

# --------------------------------------------------------------------
#                        YAKUAKE - TERMINAL
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 10 - INSTALAÇÃO DO YAKUAKE - TERMINAL ${NC}"
if ! sudo apt-get install libkf5globalaccel-bin yakuake -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar o terminal yakuake"
  exit 1
fi
log "Instalação do yakuake finalizada..."

# --------------------------------------------------------------------
#                      HTOP - GERENCIAMENTO
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 11 - INSTALAÇÃO DO HTOP - GERENCIAMENTO ${NC}"
if ! sudo apt-get install htop -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar o terminal htop"
  exit 1
fi
log "Instalação do htop..."

# --------------------------------------------------------------------
#                         REMOVENDO OPENJDK
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 12 - REMOVENDO OPENJDK ... ${NC}"
sudo apt remove openjdk* -y >/dev/null 2>&1
sudo add-apt-repository ppa:openjdk-r/ppa >/dev/null 2>&1
sudo apt-get update -y >/dev/null 2>&1
log "JDK removido ...."

# --------------------------------------------------------------------
#                SOFTWARE PROPERTIES COMMON E DEBCONF-UTILS
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 13 - INSTALANDO SOFTWARE PROPERTIES COMMON E DEBCONF-UTILS ... ${NC}"
sudo apt-get install software-properties-common debconf-utils -y >/dev/null 2>&1
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
log "Softwares Properties common e debconf-utils instalado com sucesso ...."

# --------------------------------------------------------------------
#                             OPENJDK 17
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 14 - INSTALANDO OPENJDK 17 ... ${NC}"
if ! sudo apt-get install openjdk-17-jdk-headless openjdk-17-jdk -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar o terminal openjdk-17-jdk"
  exit 1
fi
log "Instalação do openjdk-17-jdk finalizada..."
sleep 3
java -version

# --------------------------------------------------------------------
#                              MAVEN
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 15 - INSTALANDO MAVEN ... ${NC}"
if ! sudo apt install maven -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar o terminal maven"
  exit 1
fi
log "Instalação do maven finalizada..."
sleep 3
mvn -version

# --------------------------------------------------------------------
#                             OPENSSH
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 16 - INSTALANDO OPENSSH ... ${NC}"
if ! sudo apt-get install openssh-server -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar o terminal openssh-server"
  exit 1
fi
log "Instalação do openssh-server finalizada..."
sleep 3
ssh -V

# --------------------------------------------------------------------
#                            WIREGUARD
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 17 - INSTALANDO WIREGUARD ... ${NC}"
if ! sudo apt-get install wireguard -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar o terminal wireguard"
  exit 1
fi
log "Instalação do wireguard realizada com sucesso..."
sleep 3
wg --version

# --------------------------------------------------------------------
#                             DOCKER
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 18 - INSTALANDO DOCKER ... ${NC}"
if ! sudo apt-get install docker.io -y >/dev/null 2>&1 && sudo usermod -aG docker vagrant
then
  log_err "Não foi possível instalar o docker"
  exit 1
fi
log "Instalação do docker realizada com sucesso..."
sleep 3
docker --version
sudo docker ps

# --------------------------------------------------------------------
#                          SMBCLIENT
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 19 - INSTALANDO SMBCLIENT ... ${NC}"
if ! sudo apt-get install smbclient -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar o terminal smbclient"
  exit 1
fi
log "Instalação do smbclient finalizada..."

# --------------------------------------------------------------------
#                        RESTART SSH
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 20 - RESTARTANDO O SSH ... ${NC}"
sudo service ssh start >/dev/null 2>&1
log "Restart Shh Realizado ...."

# --------------------------------------------------------------------
#                        CONFIGURANDO O ICECC
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 21 - CONFIGURANDO O ICECC ... ${NC}"
sudo sed -i 's/ICECC_NETNAME=""/ICECC_NETNAME="node"/' /etc/icecc/icecc.conf
sudo sed -i 's/ICECC_SCHEDULER_HOST=""/ICECC_SCHEDULER_HOST="icecc.mateus"/' /etc/icecc/icecc.conf
log "Configuração do IECC finalizado..."
sleep 3
icecc --version


# --------------------------------------------------------------------
#                     CONFIGURANDO DO DRIVER ODBC
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 22 - CONFIGURANDO O DRIVER ODBC ... ${NC}"
echo -e "[freetds]\r\ndescription    = v0.63 with protocol v8.0\r\ndriver    = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so\r\nsetup    = /usr/lib/x86_64-linux-gnu/odbc/libtdss.so\r\nusagecount    = 1" >> /etc/odbcinst.ini
log "Configuração do Drive ODBC finalizada..."


# --------------------------------------------------------------------
#                    VERSÃO DO QT A SER INSTALADA
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 23 - VERSÃO DO QT A SER INSTALADA... ${NC}"

if [ -z "$VERSION_QT" ]
then
  QT_VERSION=5.12.2
else
  QT_VERSION=$VERSION_QT
fi
QT_VERSION_FRIST="$(cut -d'.' -f1 <<<"$QT_VERSION")"
QT_VERSION_SECOND="$(cut -d'.' -f2 <<<"$QT_VERSION")"
QT_VERSION_MAJOR=$QT_VERSION_FRIST.$QT_VERSION_SECOND
log "VERSAO QT A SER INSTALADA: "$QT_VERSION""

# --------------------------------------------------------------------
#                 COMPILAR E INSTALAR QT BASE
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 24 - COMPILAR E INSTALAR QT BASE ... ${NC}"
QT_DIST=/home/$(whoami)/Qt"$QT_VERSION"
QT_BASE_SRC=https://download.qt.io/official_releases/qt/"$QT_VERSION_MAJOR"/"$QT_VERSION"/submodules/qtbase-opensource-src-"$QT_VERSION".tar.xz >/dev/null 2>&1
QT_BASE_DIR=/qtbase-opensource-src-"$QT_VERSION" >/dev/null 2>&1

wget https://download.qt.io/archive/qt/${QT_VERSION_MAJOR}/${QT_VERSION}/qt-opensource-linux-x64-${QT_VERSION}.run >/dev/null 2>&1

chmod +x qt-opensource-linux-x64-${QT_VERSION}.run >/dev/null 2>&1

wget https://raw.githubusercontent.com/leoviana00/environment-work/master/qt-noninteractive.qs 

./qt-opensource-linux-x64-${QT_VERSION}.run --script qt-noninteractive.qs  #-platform minimal
log " Versão ${QT_VERSION} instalada sucesso.... "
sleep 3
qmake --version

# --------------------------------------------------------------------
#                       CRIANDO CHAVE SSH
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 25 - CRIANDO CHAVE SSH ... ${NC}"
cd /home/vagrant
ssh-keygen -t rsa
log 'Sua chave ssh foi criada com sucesso!';
sudo ls -la /home/vagrant/.ssh/id_rsa*

# --------------------------------------------------------------------
#                           COWSAY
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 26 - INSTALANDO COWSAY ... ${NC}"
if ! sudo apt list --installed 2> /dev/null | grep -i cowsay
then
  sudo apt-get install -y cowsay >/dev/null 2>&1
fi
log "Cowsay instalado com sucesso..."

# --------------------------------------------------------------------
#                              VIM
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 27 - INSTALANDO VIM ... ${NC}"
if ! sudo apt-get install vim -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar o terminal vim"
  exit 1
fi
log "Instalação do vim realizada com sucesso..."

# --------------------------------------------------------------------
#                            NETCAT
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 28 - INSTALANDO NETCAT ... ${NC}"
if ! sudo apt-get install netcat -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar netcat"
  exit 1
fi
log "Instalação do netcat realizada com sucesso..."

# --------------------------------------------------------------------
#                            TELNET
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 29 - INSTALANDO TELNET ... ${NC}"
if ! sudo apt-get install telnetd -y >/dev/null 2>&1
then
  log_err "Não foi possível instalar o telnet"
  exit 1
fi
log "Instalação do telnet realizada com sucesso..."

# --------------------------------------------------------------------
#                           VIRTUALBOX
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 30 - INSTALANDO VIRTUALBOX ... ${NC}"
if ! sudo apt-get install virtualbox virtualbox-dkms -y >/dev/null 2>&1 
then
  log_err "Não foi possível instalar o virtualbox"
  exit 1
fi
log "Instalação do virtualbox realizada com sucesso..."
sleep 3
vboxmanage --version

# --------------------------------------------------------------------
#                           VAGRANT
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 31 - INSTALANDO VAGRANT ... ${NC}"
if ! sudo apt-get install vagrant -y >/dev/null 2>&1 
then
  log_err "Não foi possível instalar o vagrant"
  exit 1
fi
log "Instalação do vagrant realizada com sucesso..."
sleep 3
vagrant --version

# --------------------------------------------------------------------
#                           ANSIBLE
# --------------------------------------------------------------------
echo -e "${IYELLOW} TASK 32 - INSTALANDO ANSIBLE ... ${NC}"
if ! sudo apt-get install ansible -y >/dev/null 2>&1 
then
  log_err "Não foi possível instalar o ansible"
  exit 1
fi
log "Instalação do ansible realizada com sucesso..."
sleep 3
ansible --version

# --------------------------------------------------------------------
#                        INTERAÇÃO COWSAY
# --------------------------------------------------------------------
echo -e "${IYELLOW}INTERAÇÃO COWSAY ... ${NC}"
echo "Aperte <ENTER> para continuar..."
read
cowsay -f ghostbusters "Você: - Terminou? Agora eu posso trabalhar?..."

echo "Aperte <ENTER> para continuar..."
read
cowsay "Sim, você pode"