
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema web_t2_galcho23
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema web_t2_galcho23
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `web_t2_galcho23` DEFAULT CHARACTER SET latin1 ;
USE `web_t2_galcho23` ;

-- -----------------------------------------------------
-- Table `web_t2_galcho23`.`user_type_code`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web_t2_galcho23`.`user_type_code` (
  `user_type_code` INT(11) NOT NULL AUTO_INCREMENT,
  `user_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_type_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `web_t2_galcho23`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web_t2_galcho23`.`user` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NOT NULL,
  `academy` VARCHAR(45) NULL DEFAULT NULL,
  `class` INT(11) NULL DEFAULT NULL,
  `user_type_code` INT(11) NULL DEFAULT NULL,
  `admin` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `user_type_code_idx` (`user_type_code` ASC) VISIBLE,
  CONSTRAINT `user_type_code`
    FOREIGN KEY (`user_type_code`)
    REFERENCES `web_t2_galcho23`.`user_type_code` (`user_type_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 29
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `web_t2_galcho23`.`team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web_t2_galcho23`.`team` (
  `team_id` INT(11) NOT NULL AUTO_INCREMENT,
  `team_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`team_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 48
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `web_t2_galcho23`.`project_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web_t2_galcho23`.`project_type` (
  `project_type_id` INT(11) NOT NULL AUTO_INCREMENT,
  `project_type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`project_type_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 36
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `web_t2_galcho23`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web_t2_galcho23`.`project` (
  `project_id` INT(11) NOT NULL AUTO_INCREMENT,
  `project_name` VARCHAR(45) NOT NULL,
  `project_type_id` INT(11) NULL DEFAULT NULL,
  `project_team_id` INT(11) NULL DEFAULT NULL,
  `date_proposed` DATE NULL DEFAULT NULL,
  `grade` INT(11) NULL DEFAULT NULL,
  `project_description` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  INDEX `proj_team_idx` (`project_team_id` ASC) VISIBLE,
  INDEX `proj_type_idx` (`project_type_id` ASC) VISIBLE,
  CONSTRAINT `proj_team`
    FOREIGN KEY (`project_team_id`)
    REFERENCES `web_t2_galcho23`.`team` (`team_id`),
  CONSTRAINT `proj_type`
    FOREIGN KEY (`project_type_id`)
    REFERENCES `web_t2_galcho23`.`project_type` (`project_type_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `web_t2_galcho23`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web_t2_galcho23`.`comment` (
  `comment_id` INT(11) NOT NULL AUTO_INCREMENT,
  `comment_content` VARCHAR(45) NOT NULL,
  `comment_project_id` INT(11) NOT NULL,
  `comment_user_id` INT(11) NOT NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `comment_proj_id_idx` (`comment_project_id` ASC) VISIBLE,
  INDEX `comment_usr_id_idx` (`comment_user_id` ASC) VISIBLE,
  CONSTRAINT `comment_usr_id`
    FOREIGN KEY (`comment_user_id`)
    REFERENCES `web_t2_galcho23`.`user` (`user_id`),
  CONSTRAINT `comment_proj_id`
    FOREIGN KEY (`comment_project_id`)
    REFERENCES `web_t2_galcho23`.`project` (`project_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 29
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `web_t2_galcho23`.`event_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web_t2_galcho23`.`event_location` (
  `event_location_id` INT(11) NOT NULL AUTO_INCREMENT,
  `event_location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`event_location_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `web_t2_galcho23`.`event_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web_t2_galcho23`.`event_type` (
  `event_type_id` INT(11) NOT NULL AUTO_INCREMENT,
  `event_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`event_type_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `web_t2_galcho23`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web_t2_galcho23`.`event` (
  `event_id` INT(11) NOT NULL AUTO_INCREMENT,
  `event_name` VARCHAR(45) NOT NULL,
  `event_location_id` INT(11) NULL DEFAULT NULL,
  `event_type_id` INT(11) NULL DEFAULT NULL,
  `event_dt` DATETIME NULL DEFAULT NULL,
  `event_duration` INT(11) NULL DEFAULT NULL,
  `event_description` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  INDEX `event_type_idx` (`event_type_id` ASC) VISIBLE,
  INDEX `event_location_idx` (`event_location_id` ASC) VISIBLE,
  CONSTRAINT `event_location`
    FOREIGN KEY (`event_location_id`)
    REFERENCES `web_t2_galcho23`.`event_location` (`event_location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `event_type`
    FOREIGN KEY (`event_type_id`)
    REFERENCES `web_t2_galcho23`.`event_type` (`event_type_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `web_t2_galcho23`.`event_user_registration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web_t2_galcho23`.`event_user_registration` (
  `user_id` INT(11) NOT NULL,
  `event_id` INT(11) NOT NULL,
  PRIMARY KEY (`user_id`, `event_id`),
  INDEX `event_id_registration_idx` (`event_id` ASC) VISIBLE,
  CONSTRAINT `event_id_registration`
    FOREIGN KEY (`event_id`)
    REFERENCES `web_t2_galcho23`.`event` (`event_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `user_id_registration`
    FOREIGN KEY (`user_id`)
    REFERENCES `web_t2_galcho23`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `web_t2_galcho23`.`project_like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `web_t2_galcho23`.`project_like` (
  `like_user_id` INT(11) NOT NULL,
  `like_project_id` INT(11) NOT NULL,
  PRIMARY KEY (`like_user_id`, `like_project_id`),
  INDEX `like_project_id_idx` (`like_project_id` ASC) VISIBLE,
  CONSTRAINT `like_project_id`
    FOREIGN KEY (`like_project_id`)
    REFERENCES `web_t2_galcho23`.`project` (`project_id`),
  CONSTRAINT `like_user_id`
    FOREIGN KEY (`like_user_id`)
    REFERENCES `web_t2_galcho23`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
