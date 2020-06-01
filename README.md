# WRF-Hydro

## Uso

### shell-scripts

- `env_hydro.sh`

```sh
./env_hydro.sh nome_ambiente
```

- `up_jupyter.sh`

```sh
# Step 1: remote machine
./up_jupyter.sh -s 1
# out: allocated node name. p.ex: c010

# Step 2: local machine
./up_jupyter.sh -s 2 -n c010 -c alias_remote
# or
./up_jupyter.sh -s 2 -n c010 -c 'user@host -p port -i path_key'
# or
./up_jupyter.sh -s 2 -n c010 -p 8888 -c alias_remote
# out: perform the remote connection to the server by mirroring the port

# Step 3: remote machine (inside the node: ssh c010)
./up_jupyter.sh -s 3 -e env_name
# or
./up_jupyter.sh -s 3 -p 8888 -e env_name
# or, if env is already activated
./up_jupyter.sh -s 3
# out: running jupyter-lab
```

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
