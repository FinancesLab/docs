# FinancesLabs Docs | Wiki <!-- omit from toc -->

Esse repositório contém a documentação dos projetos do **FinancesLabs**.

## Sumário <!-- omit from toc -->

As tecnologias utilizadas no projeto são **Java**, **Python**, **MySQL** e **RabbitMQ**.

- [Java](#java)
  - [Projetos](#projetos)
  - [Configurações](#configurações)
- [Python](#python)
  - [Projetos](#projetos-1)
  - [Configurações](#configurações-1)
- [MySQL](#mysql)
- [RabbitMQ](#rabbitmq)
  - [Configurações - Filas e Exchanges](#configurações---filas-e-exchanges)
  - [Filas X Projetos](#filas-x-projetos)

## Java

### Projetos

- [TickersProducer](https://github.com/FinancesLab/TickersProducer) <br />
  Responsável por coletar dados simplificados de tickers financeiros vindos do **MySQL** e enviá-los para o **RabbitMQ**.

### Configurações

- **Dependências**

  > Para a execução dos projetos **Java**, é necessário ter o **Java** instalado e configurado em sua máquina.
  > Caso não tenha ainda, você pode baixá-lo através do [Link de Download - Java 17](https://www.oracle.com/java/technologies/javase-jdk17-downloads.html).

  É necessário também, antes de executar o projeto, ter as dependências do **Maven** instaladas.

  Para isso, basta realizar a instalação das bibliotecas através do **Maven** usando a sua **IDE** preferida ou executar o comando abaixo na raiz do projeto:

  ```bash
  mvn clean install
  ```

  > O comando requer que o **Maven** esteja instalado e devidamente configurado previamente em sua máquina, podendo incluir configurações de variáveis de ambientes e outros.

- **Variáveis de Ambiente**

  Os códigos **Java** sempre irão conter um arquivo `.env.example` com o formato das variáveis de ambiente necessárias para o funcionamento do código.

  Para que o código funcione, basta duplicar o arquivo `.env.example` e renomeá-lo para `.env`, preenchendo as variáveis de ambiente com os valores corretos e configurar sua **IDE** para selecionar o arquivo `.env` como arquivo de variáveis de ambiente.

  > Ou, caso prefira, você pode configurar as variáveis de ambiente diretamente na sua **IDE** mantendo as chaves com o mesmo nome e formato do arquivo `.env.example`.

## Python

### Projetos

- [RelevantFactsWorker](https://github.com/FinancesLab/RelevantFactsWorker) <br />
  Recebe a mensagem de qual ticker será consultado e retorna os fatos relevantes do ticker para o **RabbitMQ**.

- [TickersDetailsWorker](https://github.com/FinancesLab/TickersDetailsWorker) <br/>
  Recebe a mensagem de qual ticker será consultado e retorna os detalhes do ticker para o **RabbitMQ**.

### Configurações

- **Dependências**

  > Para a execução dos projetos **Python**, é necessário ter o próprio **Python** instalado e configurado em sua máquina.
  > Caso não tenha ainda, você pode baixá-lo através do [Link de Download - Python 3.12](https://www.python.org/downloads/release/python-3120/).

  É aconselhável que se utilize um ambiente virtual para a execução dos projetos **Python**.
  Para isso, você pode instalar o **venv** através do comando abaixo:

  ```bash
  # Instalação do venv
  python -m venv venv

  # Ativação do venv
  source venv/bin/activate
  ```

  Para instalar as dependências do projeto, é necessário executar o comando abaixo na raiz do projeto:

  ```bash
  pip install -r requirements.txt
  ```

  Para executar o projeto, basta executar o comando abaixo na raiz do projeto:

  ```bash
  python main.py
  ```

- **Variáveis de Ambiente**

  Os códigos Python sempre irão conter um arquivo `.env.example` com o formato das variáveis de ambiente necessárias para o funcionamento do código.

  Para que o projeto funcione corretamente, basta replicar o arquivo `.env.example` e renomeá-lo para `.env`, preenchendo as variáveis de ambiente com os valores corretos.

## MySQL

O **MySQL** é um sistema de gerenciamento de banco de dados relacional que armazena os dados dos tickers financeiros.

Todos DDLs e DMLs das tabelas e os dados iniciais do banco estão disponíveis [aqui](https://github.com/FinancesLab/docs/blob/main/database), nesse mesmo repositório.

## RabbitMQ

O **RabbitMQ** é um sistema de mensageria que permite a comunicação entre diferentes aplicações. Ele é utilizado para enviar e receber mensagens entre os projetos.

### Configurações - Filas e Exchanges

Todas as filas e exchanges utilizadas no projeto serão criadas automaticamente ao executar os projetos.

### Filas X Projetos

**Vínculos das filas utilizadas em cada projeto**

<details>
  <summary>Main Tasks - Fanout</summary>

- **main_tasks_fanout**

  - TickersProducer

</details>

<details>
  <summary>Relevant Facts - Queues</summary>

- **relevant_facts_tasks**

  - TickersProducer
  - RelevantFactsWorker

- **relevant_facts_tasks.dlq (Dead Letter Queue)**

  - TickersProducer

- **relevant_facts_tasks.parking-lot**

  - TickersProducer

- **relevant_facts_results**

  - RelevantFactsWorker

- **relevant_facts_results.dlq (Dead Letter Queue)**

  - RelevantFactsWorker

- **relevant_facts_results.parking-lot**

  - RelevantFactsWorker

</details>

<details>
  <summary>Tickers Details - Queues</summary>

- **tickers_details_tasks**

  - TickersProducer
  - TickersDetailsWorker

- **tickers_details_tasks.dlq (Dead Letter Queue)**

  - TickersProducer

- **tickers_details_tasks.parking-lot**

  - TickersProducer

- **tickers_details_results**

  - TickersDetailsWorker

- **tickers_details_results.dlq (Dead Letter Queue)**

  - TickersDetailsWorker

- **tickers_details_results.parking-lot**

  - TickersDetailsWorker

</details>
