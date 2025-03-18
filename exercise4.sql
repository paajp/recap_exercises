-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema exercise4
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema exercise4
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `exercise4` ;
USE `exercise4` ;

-- -----------------------------------------------------
-- Table `exercise4`.`specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`specialist` (
  `idspecialist` INT NOT NULL,
  `field_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idspecialist`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`doctor` (
  `iddoctor` INT NOT NULL AUTO_INCREMENT,
  `doctorName` VARCHAR(45) NOT NULL,
  `doctorDOB` DATE NULL,
  `doctorAddress` VARCHAR(45) NULL,
  `doctorPhone` VARCHAR(10) NULL,
  `salary` FLOAT NULL,
  `specialist_idspecialist` INT NOT NULL,
  PRIMARY KEY (`iddoctor`),
  INDEX `fk_doctor_specialist1_idx` (`specialist_idspecialist` ASC) VISIBLE,
  CONSTRAINT `fk_doctor_specialist1`
    FOREIGN KEY (`specialist_idspecialist`)
    REFERENCES `exercise4`.`specialist` (`idspecialist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`medical` (
  `idmedical` INT NOT NULL AUTO_INCREMENT,
  `overtime_rate` FLOAT NULL,
  `doctor_iddoctor` INT NOT NULL,
  PRIMARY KEY (`idmedical`),
  INDEX `fk_medical_doctor1_idx` (`doctor_iddoctor` ASC) VISIBLE,
  CONSTRAINT `fk_medical_doctor1`
    FOREIGN KEY (`doctor_iddoctor`)
    REFERENCES `exercise4`.`doctor` (`iddoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`patient` (
  `idpatient` INT NOT NULL,
  `patientName` VARCHAR(45) NULL,
  `patientAddress` VARCHAR(45) NULL,
  `patientPhone` VARCHAR(10) NULL,
  `patientDOB` DATE NULL,
  PRIMARY KEY (`idpatient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`appointment` (
  `idappointment` INT NOT NULL,
  `date` DATE NULL,
  `time` TIME NULL,
  `doctor_iddoctor` INT NOT NULL,
  `patient_idpatient` INT NOT NULL,
  PRIMARY KEY (`idappointment`),
  INDEX `fk_appointment_doctor1_idx` (`doctor_iddoctor` ASC) VISIBLE,
  INDEX `fk_appointment_patient1_idx` (`patient_idpatient` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_doctor1`
    FOREIGN KEY (`doctor_iddoctor`)
    REFERENCES `exercise4`.`doctor` (`iddoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_patient1`
    FOREIGN KEY (`patient_idpatient`)
    REFERENCES `exercise4`.`patient` (`idpatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`payment` (
  `idpayment` INT NOT NULL,
  `details` BLOB NOT NULL,
  `method` ENUM('cash', 'card') NOT NULL,
  PRIMARY KEY (`idpayment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`bill` (
  `idbill` INT NOT NULL,
  `total` FLOAT NOT NULL,
  `patient_idpatient` INT NOT NULL,
  PRIMARY KEY (`idbill`),
  INDEX `fk_bill_patient1_idx` (`patient_idpatient` ASC) VISIBLE,
  CONSTRAINT `fk_bill_patient1`
    FOREIGN KEY (`patient_idpatient`)
    REFERENCES `exercise4`.`patient` (`idpatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`bill_has_payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`bill_has_payment` (
  `bill_idbill` INT NOT NULL,
  `payment_idpayment` INT NOT NULL,
  PRIMARY KEY (`bill_idbill`, `payment_idpayment`),
  INDEX `fk_bill_has_payment_payment1_idx` (`payment_idpayment` ASC) VISIBLE,
  INDEX `fk_bill_has_payment_bill1_idx` (`bill_idbill` ASC) VISIBLE,
  CONSTRAINT `fk_bill_has_payment_bill1`
    FOREIGN KEY (`bill_idbill`)
    REFERENCES `exercise4`.`bill` (`idbill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bill_has_payment_payment1`
    FOREIGN KEY (`payment_idpayment`)
    REFERENCES `exercise4`.`payment` (`idpayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
