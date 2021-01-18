-- MySQL Script generated by MySQL Workbench
-- Пн 18 янв 2021 18:04:38
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Clients` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Clients` (
  `id_Client` INT UNSIGNED NOT NULL,
  `Surname` VARCHAR(50) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(50) NOT NULL,
  `OMS` VARCHAR(45) NOT NULL,
  `Document` JSON NOT NULL,
  PRIMARY KEY (`id_Client`))
ENGINE = InnoDB
COMMENT = 'Information about clients';


-- -----------------------------------------------------
-- Table `mydb`.`Positions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Positions` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Positions` (
  `id_Position` INT UNSIGNED NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `MedEducation` BIT NOT NULL DEFAULT 0,
  `MinimumExperience` INT NOT NULL DEFAULT 0,
  `Salary` INT NOT NULL,
  PRIMARY KEY (`id_Position`))
ENGINE = InnoDB
COMMENT = 'General information about positions';


-- -----------------------------------------------------
-- Table `mydb`.`Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Employees` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Employees` (
  `id_Employee` INT UNSIGNED NOT NULL,
  `Surname` VARCHAR(50) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(50) NOT NULL,
  `Experience` INT NULL,
  `Begin_at` DATE NOT NULL,
  `EducationInfo` JSON NOT NULL,
  `Position_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_Employee`),
  INDEX `fk_Employees_Positions_idx` (`Position_id` ASC) VISIBLE,
  CONSTRAINT `fk_Employees_Positions`
    FOREIGN KEY (`Position_id`)
    REFERENCES `mydb`.`Positions` (`id_Position`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Information about Employees';


-- -----------------------------------------------------
-- Table `mydb`.`Services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Services` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Services` (
  `id_Service` INT UNSIGNED NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Cost` INT NOT NULL,
  `Duration` VARCHAR(50) NOT NULL,
  `Description` TEXT NULL,
  PRIMARY KEY (`id_Service`))
ENGINE = InnoDB
COMMENT = 'Information about available Services';


-- -----------------------------------------------------
-- Table `mydb`.`Admissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Admissions` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Admissions` (
  `Employees_id` INT UNSIGNED NOT NULL,
  `Services_id` INT UNSIGNED NOT NULL,
  `Begint_at` DATE NOT NULL,
  INDEX `fk_Admissions_Employees_idx` (`Employees_id` ASC) VISIBLE,
  INDEX `fk_Admissions_Services_idx` (`Services_id` ASC) VISIBLE,
  UNIQUE INDEX `idx_Admission` (`Employees_id` ASC, `Services_id` ASC) VISIBLE,
  CONSTRAINT `fk_Admissions_Employees`
    FOREIGN KEY (`Employees_id`)
    REFERENCES `mydb`.`Employees` (`id_Employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Admissions_Services`
    FOREIGN KEY (`Services_id`)
    REFERENCES `mydb`.`Services` (`id_Service`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Admition of Employees for Services';


-- -----------------------------------------------------
-- Table `mydb`.`Requests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Requests` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Requests` (
  `id_Request` INT UNSIGNED NOT NULL,
  `DateOfOrder` DATE NOT NULL,
  `DateOfExecution` DATE NOT NULL,
  `TotalCost` INT NOT NULL,
  `Status` ENUM("preparation", "sent", "executed") NOT NULL DEFAULT 'preparation',
  PRIMARY KEY (`id_Request`))
ENGINE = InnoDB
COMMENT = 'Request for the supply of materials and equipment\n ';


-- -----------------------------------------------------
-- Table `mydb`.`Nomenclature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Nomenclature` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Nomenclature` (
  `id_Nomenclature` INT UNSIGNED NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Description` TEXT NOT NULL,
  PRIMARY KEY (`id_Nomenclature`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Information about using equipment\n';


-- -----------------------------------------------------
-- Table `mydb`.`Equipments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Equipments` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Equipments` (
  `id_Equipment` INT UNSIGNED NOT NULL,
  `Producer` VARCHAR(45) NOT NULL,
  `SN` VARCHAR(30) NOT NULL,
  `DateRelease` DATE NOT NULL,
  `LifeTime` INT NOT NULL,
  `Request_id` INT UNSIGNED NOT NULL,
  `Nomenclature_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_Equipment`),
  INDEX `fk_Equipments_Requests_idx` (`Request_id` ASC) VISIBLE,
  INDEX `fk_Equipments_Nomenclature1_idx` (`Nomenclature_id` ASC) VISIBLE,
  CONSTRAINT `fk_Equipments_Requests`
    FOREIGN KEY (`Request_id`)
    REFERENCES `mydb`.`Requests` (`id_Request`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipments_Nomenclature`
    FOREIGN KEY (`Nomenclature_id`)
    REFERENCES `mydb`.`Nomenclature` (`id_Nomenclature`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Clinic equipments';


-- -----------------------------------------------------
-- Table `mydb`.`MedMaterials`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MedMaterials` ;

CREATE TABLE IF NOT EXISTS `mydb`.`MedMaterials` (
  `id_MedMaterials` INT UNSIGNED NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Type` ENUM("medicine", "reagent", "consumable") NOT NULL DEFAULT 'medicines',
  `Count` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_MedMaterials`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Info about materials and medicines';


-- -----------------------------------------------------
-- Table `mydb`.`ConsumptionRate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ConsumptionRate` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ConsumptionRate` (
  `Service_id` INT UNSIGNED NOT NULL,
  `Equipment_id` INT UNSIGNED NOT NULL,
  `MedMaterials_id` INT UNSIGNED NOT NULL,
  `Count` INT NOT NULL DEFAULT 1,
  INDEX `fk_ConsumptionRate_Services_idx` (`Service_id` ASC) VISIBLE,
  INDEX `fk_ConsumptionRate_Equipment_idx` (`Equipment_id` ASC) VISIBLE,
  INDEX `fk_ConsumptionRate_MedMaterials_idx` (`MedMaterials_id` ASC) VISIBLE,
  CONSTRAINT `fk_ConsumptionRate_Services`
    FOREIGN KEY (`Service_id`)
    REFERENCES `mydb`.`Services` (`id_Service`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ConsumptionRate_Equipments`
    FOREIGN KEY (`Equipment_id`)
    REFERENCES `mydb`.`Equipments` (`id_Equipment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ConsumptionRate_MedMaterials`
    FOREIGN KEY (`MedMaterials_id`)
    REFERENCES `mydb`.`MedMaterials` (`id_MedMaterials`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Information about rat98+';


-- -----------------------------------------------------
-- Table `mydb`.`RequestDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`RequestDetails` ;

CREATE TABLE IF NOT EXISTS `mydb`.`RequestDetails` (
  `Request_id` INT UNSIGNED NOT NULL,
  `MedMaterials_id` INT UNSIGNED NULL,
  `Nomenclature_id` INT UNSIGNED NULL,
  `Count` INT UNSIGNED NOT NULL DEFAULT 1,
  INDEX `fk_RequestDetails_Requests_idx` (`Request_id` ASC) VISIBLE,
  INDEX `fk_RequestDetails_MedMaterials_idx` (`MedMaterials_id` ASC) VISIBLE,
  INDEX `fk_RequestDetails_Nomenclature_idx` (`Nomenclature_id` ASC) VISIBLE,
  UNIQUE INDEX `mm_idx` (`Request_id` ASC, `MedMaterials_id` ASC) VISIBLE,
  UNIQUE INDEX `nm_idx` (`Request_id` ASC, `Nomenclature_id` ASC) VISIBLE,
  CONSTRAINT `fk_RequestDetails_Requests`
    FOREIGN KEY (`Request_id`)
    REFERENCES `mydb`.`Requests` (`id_Request`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RequestDetails_MedMaterials`
    FOREIGN KEY (`MedMaterials_id`)
    REFERENCES `mydb`.`MedMaterials` (`id_MedMaterials`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RequestDetails_Nomenclature`
    FOREIGN KEY (`Nomenclature_id`)
    REFERENCES `mydb`.`Nomenclature` (`id_Nomenclature`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Detail about requests for materials';


-- -----------------------------------------------------
-- Table `mydb`.`Appeals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Appeals` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Appeals` (
  `id_Appeal` INT UNSIGNED NOT NULL,
  `Client_id` INT UNSIGNED NOT NULL,
  `Employee_id` INT UNSIGNED NOT NULL,
  `Date_at` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` ENUM("booking", "paid", "processing", "executed") NULL DEFAULT 'booking',
  PRIMARY KEY (`id_Appeal`),
  INDEX `fk_Appeals_Clients_idx` (`Client_id` ASC) VISIBLE,
  INDEX `fk_Appeals_Employees_idx` (`Employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_Appeals_Clients`
    FOREIGN KEY (`Client_id`)
    REFERENCES `mydb`.`Clients` (`id_Client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appeals_Employees`
    FOREIGN KEY (`Employee_id`)
    REFERENCES `mydb`.`Employees` (`id_Employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Client appeals';


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Orders` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `id_Order` INT UNSIGNED NOT NULL,
  `Appeal_id` INT UNSIGNED NOT NULL,
  `Service_id` INT UNSIGNED NOT NULL,
  `Employee_id` INT UNSIGNED NOT NULL,
  `DateOrder` DATE NOT NULL,
  `DateExecution` DATE NOT NULL,
  `ExecutionStatus` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_Order`),
  INDEX `fk_Orders_Appeals_idx` (`Appeal_id` ASC) VISIBLE,
  INDEX `fk_Orders_Services_idx` (`Service_id` ASC) VISIBLE,
  INDEX `fk_Orders_Employees_idx` (`Employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Appeals`
    FOREIGN KEY (`Appeal_id`)
    REFERENCES `mydb`.`Appeals` (`id_Appeal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Services`
    FOREIGN KEY (`Service_id`)
    REFERENCES `mydb`.`Services` (`id_Service`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Employees`
    FOREIGN KEY (`Employee_id`)
    REFERENCES `mydb`.`Employees` (`id_Employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'INformation about Orders';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
