-- Using the DB created (oficina_refined)
show databases;
use oficina;
show tables;


-- Informacoes Cliente
insert into Cliente (CPF, Telefone, Endereco) values(11112345678, 3345789, 'Rua José das Rosas, Barra Mansa-RJ'),
												(22212345678, 12345678, 'Rua Monica do sertão, Volta Redonda-RJ'),
												(33312345678, 33456023, 'Rua Maciel das cadeiras, Guarulhos-SP'),
												(44412345678, 22853014, 'Rua joao zamil zarif, Guarulhos-SP');
									

-- Informacoes OSVeiculo

insert into OSVeiculo (Modelo, Placa, Ano, StatusOS, OS_Cliente) 
				values('Gol', 'ABC-1234', 1990, 'Brand New', '1'),
					('Fox', 'DEF-1234', 2020,'Used', '1'),
					('Creta', 'GHI-1234', 2015,'Worn', '2'),
                    ('Fusca', 'AAB-1234', 1965,'Brand New', '2'),
                    ('Kombi', 'KYP-1234', 2018,'Well Worn', '3'),
                    ('Golf', 'KOW-1234', 2021,'Used', '4');
                    

				
-- Informacoes Equipe

insert into Equipe(EspecialidadeEquipe, Endereco, EServico, ECliente) 
						values ('Old Models', 'Rua Miguel pereira, Volta Redonda - RJ',13, 2),
								('Old Models', 'Rua Miguel pereira, Volta Redonda - RJ', 17, 2),
								('New Models', 'Rua Carlos Guilherme, Volta Redonda - RJ', 18, 4),
                                ('Any model', 'Rua Henri Lima, Volta Redonda - RJ', 15, 1);
                                
                                
                                
 -- Informacoes Numero OS
insert into NumeroOS (Descricao) values ('Limpeza do carro'),
										('Barulho motor'),
                                        ('Alinhamento de rodas'),
                                        ('Correia dentada'),
                                        ('Alinhamento de capô');


-- Informacoes Servico
insert into Servico (Tipo_Servico, Prazo, Valor, SCliente) 
			values('Maintenance', '2022-10-31', 1500.00, 1),
				('Recall', '2022-10-31', 0, 1),
                ('Maintenance', '2022-12-05', 600.00, 2),
                ('Maintenance','2023-02-02', 250.00, 2),
                ('Maintenance','2023-02-02', 300.00, 3),
                ('Recall', '2023-02-09', 0, 4);
                




-- Informacoes Pagamento

insert into Pagamento (FormaPagamento, POS, PServico, PCliente) 
						values ('Cash', 2, 13, 2),
							('Credit Card', 3, 0, 2),
							('Bank Transfer', 4, 18, 4),
							('Cash', 2, 15, 1);
