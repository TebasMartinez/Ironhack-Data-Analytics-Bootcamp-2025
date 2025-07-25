-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema IH
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema IH
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `IH` DEFAULT CHARACTER SET utf8 ;
USE `IH` ;

-- -----------------------------------------------------
-- Table `IH`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IH`.`students` (
  `idstudents` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `age` INT NULL,
  PRIMARY KEY (`idstudents`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IH`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IH`.`courses` (
  `idcourses` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `dur` INT NULL,
  `teacher` VARCHAR(45) NULL,
  PRIMARY KEY (`idcourses`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IH`.`enrollments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IH`.`enrollments` (
  `students_idstudents` INT NOT NULL,
  `courses_idcourses` INT NOT NULL,
  `score` INT NULL,
  `att` INT NULL,
  PRIMARY KEY (`students_idstudents`, `courses_idcourses`),
  INDEX `fk_students_has_courses_courses1_idx` (`courses_idcourses` ASC) VISIBLE,
  INDEX `fk_students_has_courses_students_idx` (`students_idstudents` ASC) VISIBLE,
  CONSTRAINT `fk_students_has_courses_students`
    FOREIGN KEY (`students_idstudents`)
    REFERENCES `IH`.`students` (`idstudents`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_students_has_courses_courses1`
    FOREIGN KEY (`courses_idcourses`)
    REFERENCES `IH`.`courses` (`idcourses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
