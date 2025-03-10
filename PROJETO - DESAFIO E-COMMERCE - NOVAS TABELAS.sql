USE ecommerce;

-- Tabela Pessoa Física
CREATE TABLE PF (
	CPF CHAR(11) PRIMARY KEY NOT NULL,
    CONSTRAINT unique_cpf UNIQUE(CPF)
);

-- Tabela Pessoa Jurídica
CREATE TABLE PJ (
	CNPJ CHAR(15) PRIMARY KEY NOT NULL,
    SocialName VARCHAR(255) NOT NULL,
    CONSTRAINT unique_cnpj UNIQUE(CNPJ)
);

-- Tabela Clientes
CREATE TABLE clients (
	idClient INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Fname VARCHAR(20),
    Minit VARCHAR(15),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Address VARCHAR(80),
    CONSTRAINT fk_cpf_client FOREIGN KEY (CPF) REFERENCES PF(CPF)
);

ALTER TABLE clients AUTO_INCREMENT=1;

-- Tabela Produtos
CREATE TABLE product (
	idProduct INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Pname VARCHAR(20) NOT NULL,
    classification_kids BOOL DEFAULT false,
    category ENUM('Eletrônico', 'Móveis', 'Brinquedos', 'Livros', 'Papelaria', 'Vestimentas', 'Alimentos') NOT NULL,
    avaliation FLOAT DEFAULT 0,
    size VARCHAR(10)
);

ALTER TABLE product AUTO_INCREMENT=1;

-- Tabela Pagamentos
CREATE TABLE payments (
    idClient INT,
    idPayment INT,
    typePayment ENUM('Cartão de Débito', 'Cartão de Crédito', 'PIX', 'Boleto', 'Dois cartões'),
    limitAvailable FLOAT,
    PRIMARY KEY(idClient, idPayment),
	CONSTRAINT unique_idPayment UNIQUE (idPayment),
    CONSTRAINT fk_payments_client FOREIGN KEY (idClient) REFERENCES clients(idClient)
);

-- Tabela Pedidos
CREATE TABLE orders (
	idOrder INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    idOrderClient INT, 
    orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
    orderDescription VARCHAR(255) DEFAULT 10.0,
    sendValue FLOAT,
    paymentCash BOOL DEFAULT false,
    idPayment INT,
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) REFERENCES clients(idClient),
    CONSTRAINT fk_orders_payment FOREIGN KEY (idOrderClient, idPayment) REFERENCES payments(idClient, idPayment)
    ON UPDATE CASCADE
);

ALTER TABLE orders AUTO_INCREMENT=1;

-- Tabela estoque
CREATE TABLE productStorage (
	idProdStorage INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    storageLocation VARCHAR(100),
    quantify INT DEFAULT 0
);

ALTER TABLE productStorage AUTO_INCREMENT=1;

-- Tabela fornecedor
CREATE TABLE supplier (
	idSupplier INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    CNPJ CHAR(15) NOT NULL,
    contact VARCHAR(23) NOT NULL,
    CONSTRAINT unique_cnpj_supplier UNIQUE (CNPJ),
    CONSTRAINT fk_cnpj_supplier FOREIGN KEY (CNPJ) REFERENCES PJ(CNPJ)
);

ALTER TABLE supplier AUTO_INCREMENT=1;

-- Tabela vendedor
CREATE TABLE seller (
	idSeller INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    CNPJ CHAR(15),
    CPF CHAR(11),
    AbstName VARCHAR(30),
    location VARCHAR(255),
    contact VARCHAR(23) NOT NULL,
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE (CPF),
    CONSTRAINT fk_cnpj_seller FOREIGN KEY (CNPJ) REFERENCES PJ(CNPJ),
    CONSTRAINT fk_cpf_seller FOREIGN KEY (CPF) REFERENCES PF(CPF)
);

ALTER TABLE seller AUTO_INCREMENT=1;

-- Tabela relação: Produto -> Vendedor
CREATE TABLE productSeller (
	idSeller INT,
    idProduct INT,
    prodQuantify INT DEFAULT 1,
    PRIMARY KEY (idSeller, idProduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idSeller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

-- Tabela relação: Produto -> Pedido
CREATE TABLE productOrder (
	idPOproduct INT,
    idPOorder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPOproduct, idPOorder),
    CONSTRAINT fk_productorder_product FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_productorder_order FOREIGN KEY (idPOorder) REFERENCES orders(idOrder)
);

-- Tabela relação: Estoque -> Produto
CREATE TABLE storageLocation(
	idLproduct INT,
    idLstorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_storage_location_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storage_location_storage FOREIGN KEY (idLstorage) REFERENCES productStorage(idProdStorage)
);

-- Tabela relação: Produto -> Fornecedor
CREATE TABLE productSupplier(
	idPsSupplier INT,
    idPsProduct INT,
    quantity INT NOT NULL,
    PRIMARY KEY (idPsSupplier, idPsProduct),
    CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPsSupplier) REFERENCES supplier(idSupplier),
    CONSTRAINT fk_product_supplier_prodcut FOREIGN KEY (idPsProduct) REFERENCES product(idProduct)
);

USE information_schema;

DESC table_constraints;
DESC referential_constraints;
SELECT * FROM referential_constraints WHERE CONSTRAINT_SCHEMA = 'ecommerce';