drop database if exists mercadoDB;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mercado
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mercado
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mercado` DEFAULT CHARACTER SET utf8 ;
USE `mercado` ;

-- -----------------------------------------------------
-- Table `mercado`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mercado`.`Fornecedor` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome Fantasia` VARCHAR(45) NOT NULL,
  `Razao_Social` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  `Contato` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Telefone` CHAR(12) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercado`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mercado`.`Produto` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(255) NOT NULL,
  `Quantidade` INT NOT NULL,
  `Data_Validade` DATE NOT NULL,
  `Peso` FLOAT NOT NULL,
  `Custo` FLOAT NOT NULL,
  `Valor Venda` FLOAT NOT NULL,
  `Categoria_Produto` ENUM('Alimenticio', 'Vestuario', 'Bijouteria', 'Eletrônico', 'Livro', 'Sapato', 'Bebida', 'Vitamina') NOT NULL,
  `Fornecedor_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Produto_Fornecedor1_idx` (`Fornecedor_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_Fornecedor1`
    FOREIGN KEY (`Fornecedor_ID`)
    REFERENCES `mercado`.`Fornecedor` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercado`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mercado`.`Cliente` (
  `CPF` CHAR(11) NOT NULL,
  `Primeiro_Nome` VARCHAR(45) NOT NULL,
  `Segndo_Nome` VARCHAR(45) NOT NULL,
  `Sobrenome` VARCHAR(45) NOT NULL,
  `Data_Nascimento` DATE NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  `Email` VARCHAR(255) NULL,
  `Celular` CHAR(11) NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercado`.`Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mercado`.`Vendedor` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CPF` CHAR(11) NOT NULL,
  `Primeiro_nome` VARCHAR(45) NOT NULL,
  `Segundo_nome` VARCHAR(45) NULL,
  `Sobrenome` VARCHAR(45) NOT NULL,
  `Salario` FLOAT NOT NULL,
  `Data_nascimento` DATE NOT NULL,
  `celular` CHAR(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercado`.`Nota_Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mercado`.`Nota_Venda` (
  `ID_Venda` INT NOT NULL AUTO_INCREMENT,
  `Vendedor_ID` INT NOT NULL,
  `Cliente_CPF` INT NOT NULL,
  `Quantidade` FLOAT NOT NULL,
  `Cliente_CPF1` CHAR(11) NOT NULL,
  PRIMARY KEY (`ID_Venda`, `Vendedor_ID`, `Cliente_CPF`, `Cliente_CPF1`),
  INDEX `fk_Nota_Venda_Vendedor1_idx` (`Vendedor_ID` ASC) VISIBLE,
  INDEX `fk_Nota_Venda_Cliente1_idx` (`Cliente_CPF1` ASC) VISIBLE,
  CONSTRAINT `fk_Nota_Venda_Vendedor1`
    FOREIGN KEY (`Vendedor_ID`)
    REFERENCES `mercado`.`Vendedor` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Nota_Venda_Cliente1`
    FOREIGN KEY (`Cliente_CPF1`)
    REFERENCES `mercado`.`Cliente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercado`.`Nota_Venda_has_Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mercado`.`Nota_Venda_has_Produto` (
  `Nota_Venda_ID_Venda` INT NOT NULL,
  `Produto_ID` INT NOT NULL,
  PRIMARY KEY (`Nota_Venda_ID_Venda`, `Produto_ID`),
  INDEX `fk_Nota_Venda_has_Produto_Produto1_idx` (`Produto_ID` ASC) VISIBLE,
  INDEX `fk_Nota_Venda_has_Produto_Nota_Venda1_idx` (`Nota_Venda_ID_Venda` ASC) VISIBLE,
  CONSTRAINT `fk_Nota_Venda_has_Produto_Nota_Venda1`
    FOREIGN KEY (`Nota_Venda_ID_Venda`)
    REFERENCES `mercado`.`Nota_Venda` (`ID_Venda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Nota_Venda_has_Produto_Produto1`
    FOREIGN KEY (`Produto_ID`)
    REFERENCES `mercado`.`Produto` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
