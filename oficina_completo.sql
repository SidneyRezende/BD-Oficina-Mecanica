-- ============================================
-- PROJETO: BANCO DE DADOS - OFICINA MECÂNICA
-- ============================================

DROP DATABASE IF EXISTS oficina_mecanica;
CREATE DATABASE oficina_mecanica;
USE oficina_mecanica;

-- =========================
-- TABELAS PRINCIPAIS
-- =========================

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(150)
);

CREATE TABLE veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(50),
    marca VARCHAR(50),
    ano INT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cargo VARCHAR(50),
    salario DECIMAL(10,2)
);

CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100),
    preco DECIMAL(10,2)
);

CREATE TABLE pecas (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100),
    preco DECIMAL(10,2),
    estoque INT
);

CREATE TABLE ordens_servico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    data_abertura DATE,
    data_fechamento DATE,
    status VARCHAR(30),
    id_veiculo INT,
    id_funcionario INT,
    FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

CREATE TABLE os_servicos (
    id_os INT,
    id_servico INT,
    PRIMARY KEY (id_os, id_servico),
    FOREIGN KEY (id_os) REFERENCES ordens_servico(id_os),
    FOREIGN KEY (id_servico) REFERENCES servicos(id_servico)
);

CREATE TABLE os_pecas (
    id_os INT,
    id_peca INT,
    quantidade INT,
    PRIMARY KEY (id_os, id_peca),
    FOREIGN KEY (id_os) REFERENCES ordens_servico(id_os),
    FOREIGN KEY (id_peca) REFERENCES pecas(id_peca)
);

CREATE TABLE pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_os INT,
    valor DECIMAL(10,2),
    forma_pagamento VARCHAR(30),
    data_pagamento DATE,
    FOREIGN KEY (id_os) REFERENCES ordens_servico(id_os)
);

-- =========================
-- INSERÇÃO DE DADOS
-- =========================

INSERT INTO clientes VALUES
(NULL,'João Silva','11999999999','joao@email.com','Rua A'),
(NULL,'Maria Souza','11888888888','maria@email.com','Rua B');

INSERT INTO veiculos VALUES
(NULL,'ABC1234','Civic','Honda',2020,1),
(NULL,'DEF5678','Corolla','Toyota',2019,2);

INSERT INTO funcionarios VALUES
(NULL,'Carlos Lima','Mecânico',3500),
(NULL,'Ana Paula','Atendente',2500);

INSERT INTO servicos VALUES
(NULL,'Troca de óleo',150),
(NULL,'Alinhamento',120),
(NULL,'Revisão geral',300);

INSERT INTO pecas VALUES
(NULL,'Filtro de óleo',50,100),
(NULL,'Pastilha de freio',200,50);

INSERT INTO ordens_servico VALUES
(NULL,'2024-02-01','2024-02-02','Finalizada',1,1),
(NULL,'2024-02-05','2024-02-06','Finalizada',2,1);

INSERT INTO os_servicos VALUES
(1,1),(1,2),(2,3);

INSERT INTO os_pecas VALUES
(1,1,1),(2,2,2);

INSERT INTO pagamentos VALUES
(NULL,1,320,'Cartão','2024-02-02'),
(NULL,2,700,'Pix','2024-02-06');

-- =========================
-- QUERIES COMPLETAS
-- =========================

-- SELECT simples
SELECT * FROM clientes;

-- WHERE
SELECT * FROM veiculos WHERE marca = 'Honda';

-- Atributo derivado
SELECT descricao, preco, preco * 1.10 AS preco_com_aumento FROM servicos;

-- ORDER BY
SELECT * FROM funcionarios ORDER BY salario DESC;

-- GROUP BY + HAVING
SELECT forma_pagamento, SUM(valor) AS total
FROM pagamentos
GROUP BY forma_pagamento
HAVING total > 300;

-- JOIN complexa
SELECT 
    c.nome AS cliente,
    v.placa,
    os.id_os,
    os.status,
    f.nome AS funcionario
FROM ordens_servico os
JOIN veiculos v ON os.id_veiculo = v.id_veiculo
JOIN clientes c ON v.id_cliente = c.id_cliente
JOIN funcionarios f ON os.id_funcionario = f.id_funcionario;

-- Valor total por OS (serviços + peças)
SELECT 
    os.id_os,
    SUM(s.preco) + SUM(p.preco * op.quantidade) AS valor_total
FROM ordens_servico os
JOIN os_servicos oss ON os.id_os = oss.id_os
JOIN servicos s ON oss.id_servico = s.id_servico
JOIN os_pecas op ON os.id_os = op.id_os
JOIN pecas p ON op.id_peca = p.id_peca
GROUP BY os.id_os;
