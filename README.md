
---

## 🧠 Modelagem do Banco de Dados

### Entidades Principais:
- Clientes
- Veículos
- Funcionários
- Ordens de Serviço
- Serviços
- Peças
- Pagamentos

### Relacionamentos:
- Um cliente possui vários veículos.
- Um veículo pode ter várias ordens de serviço.
- Uma ordem de serviço pode conter vários serviços e peças.
- Cada ordem de serviço gera um pagamento.

---

## 🗄 Script SQL

O arquivo **oficina_completo.sql** contém:

- Criação do banco de dados
- Criação das tabelas com chaves primárias e estrangeiras
- Inserção de dados para testes
- Consultas SQL avançadas

---

## 🔍 Exemplos de Consultas Implementadas

- Listagem de clientes cadastrados
- Filtro de veículos por marca
- Cálculo de valores derivados
- Total de pagamentos por forma de pagamento
- Consulta com múltiplos JOINs
- Valor total por ordem de serviço

---

## 🚀 Como Executar

1. Clone o repositório:
└── checklist/
└── Checklist_Entrega.pdf

2. Abra seu SGBD MySQL / MariaDB.

3. Execute o script:

source oficina_completo.sql;
---

## 🛠 Tecnologias Utilizadas
- MySQL / MariaDB
- SQL
- Git
- GitHub
- Draw.io / MySQL Workbench (para diagrama)

---

## 👤 Autor
Projeto desenvolvido por **Sidney Rezende**.

---

## 📄 Licença
Projeto desenvolvido exclusivamente para fins educacionais.

