# WRF-Hydro

## Utilidades

### Criando alias para conexão no HPC

Entrar na pasta __.ssh__: `cd ~/.ssh`
ou criá-la caso não exista: `mkdir ~/.ssh`

Criar o arquivo de configuração para adicionar o alias de conexão ao HPC: `touch config`

Abrir o arquivo com __nano__: `nano config` e adicionar o seguinte conteúdo:

```sh
Host $_alias
User $_usuario
HostName $_ip
Port $_porta
IdentityFile $_caminho_para_a_chave_privada
```

__exemplo:__

```sh
Host ogun
User patrick.ferraz
HostName 200.9.65.60
Port 22
IdentityFile ~/.ssh/cimatec_rsa
```
