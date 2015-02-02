/*
 Navicat Premium Data Transfer

 Source Server         : recorddb
 Source Server Type    : SQLite
 Source Server Version : 3008004
 Source Database       : main

 Target Server Type    : SQLite
 Target Server Version : 3008004
 File Encoding         : utf-8

 Date: 01/31/2015 00:26:07 AM
*/

PRAGMA foreign_keys = false;

-- ----------------------------
--  Table structure for biaozhu
-- ----------------------------
DROP TABLE IF EXISTS 'biaozhu';
CREATE TABLE 'biaozhu' ('tid' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'tongfang' integer DEFAULT -1,'jiandang' integer DEFAULT -1,'jinzhouqi' integer DEFAULT -1,'jianceBchao' integer DEFAULT -1,'nanfangzhunbei' integer DEFAULT -1,'dayezhen' integer DEFAULT -1,'quruan' integer DEFAULT -1,'yizhi' integer DEFAULT -1,'dongpeixufei' integer DEFAULT -1,'xiaohuipeitai' integer DEFAULT -1,'bushufu' text);

-- ----------------------------
--  Table structure for dayima
-- ----------------------------
DROP TABLE IF EXISTS 'dayima';
CREATE TABLE 'dayima' ('tid' integer NOT NULL DEFAULT 1 PRIMARY KEY AUTOINCREMENT,'start' integer NOT NULL DEFAULT 0,'end' integer NOT NULL DEFAULT 0);
INSERT INTO 'main'.sqlite_sequence (name, seq) VALUES ('dayima', '0');

-- ----------------------------
--  Table structure for koufubiyuanyao
-- ----------------------------
DROP TABLE IF EXISTS 'koufubiyuanyao';
CREATE TABLE 'koufubiyuanyao' ('tid' integer NOT NULL PRIMARY KEY AUTOINCREMENT,'start' integer,'end' integer);
INSERT INTO 'main'.sqlite_sequence (name, seq) VALUES ('koufubiyuanyao', '0');

-- ----------------------------
--  Table structure for redianliliao
-- ----------------------------
DROP TABLE IF EXISTS 'redianliliao';
CREATE TABLE 'redianliliao' ('tid' integer NOT NULL PRIMARY KEY AUTOINCREMENT,'start' integer,'end' integer);
INSERT INTO 'main'.sqlite_sequence (name, seq) VALUES ('redianliliao', '0');

PRAGMA foreign_keys = true;
