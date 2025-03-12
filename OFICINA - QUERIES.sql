use oficina;

-- QUERIES
show tables;
select * from Cliente;
select * from NumeroOS;
select * from Pagamento;
select * from Servico;
select * from OSVeiculo;
select * from Equipe;

select * from Cliente, Pagamento where idCliente=PCliente;
select CPF, Telefone, FormaPagamento, POS from Cliente, Pagamento  where idCLiente=PCliente;


select * from Ciiente, Servico where idCliente=SCliente ORDER BY idCliente;
select Prazo, CPF, Telefone, Endereco, Tipo_Servico
				from Cliente, Servico 
                where idCliente=SCliente
                order by Prazo;
