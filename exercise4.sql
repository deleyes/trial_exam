-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Overtime_rate` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Field_area` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` VARCHAR(45) NULL,
  `Salary` FLOAT NULL,
  `Medical_ID` INT UNSIGNED NOT NULL,
  `Specialist_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`, `Medical_ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_Doctor_Medical_idx` (`Medical_ID` ASC),
  INDEX `fk_Doctor_Specialist1_idx` (`Specialist_ID` ASC),
  CONSTRAINT `fk_Doctor_Medical`
    FOREIGN KEY (`Medical_ID`)
    REFERENCES `mydb`.`Medical` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_Specialist1`
    FOREIGN KEY (`Specialist_ID`)
    REFERENCES `mydb`.`Specialist` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Total` FLOAT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Date` DATE NULL,
  `Time` TIME NULL,
  `Patient_ID` INT UNSIGNED NOT NULL,
  `Doctor_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_Appointment_Patient1_idx` (`Patient_ID` ASC),
  INDEX `fk_Appointment_Doctor1_idx` (`Doctor_ID` ASC),
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `mydb`.`Patient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Doctor1`
    FOREIGN KEY (`Doctor_ID`)
    REFERENCES `mydb`.`Doctor` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Details` BLOB NULL,
  `Method` ENUM('Credit Card', 'Visa', 'Cash', 'Banking App') NULL,
  `Patient_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`, `Patient_ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_Payment_Patient1_idx` (`Patient_ID` ASC),
  CONSTRAINT `fk_Payment_Patient1`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `mydb`.`Patient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment_has_Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment_has_Bill` (
  `Payment_ID` INT UNSIGNED NOT NULL,
  `Bill_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Payment_ID`, `Bill_ID`),
  INDEX `fk_Payment_has_Bill_Bill1_idx` (`Bill_ID` ASC),
  INDEX `fk_Payment_has_Bill_Payment1_idx` (`Payment_ID` ASC),
  CONSTRAINT `fk_Payment_has_Bill_Payment1`
    FOREIGN KEY (`Payment_ID`)
    REFERENCES `mydb`.`Payment` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_has_Bill_Bill1`
    FOREIGN KEY (`Bill_ID`)
    REFERENCES `mydb`.`Bill` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
