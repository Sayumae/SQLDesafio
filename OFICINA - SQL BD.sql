-- Creating DataBase for Oficina (Workshop)
CREATE DATABASE oficina;
USE oficina;
SHOW TABLES;

-- Table Cliente
CREATE TABLE Cliente(
					idCliente INT AUTO_INCREMENT PRIMARY KEY,
                    CPF CHAR(11) NOT NULL UNIQUE,
                    Telefone INT UNIQUE,
                    Endereco VARCHAR(150)
					);
                    
-- Table OS - Veiculo
CREATE TABLE OSVeiculo(
						idVeiculoOS INT AUTO_INCREMENT PRIMARY KEY,
                        Modelo VARCHAR(80) NOT NULL,
                        Placa VARCHAR(25),
                        Ano YEAR,
                        StatusOS VARCHAR(100),
                        OS_Cliente INT NOT NULL,
                        CONSTRAINT fk_VeiculoOS FOREIGN KEY (OS_Cliente) REFERENCES Cliente(idCLiente)
                        );

-- Table Servico
CREATE TABLE Servico(
					idServico INT AUTO_INCREMENT PRIMARY KEY,
                    Tipo_Servico ENUM('Recall', 'Maintenance') NOT NULL DEFAULT 'Maintenance',
                    Prazo DATE,
					Valor FLOAT NOT NULL,
                    SCliente INT,
                    CONSTRAINT fk_Cliente FOREIGN KEY (SCliente) REFERENCES Cliente(idCliente)
					);
                    
-- Table Equipe
CREATE TABLE Equipe(
							idEquipe INT AUTO_INCREMENT PRIMARY KEY,
                            EspecialidadeEquipe VARCHAR(50) NOT NULL,
                            Endereco VARCHAR(45),
                            EServico INT NOT NULL,
                            ECliente INT NOT NULL,
                            CONSTRAINT fk_EServico FOREIGN KEY (EServico) REFERENCES Servico(idServico),
                            CONSTRAINT fk_ECliente FOREIGN KEY (ECliente) REFERENCES Cliente(idCliente)
                            );

-- Table Numero OS
CREATE TABLE NumeroOS(
				idOS INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
                Descricao VARCHAR(100) NOT NULL
                );             
                    
-- Table Pagamento
CREATE TABLE Pagamento(
					idPagamento INT AUTO_INCREMENT PRIMARY KEY,
					FormaPagamento ENUM('Credit Card', 'Bank Transfer', 'Cash') NOT NULL DEFAULT 'Cash',
                    POS INT NOT NULL,
					PServico INT NOT NULL,
					PCliente INT NOT NULL,
					CONSTRAINT fk_POS FOREIGN KEY (POS) REFERENCES NumeroOS(idOS),
					CONSTRAINT fk_PServico FOREIGN KEY (PServico) REFERENCES Servico(idServico),
                    CONSTRAINT fk_PCliente FOREIGN KEY (PCliente) REFERENCES Cliente(idCliente)
					);