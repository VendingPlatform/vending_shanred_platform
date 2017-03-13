/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.1.62-community : Database - vending
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`vending` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `vending`;

/*Table structure for table `authorityinfo` */

DROP TABLE IF EXISTS `authorityinfo`;

CREATE TABLE `authorityinfo` (
  `authId` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `authName` varchar(50) NOT NULL COMMENT '权限名称（唯一性）',
  `authCode` varchar(10) NOT NULL COMMENT '权限编码（唯一性）',
  `operateId` int(11) DEFAULT NULL COMMENT '操作者',
  `operateDate` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`authId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `authorityinfo` */

LOCK TABLES `authorityinfo` WRITE;

insert  into `authorityinfo`(`authId`,`authName`,`authCode`,`operateId`,`operateDate`) values (1,'system','000',1,'2017-02-27 12:55:37'),(2,'oper_admin','001',1,'2017-02-27 16:09:36'),(3,'manu_admin','002',1,'2017-02-27 17:02:29');

UNLOCK TABLES;

/*Table structure for table `channelgroup` */

DROP TABLE IF EXISTS `channelgroup`;

CREATE TABLE `channelgroup` (
  `channelGroupId` int(11) NOT NULL AUTO_INCREMENT COMMENT '货道组id',
  `channelGroupName` varchar(50) NOT NULL COMMENT '货道组名称',
  `wareCode` varchar(50) DEFAULT NULL COMMENT '商品编号',
  `wareName` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `warePrice` double DEFAULT NULL COMMENT '商品价格',
  `isDiscount` int(1) DEFAULT NULL COMMENT '是否特价',
  `groupId` int(11) DEFAULT NULL COMMENT '所属售货机组',
  `operateId` int(11) DEFAULT NULL COMMENT '操作人',
  `operateDate` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`channelGroupId`),
  KEY `groupId` (`groupId`),
  CONSTRAINT `t_channel_group_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `groupinfo` (`groupId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `channelgroup` */

LOCK TABLES `channelgroup` WRITE;

UNLOCK TABLES;

/*Table structure for table `channelinfo` */

DROP TABLE IF EXISTS `channelinfo`;

CREATE TABLE `channelinfo` (
  `channelId` int(11) NOT NULL AUTO_INCREMENT COMMENT '货道id',
  `channelNo` varchar(50) NOT NULL COMMENT '货道编号',
  `wareCode` varchar(50) NOT NULL COMMENT '商品编号',
  `wareName` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `warePrice` double DEFAULT NULL COMMENT '商品价格',
  `isDiscount` int(11) DEFAULT NULL COMMENT '是否特价',
  `stockNum` int(11) NOT NULL COMMENT '额定存货量',
  `stockNumnNow` int(11) DEFAULT NULL COMMENT '当前存货量',
  `stockNumnAdd` int(11) DEFAULT NULL COMMENT '新增存货量',
  `channelGroupId` int(11) DEFAULT NULL COMMENT '所属货道组id',
  `machineId` int(11) NOT NULL COMMENT '所属售货机id',
  `isHistory` int(1) NOT NULL COMMENT '是否为历史信息',
  `operateId` int(11) DEFAULT NULL COMMENT '操作者',
  `operateDate` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`channelId`),
  KEY `channelGroupId` (`channelGroupId`),
  KEY `machineId` (`machineId`),
  CONSTRAINT `t_channel_info_ibfk_1` FOREIGN KEY (`channelGroupId`) REFERENCES `channelgroup` (`channelGroupId`),
  CONSTRAINT `t_channel_info_ibfk_2` FOREIGN KEY (`machineId`) REFERENCES `machineinfo` (`machineId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `channelinfo` */

LOCK TABLES `channelinfo` WRITE;

UNLOCK TABLES;

/*Table structure for table `firminfo` */

DROP TABLE IF EXISTS `firminfo`;

CREATE TABLE `firminfo` (
  `firmId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公司主键',
  `firmNo` varchar(50) NOT NULL COMMENT '公司编号',
  `firmName` varchar(80) NOT NULL COMMENT '公司名称',
  `firmDesc` text COMMENT '公司描述',
  `firmType` int(1) NOT NULL COMMENT '公司类型，0：系统管理员，不属于任何公司；1:运营商；2：厂商',
  `firmStatus` int(1) NOT NULL COMMENT '公司状态，0：不可用；1：可用',
  `operateId` int(11) DEFAULT NULL COMMENT '操作人',
  `operateDate` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`firmId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `firminfo` */

LOCK TABLES `firminfo` WRITE;

insert  into `firminfo`(`firmId`,`firmNo`,`firmName`,`firmDesc`,`firmType`,`firmStatus`,`operateId`,`operateDate`) values (1,'000','system','system',0,1,1,'2017-02-27 12:13:38'),(2,'001','运营商1','运营商1的描述信息',1,1,1,'2017-02-27 13:02:06'),(3,'002','厂商','厂商1的描述信息',2,1,1,'2017-02-27 17:00:49');

UNLOCK TABLES;

/*Table structure for table `groupinfo` */

DROP TABLE IF EXISTS `groupinfo`;

CREATE TABLE `groupinfo` (
  `groupId` int(11) NOT NULL AUTO_INCREMENT COMMENT '分组信息ID',
  `groupName` varchar(50) NOT NULL COMMENT '组名（唯一）',
  `groupType` int(1) NOT NULL COMMENT '分组类型，0:系統管理員；1：用户组；2：售货机组',
  `groupDesc` text COMMENT '分组描述',
  `firmId` int(11) NOT NULL COMMENT '公司id（运营商）',
  `operateId` int(11) DEFAULT NULL COMMENT '操作者',
  `operateDate` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`groupId`),
  KEY `firmId` (`firmId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `groupinfo` */

LOCK TABLES `groupinfo` WRITE;

insert  into `groupinfo`(`groupId`,`groupName`,`groupType`,`groupDesc`,`firmId`,`operateId`,`operateDate`) values (1,'system',0,'system group',1,1,'2017-02-27 12:57:36'),(2,'售货机组1',2,'售货机组1测试',2,1,'2017-02-27 15:50:10');

UNLOCK TABLES;

/*Table structure for table `machineinfo` */

DROP TABLE IF EXISTS `machineinfo`;

CREATE TABLE `machineinfo` (
  `machineId` int(11) NOT NULL AUTO_INCREMENT COMMENT '售货机id',
  `machineName` varchar(100) NOT NULL COMMENT '售货机铭牌号',
  `machinePannel` varchar(50) NOT NULL COMMENT '售货机主板号',
  `manuFirmId` int(11) NOT NULL COMMENT '厂商ID',
  `machinePrice` double NOT NULL COMMENT '售货机价格',
  `tModelName` varchar(20) NOT NULL COMMENT '售货机类型/型号',
  `manuMachineStatus` int(11) NOT NULL DEFAULT '0' COMMENT '0:未售出，1：已售出，2：回收',
  `operFirmId` int(11) DEFAULT NULL COMMENT '卖给某运营商ID',
  `operateId` int(11) DEFAULT NULL COMMENT '操作者',
  `operateDate` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`machineId`),
  KEY `manuFirmId` (`manuFirmId`),
  KEY `operFirmId` (`operFirmId`),
  CONSTRAINT `t_machine_info_ibfk_1` FOREIGN KEY (`manuFirmId`) REFERENCES `firminfo` (`firmId`),
  CONSTRAINT `t_machine_info_ibfk_2` FOREIGN KEY (`operFirmId`) REFERENCES `firminfo` (`firmId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `machineinfo` */

LOCK TABLES `machineinfo` WRITE;

insert  into `machineinfo`(`machineId`,`machineName`,`machinePannel`,`manuFirmId`,`machinePrice`,`tModelName`,`manuMachineStatus`,`operFirmId`,`operateId`,`operateDate`) values (1,'售货机名牌1','售货机主板1',3,30,'类型1',1,2,3,'2017-02-27 17:09:27'),(2,'售货机名牌2','售货机主板2',3,30,'类型1',1,2,3,'2017-02-27 17:09:27'),(3,'售货机名牌3','售货机主板3',3,30,'类型1',1,2,3,'2017-02-27 17:09:27'),(4,'售货机名牌4','售货机主板4',3,30,'类型1',1,2,3,'2017-02-27 17:09:27');

UNLOCK TABLES;

/*Table structure for table `machineoperater` */

DROP TABLE IF EXISTS `machineoperater`;

CREATE TABLE `machineoperater` (
  `mOperaterId` int(11) NOT NULL AUTO_INCREMENT COMMENT '售货机信息id',
  `machineId` int(11) NOT NULL COMMENT '售货机id',
  `machineName` varchar(100) NOT NULL DEFAULT 'null' COMMENT '售货机铭牌号',
  `machinePannel` varchar(11) NOT NULL DEFAULT 'null' COMMENT '售货机主板号',
  `machineAssign` int(1) NOT NULL DEFAULT '0' COMMENT '是否分配给某员工',
  `tModelName` varchar(50) DEFAULT 'null' COMMENT '售货机类型',
  `userId` int(11) DEFAULT NULL COMMENT '分配给某员工',
  `machineAddress` varchar(150) DEFAULT NULL COMMENT '售货机地址',
  `machineStatus` int(1) NOT NULL DEFAULT '0' COMMENT '售货机是否可用',
  `groupId` int(11) DEFAULT NULL COMMENT '售货机组id',
  `operFirmId` int(11) NOT NULL COMMENT '运营商ID',
  `operateId` int(11) DEFAULT NULL COMMENT '操作者',
  `operateDate` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`mOperaterId`),
  KEY `machineId` (`machineId`),
  KEY `userId` (`userId`),
  KEY `groupId` (`groupId`),
  CONSTRAINT `machineoperater_ibfk_1` FOREIGN KEY (`machineId`) REFERENCES `machineinfo` (`machineId`),
  CONSTRAINT `MachineOperater_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `userinfo` (`userId`),
  CONSTRAINT `MachineOperater_ibfk_3` FOREIGN KEY (`groupId`) REFERENCES `groupinfo` (`groupId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `machineoperater` */

LOCK TABLES `machineoperater` WRITE;

insert  into `machineoperater`(`mOperaterId`,`machineId`,`machineName`,`machinePannel`,`machineAssign`,`tModelName`,`userId`,`machineAddress`,`machineStatus`,`groupId`,`operFirmId`,`operateId`,`operateDate`) values (1,1,'售货机名牌1','售货机主板1',0,'类型1',NULL,'普陀修改',1,2,2,2,'2017-03-08 21:23:06')