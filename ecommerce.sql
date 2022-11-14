-- MySQL Workbench 

-- Schema ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8 ;
USE `ecommerce` ;

-- -----------------------------------------------------
-- Table `ecommerce`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Clients` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `FName` VARCHAR(10) NOT NULL,
  `Minit` VARCHAR(3) NULL,
  `Lname` VARCHAR(20) NULL COMMENT 
  `CPF` CHAR(11) NOT NULL,
  `Address` VARCHAR(45) NOT NULL COMMENT 'atributo composto: rua, bairro, complemento, cidade e estado e cep',
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`orders` (
  `idOrdes` INT NOT NULL AUTO_INCREMENT,
  `idOrderClient` INT NOT NULL,
  `orderStatus` ENUM('Em andamento', 'Em processamento', 'Enviado', 'Entregue') NOT NULL DEFAULT 'Em processamento',
  `orderDescription` VARCHAR(45) NULL,
  `sendValeu` FLOAT NULL,
  `paymentCash` VARCHAR(45) NULL,
  PRIMARY KEY (`idOrdes`, `idOrderClient`),
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`idOrderClient`)
    REFERENCES `ecommerce`.`Clients` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Product` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `Pname` VARCHAR(45) NOT NULL,
  `classification_kids` TINYINT NOT NULL,
  `category` VARCHAR(45) NOT NULL DEFAULT 'Eletrônico','Vestimenta','Alimentos','Móveis',
  `avaliacao` VARCHAR(45) NULL,
  `size` INT NULL,
  PRIMARY KEY (`idProduct`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Supplier` (
  `idSupplier` INT NOT NULL AUTO_INCREMENT,
  `SocialName` VARCHAR(45) NOT NULL,
  `CNPJ` VARCHAR(15) NOT NULL,
  `contact` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ`) ,
  PRIMARY KEY (`idSupplier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`productSupplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`productSupplier` (
  `idPsSupplier` INT NOT NULL,
  `idPsProduct` INT NOT NULL,
  `quantity` VARCHAR(45) NULL,
  PRIMARY KEY (`idPsSupplier`, `idPsProduct`),
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`idPsSupplier`)
    REFERENCES `ecommerce`.`Supplier` (`idSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`idPsProduct`)
    REFERENCES `ecommerce`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`productStorage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`productStorage` (
  `idproductStorage` INT NOT NULL AUTO_INCREMENT,
  `storageLocation` VARCHAR(45) NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`idproductStorage`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `ecommerce`.`productOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`productOrder` (
  `idPOproduct` INT NOT NULL AUTO_INCREMENT,
  `idPOordes` INT NOT NULL,
  `poQuantity` INT NULL,
  `poStatus` ENUM('disponível', 'sem estoque') NULL DEFAULT 'disponivel',
  PRIMARY KEY (`idPOproduct`, `idPOordes`),
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`idPOproduct`)
    REFERENCES `ecommerce`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`idPOordes`)
    REFERENCES `ecommerce`.`orders` (`idOrdes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`Seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Seller` (
  `idSeller` INT NOT NULL AUTO_INCREMENT,
  `SocialName` VARCHAR(45) NOT NULL,
  `AbsName` VARCHAR(45) NOT NULL,
  `CNPJ` VARCHAR(15) NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NULL,
  `contact` VARCHAR(15) NULL,
  UNIQUE INDEX `Razao_Social_UNIQUE` (`SocialName` ASC) VISIBLE,
  UNIQUE INDEX `CPF_CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  PRIMARY KEY (`idSeller`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`productSeller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`productSeller` (
  `idPseller` INT NOT NULL AUTO_INCREMENT,
  `idPproduct` INT NOT NULL,
  `prodQuantity` INT NULL,
  PRIMARY KEY (`idPseller`, `idPproduct`),
  CONSTRAINT `fk_Terceiro_Vendedor_has_Produto_Terceiro_Vendedor1`
    FOREIGN KEY (`idPseller`)
    REFERENCES `ecommerce`.`Seller` (`idSeller`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro_Vendedor_has_Produto_Produto1`
    FOREIGN KEY (`idPproduct`)
    REFERENCES `ecommerce`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

