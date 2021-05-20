
CREATE SCHEMA IF NOT EXISTS `fashiondb` DEFAULT CHARACTER SET utf8 ;
USE `fashiondb` ;


-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fashiondb`.`Factory` (
  `factory_ID` INT(9) NOT NULL,
  `name` VARCHAR(25) NULL,
  `city` VARCHAR(25) NULL,
  `location` VARCHAR(25) NULL,
  `address` VARCHAR(35) NULL,
  PRIMARY KEY (`factory_ID`))
ENGINE = InnoDB;
-- default storage engine--



-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fashiondb`.`Machine` (
  `machine_ID` INT(9) NOT NULL,
  `age` INT(3) NULL,
  `automated` TINYINT(1) NULL,
  `recycle` TINYINT(1) NULL,
  `energy_class` VARCHAR(5) NULL,
  `faccode` INT(9) NOT NULL,
  PRIMARY KEY (`machine_ID`, `faccode`),
  INDEX `factoryID_idx` (`faccode` ASC),
  CONSTRAINT `factory_ID_mach`
    FOREIGN KEY (`faccode`)
    REFERENCES `fashiondb`.`Factory` (`factory_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fashiondb`.`Product` (
  `product_ID` INT(9) NOT NULL,
  `price` DECIMAL(6,2) NULL,
  `manufacturing_date` DATE NULL,
  PRIMARY KEY (`product_ID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fashiondb`.`Produce` (
  `productcode` INT(9) NOT NULL,
  `factorycode` INT(9) NOT NULL,
  `amount` INT(7) NULL,
  PRIMARY KEY (`productcode`, `factorycode`),
  INDEX `factory_ID_idx` (`factorycode` ASC),
  CONSTRAINT `product_ID_produce`
    FOREIGN KEY (`productcode`)
    REFERENCES `fashiondb`.`Product` (`product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `factory_ID_produce`
    FOREIGN KEY (`factorycode`)
    REFERENCES `fashiondb`.`Factory` (`factory_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fashiondb`.`dress` (
  `product_ID` INT(9) NOT NULL,
  `category` ENUM('maxi', 'mini', 'asymetric') NULL,
  
  PRIMARY KEY (`product_ID`),
  CONSTRAINT `product_ID_dress`
    FOREIGN KEY (`product_ID`)
    REFERENCES `fashiondb`.`Product` (`product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fashiondb`.`tshirt` (
  `product_ID` INT(9) NOT NULL,
  `material` ENUM('elastic', 'cotton') NULL,
  
  PRIMARY KEY (`product_ID`),
  CONSTRAINT `product_ID_tshirt`
    FOREIGN KEY (`product_ID`)
    REFERENCES `fashiondb`.`Product` (`product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fashiondb`.`bags` (
  `product_ID` INT(9) NOT NULL,
  
  `category` ENUM('1', '2', '3', '4', '5') NULL,
  `name` VARCHAR(25) NULL,
  PRIMARY KEY (`product_ID`),
  CONSTRAINT `product_ID_bags`
    FOREIGN KEY (`product_ID`)
    REFERENCES `fashiondb`.`Product` (`product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fashiondb`.`Client` (
  `client_ID` INT(9) NOT NULL,
  `name` VARCHAR(25) NULL,

  PRIMARY KEY (`client_ID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fashiondb`.`Order` (
  `clientcode` INT(9) NOT NULL,
  `productcode` INT(9) NOT NULL,
  `amount` INT(7) NULL,
  PRIMARY KEY (`clientcode`, `productcode`),
  INDEX `pid_idx` (`productcode` ASC),
  CONSTRAINT `product_ID_order`
    FOREIGN KEY (`productcode`)
    REFERENCES `fashiondb`.`Product` (`product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `client_ID_order`
    FOREIGN KEY (`clientcode`)
    REFERENCES `fashiondb`.`Client` (`client_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fashiondb`.`Supplier` (
  `supplier_ID` INT(9) NOT NULL,
  `name` VARCHAR(25) NULL,

  PRIMARY KEY (`supplier_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fashiondb`.`Factory_Has_Supplier` (
  `factorycode` INT(9) NOT NULL,
  `suppliercode` INT(9) NOT NULL,
  PRIMARY KEY (`factorycode`, `suppliercode`),
  INDEX `sid_idx` (`suppliercode` ASC),
  CONSTRAINT `factory_ID_fhs`
    FOREIGN KEY (`factorycode`)
    REFERENCES `fashiondb`.`Factory` (`factory_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `supplier_ID_fhs`
    FOREIGN KEY (`suppliercode`)
    REFERENCES `fashiondb`.`Supplier` (`supplier_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
