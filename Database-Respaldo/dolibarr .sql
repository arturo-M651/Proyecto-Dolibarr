-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-01-2026 a las 02:54:17
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dolibarr`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_accounting_account`
--

CREATE TABLE `llx_accounting_account` (
  `rowid` bigint(20) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_pcg_version` varchar(32) NOT NULL,
  `pcg_type` varchar(60) NOT NULL,
  `account_number` varchar(32) NOT NULL,
  `account_parent` int(11) DEFAULT 0,
  `label` varchar(255) NOT NULL,
  `labelshort` varchar(255) DEFAULT NULL,
  `fk_accounting_category` int(11) DEFAULT 0,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `reconcilable` tinyint(4) NOT NULL DEFAULT 0,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_accounting_bookkeeping`
--

CREATE TABLE `llx_accounting_bookkeeping` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `piece_num` int(11) NOT NULL,
  `doc_date` date NOT NULL,
  `doc_type` varchar(30) NOT NULL,
  `doc_ref` varchar(300) NOT NULL,
  `fk_doc` int(11) NOT NULL,
  `fk_docdet` int(11) NOT NULL,
  `thirdparty_code` varchar(32) DEFAULT NULL,
  `subledger_account` varchar(32) DEFAULT NULL,
  `subledger_label` varchar(255) DEFAULT NULL,
  `numero_compte` varchar(32) NOT NULL,
  `label_compte` varchar(255) NOT NULL,
  `label_operation` varchar(255) DEFAULT NULL,
  `debit` double(24,8) NOT NULL,
  `credit` double(24,8) NOT NULL,
  `montant` double(24,8) DEFAULT NULL,
  `sens` varchar(1) DEFAULT NULL,
  `multicurrency_amount` double(24,8) DEFAULT NULL,
  `multicurrency_code` varchar(255) DEFAULT NULL,
  `lettering_code` varchar(255) DEFAULT NULL,
  `date_lettering` datetime DEFAULT NULL,
  `date_lim_reglement` datetime DEFAULT NULL,
  `fk_user_author` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user` int(11) DEFAULT NULL,
  `code_journal` varchar(32) NOT NULL,
  `journal_label` varchar(255) DEFAULT NULL,
  `date_validated` datetime DEFAULT NULL,
  `date_export` datetime DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_accounting_bookkeeping_tmp`
--

CREATE TABLE `llx_accounting_bookkeeping_tmp` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `doc_date` date NOT NULL,
  `doc_type` varchar(30) NOT NULL,
  `doc_ref` varchar(300) NOT NULL,
  `fk_doc` int(11) NOT NULL,
  `fk_docdet` int(11) NOT NULL,
  `thirdparty_code` varchar(32) DEFAULT NULL,
  `subledger_account` varchar(32) DEFAULT NULL,
  `subledger_label` varchar(255) DEFAULT NULL,
  `numero_compte` varchar(32) DEFAULT NULL,
  `label_compte` varchar(255) NOT NULL,
  `label_operation` varchar(255) DEFAULT NULL,
  `debit` double(24,8) NOT NULL,
  `credit` double(24,8) NOT NULL,
  `montant` double(24,8) NOT NULL,
  `sens` varchar(1) DEFAULT NULL,
  `multicurrency_amount` double(24,8) DEFAULT NULL,
  `multicurrency_code` varchar(255) DEFAULT NULL,
  `lettering_code` varchar(255) DEFAULT NULL,
  `date_lettering` datetime DEFAULT NULL,
  `date_lim_reglement` datetime DEFAULT NULL,
  `fk_user_author` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user` int(11) DEFAULT NULL,
  `code_journal` varchar(32) NOT NULL,
  `journal_label` varchar(255) DEFAULT NULL,
  `piece_num` int(11) NOT NULL,
  `date_validated` datetime DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_accounting_fiscalyear`
--

CREATE TABLE `llx_accounting_fiscalyear` (
  `rowid` int(11) NOT NULL,
  `label` varchar(128) NOT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `statut` tinyint(4) NOT NULL DEFAULT 0,
  `entity` int(11) NOT NULL DEFAULT 1,
  `datec` datetime NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_accounting_groups_account`
--

CREATE TABLE `llx_accounting_groups_account` (
  `rowid` int(11) NOT NULL,
  `fk_accounting_account` int(11) NOT NULL,
  `fk_c_accounting_category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_accounting_journal`
--

CREATE TABLE `llx_accounting_journal` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `code` varchar(32) NOT NULL,
  `label` varchar(128) NOT NULL,
  `nature` smallint(6) NOT NULL DEFAULT 1,
  `active` smallint(6) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_accounting_journal`
--

INSERT INTO `llx_accounting_journal` (`rowid`, `entity`, `code`, `label`, `nature`, `active`) VALUES
(1, 1, 'VT', 'ACCOUNTING_SELL_JOURNAL', 2, 1),
(2, 1, 'AC', 'ACCOUNTING_PURCHASE_JOURNAL', 3, 1),
(3, 1, 'BQ', 'FinanceJournal', 4, 1),
(4, 1, 'OD', 'ACCOUNTING_MISCELLANEOUS_JOURNAL', 1, 1),
(5, 1, 'AN', 'ACCOUNTING_HAS_NEW_JOURNAL', 9, 1),
(6, 1, 'ER', 'ExpenseReportsJournal', 5, 1),
(7, 1, 'INV', 'InventoryJournal', 8, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_accounting_system`
--

CREATE TABLE `llx_accounting_system` (
  `rowid` int(11) NOT NULL,
  `fk_country` int(11) DEFAULT NULL,
  `pcg_version` varchar(32) NOT NULL,
  `label` varchar(128) NOT NULL,
  `active` smallint(6) DEFAULT 0,
  `date_creation` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_accounting_system`
--

INSERT INTO `llx_accounting_system` (`rowid`, `fk_country`, `pcg_version`, `label`, `active`, `date_creation`, `fk_user_author`) VALUES
(1, 1, 'PCG25-DEV', 'The developed accountancy french plan 2025', 1, NULL, NULL),
(2, 1, 'PCG18-ASSOC', 'French foundation chart of accounts 2018', 1, NULL, NULL),
(3, 1, 'PCGAFR14-DEV', 'The developed farm accountancy french plan 2014', 1, NULL, NULL),
(4, 2, 'PCMN-BASE', 'The base accountancy belgium plan', 1, NULL, NULL),
(5, 2, 'MAR-VERKORT', 'The base accountancy belgium plan Dutch', 1, NULL, NULL),
(6, 4, 'PCG08-PYME', 'The PYME accountancy spanish plan', 1, NULL, NULL),
(7, 4, 'PCG08-PYME-CAT', 'The PYME accountancy spanish plan in catalan language', 1, NULL, NULL),
(8, 5, 'SKR03', 'Standardkontenrahmen SKR 03', 1, NULL, NULL),
(9, 5, 'SKR04', 'Standardkontenrahmen SKR 04', 1, NULL, NULL),
(10, 6, 'PCG_SUISSE', 'Switzerland plan', 1, NULL, NULL),
(11, 7, 'ENG-BASE', 'England plan', 1, NULL, NULL),
(12, 10, 'PCT', 'The Tunisia plan', 1, NULL, NULL),
(13, 12, 'PCG', 'The Moroccan chart of accounts', 1, NULL, NULL),
(14, 13, 'NSCF', 'Nouveau système comptable financier', 1, NULL, NULL),
(15, 17, 'NL-VERKORT', 'Verkort rekeningschema', 1, NULL, NULL),
(16, 20, 'BAS-K1-MINI', 'The Swedish mini chart of accounts', 1, NULL, NULL),
(17, 41, 'AT-BASE', 'Plan Austria', 1, NULL, NULL),
(18, 67, 'PC-MIPYME', 'The PYME accountancy Chile plan', 1, NULL, NULL),
(19, 80, 'DK-STD', 'Standardkontoplan fra SKAT', 1, NULL, NULL),
(20, 84, 'EC-SUPERCIAS', 'Plan de cuentas Ecuador', 1, NULL, NULL),
(21, 70, 'CO-PUC', 'Plan único de cuentas Colombia', 1, NULL, NULL),
(22, 140, 'PCN2020-LUXEMBURG', 'Plan comptable normalisé 2020 Luxembourgeois', 1, NULL, NULL),
(23, 188, 'RO-BASE', 'Plan de conturi romanesc', 1, NULL, NULL),
(24, 102, 'Ε.Λ.Π.', 'Ελληνικά Λογιστικά Πρότυπα', 1, NULL, NULL),
(25, 49, 'SYSCOHADA-BJ', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(26, 60, 'SYSCOHADA-BF', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(27, 73, 'SYSCOHADA-CD', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(28, 65, 'SYSCOHADA-CF', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(29, 72, 'SYSCOHADA-CG', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(30, 21, 'SYSCOHADA-CI', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(31, 24, 'SYSCOHADA-CM', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(32, 16, 'SYSCOHADA-GA', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(33, 87, 'SYSCOHADA-GQ', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(34, 71, 'SYSCOHADA-KM', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(35, 147, 'SYSCOHADA-ML', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(36, 168, 'SYSCOHADA-NE', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(37, 22, 'SYSCOHADA-SN', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(38, 66, 'SYSCOHADA-TD', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(39, 15, 'SYSCOHADA-TG', 'Plan comptable Ouest-Africain', 1, NULL, NULL),
(40, 11, 'US-BASE', 'USA basic chart of accounts', 1, NULL, NULL),
(41, 11, 'US-GAAP-BASIC', 'USA GAAP basic chart of accounts', 1, NULL, NULL),
(42, 14, 'CA-ENG-BASE', 'Canadian basic chart of accounts - English', 1, NULL, NULL),
(43, 154, 'SAT/24-2019', 'Catalogo y codigo agrupador fiscal del 2019', 1, NULL, NULL),
(44, 123, 'JPN-BASE', '日本 勘定科目表 基本版', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_actioncomm`
--

CREATE TABLE `llx_actioncomm` (
  `id` int(11) NOT NULL,
  `ref` varchar(30) NOT NULL,
  `ref_ext` varchar(255) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `datep` datetime DEFAULT NULL,
  `datep2` datetime DEFAULT NULL,
  `fk_action` int(11) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_mod` int(11) DEFAULT NULL,
  `fk_project` int(11) DEFAULT NULL,
  `fk_task` int(11) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_contact` int(11) DEFAULT NULL,
  `fk_parent` int(11) NOT NULL DEFAULT 0,
  `fk_user_action` int(11) DEFAULT NULL,
  `transparency` int(11) DEFAULT NULL,
  `priority` smallint(6) DEFAULT NULL,
  `visibility` varchar(12) DEFAULT 'default',
  `fulldayevent` smallint(6) NOT NULL DEFAULT 0,
  `percent` smallint(6) NOT NULL DEFAULT 0,
  `location` varchar(128) DEFAULT NULL,
  `durationp` double DEFAULT NULL,
  `label` varchar(255) NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `calling_duration` int(11) DEFAULT NULL,
  `email_subject` varchar(255) DEFAULT NULL,
  `email_msgid` varchar(255) DEFAULT NULL,
  `email_from` varchar(255) DEFAULT NULL,
  `email_sender` varchar(255) DEFAULT NULL,
  `email_to` varchar(255) DEFAULT NULL,
  `email_tocc` varchar(255) DEFAULT NULL,
  `email_tobcc` varchar(255) DEFAULT NULL,
  `errors_to` varchar(255) DEFAULT NULL,
  `reply_to` varchar(255) DEFAULT NULL,
  `recurid` varchar(128) DEFAULT NULL,
  `recurrule` varchar(128) DEFAULT NULL,
  `recurdateend` datetime DEFAULT NULL,
  `num_vote` int(11) DEFAULT NULL,
  `event_paid` smallint(6) NOT NULL DEFAULT 0,
  `status` smallint(6) NOT NULL DEFAULT 0,
  `fk_element` int(11) DEFAULT NULL,
  `elementtype` varchar(255) DEFAULT NULL,
  `ip` varchar(250) DEFAULT NULL,
  `fk_bookcal_calendar` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_actioncomm`
--

INSERT INTO `llx_actioncomm` (`id`, `ref`, `ref_ext`, `entity`, `datep`, `datep2`, `fk_action`, `code`, `datec`, `tms`, `fk_user_author`, `fk_user_mod`, `fk_project`, `fk_task`, `fk_soc`, `fk_contact`, `fk_parent`, `fk_user_action`, `transparency`, `priority`, `visibility`, `fulldayevent`, `percent`, `location`, `durationp`, `label`, `note`, `calling_duration`, `email_subject`, `email_msgid`, `email_from`, `email_sender`, `email_to`, `email_tocc`, `email_tobcc`, `errors_to`, `reply_to`, `recurid`, `recurrule`, `recurdateend`, `num_vote`, `event_paid`, `status`, `fk_element`, `elementtype`, `ip`, `fk_bookcal_calendar`, `import_key`, `extraparams`) VALUES
(2, '2', NULL, 1, '2025-08-08 03:52:05', '2025-08-08 03:52:05', 40, 'AC_USER_CREATE', '2025-08-08 03:52:05', '2025-08-08 01:52:05', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Registro  creado', 'Registro  creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 3, 'user', NULL, NULL, NULL, NULL),
(3, '3', NULL, 1, '2025-08-08 03:52:05', '2025-08-08 03:52:05', 40, 'AC_USER_NEW_PASSWORD', '2025-08-08 03:52:05', '2025-08-08 01:52:05', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Contraseña modificada en Dolibarr', 'Contraseña modificada en Dolibarr', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 3, 'user', NULL, NULL, NULL, NULL),
(4, '4', NULL, 1, '2025-08-08 03:52:29', '2025-08-08 03:52:29', 40, 'AC_USER_MODIFY', '2025-08-08 03:52:29', '2025-08-08 01:52:29', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Registro 3 modificado', 'Registro 3 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 3, 'user', NULL, NULL, NULL, NULL),
(5, '5', NULL, 1, '2025-08-08 03:53:59', '2025-08-08 03:53:59', 40, 'AC_USER_MODIFY', '2025-08-08 03:53:59', '2025-08-08 01:53:59', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Registro 3 modificado', 'Registro 3 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 3, 'user', NULL, NULL, NULL, NULL),
(6, '6', NULL, 1, '2025-08-08 04:07:48', '2025-08-08 04:07:48', 40, 'AC_PRODUCT_CREATE', '2025-08-08 04:07:48', '2025-08-08 02:07:48', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEMCA25 creado', 'Producto CEMCA25 creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 'product', NULL, NULL, NULL, NULL),
(7, '7', NULL, 1, '2025-08-08 04:08:35', '2025-08-08 04:08:35', 40, 'AC_PRODUCT_MODIFY', '2025-08-08 04:08:35', '2025-08-08 02:08:35', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto Cemento_Cruz_Azul_25_Kg modificado', 'Producto Cemento_Cruz_Azul_25_Kg modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 'product', NULL, NULL, NULL, NULL),
(8, '8', NULL, 1, '2025-08-08 04:09:00', '2025-08-08 04:09:00', 40, 'AC_PRODUCT_MODIFY', '2025-08-08 04:09:00', '2025-08-08 02:09:00', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEMCA25 modificado', 'Producto CEMCA25 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 'product', NULL, NULL, NULL, NULL),
(9, '9', NULL, 1, '2025-08-08 04:11:50', '2025-08-08 04:11:50', 40, 'AC_PRODUCT_MODIFY', '2025-08-08 04:11:50', '2025-08-08 02:11:50', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEMCA25 modificado', 'Producto CEMCA25 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 'product', NULL, NULL, NULL, NULL),
(10, '10', NULL, 1, '2025-08-08 04:16:08', '2025-08-08 04:16:08', 40, 'AC_PRODUCT_MODIFY', '2025-08-08 04:16:08', '2025-08-08 02:16:08', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEMCA25 modificado', 'Producto CEMCA25 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 'product', NULL, NULL, NULL, NULL),
(11, '11', NULL, 1, '2025-08-08 04:44:22', '2025-08-08 04:44:22', 40, 'AC_PRODUCT_MODIFY', '2025-08-08 04:44:22', '2025-08-08 02:44:22', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEMCA50 modificado', 'Producto CEMCA50 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 'product', NULL, NULL, NULL, NULL),
(12, '12', NULL, 1, '2025-08-08 04:50:30', '2025-08-08 04:50:30', 40, 'AC_PRODUCT_MODIFY', '2025-08-08 04:50:30', '2025-08-08 02:50:30', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEMCA50 modificado', 'Producto CEMCA50 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 'product', NULL, NULL, NULL, NULL),
(13, '13', NULL, 1, '2025-08-08 04:53:56', '2025-08-08 04:53:56', 40, 'AC_PRODUCT_MODIFY', '2025-08-08 04:53:56', '2025-08-08 02:53:56', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEMCA50 modificado', 'Producto CEMCA50 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 'product', NULL, NULL, NULL, NULL),
(14, '14', NULL, 1, '2025-08-08 04:54:07', '2025-08-08 04:54:07', 40, 'AC_PRODUCT_MODIFY', '2025-08-08 04:54:07', '2025-08-08 02:54:07', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEMCA50 modificado', 'Producto CEMCA50 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 'product', NULL, NULL, NULL, NULL),
(15, '15', NULL, 1, '2025-08-08 04:57:40', '2025-08-08 04:57:40', 40, 'AC_PRODUCT_CREATE', '2025-08-08 04:57:40', '2025-08-08 02:57:40', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CET25 creado', 'Producto CET25 creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 2, 'product', NULL, NULL, NULL, NULL),
(16, '16', NULL, 1, '2025-08-08 05:02:03', '2025-08-08 05:02:03', 40, 'AC_PRODUCT_MODIFY', '2025-08-08 05:02:03', '2025-08-08 03:02:03', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CET25 modificado', 'Producto CET25 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 2, 'product', NULL, NULL, NULL, NULL),
(17, '17', NULL, 1, '2025-08-08 05:03:37', '2025-08-08 05:03:37', 40, 'AC_PRODUCT_CREATE', '2025-08-08 05:03:37', '2025-08-08 03:03:37', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CET50 creado', 'Producto CET50 creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 3, 'product', NULL, NULL, NULL, NULL),
(18, '18', NULL, 1, '2025-08-08 05:05:43', '2025-08-08 05:05:43', 40, 'AC_PRODUCT_CREATE', '2025-08-08 05:05:43', '2025-08-08 03:05:43', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEMDC50 creado', 'Producto CEMDC50 creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 4, 'product', NULL, NULL, NULL, NULL),
(19, '19', NULL, 1, '2025-08-08 05:09:24', '2025-08-08 05:09:24', 40, 'AC_PRODUCT_MODIFY', '2025-08-08 05:09:24', '2025-08-08 03:09:24', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEM25 modificado', 'Producto CEM25 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 2, 'product', NULL, NULL, NULL, NULL),
(20, '20', NULL, 1, '2025-08-08 05:12:22', '2025-08-08 05:12:22', 40, 'AC_PRODUCT_MODIFY', '2025-08-08 05:12:22', '2025-08-08 03:12:22', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEM25 modificado', 'Producto CEM25 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 2, 'product', NULL, NULL, NULL, NULL),
(33, '33', NULL, 1, '2025-12-28 17:44:12', '2025-12-28 17:44:12', 40, 'AC_USER_DELETE', '2025-12-28 17:44:12', '2025-12-28 16:44:12', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Registro 3 eliminado', 'Registro 3 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 3, 'user', NULL, NULL, NULL, NULL),
(34, '34', NULL, 1, '2025-12-28 17:50:08', '2025-12-28 17:50:08', 40, 'AC_USER_MODIFY', '2025-12-28 17:50:08', '2025-12-28 16:50:08', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Registro 1 modificado', 'Registro 1 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 'user', NULL, NULL, NULL, NULL),
(35, '35', NULL, 1, '2025-12-28 18:03:45', '2025-12-28 18:03:45', 40, 'AC_PRODUCT_CREATE', '2025-12-28 18:03:45', '2025-12-28 17:03:45', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CM5X5A3 creado', 'Producto CM5X5A3 creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 5, 'product', NULL, NULL, NULL, NULL),
(36, '36', NULL, 1, '2025-12-28 18:05:09', '2025-12-28 18:05:09', 40, 'AC_PRODUCT_DELETE', '2025-12-28 18:05:09', '2025-12-28 17:05:09', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEM25 eliminado', 'Producto CEM25 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 2, 'product', NULL, NULL, NULL, NULL),
(37, '37', NULL, 1, '2025-12-28 18:06:18', '2025-12-28 18:06:18', 40, 'AC_PRODUCT_DELETE', '2025-12-28 18:06:18', '2025-12-28 17:06:18', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEMDC50 eliminado', 'Producto CEMDC50 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 4, 'product', NULL, NULL, NULL, NULL),
(38, '38', NULL, 1, '2025-12-28 18:06:22', '2025-12-28 18:06:22', 40, 'AC_PRODUCT_DELETE', '2025-12-28 18:06:22', '2025-12-28 17:06:22', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CET50 eliminado', 'Producto CET50 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 3, 'product', NULL, NULL, NULL, NULL),
(39, '39', NULL, 1, '2025-12-28 18:07:10', '2025-12-28 18:07:10', 40, 'AC_USER_MODIFY', '2025-12-28 18:07:10', '2025-12-28 17:07:10', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Registro 1 modificado', 'Registro 1 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 'user', NULL, NULL, NULL, NULL),
(42, '42', NULL, 1, '2025-12-28 18:20:46', '2025-12-28 18:20:46', 40, 'AC_PRODUCT_CREATE', '2025-12-28 18:20:46', '2025-12-28 17:20:46', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto SILLA-TIFF creado', 'Producto SILLA-TIFF creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 6, 'product', NULL, NULL, NULL, NULL),
(43, '43', NULL, 1, '2025-12-28 18:22:22', '2025-12-28 18:22:22', 40, 'AC_PRODUCT_CREATE', '2025-12-28 18:22:22', '2025-12-28 17:22:22', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto SILLA-C-P creado', 'Producto SILLA-C-P creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 7, 'product', NULL, NULL, NULL, NULL),
(44, '44', NULL, 1, '2025-12-28 18:22:36', '2025-12-28 18:22:36', 40, 'AC_PRODUCT_MODIFY', '2025-12-28 18:22:36', '2025-12-28 17:22:36', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto SILLA-TIFF modificado', 'Producto SILLA-TIFF modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 6, 'product', NULL, NULL, NULL, NULL),
(45, '45', NULL, 1, '2025-12-28 18:22:46', '2025-12-28 18:22:46', 40, 'AC_PRODUCT_MODIFY', '2025-12-28 18:22:46', '2025-12-28 17:22:46', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CM5X5A3 modificado', 'Producto CM5X5A3 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 5, 'product', NULL, NULL, NULL, NULL),
(46, '46', NULL, 1, '2025-12-28 18:22:57', '2025-12-28 18:22:57', 40, 'AC_PRODUCT_MODIFY', '2025-12-28 18:22:57', '2025-12-28 17:22:57', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CM5X5A3 modificado', 'Producto CM5X5A3 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 5, 'product', NULL, NULL, NULL, NULL),
(47, '47', NULL, 1, '2025-12-28 18:24:15', '2025-12-28 18:24:15', 40, 'AC_PRODUCT_CREATE', '2025-12-28 18:24:15', '2025-12-28 17:24:15', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto MESA-R creado', 'Producto MESA-R creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 8, 'product', NULL, NULL, NULL, NULL),
(48, '48', NULL, 1, '2025-12-28 18:26:14', '2025-12-28 18:26:14', 40, 'AC_PRODUCT_CREATE', '2025-12-28 18:26:14', '2025-12-28 17:26:14', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto PISTA-P creado', 'Producto PISTA-P creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 9, 'product', NULL, NULL, NULL, NULL),
(49, '49', NULL, 1, '2025-12-28 18:26:33', '2025-12-28 18:26:33', 40, 'AC_PRODUCT_MODIFY', '2025-12-28 18:26:33', '2025-12-28 17:26:33', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto PISTA-P modificado', 'Producto PISTA-P modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 9, 'product', NULL, NULL, NULL, NULL),
(50, '50', NULL, 1, '2025-12-28 18:26:46', '2025-12-28 18:26:46', 40, 'AC_PRODUCT_MODIFY', '2025-12-28 18:26:46', '2025-12-28 17:26:46', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto PISTA-P modificado', 'Producto PISTA-P modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 9, 'product', NULL, NULL, NULL, NULL),
(51, '51', NULL, 1, '2025-12-28 18:27:13', '2025-12-28 18:27:13', 40, 'AC_PRODUCT_MODIFY', '2025-12-28 18:27:13', '2025-12-28 17:27:13', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto PISTA-P modificado', 'Producto PISTA-P modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 9, 'product', NULL, NULL, NULL, NULL),
(52, '52', NULL, 1, '2025-12-28 18:28:55', '2025-12-28 18:28:55', 40, 'AC_PRODUCT_MODIFY', '2025-12-28 18:28:55', '2025-12-28 17:28:55', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto SILLA-C-P modificado', 'Producto SILLA-C-P modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 7, 'product', NULL, NULL, NULL, NULL),
(53, '53', NULL, 1, '2025-12-28 18:33:22', '2025-12-28 18:33:22', 40, 'AC_PRODUCT_MODIFY', '2025-12-28 18:33:22', '2025-12-28 17:33:22', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto PISTA-P modificado', 'Producto PISTA-P modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 9, 'product', NULL, NULL, NULL, NULL),
(54, '54', NULL, 1, '2025-12-28 18:47:51', '2025-12-28 18:47:51', 40, 'AC_PRODUCT_MODIFY', '2025-12-28 18:47:51', '2025-12-28 17:47:51', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEMCA50 modificado', 'Producto CEMCA50 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 'product', NULL, NULL, NULL, NULL),
(176, '176', NULL, 1, '2026-01-08 04:47:28', '2026-01-08 04:47:28', 40, 'AC_PRODUCT_MODIFY', '2026-01-08 04:47:28', '2026-01-08 03:47:28', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CM5X5A3 modificado', 'Producto CM5X5A3 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 5, 'product', NULL, NULL, NULL, NULL),
(177, '177', NULL, 1, '2026-01-08 05:06:01', '2026-01-08 05:06:01', 40, 'AC_PRODUCT_CREATE', '2026-01-08 05:06:01', '2026-01-08 04:06:01', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CM15X15A4 creado', 'Producto CM15X15A4 creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 10, 'product', NULL, NULL, NULL, NULL),
(178, '178', NULL, 1, '2026-01-08 05:06:46', '2026-01-08 05:06:46', 40, 'AC_PRODUCT_MODIFY', '2026-01-08 05:06:46', '2026-01-08 04:06:46', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CM15X15A4 modificado', 'Producto CM15X15A4 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 10, 'product', NULL, NULL, NULL, NULL),
(191, '191', NULL, 1, '2026-01-18 19:50:19', '2026-01-18 19:50:19', 40, 'AC_PRODUCT_MODIFY', '2026-01-18 19:50:19', '2026-01-18 18:50:19', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CM15X15A4 modificado', 'Producto CM15X15A4 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 10, 'product', NULL, NULL, NULL, NULL),
(192, '192', NULL, 1, '2026-01-18 19:50:38', '2026-01-18 19:50:38', 40, 'AC_PRODUCT_MODIFY', '2026-01-18 19:50:38', '2026-01-18 18:50:38', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CM15X15A4 modificado', 'Producto CM15X15A4 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 10, 'product', NULL, NULL, NULL, NULL),
(193, '193', NULL, 1, '2026-01-18 19:54:52', '2026-01-18 19:54:52', 40, 'AC_PRODUCT_MODIFY', '2026-01-18 19:54:52', '2026-01-18 18:54:52', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto C15X15A4 modificado', 'Producto C15X15A4 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 10, 'product', NULL, NULL, NULL, NULL),
(194, '194', NULL, 1, '2026-01-18 19:56:28', '2026-01-18 19:56:28', 40, 'AC_PRODUCT_MODIFY', '2026-01-18 19:56:28', '2026-01-18 18:56:28', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto C15X15-A4 modificado', 'Producto C15X15-A4 modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 10, 'product', NULL, NULL, NULL, NULL),
(195, '195', NULL, 1, '2026-01-18 19:57:23', '2026-01-18 19:57:23', 40, 'AC_PRODUCT_MODIFY', '2026-01-18 19:57:23', '2026-01-18 18:57:23', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto C15X15-4A modificado', 'Producto C15X15-4A modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 10, 'product', NULL, NULL, NULL, NULL),
(202, '202', NULL, 1, '2026-01-18 20:17:55', '2026-01-18 20:17:55', 40, 'AC_PRODUCT_CREATE', '2026-01-18 20:17:55', '2026-01-18 19:17:55', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto P-BA creado', 'Producto P-BA creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 11, 'product', NULL, NULL, NULL, NULL),
(203, '203', NULL, 1, '2026-01-20 02:28:11', '2026-01-20 02:28:11', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:28:11', '2026-01-20 01:28:11', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo Celular eliminado', 'Tercero Arturo Celular eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(204, '204', NULL, 1, '2026-01-20 02:28:11', '2026-01-20 02:28:11', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:28:11', '2026-01-20 01:28:11', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo Celular V2 eliminado', 'Tercero Arturo Celular V2 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(205, '205', NULL, 1, '2026-01-20 02:28:11', '2026-01-20 02:28:11', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:28:11', '2026-01-20 01:28:11', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V1 eliminado', 'Tercero Arturo PC V1 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(206, '206', NULL, 1, '2026-01-20 02:28:11', '2026-01-20 02:28:11', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:28:11', '2026-01-20 01:28:11', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V1 eliminado', 'Tercero Arturo PC V1 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(207, '207', NULL, 1, '2026-01-20 02:28:11', '2026-01-20 02:28:11', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:28:11', '2026-01-20 01:28:11', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V10 eliminado', 'Tercero Arturo PC V10 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(208, '208', NULL, 1, '2026-01-20 02:28:11', '2026-01-20 02:28:11', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:28:11', '2026-01-20 01:28:11', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V11 eliminado', 'Tercero Arturo PC V11 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(209, '209', NULL, 1, '2026-01-20 02:28:11', '2026-01-20 02:28:11', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:28:11', '2026-01-20 01:28:11', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V12 eliminado', 'Tercero Arturo PC V12 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(210, '210', NULL, 1, '2026-01-20 02:28:11', '2026-01-20 02:28:11', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:28:11', '2026-01-20 01:28:11', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V12 eliminado', 'Tercero Arturo PC V12 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(211, '211', NULL, 1, '2026-01-20 02:28:11', '2026-01-20 02:28:11', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:28:11', '2026-01-20 01:28:11', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V12 eliminado', 'Tercero Arturo PC V12 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(212, '212', NULL, 1, '2026-01-20 02:28:11', '2026-01-20 02:28:11', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:28:11', '2026-01-20 01:28:11', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V13 eliminado', 'Tercero Arturo PC V13 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(231, '231', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Ana eliminado', 'Tercero Ana eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(232, '232', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo eliminado', 'Tercero Arturo eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(233, '233', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo eliminado', 'Tercero Arturo eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(234, '234', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo eliminado', 'Tercero Arturo eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(235, '235', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo eliminado', 'Tercero Arturo eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(236, '236', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo eliminado', 'Tercero Arturo eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(237, '237', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo eliminado', 'Tercero Arturo eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(238, '238', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo eliminado', 'Tercero Arturo eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(239, '239', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo eliminado', 'Tercero Arturo eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(240, '240', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo Celular eliminado', 'Tercero Arturo Celular eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(241, '241', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V14 eliminado', 'Tercero Arturo PC V14 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(242, '242', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V15 eliminado', 'Tercero Arturo PC V15 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(243, '243', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V16 eliminado', 'Tercero Arturo PC V16 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(244, '244', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V17 eliminado', 'Tercero Arturo PC V17 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(245, '245', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V18 eliminado', 'Tercero Arturo PC V18 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(246, '246', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V18 eliminado', 'Tercero Arturo PC V18 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(247, '247', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V2 eliminado', 'Tercero Arturo PC V2 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(248, '248', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V3 eliminado', 'Tercero Arturo PC V3 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(249, '249', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V4 eliminado', 'Tercero Arturo PC V4 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(250, '250', NULL, 1, '2026-01-20 02:29:49', '2026-01-20 02:29:49', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:29:49', '2026-01-20 01:29:49', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V5 eliminado', 'Tercero Arturo PC V5 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(251, '251', NULL, 1, '2026-01-20 02:30:01', '2026-01-20 02:30:01', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:01', '2026-01-20 01:30:01', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V6 eliminado', 'Tercero Arturo PC V6 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(252, '252', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V7 eliminado', 'Tercero Arturo PC V7 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(253, '253', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V7 eliminado', 'Tercero Arturo PC V7 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(254, '254', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V8 eliminado', 'Tercero Arturo PC V8 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(255, '255', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V8 eliminado', 'Tercero Arturo PC V8 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(256, '256', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V9 eliminado', 'Tercero Arturo PC V9 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(257, '257', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo PC V9 eliminado', 'Tercero Arturo PC V9 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(258, '258', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Arturo Teléfono V2 eliminado', 'Tercero Arturo Teléfono V2 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(259, '259', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero ING PRUEBA V1 eliminado', 'Tercero ING PRUEBA V1 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(260, '260', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Ing Prueba V2 eliminado', 'Tercero Ing Prueba V2 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(261, '261', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero ING prueba V3 eliminado', 'Tercero ING prueba V3 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(262, '262', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero ING prueba V4 eliminado', 'Tercero ING prueba V4 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(263, '263', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero ING prueba V5 eliminado', 'Tercero ING prueba V5 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(264, '264', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero ING prueba V6 eliminado', 'Tercero ING prueba V6 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(265, '265', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero ING V10 eliminado', 'Tercero ING V10 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(266, '266', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero ING V11 eliminado', 'Tercero ING V11 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(267, '267', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero ING V12 eliminado', 'Tercero ING V12 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(268, '268', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Ingeniero Arturo eliminado', 'Tercero Ingeniero Arturo eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(269, '269', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Jazmin eliminado', 'Tercero Jazmin eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(270, '270', NULL, 1, '2026-01-20 02:30:02', '2026-01-20 02:30:02', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:02', '2026-01-20 01:30:02', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Jazmin eliminado', 'Tercero Jazmin eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(271, '271', NULL, 1, '2026-01-20 02:30:10', '2026-01-20 02:30:10', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:10', '2026-01-20 01:30:10', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero Jazz eliminado', 'Tercero Jazz eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(272, '272', NULL, 1, '2026-01-20 02:30:10', '2026-01-20 02:30:10', 40, 'AC_COMPANY_DELETE', '2026-01-20 02:30:10', '2026-01-20 01:30:10', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Tercero PRUEBA DEBUGG V1 eliminado', 'Tercero PRUEBA DEBUGG V1 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(273, '273', NULL, 1, '2026-01-20 02:30:28', '2026-01-20 02:30:28', 40, 'AC_PRODUCT_DELETE', '2026-01-20 02:30:28', '2026-01-20 01:30:28', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CEMCA50 eliminado', 'Producto CEMCA50 eliminado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 'product', NULL, NULL, NULL, NULL),
(274, '274', NULL, 1, '2026-01-20 02:30:54', '2026-01-20 02:30:54', 40, 'AC_PRODUCT_MODIFY', '2026-01-20 02:30:54', '2026-01-20 01:30:54', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto P-BA modificado', 'Producto P-BA modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 11, 'product', NULL, NULL, NULL, NULL),
(275, '275', NULL, 1, '2026-01-20 02:31:40', '2026-01-20 02:31:40', 40, 'AC_PRODUCT_CREATE', '2026-01-20 02:31:40', '2026-01-20 01:31:40', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto SL-B creado', 'Producto SL-B creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 12, 'product', NULL, NULL, NULL, NULL),
(276, '276', NULL, 1, '2026-01-20 02:32:10', '2026-01-20 02:32:10', 40, 'AC_PRODUCT_CREATE', '2026-01-20 02:32:10', '2026-01-20 01:32:10', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto MR-V creado', 'Producto MR-V creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 13, 'product', NULL, NULL, NULL, NULL),
(277, '277', NULL, 1, '2026-01-20 02:33:04', '2026-01-20 02:33:04', 40, 'AC_PRODUCT_CREATE', '2026-01-20 02:33:04', '2026-01-20 01:33:04', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CM8A3H creado', 'Producto CM8A3H creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 14, 'product', NULL, NULL, NULL, NULL),
(278, '278', NULL, 1, '2026-01-20 02:33:51', '2026-01-20 02:33:51', 40, 'AC_PRODUCT_CREATE', '2026-01-20 02:33:51', '2026-01-20 01:33:51', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto C12A-3H creado', 'Producto C12A-3H creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 15, 'product', NULL, NULL, NULL, NULL),
(279, '279', NULL, 1, '2026-01-20 02:34:45', '2026-01-20 02:34:45', 40, 'AC_PRODUCT_CREATE', '2026-01-20 02:34:45', '2026-01-20 01:34:45', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CM10A-3H creado', 'Producto CM10A-3H creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 16, 'product', NULL, NULL, NULL, NULL),
(280, '280', NULL, 1, '2026-01-20 02:35:05', '2026-01-20 02:35:05', 40, 'AC_PRODUCT_MODIFY', '2026-01-20 02:35:05', '2026-01-20 01:35:05', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto CM8A3H-A modificado', 'Producto CM8A3H-A modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 14, 'product', NULL, NULL, NULL, NULL),
(281, '281', NULL, 1, '2026-01-20 02:36:47', '2026-01-20 02:36:47', 40, 'AC_PRODUCT_CREATE', '2026-01-20 02:36:47', '2026-01-20 01:36:47', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto C15A-HL creado', 'Producto C15A-HL creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 17, 'product', NULL, NULL, NULL, NULL),
(282, '282', NULL, 1, '2026-01-20 02:39:22', '2026-01-20 02:39:22', 40, 'AC_PRODUCT_MODIFY', '2026-01-20 02:39:22', '2026-01-20 01:39:22', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto C15A-HL modificado', 'Producto C15A-HL modificado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 17, 'product', NULL, NULL, NULL, NULL),
(283, '283', NULL, 1, '2026-01-20 02:41:28', '2026-01-20 02:41:28', 40, 'AC_PRODUCT_CREATE', '2026-01-20 02:41:28', '2026-01-20 01:41:28', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto PLFN-C creado', 'Producto PLFN-C creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 18, 'product', NULL, NULL, NULL, NULL),
(284, '284', NULL, 1, '2026-01-20 02:42:44', '2026-01-20 02:42:44', 40, 'AC_PRODUCT_CREATE', '2026-01-20 02:42:44', '2026-01-20 01:42:44', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto INFL-TORO creado', 'Producto INFL-TORO creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 19, 'product', NULL, NULL, NULL, NULL),
(285, '285', NULL, 1, '2026-01-20 02:48:16', '2026-01-20 02:48:16', 40, 'AC_PRODUCT_CREATE', '2026-01-20 02:48:16', '2026-01-20 01:48:16', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto INFL-CASTILLO creado', 'Producto INFL-CASTILLO creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 20, 'product', NULL, NULL, NULL, NULL),
(286, '286', NULL, 1, '2026-01-20 02:50:39', '2026-01-20 02:50:39', 40, 'AC_PRODUCT_CREATE', '2026-01-20 02:50:39', '2026-01-20 01:50:39', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto TBLN creado', 'Producto TBLN creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 21, 'product', NULL, NULL, NULL, NULL),
(287, '287', NULL, 1, '2026-01-20 02:51:14', '2026-01-20 02:51:14', 40, 'AC_PRODUCT_CREATE', '2026-01-20 02:51:14', '2026-01-20 01:51:14', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto MCI creado', 'Producto MCI creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 22, 'product', NULL, NULL, NULL, NULL),
(288, '288', NULL, 1, '2026-01-20 02:51:42', '2026-01-20 02:51:42', 40, 'AC_PRODUCT_CREATE', '2026-01-20 02:51:42', '2026-01-20 01:51:42', 1, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'default', 0, -1, '', 0, 'Producto SILLA-PLASTICO-N creado', 'Producto SILLA-PLASTICO-N creado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 23, 'product', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_actioncomm_extrafields`
--

CREATE TABLE `llx_actioncomm_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_actioncomm_reminder`
--

CREATE TABLE `llx_actioncomm_reminder` (
  `rowid` int(11) NOT NULL,
  `dateremind` datetime NOT NULL,
  `typeremind` varchar(32) NOT NULL,
  `fk_user` int(11) NOT NULL,
  `offsetvalue` int(11) NOT NULL,
  `offsetunit` varchar(1) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `datedone` datetime DEFAULT NULL,
  `lasterror` varchar(128) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_actioncomm` int(11) NOT NULL,
  `fk_email_template` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_actioncomm_resources`
--

CREATE TABLE `llx_actioncomm_resources` (
  `rowid` int(11) NOT NULL,
  `fk_actioncomm` int(11) NOT NULL,
  `element_type` varchar(50) NOT NULL,
  `fk_element` int(11) NOT NULL,
  `answer_status` varchar(50) DEFAULT NULL,
  `mandatory` smallint(6) DEFAULT NULL,
  `transparency` smallint(6) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_actioncomm_resources`
--

INSERT INTO `llx_actioncomm_resources` (`rowid`, `fk_actioncomm`, `element_type`, `fk_element`, `answer_status`, `mandatory`, `transparency`) VALUES
(2, 2, 'user', 1, '0', 0, 0),
(3, 3, 'user', 1, '0', 0, 0),
(4, 4, 'user', 1, '0', 0, 0),
(5, 5, 'user', 1, '0', 0, 0),
(6, 6, 'user', 1, '0', 0, 0),
(7, 7, 'user', 1, '0', 0, 0),
(8, 8, 'user', 1, '0', 0, 0),
(9, 9, 'user', 1, '0', 0, 0),
(10, 10, 'user', 1, '0', 0, 0),
(11, 11, 'user', 1, '0', 0, 0),
(12, 12, 'user', 1, '0', 0, 0),
(13, 13, 'user', 1, '0', 0, 0),
(14, 14, 'user', 1, '0', 0, 0),
(15, 15, 'user', 1, '0', 0, 0),
(16, 16, 'user', 1, '0', 0, 0),
(17, 17, 'user', 1, '0', 0, 0),
(18, 18, 'user', 1, '0', 0, 0),
(19, 19, 'user', 1, '0', 0, 0),
(20, 20, 'user', 1, '0', 0, 0),
(21, 21, 'user', 1, '0', 0, 0),
(22, 22, 'user', 1, '0', 0, 0),
(23, 23, 'user', 1, '0', 0, 0),
(24, 24, 'user', 1, '0', 0, 0),
(25, 25, 'user', 1, '0', 0, 0),
(26, 26, 'user', 1, '0', 0, 0),
(27, 27, 'user', 1, '0', 0, 0),
(28, 28, 'user', 1, '0', 0, 0),
(29, 29, 'user', 1, '0', 0, 0),
(30, 30, 'user', 1, '0', 0, 0),
(31, 31, 'user', 1, '0', 0, 0),
(32, 32, 'user', 1, '0', 0, 0),
(33, 33, 'user', 1, '0', 0, 0),
(34, 34, 'user', 1, '0', 0, 0),
(35, 35, 'user', 1, '0', 0, 0),
(36, 36, 'user', 1, '0', 0, 0),
(37, 37, 'user', 1, '0', 0, 0),
(38, 38, 'user', 1, '0', 0, 0),
(39, 39, 'user', 1, '0', 0, 0),
(40, 40, 'user', 1, '0', 0, 0),
(41, 41, 'user', 1, '0', 0, 0),
(42, 42, 'user', 1, '0', 0, 0),
(43, 43, 'user', 1, '0', 0, 0),
(44, 44, 'user', 1, '0', 0, 0),
(45, 45, 'user', 1, '0', 0, 0),
(46, 46, 'user', 1, '0', 0, 0),
(47, 47, 'user', 1, '0', 0, 0),
(48, 48, 'user', 1, '0', 0, 0),
(49, 49, 'user', 1, '0', 0, 0),
(50, 50, 'user', 1, '0', 0, 0),
(51, 51, 'user', 1, '0', 0, 0),
(52, 52, 'user', 1, '0', 0, 0),
(53, 53, 'user', 1, '0', 0, 0),
(54, 54, 'user', 1, '0', 0, 0),
(55, 55, 'user', 1, '0', 0, 0),
(56, 56, 'user', 1, '0', 0, 0),
(57, 57, 'user', 1, '0', 0, 0),
(58, 58, 'user', 1, '0', 0, 0),
(59, 59, 'user', 1, '0', 0, 0),
(60, 60, 'user', 1, '0', 0, 0),
(61, 61, 'user', 1, '0', 0, 0),
(62, 62, 'user', 1, '0', 0, 0),
(63, 63, 'user', 1, '0', 0, 0),
(64, 64, 'user', 1, '0', 0, 0),
(65, 65, 'user', 1, '0', 0, 0),
(66, 66, 'user', 1, '0', 0, 0),
(67, 67, 'user', 1, '0', 0, 0),
(68, 68, 'user', 1, '0', 0, 0),
(69, 69, 'user', 1, '0', 0, 0),
(70, 70, 'user', 1, '0', 0, 0),
(71, 71, 'user', 1, '0', 0, 0),
(72, 72, 'user', 1, '0', 0, 0),
(73, 73, 'user', 1, '0', 0, 0),
(74, 74, 'user', 1, '0', 0, 0),
(75, 75, 'user', 1, '0', 0, 0),
(76, 76, 'user', 1, '0', 0, 0),
(77, 77, 'user', 1, '0', 0, 0),
(78, 78, 'user', 1, '0', 0, 0),
(79, 79, 'user', 1, '0', 0, 0),
(80, 80, 'user', 1, '0', 0, 0),
(81, 81, 'user', 1, '0', 0, 0),
(82, 82, 'user', 1, '0', 0, 0),
(83, 83, 'user', 1, '0', 0, 0),
(84, 84, 'user', 1, '0', 0, 0),
(85, 85, 'user', 1, '0', 0, 0),
(86, 86, 'user', 1, '0', 0, 0),
(87, 87, 'user', 1, '0', 0, 0),
(88, 88, 'user', 1, '0', 0, 0),
(89, 89, 'user', 1, '0', 0, 0),
(90, 90, 'user', 1, '0', 0, 0),
(91, 91, 'user', 1, '0', 0, 0),
(92, 92, 'user', 1, '0', 0, 0),
(93, 93, 'user', 1, '0', 0, 0),
(94, 94, 'user', 1, '0', 0, 0),
(95, 95, 'user', 1, '0', 0, 0),
(96, 96, 'user', 1, '0', 0, 0),
(97, 97, 'user', 1, '0', 0, 0),
(98, 98, 'user', 1, '0', 0, 0),
(99, 99, 'user', 1, '0', 0, 0),
(100, 100, 'user', 1, '0', 0, 0),
(101, 101, 'user', 1, '0', 0, 0),
(102, 102, 'user', 1, '0', 0, 0),
(103, 103, 'user', 1, '0', 0, 0),
(104, 104, 'user', 1, '0', 0, 0),
(105, 105, 'user', 1, '0', 0, 0),
(106, 106, 'user', 1, '0', 0, 0),
(107, 107, 'user', 1, '0', 0, 0),
(108, 108, 'user', 1, '0', 0, 0),
(109, 109, 'user', 1, '0', 0, 0),
(110, 110, 'user', 1, '0', 0, 0),
(111, 111, 'user', 1, '0', 0, 0),
(112, 112, 'user', 1, '0', 0, 0),
(113, 113, 'user', 1, '0', 0, 0),
(114, 114, 'user', 1, '0', 0, 0),
(115, 115, 'user', 1, '0', 0, 0),
(116, 116, 'user', 1, '0', 0, 0),
(117, 117, 'user', 1, '0', 0, 0),
(118, 118, 'user', 1, '0', 0, 0),
(119, 119, 'user', 1, '0', 0, 0),
(120, 120, 'user', 1, '0', 0, 0),
(121, 121, 'user', 1, '0', 0, 0),
(122, 122, 'user', 1, '0', 0, 0),
(123, 123, 'user', 1, '0', 0, 0),
(124, 124, 'user', 1, '0', 0, 0),
(125, 125, 'user', 1, '0', 0, 0),
(126, 126, 'user', 1, '0', 0, 0),
(127, 127, 'user', 1, '0', 0, 0),
(128, 128, 'user', 1, '0', 0, 0),
(129, 129, 'user', 1, '0', 0, 0),
(130, 130, 'user', 1, '0', 0, 0),
(131, 131, 'user', 1, '0', 0, 0),
(132, 132, 'user', 1, '0', 0, 0),
(133, 133, 'user', 1, '0', 0, 0),
(134, 134, 'user', 1, '0', 0, 0),
(135, 135, 'user', 1, '0', 0, 0),
(136, 136, 'user', 1, '0', 0, 0),
(137, 137, 'user', 1, '0', 0, 0),
(138, 138, 'user', 1, '0', 0, 0),
(139, 139, 'user', 1, '0', 0, 0),
(140, 140, 'user', 1, '0', 0, 0),
(141, 141, 'user', 1, '0', 0, 0),
(142, 142, 'user', 1, '0', 0, 0),
(143, 143, 'user', 1, '0', 0, 0),
(144, 144, 'user', 1, '0', 0, 0),
(145, 145, 'user', 1, '0', 0, 0),
(146, 146, 'user', 1, '0', 0, 0),
(147, 147, 'user', 1, '0', 0, 0),
(148, 148, 'user', 1, '0', 0, 0),
(149, 149, 'user', 1, '0', 0, 0),
(150, 150, 'user', 1, '0', 0, 0),
(151, 151, 'user', 1, '0', 0, 0),
(152, 152, 'user', 1, '0', 0, 0),
(153, 153, 'user', 1, '0', 0, 0),
(154, 154, 'user', 1, '0', 0, 0),
(155, 155, 'user', 1, '0', 0, 0),
(156, 156, 'user', 1, '0', 0, 0),
(157, 157, 'user', 1, '0', 0, 0),
(158, 158, 'user', 1, '0', 0, 0),
(159, 159, 'user', 1, '0', 0, 0),
(160, 160, 'user', 1, '0', 0, 0),
(161, 161, 'user', 1, '0', 0, 0),
(162, 162, 'user', 1, '0', 0, 0),
(163, 163, 'user', 1, '0', 0, 0),
(164, 164, 'user', 1, '0', 0, 0),
(165, 165, 'user', 1, '0', 0, 0),
(166, 166, 'user', 1, '0', 0, 0),
(167, 167, 'user', 1, '0', 0, 0),
(168, 168, 'user', 1, '0', 0, 0),
(169, 169, 'user', 1, '0', 0, 0),
(170, 170, 'user', 1, '0', 0, 0),
(171, 171, 'user', 1, '0', 0, 0),
(172, 172, 'user', 1, '0', 0, 0),
(173, 173, 'user', 1, '0', 0, 0),
(174, 174, 'user', 1, '0', 0, 0),
(175, 175, 'user', 1, '0', 0, 0),
(176, 176, 'user', 1, '0', 0, 0),
(177, 177, 'user', 1, '0', 0, 0),
(178, 178, 'user', 1, '0', 0, 0),
(179, 179, 'user', 1, '0', 0, 0),
(180, 180, 'user', 1, '0', 0, 0),
(181, 181, 'user', 1, '0', 0, 0),
(182, 182, 'user', 1, '0', 0, 0),
(183, 183, 'user', 1, '0', 0, 0),
(184, 184, 'user', 1, '0', 0, 0),
(185, 185, 'user', 1, '0', 0, 0),
(186, 186, 'user', 1, '0', 0, 0),
(187, 187, 'user', 1, '0', 0, 0),
(188, 188, 'user', 1, '0', 0, 0),
(189, 189, 'user', 1, '0', 0, 0),
(190, 190, 'user', 1, '0', 0, 0),
(191, 191, 'user', 1, '0', 0, 0),
(192, 192, 'user', 1, '0', 0, 0),
(193, 193, 'user', 1, '0', 0, 0),
(194, 194, 'user', 1, '0', 0, 0),
(195, 195, 'user', 1, '0', 0, 0),
(196, 196, 'user', 1, '0', 0, 0),
(197, 197, 'user', 1, '0', 0, 0),
(198, 198, 'user', 1, '0', 0, 0),
(199, 199, 'user', 1, '0', 0, 0),
(200, 200, 'user', 1, '0', 0, 0),
(201, 201, 'user', 1, '0', 0, 0),
(202, 202, 'user', 1, '0', 0, 0),
(203, 203, 'user', 1, '0', 0, 0),
(204, 204, 'user', 1, '0', 0, 0),
(205, 205, 'user', 1, '0', 0, 0),
(206, 206, 'user', 1, '0', 0, 0),
(207, 207, 'user', 1, '0', 0, 0),
(208, 208, 'user', 1, '0', 0, 0),
(209, 209, 'user', 1, '0', 0, 0),
(210, 210, 'user', 1, '0', 0, 0),
(211, 211, 'user', 1, '0', 0, 0),
(212, 212, 'user', 1, '0', 0, 0),
(213, 213, 'user', 1, '0', 0, 0),
(214, 214, 'user', 1, '0', 0, 0),
(215, 215, 'user', 1, '0', 0, 0),
(216, 216, 'user', 1, '0', 0, 0),
(217, 217, 'user', 1, '0', 0, 0),
(218, 218, 'user', 1, '0', 0, 0),
(219, 219, 'user', 1, '0', 0, 0),
(220, 220, 'user', 1, '0', 0, 0),
(221, 221, 'user', 1, '0', 0, 0),
(222, 222, 'user', 1, '0', 0, 0),
(223, 223, 'user', 1, '0', 0, 0),
(224, 224, 'user', 1, '0', 0, 0),
(225, 225, 'user', 1, '0', 0, 0),
(226, 226, 'user', 1, '0', 0, 0),
(227, 227, 'user', 1, '0', 0, 0),
(228, 228, 'user', 1, '0', 0, 0),
(229, 229, 'user', 1, '0', 0, 0),
(230, 230, 'user', 1, '0', 0, 0),
(231, 231, 'user', 1, '0', 0, 0),
(232, 232, 'user', 1, '0', 0, 0),
(233, 233, 'user', 1, '0', 0, 0),
(234, 234, 'user', 1, '0', 0, 0),
(235, 235, 'user', 1, '0', 0, 0),
(236, 236, 'user', 1, '0', 0, 0),
(237, 237, 'user', 1, '0', 0, 0),
(238, 238, 'user', 1, '0', 0, 0),
(239, 239, 'user', 1, '0', 0, 0),
(240, 240, 'user', 1, '0', 0, 0),
(241, 241, 'user', 1, '0', 0, 0),
(242, 242, 'user', 1, '0', 0, 0),
(243, 243, 'user', 1, '0', 0, 0),
(244, 244, 'user', 1, '0', 0, 0),
(245, 245, 'user', 1, '0', 0, 0),
(246, 246, 'user', 1, '0', 0, 0),
(247, 247, 'user', 1, '0', 0, 0),
(248, 248, 'user', 1, '0', 0, 0),
(249, 249, 'user', 1, '0', 0, 0),
(250, 250, 'user', 1, '0', 0, 0),
(251, 251, 'user', 1, '0', 0, 0),
(252, 252, 'user', 1, '0', 0, 0),
(253, 253, 'user', 1, '0', 0, 0),
(254, 254, 'user', 1, '0', 0, 0),
(255, 255, 'user', 1, '0', 0, 0),
(256, 256, 'user', 1, '0', 0, 0),
(257, 257, 'user', 1, '0', 0, 0),
(258, 258, 'user', 1, '0', 0, 0),
(259, 259, 'user', 1, '0', 0, 0),
(260, 260, 'user', 1, '0', 0, 0),
(261, 261, 'user', 1, '0', 0, 0),
(262, 262, 'user', 1, '0', 0, 0),
(263, 263, 'user', 1, '0', 0, 0),
(264, 264, 'user', 1, '0', 0, 0),
(265, 265, 'user', 1, '0', 0, 0),
(266, 266, 'user', 1, '0', 0, 0),
(267, 267, 'user', 1, '0', 0, 0),
(268, 268, 'user', 1, '0', 0, 0),
(269, 269, 'user', 1, '0', 0, 0),
(270, 270, 'user', 1, '0', 0, 0),
(271, 271, 'user', 1, '0', 0, 0),
(272, 272, 'user', 1, '0', 0, 0),
(273, 273, 'user', 1, '0', 0, 0),
(274, 274, 'user', 1, '0', 0, 0),
(275, 275, 'user', 1, '0', 0, 0),
(276, 276, 'user', 1, '0', 0, 0),
(277, 277, 'user', 1, '0', 0, 0),
(278, 278, 'user', 1, '0', 0, 0),
(279, 279, 'user', 1, '0', 0, 0),
(280, 280, 'user', 1, '0', 0, 0),
(281, 281, 'user', 1, '0', 0, 0),
(282, 282, 'user', 1, '0', 0, 0),
(283, 283, 'user', 1, '0', 0, 0),
(284, 284, 'user', 1, '0', 0, 0),
(285, 285, 'user', 1, '0', 0, 0),
(286, 286, 'user', 1, '0', 0, 0),
(287, 287, 'user', 1, '0', 0, 0),
(288, 288, 'user', 1, '0', 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_adherent`
--

CREATE TABLE `llx_adherent` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref_ext` varchar(128) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `civility` varchar(6) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `login` varchar(50) DEFAULT NULL,
  `pass` varchar(50) DEFAULT NULL,
  `pass_crypted` varchar(128) DEFAULT NULL,
  `fk_adherent_type` int(11) NOT NULL,
  `morphy` varchar(3) NOT NULL,
  `societe` varchar(128) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `zip` varchar(30) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `country` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `socialnetworks` text DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `phone_perso` varchar(30) DEFAULT NULL,
  `phone_mobile` varchar(30) DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `statut` smallint(6) NOT NULL DEFAULT 0,
  `public` smallint(6) NOT NULL DEFAULT 0,
  `datefin` datetime DEFAULT NULL,
  `default_lang` varchar(6) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `datevalid` datetime DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_mod` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `canvas` varchar(32) DEFAULT NULL,
  `ip` varchar(250) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_adherent_extrafields`
--

CREATE TABLE `llx_adherent_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_adherent_type`
--

CREATE TABLE `llx_adherent_type` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `statut` smallint(6) NOT NULL DEFAULT 0,
  `libelle` varchar(50) NOT NULL,
  `morphy` varchar(3) NOT NULL,
  `duration` varchar(6) DEFAULT NULL,
  `subscription` varchar(3) NOT NULL DEFAULT '1',
  `amount` double(24,8) DEFAULT NULL,
  `caneditamount` int(11) DEFAULT 0,
  `vote` varchar(3) NOT NULL DEFAULT '1',
  `note` text DEFAULT NULL,
  `mail_valid` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_adherent_type_extrafields`
--

CREATE TABLE `llx_adherent_type_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_adherent_type_lang`
--

CREATE TABLE `llx_adherent_type_lang` (
  `rowid` int(11) NOT NULL,
  `fk_type` int(11) NOT NULL DEFAULT 0,
  `lang` varchar(5) NOT NULL DEFAULT '0',
  `label` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `email` text DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_bank`
--

CREATE TABLE `llx_bank` (
  `rowid` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datev` date DEFAULT NULL,
  `dateo` date DEFAULT NULL,
  `amount` double(24,8) NOT NULL DEFAULT 0.00000000,
  `amount_main_currency` double(24,8) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_rappro` int(11) DEFAULT NULL,
  `fk_type` varchar(6) DEFAULT NULL,
  `num_releve` varchar(50) DEFAULT NULL,
  `num_chq` varchar(50) DEFAULT NULL,
  `numero_compte` varchar(32) DEFAULT NULL,
  `rappro` tinyint(4) DEFAULT 0,
  `note` text DEFAULT NULL,
  `fk_bordereau` int(11) DEFAULT 0,
  `position` int(11) DEFAULT 0,
  `banque` varchar(255) DEFAULT NULL,
  `emetteur` varchar(255) DEFAULT NULL,
  `author` varchar(40) DEFAULT NULL,
  `origin_id` int(11) DEFAULT NULL,
  `origin_type` varchar(64) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_bank_account`
--

CREATE TABLE `llx_bank_account` (
  `rowid` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ref` varchar(12) NOT NULL,
  `label` varchar(50) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `bank` varchar(60) DEFAULT NULL,
  `code_banque` varchar(128) DEFAULT NULL,
  `code_guichet` varchar(6) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `cle_rib` varchar(5) DEFAULT NULL,
  `bic` varchar(11) DEFAULT NULL,
  `bic_intermediate` varchar(11) DEFAULT NULL,
  `iban_prefix` varchar(80) DEFAULT NULL,
  `country_iban` varchar(2) DEFAULT NULL,
  `cle_iban` varchar(2) DEFAULT NULL,
  `domiciliation` varchar(255) DEFAULT NULL,
  `pti_in_ctti` smallint(6) DEFAULT 0,
  `state_id` int(11) DEFAULT NULL,
  `fk_pays` int(11) NOT NULL,
  `proprio` varchar(60) DEFAULT NULL,
  `owner_address` varchar(255) DEFAULT NULL,
  `owner_zip` varchar(25) DEFAULT NULL,
  `owner_town` varchar(50) DEFAULT NULL,
  `owner_country_id` int(11) DEFAULT NULL,
  `courant` smallint(6) NOT NULL DEFAULT 0,
  `clos` smallint(6) NOT NULL DEFAULT 0,
  `rappro` smallint(6) DEFAULT 1,
  `url` varchar(128) DEFAULT NULL,
  `account_number` varchar(32) DEFAULT NULL,
  `fk_accountancy_journal` int(11) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `min_allowed` int(11) DEFAULT 0,
  `min_desired` int(11) DEFAULT 0,
  `comment` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL,
  `ics` varchar(32) DEFAULT NULL,
  `ics_transfer` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_bank_account_extrafields`
--

CREATE TABLE `llx_bank_account_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_bank_extrafields`
--

CREATE TABLE `llx_bank_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_bank_url`
--

CREATE TABLE `llx_bank_url` (
  `rowid` int(11) NOT NULL,
  `fk_bank` int(11) DEFAULT NULL,
  `url_id` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `type` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_blockedlog`
--

CREATE TABLE `llx_blockedlog` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `date_creation` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `action` varchar(50) DEFAULT NULL,
  `amounts` double(24,8) NOT NULL,
  `element` varchar(50) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `user_fullname` varchar(255) DEFAULT NULL,
  `fk_object` int(11) DEFAULT NULL,
  `ref_object` varchar(255) DEFAULT NULL,
  `date_object` datetime DEFAULT NULL,
  `signature` varchar(100) NOT NULL,
  `signature_line` varchar(100) NOT NULL,
  `object_data` mediumtext DEFAULT NULL,
  `object_version` varchar(32) DEFAULT '',
  `certified` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_blockedlog_authority`
--

CREATE TABLE `llx_blockedlog_authority` (
  `rowid` int(11) NOT NULL,
  `blockchain` longtext NOT NULL,
  `signature` varchar(100) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_bookmark`
--

CREATE TABLE `llx_bookmark` (
  `rowid` int(11) NOT NULL,
  `fk_user` int(11) NOT NULL,
  `dateb` datetime DEFAULT NULL,
  `url` text DEFAULT NULL,
  `target` varchar(16) DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `favicon` varchar(24) DEFAULT NULL,
  `position` int(11) DEFAULT 0,
  `entity` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_bordereau_cheque`
--

CREATE TABLE `llx_bordereau_cheque` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(30) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `ref_ext` varchar(255) DEFAULT NULL,
  `type` varchar(6) DEFAULT 'CHQ',
  `datec` datetime NOT NULL,
  `date_bordereau` date DEFAULT NULL,
  `amount` double(24,8) NOT NULL,
  `nbcheque` smallint(6) NOT NULL,
  `fk_bank_account` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `statut` smallint(6) NOT NULL DEFAULT 0,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `note` text DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_boxes`
--

CREATE TABLE `llx_boxes` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `box_id` int(11) NOT NULL,
  `position` smallint(6) NOT NULL,
  `box_order` varchar(3) NOT NULL,
  `fk_user` int(11) NOT NULL DEFAULT 0,
  `maxline` int(11) DEFAULT NULL,
  `params` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_boxes`
--

INSERT INTO `llx_boxes` (`rowid`, `entity`, `box_id`, `position`, `box_order`, `fk_user`, `maxline`, `params`) VALUES
(1, 1, 1, 0, '0', 0, NULL, NULL),
(2, 1, 2, 0, '0', 0, NULL, NULL),
(3, 1, 3, 0, '0', 0, NULL, NULL),
(4, 1, 4, 0, '0', 0, NULL, NULL),
(5, 1, 5, 0, '0', 0, NULL, NULL),
(6, 1, 6, 0, '0', 0, NULL, NULL),
(7, 1, 7, 0, '0', 0, NULL, NULL),
(8, 1, 8, 0, '0', 0, NULL, NULL),
(9, 1, 9, 0, '0', 0, NULL, NULL),
(10, 1, 10, 0, '0', 0, NULL, NULL),
(11, 1, 11, 0, '0', 0, NULL, NULL),
(12, 1, 12, 0, '0', 0, NULL, NULL),
(13, 1, 13, 0, '0', 0, NULL, NULL),
(20, 1, 20, 0, '0', 0, NULL, NULL),
(21, 1, 21, 0, '0', 0, NULL, NULL),
(22, 1, 22, 0, '0', 0, NULL, NULL),
(23, 1, 23, 0, '0', 0, NULL, NULL),
(24, 1, 24, 0, '0', 0, NULL, NULL),
(25, 1, 25, 0, '0', 0, NULL, NULL),
(26, 1, 26, 0, '0', 0, NULL, NULL),
(27, 1, 27, 0, '0', 0, NULL, NULL),
(28, 1, 28, 0, '0', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_boxes_def`
--

CREATE TABLE `llx_boxes_def` (
  `rowid` int(11) NOT NULL,
  `file` varchar(200) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_user` int(11) NOT NULL DEFAULT 0,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `note` varchar(130) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_boxes_def`
--

INSERT INTO `llx_boxes_def` (`rowid`, `file`, `entity`, `fk_user`, `tms`, `note`) VALUES
(1, 'box_lastlogin.php', 1, 0, '2025-08-08 01:21:11', NULL),
(2, 'box_birthdays.php', 1, 0, '2025-08-08 01:21:11', NULL),
(3, 'box_dolibarr_state_board.php', 1, 0, '2025-08-08 01:21:11', NULL),
(4, 'box_actions.php', 1, 0, '2025-08-08 01:21:11', NULL),
(5, 'box_actions_future.php', 1, 0, '2025-08-08 01:21:11', NULL),
(6, 'box_produits.php', 1, 0, '2025-08-08 01:58:51', NULL),
(7, 'box_produits_alerte_stock.php', 1, 0, '2025-08-08 01:58:51', NULL),
(8, 'box_graph_product_distribution.php', 1, 0, '2025-08-08 01:58:51', NULL),
(9, 'box_clients.php', 1, 0, '2025-08-08 01:59:43', NULL),
(10, 'box_prospect.php', 1, 0, '2025-08-08 01:59:43', NULL),
(11, 'box_contacts.php', 1, 0, '2025-08-08 01:59:43', NULL),
(12, 'box_activity.php', 1, 0, '2025-08-08 01:59:43', '(WarningUsingThisBoxSlowDown)'),
(13, 'box_goodcustomers.php', 1, 0, '2025-08-08 01:59:43', '(WarningUsingThisBoxSlowDown)'),
(20, 'box_services_contracts.php', 1, 0, '2025-12-28 17:11:08', NULL),
(21, 'box_commandes.php', 1, 0, '2025-12-28 19:19:37', NULL),
(22, 'box_graph_orders_permonth.php', 1, 0, '2025-12-28 19:19:37', NULL),
(23, 'box_graph_propales_permonth.php', 1, 0, '2025-12-28 19:19:39', NULL),
(24, 'box_propales.php', 1, 0, '2025-12-28 19:19:39', NULL),
(25, 'box_factures_imp.php', 1, 0, '2026-01-18 19:15:39', NULL),
(26, 'box_factures.php', 1, 0, '2026-01-18 19:15:39', NULL),
(27, 'box_graph_invoices_permonth.php', 1, 0, '2026-01-18 19:15:39', NULL),
(28, 'box_customers_outstanding_bill_reached.php', 1, 0, '2026-01-18 19:15:39', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie`
--

CREATE TABLE `llx_categorie` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_parent` int(11) NOT NULL DEFAULT 0,
  `label` varchar(180) NOT NULL,
  `ref_ext` varchar(255) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 1,
  `description` text DEFAULT NULL,
  `color` varchar(8) DEFAULT NULL,
  `position` int(11) DEFAULT 0,
  `fk_soc` int(11) DEFAULT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `date_creation` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_categorie`
--

INSERT INTO `llx_categorie` (`rowid`, `entity`, `fk_parent`, `label`, `ref_ext`, `type`, `description`, `color`, `position`, `fk_soc`, `visible`, `date_creation`, `tms`, `fk_user_creat`, `fk_user_modif`, `import_key`) VALUES
(1, 1, 0, 'Mobiliario', NULL, 0, 'Sillas, Mesas, Sombrillas', 'aaff56', 0, NULL, 0, '2025-12-28 18:15:29', '2025-12-28 17:15:29', 1, NULL, NULL),
(2, 1, 0, 'Carpas', '', 0, '<strong>Carpas de Estructura Modular:</strong><br />\r\n&nbsp;-Cortinas<br />\r\n-Plafon<br />\r\n-Luz', 'aaffff', 0, NULL, 0, '2025-12-28 18:17:31', '2025-12-28 17:17:38', 1, 1, NULL),
(3, 1, 0, 'Manteleria', NULL, 0, '', 'd4aaff', 0, NULL, 0, '2025-12-28 18:18:17', '2025-12-28 17:18:17', 1, NULL, NULL),
(4, 1, 0, 'Pista/Tarima', NULL, 0, '', 'ffd4aa', 0, NULL, 0, '2025-12-28 18:18:44', '2025-12-28 17:18:44', 1, NULL, NULL),
(5, 1, 0, 'Inflables/Brincolines', NULL, 0, '', 'ff56ff', 0, NULL, 0, '2026-01-20 02:40:27', '2026-01-20 01:40:27', 1, NULL, NULL),
(6, 1, 0, 'Plafon Ceremonial', NULL, 0, '', '00ffff', 0, NULL, 0, '2026-01-20 02:40:52', '2026-01-20 01:40:52', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categories_extrafields`
--

CREATE TABLE `llx_categories_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_account`
--

CREATE TABLE `llx_categorie_account` (
  `fk_categorie` int(11) NOT NULL,
  `fk_account` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_actioncomm`
--

CREATE TABLE `llx_categorie_actioncomm` (
  `fk_categorie` int(11) NOT NULL,
  `fk_actioncomm` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_contact`
--

CREATE TABLE `llx_categorie_contact` (
  `fk_categorie` int(11) NOT NULL,
  `fk_socpeople` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_fournisseur`
--

CREATE TABLE `llx_categorie_fournisseur` (
  `fk_categorie` int(11) NOT NULL,
  `fk_soc` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_invoice`
--

CREATE TABLE `llx_categorie_invoice` (
  `fk_categorie` int(11) NOT NULL,
  `fk_invoice` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_lang`
--

CREATE TABLE `llx_categorie_lang` (
  `rowid` int(11) NOT NULL,
  `fk_category` int(11) NOT NULL DEFAULT 0,
  `lang` varchar(5) NOT NULL DEFAULT '0',
  `label` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_member`
--

CREATE TABLE `llx_categorie_member` (
  `fk_categorie` int(11) NOT NULL,
  `fk_member` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_order`
--

CREATE TABLE `llx_categorie_order` (
  `fk_categorie` int(11) NOT NULL,
  `fk_order` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_product`
--

CREATE TABLE `llx_categorie_product` (
  `fk_categorie` int(11) NOT NULL,
  `fk_product` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_categorie_product`
--

INSERT INTO `llx_categorie_product` (`fk_categorie`, `fk_product`, `import_key`) VALUES
(1, 6, NULL),
(1, 7, NULL),
(1, 8, NULL),
(1, 11, NULL),
(1, 12, NULL),
(1, 13, NULL),
(1, 21, NULL),
(1, 22, NULL),
(1, 23, NULL),
(2, 5, NULL),
(2, 10, NULL),
(2, 14, NULL),
(2, 15, NULL),
(2, 16, NULL),
(2, 17, NULL),
(4, 9, NULL),
(5, 19, NULL),
(5, 20, NULL),
(6, 18, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_project`
--

CREATE TABLE `llx_categorie_project` (
  `fk_categorie` int(11) NOT NULL,
  `fk_project` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_societe`
--

CREATE TABLE `llx_categorie_societe` (
  `fk_categorie` int(11) NOT NULL,
  `fk_soc` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_supplier_invoice`
--

CREATE TABLE `llx_categorie_supplier_invoice` (
  `fk_categorie` int(11) NOT NULL,
  `fk_supplier_invoice` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_supplier_order`
--

CREATE TABLE `llx_categorie_supplier_order` (
  `fk_categorie` int(11) NOT NULL,
  `fk_supplier_order` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_user`
--

CREATE TABLE `llx_categorie_user` (
  `fk_categorie` int(11) NOT NULL,
  `fk_user` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_categorie_warehouse`
--

CREATE TABLE `llx_categorie_warehouse` (
  `fk_categorie` int(11) NOT NULL,
  `fk_warehouse` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_category_bank`
--

CREATE TABLE `llx_category_bank` (
  `rowid` int(11) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_category_bankline`
--

CREATE TABLE `llx_category_bankline` (
  `lineid` int(11) NOT NULL,
  `fk_categ` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_chargesociales`
--

CREATE TABLE `llx_chargesociales` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(16) DEFAULT NULL,
  `date_ech` datetime NOT NULL,
  `libelle` varchar(80) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_creation` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_type` int(11) NOT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `amount` double(24,8) NOT NULL DEFAULT 0.00000000,
  `paye` smallint(6) NOT NULL DEFAULT 0,
  `periode` date DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_commande`
--

CREATE TABLE `llx_commande` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref_ext` varchar(255) DEFAULT NULL,
  `ref_client` varchar(255) DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_creation` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `date_commande` date DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `source` smallint(6) DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT 0,
  `amount_ht` double(24,8) DEFAULT 0.00000000,
  `remise_percent` double DEFAULT 0,
  `remise_absolue` double DEFAULT 0,
  `remise` double DEFAULT 0,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `localtax1` double(24,8) DEFAULT 0.00000000,
  `localtax2` double(24,8) DEFAULT 0.00000000,
  `revenuestamp` double(24,8) DEFAULT 0.00000000,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `signed_status` smallint(6) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `module_source` varchar(32) DEFAULT NULL,
  `pos_source` varchar(32) DEFAULT NULL,
  `facture` tinyint(4) DEFAULT 0,
  `fk_account` int(11) DEFAULT NULL,
  `fk_currency` varchar(3) DEFAULT NULL,
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `deposit_percent` varchar(63) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `date_livraison` datetime DEFAULT NULL,
  `fk_shipping_method` int(11) DEFAULT NULL,
  `fk_warehouse` int(11) DEFAULT NULL,
  `fk_availability` int(11) DEFAULT NULL,
  `fk_input_reason` int(11) DEFAULT NULL,
  `fk_delivery_address` int(11) DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_commandedet`
--

CREATE TABLE `llx_commandedet` (
  `rowid` int(11) NOT NULL,
  `fk_commande` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `vat_src_code` varchar(10) DEFAULT '',
  `tva_tx` double(7,4) DEFAULT NULL,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT 0,
  `remise` double DEFAULT 0,
  `fk_remise_except` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `subprice` double(24,8) DEFAULT 0.00000000,
  `subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `total_localtax1` double(24,8) DEFAULT 0.00000000,
  `total_localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `product_type` int(11) DEFAULT 0,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT 0,
  `buy_price_ht` double(24,8) DEFAULT 0.00000000,
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `special_code` int(11) DEFAULT 0,
  `rang` int(11) DEFAULT 0,
  `fk_unit` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `ref_ext` varchar(255) DEFAULT NULL,
  `fk_commandefourndet` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT 0.00000000,
  `multicurrency_subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_commandedet_extrafields`
--

CREATE TABLE `llx_commandedet_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_commande_extrafields`
--

CREATE TABLE `llx_commande_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_commande_fournisseur`
--

CREATE TABLE `llx_commande_fournisseur` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(180) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref_ext` varchar(255) DEFAULT NULL,
  `ref_supplier` varchar(255) DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT 0,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_creation` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_approve` datetime DEFAULT NULL,
  `date_approve2` datetime DEFAULT NULL,
  `date_commande` date DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_approve` int(11) DEFAULT NULL,
  `fk_user_approve2` int(11) DEFAULT NULL,
  `source` smallint(6) NOT NULL,
  `fk_statut` smallint(6) DEFAULT 0,
  `billed` smallint(6) DEFAULT 0,
  `amount_ht` double(24,8) DEFAULT 0.00000000,
  `remise_percent` double DEFAULT 0,
  `remise` double DEFAULT 0,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `localtax1` double(24,8) DEFAULT 0.00000000,
  `localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `date_livraison` datetime DEFAULT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `fk_input_method` int(11) DEFAULT 0,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_commande_fournisseurdet`
--

CREATE TABLE `llx_commande_fournisseurdet` (
  `rowid` int(11) NOT NULL,
  `fk_commande` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `ref` varchar(128) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `vat_src_code` varchar(10) DEFAULT '',
  `tva_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT 0,
  `remise` double DEFAULT 0,
  `subprice` double(24,8) DEFAULT 0.00000000,
  `subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `total_localtax1` double(24,8) DEFAULT 0.00000000,
  `total_localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `product_type` int(11) DEFAULT 0,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT 0,
  `special_code` int(11) DEFAULT 0,
  `rang` int(11) DEFAULT 0,
  `import_key` varchar(14) DEFAULT NULL,
  `fk_unit` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT 0.00000000,
  `multicurrency_subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_commande_fournisseurdet_extrafields`
--

CREATE TABLE `llx_commande_fournisseurdet_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_commande_fournisseur_extrafields`
--

CREATE TABLE `llx_commande_fournisseur_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_commande_fournisseur_log`
--

CREATE TABLE `llx_commande_fournisseur_log` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datelog` datetime NOT NULL,
  `fk_commande` int(11) NOT NULL,
  `fk_statut` smallint(6) NOT NULL,
  `fk_user` int(11) NOT NULL,
  `comment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_comment`
--

CREATE TABLE `llx_comment` (
  `rowid` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `description` text NOT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_element` int(11) DEFAULT NULL,
  `element_type` varchar(50) DEFAULT NULL,
  `entity` int(11) DEFAULT 1,
  `import_key` varchar(125) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_const`
--

CREATE TABLE `llx_const` (
  `rowid` int(11) NOT NULL,
  `name` varchar(180) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `value` text NOT NULL,
  `type` varchar(64) DEFAULT 'string',
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `note` text DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_const`
--

INSERT INTO `llx_const` (`rowid`, `name`, `entity`, `value`, `type`, `visible`, `note`, `tms`) VALUES
(2, 'MAIN_FEATURES_LEVEL', 0, '0', 'chaine', 1, 'Level of features to show: -1=stable+deprecated, 0=stable only (default), 1=stable+experimental, 2=stable+experimental+development', '2025-08-08 01:15:52'),
(3, 'MAILING_LIMIT_SENDBYWEB', 0, '25', 'chaine', 1, 'Number of targets to defined packet size when sending mass email', '2025-08-08 01:15:52'),
(4, 'SYSLOG_HANDLERS', 0, '[\"mod_syslog_file\"]', 'chaine', 0, 'Which logger to use', '2025-08-08 01:15:52'),
(5, 'SYSLOG_FILE', 0, 'DOL_DATA_ROOT/dolibarr.log', 'chaine', 0, 'Directory where to write log file', '2025-08-08 01:15:52'),
(6, 'SYSLOG_LEVEL', 0, '7', 'chaine', 0, 'Level of debug info to show', '2025-08-08 01:15:52'),
(7, 'MAIN_UPLOAD_DOC', 0, '2048', 'chaine', 0, 'Max size for file upload (0 means no upload allowed)', '2025-08-08 01:15:52'),
(8, 'MAIN_ENABLE_OVERWRITE_TRANSLATION', 1, '1', 'chaine', 0, 'Enable translation overwrite', '2025-08-08 01:15:52'),
(9, 'MAIN_ENABLE_DEFAULT_VALUES', 1, '1', 'chaine', 0, 'Enable default value overwrite', '2025-08-08 01:15:52'),
(11, 'MAIN_MAIL_SMTP_SERVER', 1, '', 'chaine', 0, 'Host or ip address for SMTP server', '2025-08-08 01:15:52'),
(12, 'MAIN_MAIL_SMTP_PORT', 1, '', 'chaine', 0, 'Port for SMTP server', '2025-08-08 01:15:52'),
(13, 'MAIN_MAIL_EMAIL_FROM', 1, 'robot@domain.com', 'chaine', 0, 'email emitter for Dolibarr automatic emails', '2025-08-08 01:15:52'),
(14, 'MAIN_SIZE_LISTE_LIMIT', 0, '20', 'chaine', 0, 'Maximum length of lists', '2025-08-08 01:15:52'),
(15, 'MAIN_SIZE_SHORTLIST_LIMIT', 0, '3', 'chaine', 0, 'Maximum length of short lists', '2025-08-08 01:15:52'),
(16, 'MAIN_MENU_STANDARD', 0, 'eldy_menu.php', 'chaine', 0, 'Menu manager for internal users', '2025-08-08 01:15:52'),
(17, 'MAIN_MENUFRONT_STANDARD', 0, 'eldy_menu.php', 'chaine', 0, 'Menu manager for external users', '2025-08-08 01:15:52'),
(18, 'MAIN_MENU_SMARTPHONE', 0, 'eldy_menu.php', 'chaine', 0, 'Menu manager for internal users using smartphones', '2025-08-08 01:15:52'),
(19, 'MAIN_MENUFRONT_SMARTPHONE', 0, 'eldy_menu.php', 'chaine', 0, 'Menu manager for external users using smartphones', '2025-08-08 01:15:52'),
(20, 'THEME_ELDY_USEBORDERONTABLE', 0, '1', 'chaine', 0, 'Enable the border in theme', '2025-08-08 01:15:52'),
(21, 'MAIN_DELAY_ACTIONS_TODO', 1, '7', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur actions planifiées non réalisées', '2025-08-08 01:15:52'),
(22, 'MAIN_DELAY_ORDERS_TO_PROCESS', 1, '2', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur commandes clients non traitées', '2025-08-08 01:15:52'),
(23, 'MAIN_DELAY_SUPPLIER_ORDERS_TO_PROCESS', 1, '7', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur commandes fournisseurs non traitées', '2025-08-08 01:15:52'),
(24, 'MAIN_DELAY_PROPALS_TO_CLOSE', 1, '31', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur propales à cloturer', '2025-08-08 01:15:52'),
(25, 'MAIN_DELAY_PROPALS_TO_BILL', 1, '7', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur propales non facturées', '2025-08-08 01:15:52'),
(26, 'MAIN_DELAY_CUSTOMER_BILLS_UNPAYED', 1, '31', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur factures client impayées', '2025-08-08 01:15:52'),
(27, 'MAIN_DELAY_SUPPLIER_BILLS_TO_PAY', 1, '2', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur factures fournisseur impayées', '2025-08-08 01:15:52'),
(28, 'MAIN_DELAY_NOT_ACTIVATED_SERVICES', 1, '0', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur services à activer', '2025-08-08 01:15:52'),
(29, 'MAIN_DELAY_RUNNING_SERVICES', 1, '0', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur services expirés', '2025-08-08 01:15:52'),
(30, 'MAIN_DELAY_MEMBERS', 1, '31', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur cotisations adhérent en retard', '2025-08-08 01:15:52'),
(31, 'MAIN_DELAY_TRANSACTIONS_TO_CONCILIATE', 1, '62', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur rapprochements bancaires à faire', '2025-08-08 01:15:52'),
(32, 'MAIN_DELAY_EXPENSEREPORTS_TO_PAY', 1, '31', 'chaine', 0, 'Tolérance de retard avant alerte (en jours) sur les notes de frais impayées', '2025-08-08 01:15:52'),
(33, 'MAILING_EMAIL_FROM', 1, 'no-reply@mydomain.com', 'chaine', 0, 'EMail emmetteur pour les envois d emailings', '2025-08-08 01:15:52'),
(34, 'PRODUCT_ADDON_PDF_ODT_PATH', 1, 'DOL_DATA_ROOT/doctemplates/products', 'chaine', 0, NULL, '2025-08-08 01:15:52'),
(35, 'CONTRACT_ADDON_PDF_ODT_PATH', 1, 'DOL_DATA_ROOT/doctemplates/contracts', 'chaine', 0, NULL, '2025-08-08 01:15:52'),
(36, 'USERGROUP_ADDON_PDF_ODT_PATH', 1, 'DOL_DATA_ROOT/doctemplates/usergroups', 'chaine', 0, NULL, '2025-08-08 01:15:52'),
(37, 'USER_ADDON_PDF_ODT_PATH', 1, 'DOL_DATA_ROOT/doctemplates/users', 'chaine', 0, NULL, '2025-08-08 01:15:52'),
(38, 'PRODUCT_PRICE_BASE_TYPE', 0, 'HT', 'string', 0, NULL, '2025-08-08 01:15:52'),
(39, 'ADHERENT_LOGIN_NOT_REQUIRED', 0, '1', 'string', 0, NULL, '2025-08-08 01:15:52'),
(40, 'MAIN_MODULE_USER', 0, '1', 'string', 0, '{\"authorid\":0,\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2025-08-08 01:21:11'),
(41, 'DATABASE_PWD_ENCRYPTED', 1, '1', 'chaine', 0, '', '2025-08-08 01:21:11'),
(42, 'MAIN_SECURITY_SALT', 0, '20250808032111', 'chaine', 0, '', '2025-08-08 01:21:11'),
(43, 'MAIN_SECURITY_HASH_ALGO', 0, 'password_hash', 'chaine', 0, '', '2025-08-08 01:21:11'),
(44, 'MAIN_VERSION_FIRST_INSTALL', 0, '21.0.2', 'chaine', 0, 'Dolibarr version when first install', '2025-08-08 01:21:11'),
(45, 'MAIN_VERSION_LAST_INSTALL', 0, '21.0.2', 'chaine', 0, 'Dolibarr version when last install', '2025-08-08 01:21:11'),
(46, 'MAIN_MODULE_AGENDA', 1, '1', 'string', 0, '{\"authorid\":0,\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2025-08-08 01:21:11'),
(47, 'MAIN_AGENDA_ACTIONAUTO_COMPANY_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(48, 'MAIN_AGENDA_ACTIONAUTO_COMPANY_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(49, 'MAIN_AGENDA_ACTIONAUTO_COMPANY_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(50, 'MAIN_AGENDA_ACTIONAUTO_COMPANY_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(51, 'MAIN_AGENDA_ACTIONAUTO_COMPANY_RIB_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(52, 'MAIN_AGENDA_ACTIONAUTO_COMPANY_RIB_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(53, 'MAIN_AGENDA_ACTIONAUTO_COMPANY_RIB_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(54, 'MAIN_AGENDA_ACTIONAUTO_PROPAL_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(55, 'MAIN_AGENDA_ACTIONAUTO_PROPAL_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(56, 'MAIN_AGENDA_ACTIONAUTO_PROPAL_CLOSE_SIGNED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(57, 'MAIN_AGENDA_ACTIONAUTO_PROPAL_CLOSE_REFUSED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(58, 'MAIN_AGENDA_ACTIONAUTO_PROPAL_CLASSIFY_BILLED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(59, 'MAIN_AGENDA_ACTIONAUTO_PROPAL_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(60, 'MAIN_AGENDA_ACTIONAUTO_PROPAL_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(61, 'MAIN_AGENDA_ACTIONAUTO_ORDER_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(62, 'MAIN_AGENDA_ACTIONAUTO_ORDER_CLOSE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(63, 'MAIN_AGENDA_ACTIONAUTO_ORDER_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(64, 'MAIN_AGENDA_ACTIONAUTO_ORDER_CLASSIFY_BILLED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(65, 'MAIN_AGENDA_ACTIONAUTO_ORDER_CANCEL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(66, 'MAIN_AGENDA_ACTIONAUTO_ORDER_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(67, 'MAIN_AGENDA_ACTIONAUTO_ORDER_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(68, 'MAIN_AGENDA_ACTIONAUTO_BILL_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(69, 'MAIN_AGENDA_ACTIONAUTO_BILL_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(70, 'MAIN_AGENDA_ACTIONAUTO_BILL_PAYED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(71, 'MAIN_AGENDA_ACTIONAUTO_BILL_CANCEL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(72, 'MAIN_AGENDA_ACTIONAUTO_BILL_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(73, 'MAIN_AGENDA_ACTIONAUTO_BILL_UNVALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(74, 'MAIN_AGENDA_ACTIONAUTO_BILL_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(75, 'MAIN_AGENDA_ACTIONAUTO_PROPOSAL_SUPPLIER_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(76, 'MAIN_AGENDA_ACTIONAUTO_PROPOSAL_SUPPLIER_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(77, 'MAIN_AGENDA_ACTIONAUTO_PROPOSAL_SUPPLIER_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(78, 'MAIN_AGENDA_ACTIONAUTO_PROPOSAL_SUPPLIER_CLOSE_SIGNED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(79, 'MAIN_AGENDA_ACTIONAUTO_PROPOSAL_SUPPLIER_CLOSE_REFUSED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(80, 'MAIN_AGENDA_ACTIONAUTO_PROPOSAL_SUPPLIER_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(81, 'MAIN_AGENDA_ACTIONAUTO_ORDER_SUPPLIER_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(82, 'MAIN_AGENDA_ACTIONAUTO_ORDER_SUPPLIER_APPROVE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(83, 'MAIN_AGENDA_ACTIONAUTO_ORDER_SUPPLIER_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(84, 'MAIN_AGENDA_ACTIONAUTO_ORDER_SUPPLIER_SUBMIT', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(85, 'MAIN_AGENDA_ACTIONAUTO_ORDER_SUPPLIER_RECEIVE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(86, 'MAIN_AGENDA_ACTIONAUTO_ORDER_SUPPLIER_REFUSE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(87, 'MAIN_AGENDA_ACTIONAUTO_ORDER_SUPPLIER_CANCEL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(88, 'MAIN_AGENDA_ACTIONAUTO_ORDER_SUPPLIER_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(89, 'MAIN_AGENDA_ACTIONAUTO_ORDER_SUPPLIER_CLASSIFY_BILLED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(90, 'MAIN_AGENDA_ACTIONAUTO_ORDER_SUPPLIER_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(91, 'MAIN_AGENDA_ACTIONAUTO_BILL_SUPPLIER_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(92, 'MAIN_AGENDA_ACTIONAUTO_BILL_SUPPLIER_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(93, 'MAIN_AGENDA_ACTIONAUTO_BILL_SUPPLIER_UNVALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(94, 'MAIN_AGENDA_ACTIONAUTO_BILL_SUPPLIER_PAYED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(95, 'MAIN_AGENDA_ACTIONAUTO_BILL_SUPPLIER_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(96, 'MAIN_AGENDA_ACTIONAUTO_BILL_SUPPLIER_CANCELED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(97, 'MAIN_AGENDA_ACTIONAUTO_BILL_SUPPLIER_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(98, 'MAIN_AGENDA_ACTIONAUTO_CONTRACT_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(99, 'MAIN_AGENDA_ACTIONAUTO_CONTRACT_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(100, 'MAIN_AGENDA_ACTIONAUTO_CONTRACT_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(101, 'MAIN_AGENDA_ACTIONAUTO_CONTRACT_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(102, 'MAIN_AGENDA_ACTIONAUTO_SHIPPING_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(103, 'MAIN_AGENDA_ACTIONAUTO_SHIPPING_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(104, 'MAIN_AGENDA_ACTIONAUTO_SHIPPING_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(105, 'MAIN_AGENDA_ACTIONAUTO_SHIPPING_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(106, 'MAIN_AGENDA_ACTIONAUTO_RECEPTION_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(107, 'MAIN_AGENDA_ACTIONAUTO_RECEPTION_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(108, 'MAIN_AGENDA_ACTIONAUTO_MEMBER_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(109, 'MAIN_AGENDA_ACTIONAUTO_MEMBER_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(110, 'MAIN_AGENDA_ACTIONAUTO_MEMBER_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(111, 'MAIN_AGENDA_ACTIONAUTO_MEMBER_SUBSCRIPTION_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(112, 'MAIN_AGENDA_ACTIONAUTO_MEMBER_SUBSCRIPTION_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(113, 'MAIN_AGENDA_ACTIONAUTO_MEMBER_SUBSCRIPTION_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(114, 'MAIN_AGENDA_ACTIONAUTO_MEMBER_RESILIATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(115, 'MAIN_AGENDA_ACTIONAUTO_MEMBER_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(116, 'MAIN_AGENDA_ACTIONAUTO_MEMBER_EXCLUDE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(117, 'MAIN_AGENDA_ACTIONAUTO_FICHINTER_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(118, 'MAIN_AGENDA_ACTIONAUTO_FICHINTER_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(119, 'MAIN_AGENDA_ACTIONAUTO_FICHINTER_CLASSIFY_BILLED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(120, 'MAIN_AGENDA_ACTIONAUTO_FICHINTER_CLASSIFY_UNBILLED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(121, 'MAIN_AGENDA_ACTIONAUTO_FICHINTER_REOPEN', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(122, 'MAIN_AGENDA_ACTIONAUTO_FICHINTER_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(123, 'MAIN_AGENDA_ACTIONAUTO_FICHINTER_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(124, 'MAIN_AGENDA_ACTIONAUTO_FICHINTER_CLOSE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(125, 'MAIN_AGENDA_ACTIONAUTO_PRODUCT_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(126, 'MAIN_AGENDA_ACTIONAUTO_PRODUCT_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(127, 'MAIN_AGENDA_ACTIONAUTO_PRODUCT_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(128, 'MAIN_AGENDA_ACTIONAUTO_CONTACT_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(129, 'MAIN_AGENDA_ACTIONAUTO_CONTACT_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(130, 'MAIN_AGENDA_ACTIONAUTO_CONTACT_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(131, 'MAIN_AGENDA_ACTIONAUTO_CONTACT_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(132, 'MAIN_AGENDA_ACTIONAUTO_PROJECT_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(133, 'MAIN_AGENDA_ACTIONAUTO_PROJECT_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(134, 'MAIN_AGENDA_ACTIONAUTO_PROJECT_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(135, 'MAIN_AGENDA_ACTIONAUTO_PROJECT_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(136, 'MAIN_AGENDA_ACTIONAUTO_PROJECT_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(137, 'MAIN_AGENDA_ACTIONAUTO_PROJECT_CLOSE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(138, 'MAIN_AGENDA_ACTIONAUTO_TICKET_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(139, 'MAIN_AGENDA_ACTIONAUTO_TICKET_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(140, 'MAIN_AGENDA_ACTIONAUTO_TICKET_ASSIGNED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(141, 'MAIN_AGENDA_ACTIONAUTO_TICKET_CLOSE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(142, 'MAIN_AGENDA_ACTIONAUTO_TICKET_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(143, 'MAIN_AGENDA_ACTIONAUTO_TICKET_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(144, 'MAIN_AGENDA_ACTIONAUTO_EXPENSE_REPORT_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(145, 'MAIN_AGENDA_ACTIONAUTO_EXPENSE_REPORT_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(146, 'MAIN_AGENDA_ACTIONAUTO_EXPENSE_REPORT_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(147, 'MAIN_AGENDA_ACTIONAUTO_EXPENSE_REPORT_APPROVE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(148, 'MAIN_AGENDA_ACTIONAUTO_EXPENSE_REPORT_PAID', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(149, 'MAIN_AGENDA_ACTIONAUTO_EXPENSE_REPORT_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(150, 'MAIN_AGENDA_ACTIONAUTO_USER_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(151, 'MAIN_AGENDA_ACTIONAUTO_USER_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(152, 'MAIN_AGENDA_ACTIONAUTO_USER_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(153, 'MAIN_AGENDA_ACTIONAUTO_USER_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(154, 'MAIN_AGENDA_ACTIONAUTO_USER_NEW_PASSWORD', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(155, 'MAIN_AGENDA_ACTIONAUTO_USER_ENABLEDISABLE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(156, 'MAIN_AGENDA_ACTIONAUTO_BOM_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(157, 'MAIN_AGENDA_ACTIONAUTO_BOM_UNVALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(158, 'MAIN_AGENDA_ACTIONAUTO_BOM_CLOSE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(159, 'MAIN_AGENDA_ACTIONAUTO_BOM_REOPEN', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(160, 'MAIN_AGENDA_ACTIONAUTO_BOM_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(161, 'MAIN_AGENDA_ACTIONAUTO_MRP_MO_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(162, 'MAIN_AGENDA_ACTIONAUTO_MRP_MO_PRODUCED', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(163, 'MAIN_AGENDA_ACTIONAUTO_MRP_MO_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(164, 'MAIN_AGENDA_ACTIONAUTO_MRP_MO_CANCEL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(165, 'MAIN_AGENDA_ACTIONAUTO_ACTION_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(166, 'MAIN_AGENDA_ACTIONAUTO_HOLIDAY_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(167, 'MAIN_AGENDA_ACTIONAUTO_HOLIDAY_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(168, 'MAIN_AGENDA_ACTIONAUTO_HOLIDAY_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(169, 'MAIN_AGENDA_ACTIONAUTO_HOLIDAY_CANCEL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(170, 'MAIN_AGENDA_ACTIONAUTO_HOLIDAY_APPROVE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(171, 'MAIN_AGENDA_ACTIONAUTO_HOLIDAY_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(172, 'MAIN_AGENDA_ACTIONAUTO_BILLREC_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(173, 'MAIN_AGENDA_ACTIONAUTO_BILLREC_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(174, 'MAIN_AGENDA_ACTIONAUTO_BILLREC_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(175, 'MAIN_AGENDA_ACTIONAUTO_HRM_EVALUATION_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(176, 'MAIN_AGENDA_ACTIONAUTO_HRM_EVALUATION_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(177, 'MAIN_AGENDA_ACTIONAUTO_HRM_EVALUATION_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(178, 'MAIN_AGENDA_ACTIONAUTO_HRM_EVALUATION_UNVALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(179, 'MAIN_AGENDA_ACTIONAUTO_HRM_EVALUATION_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(180, 'MAIN_AGENDA_ACTIONAUTO_RECRUITMENTJOBPOSITION_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(181, 'MAIN_AGENDA_ACTIONAUTO_RECRUITMENTJOBPOSITION_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(182, 'MAIN_AGENDA_ACTIONAUTO_RECRUITMENTJOBPOSITION_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(183, 'MAIN_AGENDA_ACTIONAUTO_RECRUITMENTJOBPOSITION_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(184, 'MAIN_AGENDA_ACTIONAUTO_RECRUITMENTCANDIDATURE_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(185, 'MAIN_AGENDA_ACTIONAUTO_RECRUITMENTCANDIDATURE_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(186, 'MAIN_AGENDA_ACTIONAUTO_RECRUITMENTCANDIDATURE_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(187, 'MAIN_AGENDA_ACTIONAUTO_RECRUITMENTCANDIDATURE_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(188, 'MAIN_AGENDA_ACTIONAUTO_KNOWLEDGERECORD_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(189, 'MAIN_AGENDA_ACTIONAUTO_KNOWLEDGERECORD_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(190, 'MAIN_AGENDA_ACTIONAUTO_KNOWLEDGERECORD_VALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(191, 'MAIN_AGENDA_ACTIONAUTO_KNOWLEDGERECORD_REOPEN', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(192, 'MAIN_AGENDA_ACTIONAUTO_KNOWLEDGERECORD_UNVALIDATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(193, 'MAIN_AGENDA_ACTIONAUTO_KNOWLEDGERECORD_CANCEL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(194, 'MAIN_AGENDA_ACTIONAUTO_KNOWLEDGERECORD_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(195, 'MAIN_AGENDA_ACTIONAUTO_KNOWLEDGERECORD_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(196, 'MAIN_AGENDA_ACTIONAUTO_PARTNERSHIP_CREATE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(197, 'MAIN_AGENDA_ACTIONAUTO_PARTNERSHIP_MODIFY', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(198, 'MAIN_AGENDA_ACTIONAUTO_PARTNERSHIP_SENTBYMAIL', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(199, 'MAIN_AGENDA_ACTIONAUTO_PARTNERSHIP_DELETE', 1, '1', 'chaine', 0, NULL, '2025-08-08 01:21:11'),
(200, 'MAIN_MODULE_EXPORT', 1, '1', 'string', 0, '{\"authorid\":0,\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2025-08-08 01:21:11'),
(201, 'MAIN_MODULE_FCKEDITOR', 1, '1', 'string', 0, '{\"authorid\":0,\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2025-08-08 01:21:11'),
(202, 'FCKEDITOR_ENABLE_SOCIETE', 1, '1', 'yesno', 0, 'WYSIWYG for the fields descriptions of elements (except products/services)', '2025-08-08 01:21:11'),
(203, 'FCKEDITOR_ENABLE_DETAILS', 1, '1', 'yesno', 0, 'WYSIWYG for products details lines for all entities', '2025-08-08 01:21:11'),
(204, 'FCKEDITOR_ENABLE_USERSIGN', 1, '1', 'yesno', 0, 'WYSIWYG for user signature', '2025-08-08 01:21:11'),
(205, 'FCKEDITOR_ENABLE_MAILING', 1, '1', 'yesno', 0, 'WYSIWYG for mass emailings', '2025-08-08 01:21:11'),
(206, 'FCKEDITOR_ENABLE_MAIL', 1, '1', 'yesno', 0, 'WYSIWYG for products details lines for all entities', '2025-08-08 01:21:11'),
(207, 'MAIN_MODULE_IMPORT', 1, '1', 'string', 0, '{\"authorid\":0,\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2025-08-08 01:21:11'),
(265, 'MAIN_MODULE_PRODUCT', 1, '1', 'string', 0, '{\"authorid\":\"1\",\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2025-08-08 01:58:51'),
(266, 'PRODUCT_CODEPRODUCT_ADDON', 1, 'mod_codeproduct_leopard', 'chaine', 0, 'Module to control product codes', '2025-08-08 01:58:51'),
(267, 'PRODUCT_PRICE_UNIQ', 1, '1', 'chaine', 0, 'pricing rule by default', '2025-08-08 01:58:51'),
(273, 'MAIN_MODULE_SOCIETE', 1, '1', 'string', 0, '{\"authorid\":\"1\",\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2025-08-08 01:59:43'),
(274, 'SOCIETE_CODECLIENT_ADDON', 1, 'mod_codeclient_monkey', 'chaine', 0, 'Module to control third parties codes', '2025-08-08 01:59:43'),
(275, 'SOCIETE_CODECOMPTA_ADDON', 1, 'mod_codecompta_panicum', 'chaine', 0, 'Module to control third parties codes', '2025-08-08 01:59:43'),
(276, 'COMPANY_ADDON_PDF_ODT_PATH', 1, 'DOL_DATA_ROOT/doctemplates/thirdparties', 'chaine', 0, NULL, '2025-08-08 01:59:43'),
(277, 'SOCIETE_ADD_REF_IN_LIST', 1, '0', 'yesno', 0, 'Display customer ref into select list', '2025-08-08 01:59:43'),
(282, 'FACTURE_ADDON', 1, 'mod_facture_terre', 'chaine', 0, 'Name of numbering numerotation rules of invoice', '2025-08-08 02:00:01'),
(283, 'FACTURE_ADDON_PDF', 1, 'sponge', 'chaine', 0, 'Name of PDF model of invoice', '2025-08-08 02:00:01'),
(284, 'FACTURE_ADDON_PDF_ODT_PATH', 1, 'DOL_DATA_ROOT/doctemplates/invoices', 'chaine', 0, NULL, '2025-08-08 02:00:01'),
(289, 'COMMANDE_ADDON_PDF', 1, 'eratosthene', 'chaine', 0, 'Name of PDF model of order', '2025-08-08 02:00:13'),
(290, 'COMMANDE_ADDON', 1, 'mod_commande_marbre', 'chaine', 0, 'Name of numbering numerotation rules of order', '2025-08-08 02:00:13'),
(291, 'COMMANDE_ADDON_PDF_ODT_PATH', 1, 'DOL_DATA_ROOT/doctemplates/orders', 'chaine', 0, NULL, '2025-08-08 02:00:13'),
(298, 'STOCK_ALLOW_NEGATIVE_TRANSFER', 1, '1', 'chaine', 1, NULL, '2025-08-08 02:01:18'),
(299, 'STOCK_ADDON_PDF', 1, 'standard_stock', 'chaine', 0, 'Name of PDF model of stock', '2025-08-08 02:01:18'),
(300, 'MOUVEMENT_ADDON_PDF', 1, 'standard_movement_stock', 'chaine', 0, 'Name of PDF model of stock movement', '2025-08-08 02:01:18'),
(301, 'STOCK_ADDON_PDF_ODT_PATH', 1, 'DOL_DATA_ROOT/doctemplates/stocks', 'chaine', 0, NULL, '2025-08-08 02:01:18'),
(302, 'MOUVEMENT_ADDON_PDF_ODT_PATH', 1, 'DOL_DATA_ROOT/doctemplates/stocks/movements', 'chaine', 0, NULL, '2025-08-08 02:01:18'),
(351, 'MAIN_LANG_DEFAULT', 1, 'es_MX', 'chaine', 0, '', '2025-12-28 16:41:40'),
(353, 'MAIN_SIZE_LISTE_LIMIT', 1, '20', 'chaine', 0, '', '2025-12-28 16:41:40'),
(354, 'MAIN_SIZE_SHORTLIST_LIMIT', 1, '3', 'chaine', 0, '', '2025-12-28 16:41:40'),
(355, 'MAIN_START_WEEK', 1, '1', 'chaine', 0, '', '2025-12-28 16:41:40'),
(356, 'MAIN_DEFAULT_WORKING_DAYS', 1, '1-5', 'chaine', 0, '', '2025-12-28 16:41:40'),
(357, 'MAIN_DEFAULT_WORKING_HOURS', 1, '9-18', 'chaine', 0, '', '2025-12-28 16:41:40'),
(358, 'MAIN_FIRSTNAME_NAME_POSITION', 1, '0', 'chaine', 0, '', '2025-12-28 16:41:40'),
(366, 'THEME_ELDY_USEBORDERONTABLE', 1, '1', 'chaine', 0, '', '2025-12-28 16:43:00'),
(370, 'MAIN_MODULE_API', 0, '1', 'string', 0, '{\"authorid\":\"1\",\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2025-12-28 16:45:16'),
(383, 'MAIN_MODULE_SERVICE', 1, '1', 'string', 0, '{\"authorid\":\"1\",\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2025-12-28 17:11:08'),
(390, 'MAIN_MODULE_CATEGORIE', 1, '1', 'string', 0, '{\"authorid\":\"1\",\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2025-12-28 17:14:12'),
(391, 'CATEGORIE_RECURSIV_ADD', 1, '0', 'yesno', 0, 'Affect parent categories', '2025-12-28 17:14:12'),
(395, 'MAIN_MODULE_STOCK', 1, '1', 'string', 0, '{\"authorid\":\"1\",\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2025-12-28 17:29:59'),
(399, 'MAIN_MODULE_COMMANDE', 1, '1', 'string', 0, '{\"authorid\":\"1\",\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2025-12-28 19:19:37'),
(403, 'MAIN_MODULE_PROPALE', 1, '1', 'string', 0, '{\"authorid\":\"1\",\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2025-12-28 19:19:39'),
(404, 'PROPALE_ADDON_PDF', 1, 'cyan', 'chaine', 0, 'Name of the proposal generation manager in PDF format', '2025-12-28 19:19:39'),
(405, 'PROPALE_ADDON', 1, 'mod_propale_marbre', 'chaine', 0, 'Name of proposal numbering manager', '2025-12-28 19:19:39'),
(406, 'PROPALE_VALIDITY_DURATION', 1, '15', 'chaine', 0, 'Duration of validity of business proposals', '2025-12-28 19:19:39'),
(407, 'PROPALE_ADDON_PDF_ODT_PATH', 1, 'DOL_DATA_ROOT/doctemplates/proposals', 'chaine', 0, NULL, '2025-12-28 19:19:39'),
(408, 'PROPOSAL_ALLOW_ONLINESIGN', 1, '1', 'chaine', 0, NULL, '2025-12-28 19:19:39'),
(556, 'THEME_MENU_COLORLOGO', 1, '1', 'chaine', 0, '', '2025-12-31 03:50:53'),
(558, 'MAIN_SHOW_LOGO', 1, '1', 'chaine', 0, '', '2025-12-31 03:50:58'),
(584, 'MAIN_INFO_SOCIETE_LOGO', 1, 'logo_small.png', 'chaine', 0, '', '2025-12-31 03:54:31'),
(598, 'MAIN_INFO_SOCIETE_LOGO_SQUARRED', 1, 'logo_small.png', 'chaine', 0, '', '2025-12-31 03:54:37'),
(602, 'MAIN_PDF_USE_LARGE_LOGO', 1, '1', 'chaine', 1, 'Fix logo PDF', '2025-12-31 04:07:50'),
(603, 'MAIN_INFO_SOCIETE_COUNTRY', 1, '154:MX:Mexico', 'chaine', 0, '', '2025-12-31 04:08:17'),
(604, 'MAIN_INFO_SOCIETE_STATE', 1, '1572:MEX:México', 'chaine', 0, '', '2025-12-31 04:08:17'),
(605, 'MAIN_INFO_SOCIETE_NOM', 1, 'Carpas Y Lonas Montes S.a de C.V', 'chaine', 0, '', '2025-12-31 04:08:17'),
(606, 'MAIN_INFO_SOCIETE_ADDRESS', 1, 'Estado de Mexico, Amecameca, Avenida 20 de Noviembre', 'chaine', 0, '', '2025-12-31 04:08:17'),
(607, 'MAIN_INFO_SOCIETE_TOWN', 1, 'CHALCO', 'chaine', 0, '', '2025-12-31 04:08:17'),
(608, 'MAIN_INFO_SOCIETE_ZIP', 1, '56600', 'chaine', 0, '', '2025-12-31 04:08:17'),
(609, 'MAIN_MONNAIE', 1, 'MXN', 'chaine', 0, '', '2025-12-31 04:08:17'),
(610, 'MAIN_INFO_SOCIETE_TEL', 1, '5559207816', 'chaine', 0, '', '2025-12-31 04:08:17'),
(611, 'MAIN_INFO_SOCIETE_MOBILE', 1, '5630789541', 'chaine', 0, '', '2025-12-31 04:08:17'),
(612, 'MAIN_INFO_SOCIETE_MAIL', 1, 'arturomontes49@gmail.com', 'chaine', 0, '', '2025-12-31 04:08:17'),
(613, 'MAIN_INFO_SOCIETE_FORME_JURIDIQUE', 1, '0', 'chaine', 0, '', '2025-12-31 04:08:17'),
(614, 'SOCIETE_FISCAL_MONTH_START', 1, '1', 'chaine', 0, '', '2025-12-31 04:08:17'),
(615, 'FACTURE_TVAOPTION', 1, '0', 'chaine', 0, '', '2025-12-31 04:08:17'),
(616, 'MAIN_LAST_PING_KO_DATE', 1, '20260107025829', 'chaine', 0, '', '2026-01-07 02:58:29'),
(617, 'MAIN_THEME', 1, 'eldy', 'chaine', 0, '', '2026-01-07 03:22:44'),
(619, 'THEME_DARKMODEENABLED', 1, '1', 'chaine', 0, '', '2026-01-07 03:22:44'),
(620, 'THEME_ELDY_BORDER_RADIUS', 1, '0', 'chaine', 0, '', '2026-01-07 03:22:44'),
(623, 'MAIN_MODULE_FACTURE', 1, '1', 'string', 0, '{\"authorid\":\"1\",\"ip\":\"::1\",\"lastactivationversion\":\"dolibarr\"}', '2026-01-18 19:15:39'),
(624, 'MAIN_IHM_PARAMS_REV', 1, '28', 'chaine', 0, '', '2026-01-18 19:15:39'),
(625, 'MAIN_MODULE_SETUP_ON_LIST_BY_DEFAULT', 1, 'commonkanban', 'chaine', 0, '', '2026-01-18 19:15:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_contrat`
--

CREATE TABLE `llx_contrat` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(255) DEFAULT NULL,
  `ref_customer` varchar(255) DEFAULT NULL,
  `ref_supplier` varchar(255) DEFAULT NULL,
  `ref_ext` varchar(255) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `date_contrat` datetime DEFAULT NULL,
  `statut` smallint(6) DEFAULT 0,
  `fin_validite` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_commercial_signature` int(11) DEFAULT NULL,
  `fk_commercial_suivi` int(11) DEFAULT NULL,
  `fk_user_author` int(11) NOT NULL DEFAULT 0,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `localtax1` double(24,8) DEFAULT 0.00000000,
  `localtax2` double(24,8) DEFAULT 0.00000000,
  `revenuestamp` double(24,8) DEFAULT 0.00000000,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `denormalized_lower_planned_end_date` datetime DEFAULT NULL,
  `signed_status` smallint(6) DEFAULT NULL,
  `online_sign_ip` varchar(48) DEFAULT NULL,
  `online_sign_name` varchar(64) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_contratdet`
--

CREATE TABLE `llx_contratdet` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_contrat` int(11) NOT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `statut` smallint(6) DEFAULT 0,
  `label` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `fk_remise_except` int(11) DEFAULT NULL,
  `date_commande` datetime DEFAULT NULL,
  `date_ouverture_prevue` datetime DEFAULT NULL,
  `date_ouverture` datetime DEFAULT NULL,
  `date_fin_validite` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `vat_src_code` varchar(10) DEFAULT '',
  `tva_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) DEFAULT NULL,
  `qty` double NOT NULL,
  `remise_percent` double DEFAULT 0,
  `subprice` double(24,8) DEFAULT 0.00000000,
  `subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `price_ht` double DEFAULT NULL,
  `remise` double DEFAULT 0,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `total_localtax1` double(24,8) DEFAULT 0.00000000,
  `total_localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `product_type` int(11) DEFAULT 1,
  `info_bits` int(11) DEFAULT 0,
  `rang` int(11) DEFAULT 0,
  `buy_price_ht` double(24,8) DEFAULT NULL,
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `fk_user_author` int(11) NOT NULL DEFAULT 0,
  `fk_user_ouverture` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `commentaire` text DEFAULT NULL,
  `fk_unit` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT 0.00000000,
  `multicurrency_subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_contratdet_extrafields`
--

CREATE TABLE `llx_contratdet_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_contrat_extrafields`
--

CREATE TABLE `llx_contrat_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_cronjob`
--

CREATE TABLE `llx_cronjob` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `jobtype` varchar(10) NOT NULL,
  `label` varchar(255) NOT NULL,
  `command` varchar(255) DEFAULT NULL,
  `classesname` varchar(255) DEFAULT NULL,
  `objectname` varchar(255) DEFAULT NULL,
  `methodename` varchar(255) DEFAULT NULL,
  `params` text DEFAULT NULL,
  `md5params` varchar(32) DEFAULT NULL,
  `module_name` varchar(255) DEFAULT NULL,
  `priority` int(11) DEFAULT 0,
  `datelastrun` datetime DEFAULT NULL,
  `datenextrun` datetime DEFAULT NULL,
  `datestart` datetime DEFAULT NULL,
  `dateend` datetime DEFAULT NULL,
  `datelastresult` datetime DEFAULT NULL,
  `lastresult` text DEFAULT NULL,
  `lastoutput` text DEFAULT NULL,
  `unitfrequency` varchar(255) NOT NULL DEFAULT '3600',
  `frequency` int(11) NOT NULL DEFAULT 0,
  `maxrun` int(11) NOT NULL DEFAULT 0,
  `nbrun` int(11) DEFAULT NULL,
  `autodelete` int(11) DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1,
  `processing` int(11) NOT NULL DEFAULT 0,
  `pid` int(11) DEFAULT NULL,
  `test` varchar(255) DEFAULT '1',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_mod` int(11) DEFAULT NULL,
  `fk_mailing` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `libname` varchar(255) DEFAULT NULL,
  `email_alert` varchar(128) DEFAULT NULL,
  `entity` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_cronjob`
--

INSERT INTO `llx_cronjob` (`rowid`, `tms`, `datec`, `jobtype`, `label`, `command`, `classesname`, `objectname`, `methodename`, `params`, `md5params`, `module_name`, `priority`, `datelastrun`, `datenextrun`, `datestart`, `dateend`, `datelastresult`, `lastresult`, `lastoutput`, `unitfrequency`, `frequency`, `maxrun`, `nbrun`, `autodelete`, `status`, `processing`, `pid`, `test`, `fk_user_author`, `fk_user_mod`, `fk_mailing`, `note`, `libname`, `email_alert`, `entity`) VALUES
(1, '2025-08-08 01:21:11', '2025-08-08 03:21:11', 'method', 'SendEmailsReminders', '', 'comm/action/class/actioncomm.class.php', 'ActionComm', 'sendEmailsReminder', '', '', 'agenda', 10, NULL, '2025-08-08 03:21:11', '2025-08-08 03:21:11', NULL, NULL, NULL, NULL, '60', 5, 0, 0, 0, 1, 0, NULL, 'isModEnabled(\"agenda\")', NULL, NULL, NULL, 'SendEMailsReminder', '', NULL, 1),
(2, '2025-08-08 02:00:01', '2025-08-08 04:00:01', 'method', 'RecurringInvoicesJob', '', 'compta/facture/class/facture-rec.class.php', 'FactureRec', 'createRecurringInvoices', '', '', 'facture', 51, NULL, '2025-08-08 04:00:01', '2025-08-08 23:00:00', NULL, NULL, NULL, NULL, '86400', 1, 0, 0, 0, 1, 0, NULL, '$conf->facture->enabled', 1, 1, NULL, 'Generate recurring invoices', '', NULL, 1),
(3, '2025-08-08 02:00:01', '2025-08-08 04:00:01', 'method', 'SendEmailsRemindersOnInvoiceDueDate', '', 'compta/facture/class/facture.class.php', 'Facture', 'sendEmailsRemindersOnInvoiceDueDate', '10,all,EmailTemplateCode,duedate', '', 'facture', 50, NULL, '2025-08-08 04:00:01', '2025-08-08 23:00:00', NULL, NULL, NULL, NULL, '86400', 1, 0, 0, 0, 0, 0, NULL, '$conf->facture->enabled', 1, 1, NULL, 'Send an email when we reach the invoice due date (or invoice date) - n days. First param is n, the number of days before due date (or invoice date) to send the remind (or after if value is negative), second parameter is \"all\" or a payment mode code, third parameter is the code of the email template to use (an email template with the EmailTemplateCode must exists. The version of the email template in the language of the thirdparty will be used in priority. Language of the thirdparty will be also used to update the PDF of the sent invoice). The fourth parameter is the string \"duedate\" (default) or \"invoicedate\" to define which date of the invoice to use.', '', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_actioncomm`
--

CREATE TABLE `llx_c_actioncomm` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'system',
  `libelle` varchar(128) NOT NULL,
  `module` varchar(50) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `todo` tinyint(4) DEFAULT NULL,
  `color` varchar(9) DEFAULT NULL,
  `picto` varchar(48) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_actioncomm`
--

INSERT INTO `llx_c_actioncomm` (`id`, `code`, `type`, `libelle`, `module`, `active`, `todo`, `color`, `picto`, `position`) VALUES
(1, 'AC_TEL', 'system', 'Phone call', NULL, 1, NULL, NULL, NULL, 2),
(2, 'AC_FAX', 'system', 'Send Fax', NULL, 0, NULL, NULL, NULL, 3),
(4, 'AC_EMAIL', 'system', 'Send Email', NULL, 0, NULL, NULL, NULL, 4),
(5, 'AC_RDV', 'system', 'Rendez-vous', NULL, 1, NULL, NULL, NULL, 1),
(6, 'AC_EMAIL_IN', 'system', 'Reception Email', NULL, 0, NULL, NULL, NULL, 4),
(11, 'AC_INT', 'system', 'Intervention on site', NULL, 1, NULL, NULL, NULL, 4),
(40, 'AC_OTH_AUTO', 'systemauto', 'Other (automatically inserted events)', NULL, 1, NULL, NULL, NULL, 20),
(50, 'AC_OTH', 'system', 'Other (manually inserted events)', NULL, 1, NULL, NULL, NULL, 5),
(60, 'AC_EO_ONLINECONF', 'module', 'Online/Virtual conference', 'conference@eventorganization', 1, NULL, NULL, NULL, 60),
(61, 'AC_EO_INDOORCONF', 'module', 'Indoor conference', 'conference@eventorganization', 1, NULL, NULL, NULL, 61),
(62, 'AC_EO_ONLINEBOOTH', 'module', 'Online/Virtual booth', 'booth@eventorganization', 1, NULL, NULL, NULL, 62),
(63, 'AC_EO_INDOORBOOTH', 'module', 'Indoor booth', 'booth@eventorganization', 1, NULL, NULL, NULL, 63);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_action_trigger`
--

CREATE TABLE `llx_c_action_trigger` (
  `rowid` int(11) NOT NULL,
  `elementtype` varchar(64) NOT NULL,
  `code` varchar(128) NOT NULL,
  `contexts` varchar(255) DEFAULT NULL,
  `label` varchar(128) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `rang` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_action_trigger`
--

INSERT INTO `llx_c_action_trigger` (`rowid`, `elementtype`, `code`, `contexts`, `label`, `description`, `rang`) VALUES
(1, 'societe', 'COMPANY_CREATE', NULL, 'Third party created', 'Executed when a third party is created', 1),
(2, 'societe', 'COMPANY_MODIFY', NULL, 'Third party update', 'Executed when you update third party', 1),
(3, 'societe', 'COMPANY_SENTBYMAIL', NULL, 'Mails sent from third party card', 'Executed when you send email from third party card', 1),
(4, 'societe', 'COMPANY_DELETE', NULL, 'Third party deleted', 'Executed when you delete third party', 1),
(5, 'societe', 'COMPANY_RIB_CREATE', NULL, 'Third party payment information created', 'Executed when a third party payment information is created', 1),
(6, 'societe', 'COMPANY_RIB_MODIFY', NULL, 'Third party payment information updated', 'Executed when a third party payment information is updated', 1),
(7, 'societe', 'COMPANY_RIB_DELETE', NULL, 'Third party payment information deleted', 'Executed when a third party payment information is deleted', 1),
(8, 'propal', 'PROPAL_VALIDATE', NULL, 'Customer proposal validated', 'Executed when a commercial proposal is validated', 2),
(9, 'propal', 'PROPAL_MODIFY', NULL, 'Customer proposal modified', 'Executed when a customer proposal is modified', 2),
(10, 'propal', 'PROPAL_SENTBYMAIL', NULL, 'Commercial proposal sent by mail', 'Executed when a commercial proposal is sent by mail', 3),
(11, 'propal', 'PROPAL_CLOSE_SIGNED', NULL, 'Customer proposal closed signed', 'Executed when a customer proposal is closed signed', 2),
(12, 'propal', 'PROPAL_CLOSE_REFUSED', NULL, 'Customer proposal closed refused', 'Executed when a customer proposal is closed refused', 2),
(13, 'propal', 'PROPAL_CLASSIFY_BILLED', NULL, 'Customer proposal set billed', 'Executed when a customer proposal is set to billed', 2),
(14, 'propal', 'PROPAL_DELETE', NULL, 'Customer proposal deleted', 'Executed when a customer proposal is deleted', 2),
(15, 'commande', 'ORDER_VALIDATE', NULL, 'Customer order validate', 'Executed when a customer order is validated', 4),
(16, 'commande', 'ORDER_CLOSE', NULL, 'Customer order classify delivered', 'Executed when a customer order is set delivered', 5),
(17, 'commande', 'ORDER_MODIFY', NULL, 'Customer order modified', 'Executed when a customer order is set modified', 5),
(18, 'commande', 'ORDER_CLASSIFY_BILLED', NULL, 'Customer order classify billed', 'Executed when a customer order is set to billed', 5),
(19, 'commande', 'ORDER_CANCEL', NULL, 'Customer order canceled', 'Executed when a customer order is canceled', 5),
(20, 'commande', 'ORDER_SENTBYMAIL', NULL, 'Customer order sent by mail', 'Executed when a customer order is sent by mail ', 5),
(21, 'commande', 'ORDER_DELETE', NULL, 'Customer order deleted', 'Executed when a customer order is deleted', 5),
(22, 'facture', 'BILL_VALIDATE', NULL, 'Customer invoice validated', 'Executed when a customer invoice is approved', 6),
(23, 'facture', 'BILL_MODIFY', NULL, 'Customer invoice modified', 'Executed when a customer invoice is modified', 7),
(24, 'facture', 'BILL_PAYED', NULL, 'Customer invoice payed', 'Executed when a customer invoice is payed', 7),
(25, 'facture', 'BILL_CANCEL', NULL, 'Customer invoice canceled', 'Executed when a customer invoice is canceled', 8),
(26, 'facture', 'BILL_SENTBYMAIL', NULL, 'Customer invoice sent by mail', 'Executed when a customer invoice is sent by mail', 9),
(27, 'facture', 'BILL_UNVALIDATE', NULL, 'Customer invoice unvalidated', 'Executed when a customer invoice status set back to draft', 9),
(28, 'facture', 'BILL_DELETE', NULL, 'Customer invoice deleted', 'Executed when a customer invoice is deleted', 9),
(29, 'proposal_supplier', 'PROPOSAL_SUPPLIER_VALIDATE', NULL, 'Price request validated', 'Executed when a commercial proposal is validated', 10),
(30, 'proposal_supplier', 'PROPOSAL_SUPPLIER_MODIFY', NULL, 'Price request modified', 'Executed when a commercial proposal is modified', 10),
(31, 'proposal_supplier', 'PROPOSAL_SUPPLIER_SENTBYMAIL', NULL, 'Price request sent by mail', 'Executed when a commercial proposal is sent by mail', 10),
(32, 'proposal_supplier', 'PROPOSAL_SUPPLIER_CLOSE_SIGNED', NULL, 'Price request closed signed', 'Executed when a customer proposal is closed signed', 10),
(33, 'proposal_supplier', 'PROPOSAL_SUPPLIER_CLOSE_REFUSED', NULL, 'Price request closed refused', 'Executed when a customer proposal is closed refused', 10),
(34, 'proposal_supplier', 'PROPOSAL_SUPPLIER_DELETE', NULL, 'Price request deleted', 'Executed when a customer proposal delete', 10),
(35, 'order_supplier', 'ORDER_SUPPLIER_VALIDATE', NULL, 'Purchase order validated', 'Executed when a supplier order is validated', 12),
(36, 'order_supplier', 'ORDER_SUPPLIER_APPROVE', NULL, 'Purchase order request approved', 'Executed when a supplier order is approved', 13),
(37, 'order_supplier', 'ORDER_SUPPLIER_MODIFY', NULL, 'Purchase order request modified', 'Executed when a supplier order is modified', 13),
(38, 'order_supplier', 'ORDER_SUPPLIER_SUBMIT', NULL, 'Purchase order request submited', 'Executed when a supplier order is approved', 13),
(39, 'order_supplier', 'ORDER_SUPPLIER_RECEIVE', NULL, 'Purchase order request received', 'Executed when a supplier order is received', 13),
(40, 'order_supplier', 'ORDER_SUPPLIER_REFUSE', NULL, 'Purchase order request refused', 'Executed when a supplier order is refused', 13),
(41, 'order_supplier', 'ORDER_SUPPLIER_CANCEL', NULL, 'Purchase order request canceled', 'Executed when a supplier order is canceled', 13),
(42, 'order_supplier', 'ORDER_SUPPLIER_SENTBYMAIL', NULL, 'Purchase order sent by mail', 'Executed when a supplier order is sent by mail', 14),
(43, 'order_supplier', 'ORDER_SUPPLIER_CLASSIFY_BILLED', NULL, 'Purchase order set billed', 'Executed when a supplier order is set as billed', 14),
(44, 'order_supplier', 'ORDER_SUPPLIER_DELETE', NULL, 'Purchase order deleted', 'Executed when a supplier order is deleted', 14),
(45, 'invoice_supplier', 'BILL_SUPPLIER_VALIDATE', NULL, 'Supplier invoice validated', 'Executed when a supplier invoice is validated', 15),
(46, 'invoice_supplier', 'BILL_SUPPLIER_MODIFY', NULL, 'Supplier invoice modified', 'Executed when a supplier invoice is modified', 15),
(47, 'invoice_supplier', 'BILL_SUPPLIER_UNVALIDATE', NULL, 'Supplier invoice unvalidated', 'Executed when a supplier invoice status is set back to draft', 15),
(48, 'invoice_supplier', 'BILL_SUPPLIER_PAYED', NULL, 'Supplier invoice payed', 'Executed when a supplier invoice is payed', 16),
(49, 'invoice_supplier', 'BILL_SUPPLIER_SENTBYMAIL', NULL, 'Supplier invoice sent by mail', 'Executed when a supplier invoice is sent by mail', 17),
(50, 'invoice_supplier', 'BILL_SUPPLIER_CANCELED', NULL, 'Supplier invoice cancelled', 'Executed when a supplier invoice is cancelled', 17),
(51, 'invoice_supplier', 'BILL_SUPPLIER_DELETE', NULL, 'Supplier invoice deleted', 'Executed when a supplier invoice is deleted', 17),
(52, 'contrat', 'CONTRACT_VALIDATE', NULL, 'Contract validated', 'Executed when a contract is validated', 18),
(53, 'contrat', 'CONTRACT_MODIFY', NULL, 'Contract modified', 'Executed when a contract is modified', 18),
(54, 'contrat', 'CONTRACT_SENTBYMAIL', NULL, 'Contract sent by mail', 'Executed when a contract is sent by mail', 18),
(55, 'contrat', 'CONTRACT_DELETE', NULL, 'Contract deleted', 'Executed when a contract is deleted', 18),
(56, 'shipping', 'SHIPPING_VALIDATE', NULL, 'Shipping validated', 'Executed when a shipping is validated', 20),
(57, 'shipping', 'SHIPPING_MODIFY', NULL, 'Shipping modified', 'Executed when a shipping is modified', 20),
(58, 'shipping', 'SHIPPING_SENTBYMAIL', NULL, 'Shipping sent by mail', 'Executed when a shipping is sent by mail', 21),
(59, 'shipping', 'SHIPPING_DELETE', NULL, 'Shipping sent is deleted', 'Executed when a shipping is deleted', 21),
(60, 'reception', 'RECEPTION_VALIDATE', NULL, 'Reception validated', 'Executed when a reception is validated', 22),
(61, 'reception', 'RECEPTION_SENTBYMAIL', NULL, 'Reception sent by mail', 'Executed when a reception is sent by mail', 22),
(62, 'member', 'MEMBER_VALIDATE', NULL, 'Member validated', 'Executed when a member is validated', 22),
(63, 'member', 'MEMBER_MODIFY', NULL, 'Member modified', 'Executed when a member is modified', 23),
(64, 'member', 'MEMBER_SENTBYMAIL', NULL, 'Mails sent from member card', 'Executed when you send email from member card', 23),
(65, 'member', 'MEMBER_SUBSCRIPTION_CREATE', NULL, 'Member subscribtion recorded', 'Executed when a member subscribtion is deleted', 24),
(66, 'member', 'MEMBER_SUBSCRIPTION_MODIFY', NULL, 'Member subscribtion modified', 'Executed when a member subscribtion is modified', 24),
(67, 'member', 'MEMBER_SUBSCRIPTION_DELETE', NULL, 'Member subscribtion deleted', 'Executed when a member subscribtion is deleted', 24),
(68, 'member', 'MEMBER_RESILIATE', NULL, 'Member resiliated', 'Executed when a member is resiliated', 25),
(69, 'member', 'MEMBER_DELETE', NULL, 'Member deleted', 'Executed when a member is deleted', 26),
(70, 'member', 'MEMBER_EXCLUDE', NULL, 'Member excluded', 'Executed when a member is excluded', 27),
(71, 'ficheinter', 'FICHINTER_VALIDATE', NULL, 'Intervention validated', 'Executed when a intervention is validated', 30),
(72, 'ficheinter', 'FICHINTER_MODIFY', NULL, 'Intervention modified', 'Executed when a intervention is modify', 30),
(73, 'ficheinter', 'FICHINTER_CLASSIFY_BILLED', NULL, 'Intervention set billed', 'Executed when a intervention is set to billed (when option FICHINTER_CLASSIFY_BILLED is set)', 32),
(74, 'ficheinter', 'FICHINTER_CLASSIFY_UNBILLED', NULL, 'Intervention set unbilled', 'Executed when a intervention is set to unbilled (when option FICHINTER_CLASSIFY_BILLED is set)', 33),
(75, 'ficheinter', 'FICHINTER_REOPEN', NULL, 'Intervention opened', 'Executed when a intervention is re-opened', 34),
(76, 'ficheinter', 'FICHINTER_SENTBYMAIL', NULL, 'Intervention sent by mail', 'Executed when a intervention is sent by mail', 35),
(77, 'ficheinter', 'FICHINTER_DELETE', NULL, 'Intervention is deleted', 'Executed when a intervention is deleted', 35),
(78, 'ficheinter', 'FICHINTER_CLOSE', NULL, 'Intervention is done', 'Executed when a intervention is done', 36),
(79, 'product', 'PRODUCT_CREATE', NULL, 'Product or service created', 'Executed when a product or sevice is created', 40),
(80, 'product', 'PRODUCT_MODIFY', NULL, 'Product or service modified', 'Executed when a product or sevice is modified', 41),
(81, 'product', 'PRODUCT_DELETE', NULL, 'Product or service deleted', 'Executed when a product or sevice is deleted', 42),
(82, 'expensereport', 'EXPENSE_REPORT_CREATE', NULL, 'Expense report created', 'Executed when an expense report is created', 201),
(83, 'expensereport', 'EXPENSE_REPORT_VALIDATE', NULL, 'Expense report validated', 'Executed when an expense report is validated', 202),
(84, 'expensereport', 'EXPENSE_REPORT_MODIFY', NULL, 'Expense report modified', 'Executed when an expense report is modified', 202),
(85, 'expensereport', 'EXPENSE_REPORT_APPROVE', NULL, 'Expense report approved', 'Executed when an expense report is approved', 203),
(86, 'expensereport', 'EXPENSE_REPORT_PAID', NULL, 'Expense report billed', 'Executed when an expense report is set as billed', 204),
(87, 'expensereport', 'EXPENSE_REPORT_DELETE', NULL, 'Expense report deleted', 'Executed when an expense report is deleted', 205),
(88, 'project', 'PROJECT_CREATE', NULL, 'Project creation', 'Executed when a project is created', 140),
(89, 'project', 'PROJECT_VALIDATE', NULL, 'Project validation', 'Executed when a project is validated', 141),
(90, 'project', 'PROJECT_MODIFY', NULL, 'Project modified', 'Executed when a project is modified', 142),
(91, 'project', 'PROJECT_DELETE', NULL, 'Project deleted', 'Executed when a project is deleted', 143),
(92, 'project', 'PROJECT_SENTBYMAIL', NULL, 'Project sent by mail', 'Executed when a project is sent by email', 144),
(93, 'project', 'PROJECT_CLOSE', NULL, 'Project closed', 'Executed when a project is closed', 145),
(94, 'ticket', 'TICKET_CREATE', NULL, 'Ticket created', 'Executed when a ticket is created', 161),
(95, 'ticket', 'TICKET_MODIFY', NULL, 'Ticket modified', 'Executed when a ticket is modified', 163),
(96, 'ticket', 'TICKET_ASSIGNED', NULL, 'Ticket assigned', 'Executed when a ticket is modified', 164),
(97, 'ticket', 'TICKET_CLOSE', NULL, 'Ticket closed', 'Executed when a ticket is closed', 165),
(98, 'ticket', 'TICKET_SENTBYMAIL', NULL, 'Ticket message sent by email', 'Executed when a message is sent from the ticket record', 166),
(99, 'ticket', 'TICKET_DELETE', NULL, 'Ticket deleted', 'Executed when a ticket is deleted', 167),
(100, 'user', 'USER_SENTBYMAIL', NULL, 'Email sent', 'Executed when an email is sent from user card', 300),
(101, 'user', 'USER_CREATE', NULL, 'User created', 'Executed when a user is created', 301),
(102, 'user', 'USER_MODIFY', NULL, 'User update', 'Executed when a user is updated', 302),
(103, 'user', 'USER_DELETE', NULL, 'User update', 'Executed when a user is deleted', 303),
(104, 'user', 'USER_NEW_PASSWORD', NULL, 'User update', 'Executed when a user is change password', 304),
(105, 'user', 'USER_ENABLEDISABLE', NULL, 'User update', 'Executed when a user is enable or disable', 305),
(106, 'bom', 'BOM_VALIDATE', NULL, 'BOM validated', 'Executed when a BOM is validated', 650),
(107, 'bom', 'BOM_UNVALIDATE', NULL, 'BOM unvalidated', 'Executed when a BOM is unvalidated', 651),
(108, 'bom', 'BOM_CLOSE', NULL, 'BOM disabled', 'Executed when a BOM is disabled', 652),
(109, 'bom', 'BOM_REOPEN', NULL, 'BOM reopen', 'Executed when a BOM is re-open', 653),
(110, 'bom', 'BOM_DELETE', NULL, 'BOM deleted', 'Executed when a BOM deleted', 654),
(111, 'mrp', 'MRP_MO_VALIDATE', NULL, 'MO validated', 'Executed when a MO is validated', 660),
(112, 'mrp', 'MRP_MO_PRODUCED', NULL, 'MO produced', 'Executed when a MO is produced', 661),
(113, 'mrp', 'MRP_MO_DELETE', NULL, 'MO deleted', 'Executed when a MO is deleted', 662),
(114, 'mrp', 'MRP_MO_CANCEL', NULL, 'MO canceled', 'Executed when a MO is canceled', 663),
(115, 'contact', 'CONTACT_CREATE', NULL, 'Contact address created', 'Executed when a contact is created', 50),
(116, 'contact', 'CONTACT_MODIFY', NULL, 'Contact address update', 'Executed when a contact is updated', 51),
(117, 'contact', 'CONTACT_SENTBYMAIL', NULL, 'Mails sent from third party card', 'Executed when you send email from contact address record', 52),
(118, 'contact', 'CONTACT_DELETE', NULL, 'Contact address deleted', 'Executed when a contact is deleted', 53),
(119, 'recruitment', 'RECRUITMENTJOBPOSITION_CREATE', NULL, 'Job created', 'Executed when a job is created', 7500),
(120, 'recruitment', 'RECRUITMENTJOBPOSITION_MODIFY', NULL, 'Job modified', 'Executed when a job is modified', 7502),
(121, 'recruitment', 'RECRUITMENTJOBPOSITION_SENTBYMAIL', NULL, 'Mails sent from job record', 'Executed when you send email from job record', 7504),
(122, 'recruitment', 'RECRUITMENTJOBPOSITION_DELETE', NULL, 'Job deleted', 'Executed when a job is deleted', 7506),
(123, 'recruitment', 'RECRUITMENTCANDIDATURE_CREATE', NULL, 'Candidature created', 'Executed when a candidature is created', 7510),
(124, 'recruitment', 'RECRUITMENTCANDIDATURE_MODIFY', NULL, 'Candidature modified', 'Executed when a candidature is modified', 7512),
(125, 'recruitment', 'RECRUITMENTCANDIDATURE_SENTBYMAIL', NULL, 'Mails sent from candidature record', 'Executed when you send email from candidature record', 7514),
(126, 'recruitment', 'RECRUITMENTCANDIDATURE_DELETE', NULL, 'Candidature deleted', 'Executed when a candidature is deleted', 7516),
(127, 'project', 'TASK_CREATE', NULL, 'Task created', 'Executed when a project task is created', 150),
(128, 'project', 'TASK_MODIFY', NULL, 'Task modified', 'Executed when a project task is modified', 151),
(129, 'project', 'TASK_DELETE', NULL, 'Task deleted', 'Executed when a project task is deleted', 152),
(130, 'agenda', 'ACTION_CREATE', NULL, 'Action added', 'Executed when an action is added to the agenda', 700),
(131, 'holiday', 'HOLIDAY_CREATE', NULL, 'Holiday created', 'Executed when a holiday is created', 800),
(132, 'holiday', 'HOLIDAY_MODIFY', NULL, 'Holiday modified', 'Executed when a holiday is modified', 801),
(133, 'holiday', 'HOLIDAY_VALIDATE', NULL, 'Holiday validated', 'Executed when a holiday is validated', 802),
(134, 'holiday', 'HOLIDAY_APPROVE', NULL, 'Holiday approved', 'Executed when a holiday is aprouved', 803),
(135, 'holiday', 'HOLIDAY_CANCEL', NULL, 'Holiday canceled', 'Executed when a holiday is canceled', 802),
(136, 'holiday', 'HOLIDAY_DELETE', NULL, 'Holiday deleted', 'Executed when a holiday is deleted', 804),
(137, 'hrm', 'HRM_EVALUATION_CREATE', NULL, 'HR Evaluation created', 'Executed when an evaluation is created', 4000),
(138, 'hrm', 'HRM_EVALUATION_MODIFY', NULL, 'HR Evaluation modified', 'Executed when an evaluation is modified', 4001),
(139, 'hrm', 'HRM_EVALUATION_VALIDATE', NULL, 'HR Evaluation validated', 'Executed when an evaluation is validated', 4002),
(140, 'hrm', 'HRM_EVALUATION_UNVALIDATE', NULL, 'HR Evaluation back to draft', 'Executed when an evaluation is back to draft', 4003),
(141, 'hrm', 'HRM_EVALUATION_DELETE', NULL, 'HR Evaluation deleted', 'Executed when an evaluation is dleted', 4005),
(142, 'facturerec', 'BILLREC_CREATE', NULL, 'Template invoices created', 'Executed when a Template invoices is created', 900),
(143, 'facturerec', 'BILLREC_MODIFY', NULL, 'Template invoices update', 'Executed when a Template invoices is updated', 901),
(144, 'facturerec', 'BILLREC_DELETE', NULL, 'Template invoices deleted', 'Executed when a Template invoices is deleted', 902),
(145, 'partnership', 'PARTNERSHIP_CREATE', NULL, 'Partnership created', 'Executed when a partnership is created', 58000),
(146, 'partnership', 'PARTNERSHIP_MODIFY', NULL, 'Partnership modified', 'Executed when a partnership is modified', 58002),
(147, 'partnership', 'PARTNERSHIP_SENTBYMAIL', NULL, 'Mails sent from partnership file', 'Executed when you send email from partnership file', 58004),
(148, 'partnership', 'PARTNERSHIP_DELETE', NULL, 'Partnership deleted', 'Executed when a partnership is deleted', 58006),
(149, 'knowledgemanagement', 'KNOWLEDGERECORD_CREATE', NULL, 'Knowledgerecord created', 'Executed when a knowledgerecord is created', 57001),
(150, 'knowledgemanagement', 'KNOWLEDGERECORD_MODIFY', NULL, 'Knowledgerecord modified', 'Executed when a knowledgerecord is modified', 57002),
(151, 'knowledgemanagement', 'KNOWLEDGERECORD_VALIDATE', NULL, 'Knowledgerecord Evaluation validated', 'Executed when an evaluation is validated', 57004),
(152, 'knowledgemanagement', 'KNOWLEDGERECORD_REOPEN', NULL, 'Knowledgerecord reopen', 'Executed when an evaluation is back to draft', 57004),
(153, 'knowledgemanagement', 'KNOWLEDGERECORD_UNVALIDATE', NULL, 'Knowledgerecord unvalidated', 'Executed when an evaluation is back to draft', 57004),
(154, 'knowledgemanagement', 'KNOWLEDGERECORD_CANCEL', NULL, 'Knowledgerecord cancel', 'Executed when an evaluation to cancel', 57004),
(155, 'knowledgemanagement', 'KNOWLEDGERECORD_SENTBYMAIL', NULL, 'Mails sent from knowledgerecord file', 'knowledgerecord when you send email from knowledgerecord file', 57004),
(156, 'knowledgemanagement', 'KNOWLEDGERECORD_DELETE', NULL, 'Knowledgerecord deleted', 'Executed when a knowledgerecord is deleted', 57006);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_availability`
--

CREATE TABLE `llx_c_availability` (
  `rowid` int(11) NOT NULL,
  `code` varchar(30) NOT NULL,
  `label` varchar(128) NOT NULL,
  `type_duration` varchar(1) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `position` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_availability`
--

INSERT INTO `llx_c_availability` (`rowid`, `code`, `label`, `type_duration`, `qty`, `active`, `position`) VALUES
(1, 'AV_NOW', 'Immediate', NULL, 0, 1, 10),
(2, 'AV_1D', '1 day', 'd', 1, 1, 11),
(3, 'AV_2D', '2 days', 'd', 2, 1, 12),
(4, 'AV_3D', '3 days', 'd', 3, 1, 13),
(5, 'AV_4D', '4 days', 'd', 4, 1, 14),
(6, 'AV_5D', '5 days', 'd', 5, 1, 15),
(7, 'AV_1W', '1 week', 'w', 1, 1, 20),
(8, 'AV_2W', '2 weeks', 'w', 2, 1, 30),
(9, 'AV_3W', '3 weeks', 'w', 3, 1, 40),
(10, 'AV_4W', '4 weeks', 'w', 4, 1, 50),
(11, 'AV_5W', '5 weeks', 'w', 5, 1, 60),
(12, 'AV_6W', '6 weeks', 'w', 6, 1, 70),
(13, 'AV_8W', '8 weeks', 'w', 8, 1, 80),
(14, 'AV_10W', '10 weeks', 'w', 10, 1, 90),
(15, 'AV_12W', '12 weeks', 'w', 12, 1, 100),
(16, 'AV_14W', '14 weeks', 'w', 14, 1, 110),
(17, 'AV_16W', '16 weeks', 'w', 16, 1, 120);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_barcode_type`
--

CREATE TABLE `llx_c_barcode_type` (
  `rowid` int(11) NOT NULL,
  `code` varchar(16) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `libelle` varchar(128) NOT NULL,
  `coder` varchar(16) NOT NULL,
  `example` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_chargesociales`
--

CREATE TABLE `llx_c_chargesociales` (
  `id` int(11) NOT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `deductible` smallint(6) NOT NULL DEFAULT 0,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `code` varchar(24) NOT NULL,
  `accountancy_code` varchar(32) DEFAULT NULL,
  `fk_pays` int(11) NOT NULL DEFAULT 1,
  `module` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_chargesociales`
--

INSERT INTO `llx_c_chargesociales` (`id`, `libelle`, `deductible`, `active`, `code`, `accountancy_code`, `fk_pays`, `module`) VALUES
(1, 'Securite sociale (URSSAF / MSA)', 1, 1, 'TAXSECU', NULL, 1, NULL),
(2, 'Securite sociale des indépendants (URSSAF)', 1, 1, 'TAXSSI', NULL, 1, NULL),
(10, 'Taxe apprentissage', 1, 1, 'TAXAPP', NULL, 1, NULL),
(11, 'Formation professionnelle continue', 1, 1, 'TAXFPC', NULL, 1, NULL),
(12, 'Cotisation fonciere des entreprises (CFE)', 1, 1, 'TAXCFE', NULL, 1, NULL),
(13, 'Cotisation sur la valeur ajoutee des entreprises (CVAE)', 1, 1, 'TAXCVAE', NULL, 1, NULL),
(20, 'Taxe fonciere', 1, 1, 'TAXFON', NULL, 1, NULL),
(25, 'Prelevement à la source (PAS)', 0, 1, 'TAXPAS', NULL, 1, NULL),
(30, 'Prevoyance', 1, 1, 'TAXPREV', NULL, 1, NULL),
(40, 'Mutuelle', 1, 1, 'TAXMUT', NULL, 1, NULL),
(50, 'Retraite', 1, 1, 'TAXRET', NULL, 1, NULL),
(60, 'Taxe sur vehicule societe (TVS)', 0, 1, 'TAXTVS', NULL, 1, NULL),
(70, 'impôts sur les sociétés (IS)', 0, 1, 'TAXIS', NULL, 1, NULL),
(201, 'ONSS', 1, 1, 'TAXBEONSS', NULL, 2, NULL),
(210, 'Precompte professionnel', 1, 1, 'TAXBEPREPRO', NULL, 2, NULL),
(220, 'Prime existence', 1, 1, 'TAXBEPRIEXI', NULL, 2, NULL),
(230, 'Precompte immobilier', 1, 1, 'TAXBEPREIMMO', NULL, 2, NULL),
(4101, 'Krankenversicherung', 1, 1, 'TAXATKV', NULL, 41, NULL),
(4102, 'Unfallversicherung', 1, 1, 'TAXATUV', NULL, 41, NULL),
(4103, 'Pensionsversicherung', 1, 1, 'TAXATPV', NULL, 41, NULL),
(4104, 'Arbeitslosenversicherung', 1, 1, 'TAXATAV', NULL, 41, NULL),
(4105, 'Insolvenzentgeltsicherungsfond', 1, 1, 'TAXATIESG', NULL, 41, NULL),
(4106, 'Wohnbauförderung', 1, 1, 'TAXATWF', NULL, 41, NULL),
(4107, 'Arbeiterkammerumlage', 1, 1, 'TAXATAK', NULL, 41, NULL),
(4108, 'Mitarbeitervorsorgekasse', 1, 1, 'TAXATMVK', NULL, 41, NULL),
(4109, 'Familienlastenausgleichsfond', 1, 1, 'TAXATFLAF', NULL, 41, NULL),
(10201, 'Αναλυτική Περιοδική Δήλωση (ΑΠΔ)', 1, 1, 'ΑΠΔ', NULL, 102, NULL),
(10202, 'Φόρος Μισθωτών Υπηρεσιών (ΦΜΥ)', 1, 1, 'ΦΜΥ', NULL, 102, NULL),
(10203, 'Ασφαλιστικές εισφορές (ΕΦΚΑ)', 1, 1, 'ΕΦΚΑ', NULL, 102, NULL),
(10204, 'Προκαταβολή Φόρου Εισοδήματος', 0, 1, 'ΕΦΟΡΙΑ', NULL, 102, NULL),
(10205, 'Ενιαίος Φόρος Ιδιοκτησίας Ακινήτων (ΕΝ.Φ.Ι.Α) ', 0, 1, 'ΕΝΦΙΑ', NULL, 102, NULL),
(10206, 'Ετήσιο τέλος διατήρησης Μερίδας στο Γ.Ε.ΜΗ.', 1, 1, 'ΓΕΜΗ', NULL, 102, NULL),
(10207, 'Επαγγελματικό Επιμελητήριο', 1, 1, 'ΕΕ', NULL, 102, NULL),
(10208, 'Εμπορικό και Βιομηχανικό Επιμελητηρίο', 1, 1, 'ΕΒΕ', NULL, 102, NULL),
(10209, 'Τέλη Κυκλοφορίας', 1, 1, 'ΤΕΛΗ', NULL, 102, NULL),
(10210, 'Ασφάλιση οχήματος', 1, 1, 'ΑΣΦΑΛΕΙΑ', NULL, 102, NULL),
(10211, 'Ενοίκιο', 1, 1, 'ΕΝΟΙΚΙΟ', NULL, 102, NULL),
(10212, 'Κοινόχρηστα', 1, 1, 'ΚΟΙΝΟ', NULL, 102, NULL),
(10213, 'Ηλεκτροδότηση', 1, 1, 'ΡΕΥΜΑ', NULL, 102, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_civility`
--

CREATE TABLE `llx_c_civility` (
  `rowid` int(11) NOT NULL,
  `code` varchar(6) NOT NULL,
  `label` varchar(128) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `module` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_civility`
--

INSERT INTO `llx_c_civility` (`rowid`, `code`, `label`, `active`, `module`) VALUES
(1, 'MME', 'Madame', 1, NULL),
(2, 'MR', 'Monsieur', 1, NULL),
(3, 'MLE', 'Mademoiselle', 1, NULL),
(4, 'MTRE', 'Maître', 1, NULL),
(5, 'DR', 'Docteur', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_country`
--

CREATE TABLE `llx_c_country` (
  `rowid` int(11) NOT NULL,
  `code` varchar(2) NOT NULL,
  `code_iso` varchar(3) DEFAULT NULL,
  `numeric_code` varchar(3) DEFAULT NULL,
  `label` varchar(128) NOT NULL,
  `eec` tinyint(4) NOT NULL DEFAULT 0,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `favorite` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_country`
--

INSERT INTO `llx_c_country` (`rowid`, `code`, `code_iso`, `numeric_code`, `label`, `eec`, `active`, `favorite`) VALUES
(0, '', NULL, NULL, '-', 0, 1, 1),
(1, 'FR', 'FRA', '250', 'France', 1, 1, 0),
(2, 'BE', 'BEL', '056', 'Belgium', 1, 1, 0),
(3, 'IT', 'ITA', '380', 'Italy', 1, 1, 0),
(4, 'ES', 'ESP', '724', 'Spain', 1, 1, 0),
(5, 'DE', 'DEU', '276', 'Germany', 1, 1, 0),
(6, 'CH', 'CHE', '756', 'Switzerland', 0, 1, 0),
(7, 'GB', 'GBR', '826', 'United Kingdom', 0, 1, 0),
(8, 'IE', 'IRL', '372', 'Ireland', 1, 1, 0),
(9, 'CN', 'CHN', '156', 'China', 0, 1, 0),
(10, 'TN', 'TUN', '788', 'Tunisia', 0, 1, 0),
(11, 'US', 'USA', '840', 'United States', 0, 1, 0),
(12, 'MA', 'MAR', '504', 'Morocco', 0, 1, 0),
(13, 'DZ', 'DZA', '012', 'Algeria', 0, 1, 0),
(14, 'CA', 'CAN', '124', 'Canada', 0, 1, 0),
(15, 'TG', 'TGO', '768', 'Togo', 0, 1, 0),
(16, 'GA', 'GAB', '266', 'Gabon', 0, 1, 0),
(17, 'NL', 'NLD', '528', 'Netherlands', 1, 1, 0),
(18, 'HU', 'HUN', '348', 'Hungary', 1, 1, 0),
(19, 'RU', 'RUS', '643', 'Russia', 0, 1, 0),
(20, 'SE', 'SWE', '752', 'Sweden', 1, 1, 0),
(21, 'CI', 'CIV', '384', 'Côte d\'Ivoire', 0, 1, 0),
(22, 'SN', 'SEN', '686', 'Senegal', 0, 1, 0),
(23, 'AR', 'ARG', '032', 'Argentina', 0, 1, 0),
(24, 'CM', 'CMR', '120', 'Cameroun', 0, 1, 0),
(25, 'PT', 'PRT', '620', 'Portugal', 1, 1, 0),
(26, 'SA', 'SAU', '682', 'Saudi Arabia', 0, 1, 0),
(27, 'MC', 'MCO', '492', 'Monaco', 1, 1, 0),
(28, 'AU', 'AUS', '036', 'Australia', 0, 1, 0),
(29, 'SG', 'SGP', '702', 'Singapore', 0, 1, 0),
(30, 'AF', 'AFG', '004', 'Afghanistan', 0, 1, 0),
(31, 'AX', 'ALA', '248', 'Åland Island', 0, 1, 0),
(32, 'AL', 'ALB', '008', 'Albania', 0, 1, 0),
(33, 'AS', 'ASM', '016', 'American Samoa', 0, 1, 0),
(34, 'AD', 'AND', '020', 'Andorra', 0, 1, 0),
(35, 'AO', 'AGO', '024', 'Angola', 0, 1, 0),
(36, 'AI', 'AIA', '660', 'Anguilla', 0, 1, 0),
(37, 'AQ', 'ATA', '010', 'Antarctica', 0, 1, 0),
(38, 'AG', 'ATG', '028', 'Antigua and Barbuda', 0, 1, 0),
(39, 'AM', 'ARM', '051', 'Armenia', 0, 1, 0),
(40, 'AW', 'ABW', '533', 'Aruba', 0, 1, 0),
(41, 'AT', 'AUT', '040', 'Austria', 1, 1, 0),
(42, 'AZ', 'AZE', '031', 'Azerbaijan', 0, 1, 0),
(43, 'BS', 'BHS', '044', 'Bahamas', 0, 1, 0),
(44, 'BH', 'BHR', '048', 'Bahrain', 0, 1, 0),
(45, 'BD', 'BGD', '050', 'Bangladesh', 0, 1, 0),
(46, 'BB', 'BRB', '052', 'Barbados', 0, 1, 0),
(47, 'BY', 'BLR', '112', 'Belarus', 0, 1, 0),
(48, 'BZ', 'BLZ', '084', 'Belize', 0, 1, 0),
(49, 'BJ', 'BEN', '204', 'Benin', 0, 1, 0),
(50, 'BM', 'BMU', '060', 'Bermuda', 0, 1, 0),
(51, 'BT', 'BTN', '064', 'Bhutan', 0, 1, 0),
(52, 'BO', 'BOL', '068', 'Bolivia', 0, 1, 0),
(53, 'BA', 'BIH', '070', 'Bosnia and Herzegovina', 0, 1, 0),
(54, 'BW', 'BWA', '072', 'Botswana', 0, 1, 0),
(55, 'BV', 'BVT', '074', 'Bouvet Island', 0, 0, 0),
(56, 'BR', 'BRA', '076', 'Brazil', 0, 1, 0),
(57, 'IO', 'IOT', '086', 'British Indian Ocean Territory', 0, 1, 0),
(58, 'BN', 'BRN', '096', 'Brunei', 0, 1, 0),
(59, 'BG', 'BGR', '100', 'Bulgaria', 1, 1, 0),
(60, 'BF', 'BFA', '854', 'Burkina Faso', 0, 1, 0),
(61, 'BI', 'BDI', '108', 'Burundi', 0, 1, 0),
(62, 'KH', 'KHM', '116', 'Cambodge / Cambodia', 0, 1, 0),
(63, 'CV', 'CPV', '132', 'Cap-Vert', 0, 1, 0),
(64, 'KY', 'CYM', '136', 'Iles Cayman', 0, 1, 0),
(65, 'CF', 'CAF', '140', 'Central African Republic (CAR/RCA)', 0, 1, 0),
(66, 'TD', 'TCD', '148', 'Tchad', 0, 1, 0),
(67, 'CL', 'CHL', '152', 'Chile', 0, 1, 0),
(68, 'CX', 'CXR', '162', 'Ile Christmas', 0, 1, 0),
(69, 'CC', 'CCK', '166', 'Iles des Cocos (Keeling)', 0, 1, 0),
(70, 'CO', 'COL', '170', 'Colombie', 0, 1, 0),
(71, 'KM', 'COM', '174', 'Comores', 0, 1, 0),
(72, 'CG', 'COG', '178', 'Congo', 0, 1, 0),
(73, 'CD', 'COD', '180', 'DR Congo (RDC)', 0, 1, 0),
(74, 'CK', 'COK', '184', 'Iles Cook', 0, 1, 0),
(75, 'CR', 'CRI', '188', 'Costa Rica', 0, 1, 0),
(76, 'HR', 'HRV', '191', 'Croatia', 1, 1, 0),
(77, 'CU', 'CUB', '192', 'Cuba', 0, 1, 0),
(78, 'CY', 'CYP', '196', 'Cyprus', 1, 1, 0),
(79, 'CZ', 'CZE', '203', 'Czech Republic', 1, 1, 0),
(80, 'DK', 'DNK', '208', 'Denmark', 1, 1, 0),
(81, 'DJ', 'DJI', '262', 'Djibouti', 0, 1, 0),
(82, 'DM', 'DMA', '212', 'Dominica', 0, 1, 0),
(83, 'DO', 'DOM', '214', 'Dominican Republic', 0, 1, 0),
(84, 'EC', 'ECU', '218', 'Republic of Ecuador', 0, 1, 0),
(85, 'EG', 'EGY', '818', 'Egypt', 0, 1, 0),
(86, 'SV', 'SLV', '222', 'El Salvador', 0, 1, 0),
(87, 'GQ', 'GNQ', '226', 'Equatorial Guinea', 0, 1, 0),
(88, 'ER', 'ERI', '232', 'Eritrea', 0, 1, 0),
(89, 'EE', 'EST', '233', 'Estonia', 1, 1, 0),
(90, 'ET', 'ETH', '231', 'Ethiopia', 0, 1, 0),
(91, 'FK', 'FLK', '238', 'Falkland Islands', 0, 1, 0),
(92, 'FO', 'FRO', '234', 'Faroe Islands', 0, 1, 0),
(93, 'FJ', 'FJI', '242', 'Fidji Islands', 0, 1, 0),
(94, 'FI', 'FIN', '246', 'Finland', 1, 1, 0),
(95, 'GF', 'GUF', '254', 'French Guiana', 0, 1, 0),
(96, 'PF', 'PYF', '258', 'French Polynesia', 0, 1, 0),
(97, 'TF', 'ATF', '260', 'Terres australes françaises', 0, 1, 0),
(98, 'GM', 'GMB', '270', 'Gambie', 0, 1, 0),
(99, 'GE', 'GEO', '268', 'Georgia', 0, 1, 0),
(100, 'GH', 'GHA', '288', 'Ghana', 0, 1, 0),
(101, 'GI', 'GIB', '292', 'Gibraltar', 0, 1, 0),
(102, 'GR', 'GRC', '300', 'Greece', 1, 1, 0),
(103, 'GL', 'GRL', '304', 'Groenland', 0, 1, 0),
(104, 'GD', 'GRD', '308', 'Grenade', 0, 1, 0),
(106, 'GU', 'GUM', '316', 'Guam', 0, 1, 0),
(107, 'GT', 'GTM', '320', 'Guatemala', 0, 1, 0),
(108, 'GN', 'GIN', '324', 'Guinea', 0, 1, 0),
(109, 'GW', 'GNB', '624', 'Guinea-Bissao', 0, 1, 0),
(111, 'HT', 'HTI', '332', 'Haiti', 0, 1, 0),
(112, 'HM', 'HMD', '334', 'Iles Heard et McDonald', 0, 1, 0),
(113, 'VA', 'VAT', '336', 'Vatican City (Saint-Siège)', 0, 1, 0),
(114, 'HN', 'HND', '340', 'Honduras', 0, 1, 0),
(115, 'HK', 'HKG', '344', 'Hong Kong', 0, 1, 0),
(116, 'IS', 'ISL', '352', 'Islande', 0, 1, 0),
(117, 'IN', 'IND', '356', 'India', 0, 1, 0),
(118, 'ID', 'IDN', '360', 'Indonesia', 0, 1, 0),
(119, 'IR', 'IRN', '364', 'Iran', 0, 1, 0),
(120, 'IQ', 'IRQ', '368', 'Iraq', 0, 1, 0),
(121, 'IL', 'ISR', '376', 'Israel', 0, 1, 0),
(122, 'JM', 'JAM', '388', 'Jamaica', 0, 1, 0),
(123, 'JP', 'JPN', '392', 'Japan (Nippon)', 0, 1, 0),
(124, 'JO', 'JOR', '400', 'Jordanie', 0, 1, 0),
(125, 'KZ', 'KAZ', '398', 'Kazakhstan', 0, 1, 0),
(126, 'KE', 'KEN', '404', 'Kenya', 0, 1, 0),
(127, 'KI', 'KIR', '296', 'Kiribati', 0, 1, 0),
(128, 'KP', 'PRK', '408', 'North Corea', 0, 1, 0),
(129, 'KR', 'KOR', '410', 'South Corea', 0, 1, 0),
(130, 'KW', 'KWT', '414', 'Koweït', 0, 1, 0),
(131, 'KG', 'KGZ', '417', 'Kirghizistan', 0, 1, 0),
(132, 'LA', 'LAO', '418', 'Laos', 0, 1, 0),
(133, 'LV', 'LVA', '428', 'Lettonie', 1, 1, 0),
(134, 'LB', 'LBN', '422', 'Liban', 0, 1, 0),
(135, 'LS', 'LSO', '426', 'Lesotho', 0, 1, 0),
(136, 'LR', 'LBR', '430', 'Liberia', 0, 1, 0),
(137, 'LY', 'LBY', '434', 'Libye', 0, 1, 0),
(138, 'LI', 'LIE', '438', 'Liechtenstein', 0, 1, 0),
(139, 'LT', 'LTU', '440', 'Lituanie', 1, 1, 0),
(140, 'LU', 'LUX', '442', 'Luxembourg', 1, 1, 0),
(141, 'MO', 'MAC', '446', 'Macao', 0, 1, 0),
(142, 'MK', 'MKD', '807', 'North Macedonia', 0, 1, 0),
(143, 'MG', 'MDG', '450', 'Madagascar', 0, 1, 0),
(144, 'MW', 'MWI', '454', 'Malawi', 0, 1, 0),
(145, 'MY', 'MYS', '458', 'Malaisie', 0, 1, 0),
(146, 'MV', 'MDV', '462', 'Maldives', 0, 1, 0),
(147, 'ML', 'MLI', '466', 'Mali', 0, 1, 0),
(148, 'MT', 'MLT', '470', 'Malte', 1, 1, 0),
(149, 'MH', 'MHL', '584', 'Iles Marshall', 0, 1, 0),
(151, 'MR', 'MRT', '478', 'Mauritanie', 0, 1, 0),
(152, 'MU', 'MUS', '480', 'Maurice', 0, 1, 0),
(153, 'YT', 'MYT', '175', 'Mayotte', 0, 1, 0),
(154, 'MX', 'MEX', '484', 'Mexique', 0, 1, 0),
(155, 'FM', 'FSM', '583', 'Micronésie', 0, 1, 0),
(156, 'MD', 'MDA', '498', 'Moldavie', 0, 1, 0),
(157, 'MN', 'MNG', '496', 'Mongolie', 0, 1, 0),
(158, 'MS', 'MSR', '500', 'Monserrat', 0, 1, 0),
(159, 'MZ', 'MOZ', '508', 'Mozambique', 0, 1, 0),
(160, 'MM', 'MMR', '104', 'Birmanie (Myanmar)', 0, 1, 0),
(161, 'NA', 'NAM', '516', 'Namibie', 0, 1, 0),
(162, 'NR', 'NRU', '520', 'Nauru', 0, 1, 0),
(163, 'NP', 'NPL', '524', 'Népal', 0, 1, 0),
(165, 'NC', 'NCL', '540', 'New Caledonia', 0, 1, 0),
(166, 'NZ', 'NZL', '554', 'New Zealand', 0, 1, 0),
(167, 'NI', 'NIC', '558', 'Nicaragua', 0, 1, 0),
(168, 'NE', 'NER', '562', 'Niger', 0, 1, 0),
(169, 'NG', 'NGA', '566', 'Nigeria', 0, 1, 0),
(170, 'NU', 'NIU', '570', 'Niue', 0, 1, 0),
(171, 'NF', 'NFK', '574', 'Norfolk Island', 0, 1, 0),
(172, 'MP', 'MNP', '580', 'Northern Mariana Islands', 0, 1, 0),
(173, 'NO', 'NOR', '578', 'Norway', 0, 1, 0),
(174, 'OM', 'OMN', '512', 'Oman', 0, 1, 0),
(175, 'PK', 'PAK', '586', 'Pakistan', 0, 1, 0),
(176, 'PW', 'PLW', '585', 'Palau', 0, 1, 0),
(177, 'PS', 'PSE', '275', 'Palestinian territories', 0, 1, 0),
(178, 'PA', 'PAN', '591', 'Panama', 0, 1, 0),
(179, 'PG', 'PNG', '598', 'Papua New Guinea', 0, 1, 0),
(180, 'PY', 'PRY', '600', 'Paraguay', 0, 1, 0),
(181, 'PE', 'PER', '604', 'Peru', 0, 1, 0),
(182, 'PH', 'PHL', '608', 'Philippines', 0, 1, 0),
(183, 'PN', 'PCN', '612', 'Pitcairn Islands', 0, 1, 0),
(184, 'PL', 'POL', '616', 'Pologne', 1, 1, 0),
(185, 'PR', 'PRI', '630', 'Puerto Rico', 0, 1, 0),
(186, 'QA', 'QAT', '634', 'Qatar', 0, 1, 0),
(188, 'RO', 'ROU', '642', 'Romania', 1, 1, 0),
(189, 'RW', 'RWA', '646', 'Rwanda', 0, 1, 0),
(190, 'SH', 'SHN', '654', 'Saint Helena', 0, 1, 0),
(191, 'KN', 'KNA', '659', 'Saint Kitts and Nevis', 0, 1, 0),
(192, 'LC', 'LCA', '662', 'Saint Lucia', 0, 1, 0),
(193, 'PM', 'SPM', '666', 'Saint Pierre and Miquelon', 0, 1, 0),
(194, 'VC', 'VCT', '670', 'Saint Vincent and the Grenadines', 0, 1, 0),
(195, 'WS', 'WSM', '882', 'Samoa', 0, 1, 0),
(196, 'SM', 'SMR', '674', 'San Marino ', 0, 1, 0),
(197, 'ST', 'STP', '678', 'Saint Thomas and Prince', 0, 1, 0),
(198, 'RS', 'SRB', '688', 'Serbia', 0, 1, 0),
(199, 'SC', 'SYC', '690', 'Seychelles', 0, 1, 0),
(200, 'SL', 'SLE', '694', 'Sierra Leone', 0, 1, 0),
(201, 'SK', 'SVK', '703', 'Slovakia', 1, 1, 0),
(202, 'SI', 'SVN', '705', 'Slovenia', 1, 1, 0),
(203, 'SB', 'SLB', '090', 'Solomon Islands', 0, 1, 0),
(204, 'SO', 'SOM', '706', 'Somalia', 0, 1, 0),
(205, 'ZA', 'ZAF', '710', 'South Africa', 0, 1, 0),
(206, 'GS', 'SGS', '239', 'South Georgia and the South Sandwich Islands ', 0, 1, 0),
(207, 'LK', 'LKA', '144', 'Sri Lanka', 0, 1, 0),
(208, 'SD', 'SDN', '729', 'Sudan', 0, 1, 0),
(209, 'SR', 'SUR', '740', 'Suriname', 0, 1, 0),
(210, 'SJ', 'SJM', '744', 'Svalbard and Jan Mayen', 0, 1, 0),
(211, 'SZ', 'SWZ', '748', 'Swaziland / Eswatini', 0, 1, 0),
(212, 'SY', 'SYR', '760', 'Syria', 0, 1, 0),
(213, 'TW', 'TWN', '158', 'Taiwan', 0, 1, 0),
(214, 'TJ', 'TJK', '762', 'Tajikistan', 0, 1, 0),
(215, 'TZ', 'TZA', '834', 'Tanzania', 0, 1, 0),
(216, 'TH', 'THA', '764', 'Thailand', 0, 1, 0),
(217, 'TL', 'TLS', '626', 'Timor-Leste', 0, 1, 0),
(218, 'TK', 'TKL', '772', 'Tokelau', 0, 1, 0),
(219, 'TO', 'TON', '776', 'Tonga', 0, 1, 0),
(220, 'TT', 'TTO', '780', 'Trinidad and Tobago', 0, 1, 0),
(221, 'TR', 'TUR', '792', 'Turkey', 0, 1, 0),
(222, 'TM', 'TKM', '795', 'Turkmenistan', 0, 1, 0),
(223, 'TC', 'TCA', '796', 'Turks and Caicos Islands', 0, 1, 0),
(224, 'TV', 'TUV', '798', 'Tuvalu', 0, 1, 0),
(225, 'UG', 'UGA', '800', 'Uganda', 0, 1, 0),
(226, 'UA', 'UKR', '804', 'Ukraine', 0, 1, 0),
(227, 'AE', 'ARE', '784', 'United Arab Emirates', 0, 1, 0),
(228, 'UM', 'UMI', '581', 'United States Minor Outlying Islands', 0, 1, 0),
(229, 'UY', 'URY', '858', 'Uruguay', 0, 1, 0),
(230, 'UZ', 'UZB', '860', 'Uzbekistan', 0, 1, 0),
(231, 'VU', 'VUT', '548', 'Vanuatu', 0, 1, 0),
(232, 'VE', 'VEN', '862', 'Venezuela', 0, 1, 0),
(233, 'VN', 'VNM', '704', 'Vietnam', 0, 1, 0),
(234, 'VG', 'VGB', '092', 'British Virgin Islands', 0, 1, 0),
(235, 'VI', 'VIR', '850', 'Virgin Islands of the United States', 0, 1, 0),
(236, 'WF', 'WLF', '876', 'Wallis and Futuna', 0, 1, 0),
(237, 'EH', 'ESH', '732', 'Western Sahara', 0, 1, 0),
(238, 'YE', 'YEM', '887', 'Yemen', 0, 1, 0),
(239, 'ZM', 'ZMB', '894', 'Zambia', 0, 1, 0),
(240, 'ZW', 'ZWE', '716', 'Zimbabwe', 0, 1, 0),
(241, 'GG', 'GGY', '831', 'Guernsey', 0, 1, 0),
(242, 'IM', 'IMN', '833', 'Isle of Man', 0, 1, 0),
(243, 'JE', 'JEY', '832', 'Jersey', 0, 1, 0),
(244, 'ME', 'MNE', '499', 'Montenegro', 0, 1, 0),
(245, 'BL', 'BLM', '652', 'Saint-Barthélemy', 0, 1, 0),
(246, 'MF', 'MAF', '663', 'Saint-Martin', 0, 1, 0),
(247, 'XK', 'XKX', NULL, 'Kosovo', 0, 1, 0),
(300, 'CW', 'CUW', '531', 'Curaçao', 0, 1, 0),
(301, 'SX', 'SXM', '534', 'Sint Maarten', 0, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_currencies`
--

CREATE TABLE `llx_c_currencies` (
  `code_iso` varchar(3) NOT NULL,
  `label` varchar(128) NOT NULL,
  `unicode` varchar(32) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_currencies`
--

INSERT INTO `llx_c_currencies` (`code_iso`, `label`, `unicode`, `active`) VALUES
('AED', 'United Arab Emirates Dirham', NULL, 1),
('AFN', 'Afghanistan Afghani', '[1547]', 1),
('ALL', 'Albania Lek', '[76,101,107]', 1),
('ANG', 'Netherlands Antilles Guilder', '[402]', 1),
('AOA', 'Angola Kwanza', NULL, 1),
('ARP', 'Pesos argentins', NULL, 0),
('ARS', 'Argentino Peso', '[36]', 1),
('ATS', 'Shiliing autrichiens', NULL, 0),
('AUD', 'Australia Dollar', '[36]', 1),
('AWG', 'Aruba Guilder', '[402]', 1),
('AZN', 'Azerbaijan New Manat', '[1084,1072,1085]', 1),
('BAM', 'Bosnia and Herzegovina Convertible Marka', '[75,77]', 1),
('BBD', 'Barbados Dollar', '[36]', 1),
('BDT', 'Bangladeshi Taka', '[2547]', 1),
('BEF', 'Francs belges', NULL, 0),
('BGN', 'Bulgaria Lev', '[1083,1074]', 1),
('BHD', 'Bahrain', NULL, 1),
('BIF', 'Burundi Franc', NULL, 1),
('BMD', 'Bermuda Dollar', '[36]', 1),
('BND', 'Brunei Darussalam Dollar', '[36]', 1),
('BOB', 'Bolivia Boliviano', '[66,115]', 1),
('BRL', 'Brazil Real', '[82,36]', 1),
('BSD', 'Bahamas Dollar', '[36]', 1),
('BWP', 'Botswana Pula', '[80]', 1),
('BYR', 'Belarus Ruble', '[112,46]', 1),
('BZD', 'Belize Dollar', '[66,90,36]', 1),
('CAD', 'Canada Dollar', '[36]', 1),
('CHF', 'Switzerland Franc', '[67,72,70]', 1),
('CLP', 'Chile Peso', '[36]', 1),
('CNY', 'China Yuan Renminbi', '[165]', 1),
('COP', 'Colombia Peso', '[36]', 1),
('CRC', 'Costa Rica Colon', '[8353]', 1),
('CUP', 'Cuba Peso', '[8369]', 1),
('CVE', 'Cap Verde Escudo', '[4217]', 1),
('CZK', 'Czech Republic Koruna', '[75,269]', 1),
('DEM', 'Deutsche Mark', NULL, 0),
('DKK', 'Denmark Krone', '[107,114]', 1),
('DOP', 'Dominican Republic Peso', '[82,68,36]', 1),
('DZD', 'Algeria Dinar', NULL, 1),
('ECS', 'Ecuador Sucre', '[83,47,46]', 1),
('EEK', 'Estonia Kroon', '[107,114]', 1),
('EGP', 'Egypt Pound', '[163]', 1),
('ESP', 'Pesete', NULL, 0),
('ETB', 'Ethiopian Birr', NULL, 1),
('EUR', 'Euro Member Countries', '[8364]', 1),
('FIM', 'Mark finlandais', NULL, 0),
('FJD', 'Fiji Dollar', '[36]', 1),
('FKP', 'Falkland Islands (Malvinas) Pound', '[163]', 1),
('FRF', 'Francs francais', NULL, 0),
('GBP', 'United Kingdom Pound', '[163]', 1),
('GGP', 'Guernsey Pound', '[163]', 1),
('GHC', 'Ghana Cedis', '[162]', 1),
('GIP', 'Gibraltar Pound', '[163]', 1),
('GNF', 'Guinea Franc', '[70,71]', 1),
('GRD', 'Drachme (grece)', NULL, 0),
('GTQ', 'Guatemala Quetzal', '[81]', 1),
('GYD', 'Guyana Dollar', '[36]', 1),
('HKD', 'Hong Kong Dollar', '[36]', 1),
('HNL', 'Honduras Lempira', '[76]', 1),
('HRK', 'Croatia Kuna', '[107,110]', 1),
('HUF', 'Hungary Forint', '[70,116]', 1),
('IDR', 'Indonesia Rupiah', '[82,112]', 1),
('IEP', 'Livres irlandaises', NULL, 0),
('ILS', 'Israel Shekel', '[8362]', 1),
('IMP', 'Isle of Man Pound', '[163]', 1),
('INR', 'India Rupee', '[8377]', 1),
('IRR', 'Iran Rial', '[65020]', 1),
('ISK', 'Iceland Krona', '[107,114]', 1),
('ITL', 'Lires', NULL, 0),
('JEP', 'Jersey Pound', '[163]', 1),
('JMD', 'Jamaica Dollar', '[74,36]', 1),
('JPY', 'Japan Yen', '[165]', 1),
('KES', 'Kenya Shilling', NULL, 1),
('KGS', 'Kyrgyzstan Som', '[1083,1074]', 1),
('KHR', 'Cambodia Riel', '[6107]', 1),
('KPW', 'Korea (North) Won', '[8361]', 1),
('KRW', 'Korea (South) Won', '[8361]', 1),
('KYD', 'Cayman Islands Dollar', '[36]', 1),
('KZT', 'Kazakhstan Tenge', '[1083,1074]', 1),
('LAK', 'Laos Kip', '[8365]', 1),
('LBP', 'Lebanon Pound', '[163]', 1),
('LKR', 'Sri Lanka Rupee', '[8360]', 1),
('LRD', 'Liberia Dollar', '[36]', 1),
('LTL', 'Lithuania Litas', '[76,116]', 1),
('LUF', 'Francs luxembourgeois', NULL, 0),
('LVL', 'Latvia Lat', '[76,115]', 1),
('MAD', 'Morocco Dirham', NULL, 1),
('MDL', 'Moldova Leu', NULL, 1),
('MGA', 'Ariary', NULL, 1),
('MKD', 'Macedonia Denar', '[1076,1077,1085]', 1),
('MMK', 'Myanmar Kyat', '[75]', 1),
('MNT', 'Mongolia Tughrik', '[8366]', 1),
('MRO', 'Mauritania Ouguiya', NULL, 1),
('MUR', 'Mauritius Rupee', '[8360]', 1),
('MXN', 'Mexico Peso', '[36]', 1),
('MXP', 'Pesos Mexicans', NULL, 0),
('MYR', 'Malaysia Ringgit', '[82,77]', 1),
('MZN', 'Mozambique Metical', '[77,84]', 1),
('NAD', 'Namibia Dollar', '[36]', 1),
('NGN', 'Nigeria Naira', '[8358]', 1),
('NIO', 'Nicaragua Cordoba', '[67,36]', 1),
('NLG', 'Florins', NULL, 0),
('NOK', 'Norway Krone', '[107,114]', 1),
('NPR', 'Nepal Rupee', '[8360]', 1),
('NZD', 'New Zealand Dollar', '[36]', 1),
('OMR', 'Oman Rial', '[65020]', 1),
('PAB', 'Panama Balboa', '[66,47,46]', 1),
('PEN', 'Perú Sol', '[83,47]', 1),
('PHP', 'Philippines Peso', '[8369]', 1),
('PKR', 'Pakistan Rupee', '[8360]', 1),
('PLN', 'Poland Zloty', '[122,322]', 1),
('PTE', 'Escudos', NULL, 0),
('PYG', 'Paraguay Guarani', '[71,115]', 1),
('QAR', 'Qatar Riyal', '[65020]', 1),
('RON', 'Romania New Leu', '[108,101,105]', 1),
('RSD', 'Serbia Dinar', '[1044,1080,1085,46]', 1),
('RUB', 'Russia Ruble', '[1088,1091,1073]', 1),
('SAR', 'Saudi Arabia Riyal', '[65020]', 1),
('SBD', 'Solomon Islands Dollar', '[36]', 1),
('SCR', 'Seychelles Rupee', '[8360]', 1),
('SEK', 'Sweden Krona', '[107,114]', 1),
('SGD', 'Singapore Dollar', '[36]', 1),
('SHP', 'Saint Helena Pound', '[163]', 1),
('SKK', 'Couronnes slovaques', NULL, 0),
('SOS', 'Somalia Shilling', '[83]', 1),
('SRD', 'Suriname Dollar', '[36]', 1),
('SUR', 'Rouble', NULL, 0),
('SVC', 'El Salvador Colon', '[36]', 1),
('SYP', 'Syria Pound', '[163]', 1),
('THB', 'Thailand Baht', '[3647]', 1),
('TND', 'Tunisia Dinar', NULL, 1),
('TRL', 'Turkey Lira', '[84,76]', 0),
('TRY', 'Turkey Lira', '[8378]', 1),
('TTD', 'Trinidad and Tobago Dollar', '[84,84,36]', 1),
('TVD', 'Tuvalu Dollar', '[36]', 1),
('TWD', 'Taiwan New Dollar', '[78,84,36]', 1),
('UAH', 'Ukraine Hryvna', '[8372]', 1),
('USD', 'United States Dollar', '[36]', 1),
('UYU', 'Uruguay Peso', '[36,85]', 1),
('UZS', 'Uzbekistan Som', '[1083,1074]', 1),
('VEF', 'Venezuela Bolivar Fuerte', '[66,115]', 1),
('VND', 'Viet Nam Dong', '[8363]', 1),
('XAF', 'Communaute Financiere Africaine (BEAC) CFA Franc', NULL, 1),
('XCD', 'East Caribbean Dollar', '[36]', 1),
('XEU', 'Ecus', NULL, 0),
('XOF', 'Communaute Financiere Africaine (BCEAO) Franc', NULL, 1),
('XPF', 'Franc CFP', '[70]', 1),
('YER', 'Yemen Rial', '[65020]', 1),
('ZAR', 'South Africa Rand', '[82]', 1),
('ZWD', 'Zimbabwe Dollar', '[90,36]', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_departements`
--

CREATE TABLE `llx_c_departements` (
  `rowid` int(11) NOT NULL,
  `code_departement` varchar(6) NOT NULL,
  `fk_region` int(11) DEFAULT NULL,
  `cheflieu` varchar(50) DEFAULT NULL,
  `tncc` int(11) DEFAULT NULL,
  `ncc` varchar(50) DEFAULT NULL,
  `nom` varchar(50) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_departements`
--

INSERT INTO `llx_c_departements` (`rowid`, `code_departement`, `fk_region`, `cheflieu`, `tncc`, `ncc`, `nom`, `active`) VALUES
(1, '0', 0, '0', 0, '-', '-', 1),
(2, '01', 1301, '', 0, '', 'Adrar', 1),
(3, '02', 1301, '', 0, '', 'Chlef', 1),
(4, '03', 1301, '', 0, '', 'Laghouat', 1),
(5, '04', 1301, '', 0, '', 'Oum El Bouaghi', 1),
(6, '05', 1301, '', 0, '', 'Batna', 1),
(7, '06', 1301, '', 0, '', 'Béjaïa', 1),
(8, '07', 1301, '', 0, '', 'Biskra', 1),
(9, '08', 1301, '', 0, '', 'Béchar', 1),
(10, '09', 1301, '', 0, '', 'Blida', 1),
(11, '10', 1301, '', 0, '', 'Bouira', 1),
(12, '11', 1301, '', 0, '', 'Tamanrasset', 1),
(13, '12', 1301, '', 0, '', 'Tébessa', 1),
(14, '13', 1301, '', 0, '', 'Tlemcen', 1),
(15, '14', 1301, '', 0, '', 'Tiaret', 1),
(16, '15', 1301, '', 0, '', 'Tizi Ouzou', 1),
(17, '16', 1301, '', 0, '', 'Alger', 1),
(18, '17', 1301, '', 0, '', 'Djelfa', 1),
(19, '18', 1301, '', 0, '', 'Jijel', 1),
(20, '19', 1301, '', 0, '', 'Sétif', 1),
(21, '20', 1301, '', 0, '', 'Saïda', 1),
(22, '21', 1301, '', 0, '', 'Skikda', 1),
(23, '22', 1301, '', 0, '', 'Sidi Bel Abbès', 1),
(24, '23', 1301, '', 0, '', 'Annaba', 1),
(25, '24', 1301, '', 0, '', 'Guelma', 1),
(26, '25', 1301, '', 0, '', 'Constantine', 1),
(27, '26', 1301, '', 0, '', 'Médéa', 1),
(28, '27', 1301, '', 0, '', 'Mostaganem', 1),
(29, '28', 1301, '', 0, '', 'M\'Sila', 1),
(30, '29', 1301, '', 0, '', 'Mascara', 1),
(31, '30', 1301, '', 0, '', 'Ouargla', 1),
(32, '31', 1301, '', 0, '', 'Oran', 1),
(33, '32', 1301, '', 0, '', 'El Bayadh', 1),
(34, '33', 1301, '', 0, '', 'Illizi', 1),
(35, '34', 1301, '', 0, '', 'Bordj Bou Arreridj', 1),
(36, '35', 1301, '', 0, '', 'Boumerdès', 1),
(37, '36', 1301, '', 0, '', 'El Tarf', 1),
(38, '37', 1301, '', 0, '', 'Tindouf', 1),
(39, '38', 1301, '', 0, '', 'Tissemsilt', 1),
(40, '39', 1301, '', 0, '', 'El Oued', 1),
(41, '40', 1301, '', 0, '', 'Khenchela', 1),
(42, '41', 1301, '', 0, '', 'Souk Ahras', 1),
(43, '42', 1301, '', 0, '', 'Tipaza', 1),
(44, '43', 1301, '', 0, '', 'Mila', 1),
(45, '44', 1301, '', 0, '', 'Aïn Defla', 1),
(46, '45', 1301, '', 0, '', 'Naâma', 1),
(47, '46', 1301, '', 0, '', 'Aïn Témouchent', 1),
(48, '47', 1301, '', 0, '', 'Ghardaïa', 1),
(49, '48', 1301, '', 0, '', 'Relizane', 1),
(50, '49', 1301, '', 0, '', 'Timimoun', 1),
(51, '50', 1301, '', 0, '', 'Bordj Badji Mokhtar', 1),
(52, '51', 1301, '', 0, '', 'Ouled Djellal', 1),
(53, '52', 1301, '', 0, '', 'Béni Abbès', 1),
(54, '53', 1301, '', 0, '', 'In Salah', 1),
(55, '54', 1301, '', 0, '', 'In Guezzam', 1),
(56, '55', 1301, '', 0, '', 'Touggourt', 1),
(57, '56', 1301, '', 0, '', 'Djanet', 1),
(58, '57', 1301, '', 0, '', 'El M\'Ghair', 1),
(59, '58', 1301, '', 0, '', 'El Ménéa', 1),
(60, 'AD-002', 34000, 'AD100', NULL, NULL, 'Canillo', 1),
(61, 'AD-003', 34000, 'AD200', NULL, NULL, 'Encamp', 1),
(62, 'AD-004', 34000, 'AD400', NULL, NULL, 'La Massana', 1),
(63, 'AD-005', 34000, 'AD300', NULL, NULL, 'Ordino', 1),
(64, 'AD-006', 34000, 'AD600', NULL, NULL, 'Sant Julià de Lòria', 1),
(65, 'AD-007', 34000, 'AD500', NULL, NULL, 'Andorra la Vella', 1),
(66, 'AD-008', 34000, 'AD700', NULL, NULL, 'Escaldes-Engordany', 1),
(67, 'AO-ABO', 35001, NULL, NULL, 'BENGO', 'Bengo', 1),
(68, 'AO-BGU', 35001, NULL, NULL, 'BENGUELA', 'Benguela', 1),
(69, 'AO-BIE', 35001, NULL, NULL, 'BIÉ', 'Bié', 1),
(70, 'AO-CAB', 35001, NULL, NULL, 'CABINDA', 'Cabinda', 1),
(71, 'AO-CCU', 35001, NULL, NULL, 'KUANDO KUBANGO', 'Kuando Kubango', 1),
(72, 'AO-CNO', 35001, NULL, NULL, 'KWANZA NORTE', 'Kwanza Norte', 1),
(73, 'AO-CUS', 35001, NULL, NULL, 'KWANZA SUL', 'Kwanza Sul', 1),
(74, 'AO-CNN', 35001, NULL, NULL, 'CUNENE', 'Cunene', 1),
(75, 'AO-HUA', 35001, NULL, NULL, 'HUAMBO', 'Huambo', 1),
(76, 'AO-HUI', 35001, NULL, NULL, 'HUÍLA', 'Huila', 1),
(77, 'AO-LUA', 35001, NULL, NULL, 'LUANDA', 'Luanda', 1),
(78, 'AO-LNO', 35001, NULL, NULL, 'LUNDA-NORTE', 'Lunda-Norte', 1),
(79, 'AO-LSU', 35001, NULL, NULL, 'LUNDA-SUL', 'Lunda-Sul', 1),
(80, 'AO-MAL', 35001, NULL, NULL, 'MALANGE', 'Malange', 1),
(81, 'AO-MOX', 35001, NULL, NULL, 'MOXICO', 'Moxico', 1),
(82, 'AO-NAM', 35001, NULL, NULL, 'NAMÍBE', 'Namíbe', 1),
(83, 'AO-UIG', 35001, NULL, NULL, 'UÍGE', 'Uíge', 1),
(84, 'AO-ZAI', 35001, NULL, NULL, 'ZAÍRE', 'Zaíre', 1),
(85, '2301', 2301, '', 0, 'CATAMARCA', 'Catamarca', 1),
(86, '2302', 2301, '', 0, 'JUJUY', 'Jujuy', 1),
(87, '2303', 2301, '', 0, 'TUCAMAN', 'Tucamán', 1),
(88, '2304', 2301, '', 0, 'SANTIAGO DEL ESTERO', 'Santiago del Estero', 1),
(89, '2305', 2301, '', 0, 'SALTA', 'Salta', 1),
(90, '2306', 2302, '', 0, 'CHACO', 'Chaco', 1),
(91, '2307', 2302, '', 0, 'CORRIENTES', 'Corrientes', 1),
(92, '2308', 2302, '', 0, 'ENTRE RIOS', 'Entre Ríos', 1),
(93, '2309', 2302, '', 0, 'FORMOSA', 'Formosa', 1),
(94, '2310', 2302, '', 0, 'SANTA FE', 'Santa Fe', 1),
(95, '2311', 2303, '', 0, 'LA RIOJA', 'La Rioja', 1),
(96, '2312', 2303, '', 0, 'MENDOZA', 'Mendoza', 1),
(97, '2313', 2303, '', 0, 'SAN JUAN', 'San Juan', 1),
(98, '2314', 2303, '', 0, 'SAN LUIS', 'San Luis', 1),
(99, '2315', 2304, '', 0, 'CORDOBA', 'Córdoba', 1),
(100, '2316', 2304, '', 0, 'BUENOS AIRES', 'Buenos Aires', 1),
(101, '2317', 2304, '', 0, 'CABA', 'Caba', 1),
(102, '2318', 2305, '', 0, 'LA PAMPA', 'La Pampa', 1),
(103, '2319', 2305, '', 0, 'NEUQUEN', 'Neuquén', 1),
(104, '2320', 2305, '', 0, 'RIO NEGRO', 'Río Negro', 1),
(105, '2321', 2305, '', 0, 'CHUBUT', 'Chubut', 1),
(106, '2322', 2305, '', 0, 'SANTA CRUZ', 'Santa Cruz', 1),
(107, '2323', 2305, '', 0, 'TIERRA DEL FUEGO', 'Tierra del Fuego', 1),
(108, '2324', 2305, '', 0, 'ISLAS MALVINAS', 'Islas Malvinas', 1),
(109, '2325', 2305, '', 0, 'ANTARTIDA', 'Antártida', 1),
(110, '2326', 2305, '', 0, 'MISIONES', 'Misiones', 1),
(111, 'NSW', 2801, '', 1, '', 'New South Wales', 1),
(112, 'VIC', 2801, '', 1, '', 'Victoria', 1),
(113, 'QLD', 2801, '', 1, '', 'Queensland', 1),
(114, 'SA', 2801, '', 1, '', 'South Australia', 1),
(115, 'ACT', 2801, '', 1, '', 'Australia Capital Territory', 1),
(116, 'TAS', 2801, '', 1, '', 'Tasmania', 1),
(117, 'WA', 2801, '', 1, '', 'Western Australia', 1),
(118, 'NT', 2801, '', 1, '', 'Northern Territory', 1),
(119, 'B', 4101, NULL, NULL, 'BURGENLAND', 'Burgenland', 1),
(120, 'K', 4101, NULL, NULL, 'KAERNTEN', 'Kärnten', 1),
(121, 'N', 4101, NULL, NULL, 'NIEDEROESTERREICH', 'Niederösterreich', 1),
(122, 'O', 4101, NULL, NULL, 'OBEROESTERREICH', 'Oberösterreich', 1),
(123, 'S', 4101, NULL, NULL, 'SALZBURG', 'Salzburg', 1),
(124, 'ST', 4101, NULL, NULL, 'STEIERMARK', 'Steiermark', 1),
(125, 'T', 4101, NULL, NULL, 'TIROL', 'Tirol', 1),
(126, 'V', 4101, NULL, NULL, 'VORARLBERG', 'Vorarlberg', 1),
(127, 'W', 4101, NULL, NULL, 'WIEN', 'Wien', 1),
(128, 'CC', 4601, 'Oistins', 0, 'CC', 'Christ Church', 1),
(129, 'SA', 4601, 'Greenland', 0, 'SA', 'Saint Andrew', 1),
(130, 'SG', 4601, 'Bulkeley', 0, 'SG', 'Saint George', 1),
(131, 'JA', 4601, 'Holetown', 0, 'JA', 'Saint James', 1),
(132, 'SJ', 4601, 'Four Roads', 0, 'SJ', 'Saint John', 1),
(133, 'SB', 4601, 'Bathsheba', 0, 'SB', 'Saint Joseph', 1),
(134, 'SL', 4601, 'Crab Hill', 0, 'SL', 'Saint Lucy', 1),
(135, 'SM', 4601, 'Bridgetown', 0, 'SM', 'Saint Michael', 1),
(136, 'SP', 4601, 'Speightstown', 0, 'SP', 'Saint Peter', 1),
(137, 'SC', 4601, 'Crane', 0, 'SC', 'Saint Philip', 1),
(138, 'ST', 4601, 'Hillaby', 0, 'ST', 'Saint Thomas', 1),
(139, '01', 201, '', 1, 'ANVERS', 'Anvers', 1),
(140, '02', 203, '', 3, 'BRUXELLES-CAPITALE', 'Bruxelles-Capitale', 1),
(141, '03', 202, '', 2, 'BRABANT-WALLON', 'Brabant-Wallon', 1),
(142, '04', 201, '', 1, 'BRABANT-FLAMAND', 'Brabant-Flamand', 1),
(143, '05', 201, '', 1, 'FLANDRE-OCCIDENTALE', 'Flandre-Occidentale', 1),
(144, '06', 201, '', 1, 'FLANDRE-ORIENTALE', 'Flandre-Orientale', 1),
(145, '07', 202, '', 2, 'HAINAUT', 'Hainaut', 1),
(146, '08', 202, '', 2, 'LIEGE', 'Liège', 1),
(147, '09', 202, '', 1, 'LIMBOURG', 'Limbourg', 1),
(148, '10', 202, '', 2, 'LUXEMBOURG', 'Luxembourg', 1),
(149, '11', 202, '', 2, 'NAMUR', 'Namur', 1),
(150, 'AC', 5601, 'ACRE', 0, 'AC', 'Acre', 1),
(151, 'AL', 5601, 'ALAGOAS', 0, 'AL', 'Alagoas', 1),
(152, 'AP', 5601, 'AMAPA', 0, 'AP', 'Amapá', 1),
(153, 'AM', 5601, 'AMAZONAS', 0, 'AM', 'Amazonas', 1),
(154, 'BA', 5601, 'BAHIA', 0, 'BA', 'Bahia', 1),
(155, 'CE', 5601, 'CEARA', 0, 'CE', 'Ceará', 1),
(156, 'ES', 5601, 'ESPIRITO SANTO', 0, 'ES', 'Espirito Santo', 1),
(157, 'GO', 5601, 'GOIAS', 0, 'GO', 'Goiás', 1),
(158, 'MA', 5601, 'MARANHAO', 0, 'MA', 'Maranhão', 1),
(159, 'MT', 5601, 'MATO GROSSO', 0, 'MT', 'Mato Grosso', 1),
(160, 'MS', 5601, 'MATO GROSSO DO SUL', 0, 'MS', 'Mato Grosso do Sul', 1),
(161, 'MG', 5601, 'MINAS GERAIS', 0, 'MG', 'Minas Gerais', 1),
(162, 'PA', 5601, 'PARA', 0, 'PA', 'Pará', 1),
(163, 'PB', 5601, 'PARAIBA', 0, 'PB', 'Paraiba', 1),
(164, 'PR', 5601, 'PARANA', 0, 'PR', 'Paraná', 1),
(165, 'PE', 5601, 'PERNAMBUCO', 0, 'PE', 'Pernambuco', 1),
(166, 'PI', 5601, 'PIAUI', 0, 'PI', 'Piauí', 1),
(167, 'RJ', 5601, 'RIO DE JANEIRO', 0, 'RJ', 'Rio de Janeiro', 1),
(168, 'RN', 5601, 'RIO GRANDE DO NORTE', 0, 'RN', 'Rio Grande do Norte', 1),
(169, 'RS', 5601, 'RIO GRANDE DO SUL', 0, 'RS', 'Rio Grande do Sul', 1),
(170, 'RO', 5601, 'RONDONIA', 0, 'RO', 'Rondônia', 1),
(171, 'RR', 5601, 'RORAIMA', 0, 'RR', 'Roraima', 1),
(172, 'SC', 5601, 'SANTA CATARINA', 0, 'SC', 'Santa Catarina', 1),
(173, 'SE', 5601, 'SERGIPE', 0, 'SE', 'Sergipe', 1),
(174, 'SP', 5601, 'SAO PAULO', 0, 'SP', 'Sao Paulo', 1),
(175, 'TO', 5601, 'TOCANTINS', 0, 'TO', 'Tocantins', 1),
(176, 'DF', 5601, 'DISTRITO FEDERAL', 0, 'DF', 'Distrito Federal', 1),
(177, 'ON', 1401, '', 1, '', 'Ontario', 1),
(178, 'QC', 1401, '', 1, '', 'Quebec', 1),
(179, 'NS', 1401, '', 1, '', 'Nova Scotia', 1),
(180, 'NB', 1401, '', 1, '', 'New Brunswick', 1),
(181, 'MB', 1401, '', 1, '', 'Manitoba', 1),
(182, 'BC', 1401, '', 1, '', 'British Columbia', 1),
(183, 'PE', 1401, '', 1, '', 'Prince Edward Island', 1),
(184, 'SK', 1401, '', 1, '', 'Saskatchewan', 1),
(185, 'AB', 1401, '', 1, '', 'Alberta', 1),
(186, 'NL', 1401, '', 1, '', 'Newfoundland and Labrador', 1),
(187, 'YT', 1401, '', 1, '', 'Yukon', 1),
(188, 'NT', 1401, '', 1, '', 'Northwest Territories', 1),
(189, 'NU', 1401, '', 1, '', 'Nunavut', 1),
(190, '011', 6701, '', 0, '011', 'Iquique', 1),
(191, '014', 6701, '', 0, '014', 'Tamarugal', 1),
(192, '021', 6702, '', 0, '021', 'Antofagasa', 1),
(193, '022', 6702, '', 0, '022', 'El Loa', 1),
(194, '023', 6702, '', 0, '023', 'Tocopilla', 1),
(195, '031', 6703, '', 0, '031', 'Copiapó', 1),
(196, '032', 6703, '', 0, '032', 'Chañaral', 1),
(197, '033', 6703, '', 0, '033', 'Huasco', 1),
(198, '041', 6704, '', 0, '041', 'Elqui', 1),
(199, '042', 6704, '', 0, '042', 'Choapa', 1),
(200, '043', 6704, '', 0, '043', 'Limarí', 1),
(201, '051', 6705, '', 0, '051', 'Valparaíso', 1),
(202, '052', 6705, '', 0, '052', 'Isla de Pascua', 1),
(203, '053', 6705, '', 0, '053', 'Los Andes', 1),
(204, '054', 6705, '', 0, '054', 'Petorca', 1),
(205, '055', 6705, '', 0, '055', 'Quillota', 1),
(206, '056', 6705, '', 0, '056', 'San Antonio', 1),
(207, '057', 6705, '', 0, '057', 'San Felipe de Aconcagua', 1),
(208, '058', 6705, '', 0, '058', 'Marga Marga', 1),
(209, '061', 6706, '', 0, '061', 'Cachapoal', 1),
(210, '062', 6706, '', 0, '062', 'Cardenal Caro', 1),
(211, '063', 6706, '', 0, '063', 'Colchagua', 1),
(212, '071', 6707, '', 0, '071', 'Talca', 1),
(213, '072', 6707, '', 0, '072', 'Cauquenes', 1),
(214, '073', 6707, '', 0, '073', 'Curicó', 1),
(215, '074', 6707, '', 0, '074', 'Linares', 1),
(216, '081', 6708, '', 0, '081', 'Concepción', 1),
(217, '082', 6708, '', 0, '082', 'Arauco', 1),
(218, '083', 6708, '', 0, '083', 'Biobío', 1),
(219, '084', 6708, '', 0, '084', 'Ñuble', 1),
(220, '091', 6709, '', 0, '091', 'Cautín', 1),
(221, '092', 6709, '', 0, '092', 'Malleco', 1),
(222, '101', 6710, '', 0, '101', 'Llanquihue', 1),
(223, '102', 6710, '', 0, '102', 'Chiloé', 1),
(224, '103', 6710, '', 0, '103', 'Osorno', 1),
(225, '104', 6710, '', 0, '104', 'Palena', 1),
(226, '111', 6711, '', 0, '111', 'Coihaique', 1),
(227, '112', 6711, '', 0, '112', 'Aisén', 1),
(228, '113', 6711, '', 0, '113', 'Capitán Prat', 1),
(229, '114', 6711, '', 0, '114', 'General Carrera', 1),
(230, '121', 6712, '', 0, '121', 'Magallanes', 1),
(231, '122', 6712, '', 0, '122', 'Antártica Chilena', 1),
(232, '123', 6712, '', 0, '123', 'Tierra del Fuego', 1),
(233, '124', 6712, '', 0, '124', 'Última Esperanza', 1),
(234, '131', 6713, '', 0, '131', 'Santiago', 1),
(235, '132', 6713, '', 0, '132', 'Cordillera', 1),
(236, '133', 6713, '', 0, '133', 'Chacabuco', 1),
(237, '134', 6713, '', 0, '134', 'Maipo', 1),
(238, '135', 6713, '', 0, '135', 'Melipilla', 1),
(239, '136', 6713, '', 0, '136', 'Talagante', 1),
(240, '141', 6714, '', 0, '141', 'Valdivia', 1),
(241, '142', 6714, '', 0, '142', 'Ranco', 1),
(242, '151', 6715, '', 0, '151', 'Arica', 1),
(243, '152', 6715, '', 0, '152', 'Parinacota', 1),
(244, 'ANT', 7001, '', 0, 'ANT', 'Antioquia', 1),
(245, 'BOL', 7001, '', 0, 'BOL', 'Bolívar', 1),
(246, 'BOY', 7001, '', 0, 'BOY', 'Boyacá', 1),
(247, 'CAL', 7001, '', 0, 'CAL', 'Caldas', 1),
(248, 'CAU', 7001, '', 0, 'CAU', 'Cauca', 1),
(249, 'CUN', 7001, '', 0, 'CUN', 'Cundinamarca', 1),
(250, 'HUI', 7001, '', 0, 'HUI', 'Huila', 1),
(251, 'LAG', 7001, '', 0, 'LAG', 'La Guajira', 1),
(252, 'MET', 7001, '', 0, 'MET', 'Meta', 1),
(253, 'NAR', 7001, '', 0, 'NAR', 'Nariño', 1),
(254, 'NDS', 7001, '', 0, 'NDS', 'Norte de Santander', 1),
(255, 'SAN', 7001, '', 0, 'SAN', 'Santander', 1),
(256, 'SUC', 7001, '', 0, 'SUC', 'Sucre', 1),
(257, 'TOL', 7001, '', 0, 'TOL', 'Tolima', 1),
(258, 'VAC', 7001, '', 0, 'VAC', 'Valle del Cauca', 1),
(259, 'RIS', 7001, '', 0, 'RIS', 'Risalda', 1),
(260, 'ATL', 7001, '', 0, 'ATL', 'Atlántico', 1),
(261, 'COR', 7001, '', 0, 'COR', 'Córdoba', 1),
(262, 'SAP', 7001, '', 0, 'SAP', 'San Andrés, Providencia y Santa Catalina', 1),
(263, 'ARA', 7001, '', 0, 'ARA', 'Arauca', 1),
(264, 'CAS', 7001, '', 0, 'CAS', 'Casanare', 1),
(265, 'AMA', 7001, '', 0, 'AMA', 'Amazonas', 1),
(266, 'CAQ', 7001, '', 0, 'CAQ', 'Caquetá', 1),
(267, 'CHO', 7001, '', 0, 'CHO', 'Chocó', 1),
(268, 'GUA', 7001, '', 0, 'GUA', 'Guainía', 1),
(269, 'GUV', 7001, '', 0, 'GUV', 'Guaviare', 1),
(270, 'PUT', 7001, '', 0, 'PUT', 'Putumayo', 1),
(271, 'QUI', 7001, '', 0, 'QUI', 'Quindío', 1),
(272, 'VAU', 7001, '', 0, 'VAU', 'Vaupés', 1),
(273, 'BOG', 7001, '', 0, 'BOG', 'Bogotá', 1),
(274, 'VID', 7001, '', 0, 'VID', 'Vichada', 1),
(275, 'CES', 7001, '', 0, 'CES', 'Cesar', 1),
(276, 'MAG', 7001, '', 0, 'MAG', 'Magdalena', 1),
(277, 'HR-01', 7601, 'Bjelovar', 0, NULL, 'Bjelovarsko-bilogorska županija', 1),
(278, 'HR-02', 7601, 'Karlovac', 0, NULL, 'Karlovačka županija', 1),
(279, 'HR-03', 7601, 'Koprivnica', 0, NULL, 'Koprivničko-križevačka županija', 1),
(280, 'HR-04', 7601, 'Krapina', 0, NULL, 'Krapinsko-zagorska županija', 1),
(281, 'HR-05', 7601, 'Gospić', 0, NULL, 'Ličko-senjska županija', 1),
(282, 'HR-06', 7601, 'Čakovec', 0, NULL, 'Međimurska županija', 1),
(283, 'HR-07', 7601, 'Rijeka', 0, NULL, 'Primorsko-goranska županija', 1),
(284, 'HR-08', 7601, 'Sisak', 0, NULL, 'Sisačko-moslavačka županija', 1),
(285, 'HR-09', 7601, 'Varaždin', 0, NULL, 'Varaždinska županija', 1),
(286, 'HR-10', 7601, 'Zagreb', 0, NULL, 'Zagrebačka županija', 1),
(287, 'HR-11', 7601, 'Zagreb', 0, NULL, 'Grad Zagreb', 1),
(288, 'HR-12', 7602, 'Zadar', 0, NULL, 'Zadarska županija', 1),
(289, 'HR-13', 7602, 'Šibenik', 0, NULL, 'Šibensko-kninska županija', 1),
(290, 'HR-14', 7602, 'Split', 0, NULL, 'Splitsko-dalmatinska županija', 1),
(291, 'HR-15', 7602, 'Dubrovnik', 0, NULL, 'Dubrovačko-neretvanska županija', 1),
(292, 'HR-16', 7603, 'Slavonski Brod', 0, NULL, 'Brodsko-posavska županija', 1),
(293, 'HR-17', 7603, 'Osijek', 0, NULL, 'Osječko-baranjska županija', 1),
(294, 'HR-18', 7603, 'Požega', 0, NULL, 'Požeško-slavonska županija', 1),
(295, 'HR-19', 7603, 'Virovitica', 0, NULL, 'Virovitičko-podravska županija', 1),
(296, 'HR-20', 7603, 'Vukovar', 0, NULL, 'Vukovarsko-srijemska županija', 1),
(297, 'HR-21', 7604, 'Pazin', 0, NULL, 'Istarska županija', 1),
(298, '971', 1, '97105', 3, 'GUADELOUPE', 'Guadeloupe', 1),
(299, '972', 2, '97209', 3, 'MARTINIQUE', 'Martinique', 1),
(300, '973', 3, '97302', 3, 'GUYANE', 'Guyane', 1),
(301, '974', 4, '97411', 3, 'REUNION', 'Réunion', 1),
(302, '976', 6, '97601', 3, 'MAYOTTE', 'Mayotte', 1),
(303, '01', 84, '01053', 5, 'AIN', 'Ain', 1),
(304, '02', 32, '02408', 5, 'AISNE', 'Aisne', 1),
(305, '03', 84, '03190', 5, 'ALLIER', 'Allier', 1),
(306, '04', 93, '04070', 4, 'ALPES-DE-HAUTE-PROVENCE', 'Alpes-de-Haute-Provence', 1),
(307, '05', 93, '05061', 4, 'HAUTES-ALPES', 'Hautes-Alpes', 1),
(308, '06', 93, '06088', 4, 'ALPES-MARITIMES', 'Alpes-Maritimes', 1),
(309, '07', 84, '07186', 5, 'ARDECHE', 'Ardèche', 1),
(310, '08', 44, '08105', 4, 'ARDENNES', 'Ardennes', 1),
(311, '09', 76, '09122', 5, 'ARIEGE', 'Ariège', 1),
(312, '10', 44, '10387', 5, 'AUBE', 'Aube', 1),
(313, '11', 76, '11069', 5, 'AUDE', 'Aude', 1),
(314, '12', 76, '12202', 5, 'AVEYRON', 'Aveyron', 1),
(315, '13', 93, '13055', 4, 'BOUCHES-DU-RHONE', 'Bouches-du-Rhône', 1),
(316, '14', 28, '14118', 2, 'CALVADOS', 'Calvados', 1),
(317, '15', 84, '15014', 2, 'CANTAL', 'Cantal', 1),
(318, '16', 75, '16015', 3, 'CHARENTE', 'Charente', 1),
(319, '17', 75, '17300', 3, 'CHARENTE-MARITIME', 'Charente-Maritime', 1),
(320, '18', 24, '18033', 2, 'CHER', 'Cher', 1),
(321, '19', 75, '19272', 3, 'CORREZE', 'Corrèze', 1),
(322, '2A', 94, '2A004', 3, 'CORSE-DU-SUD', 'Corse-du-Sud', 1),
(323, '2B', 94, '2B033', 3, 'HAUTE-CORSE', 'Haute-Corse', 1),
(324, '21', 27, '21231', 3, 'COTE-D OR', 'Côte-d Or', 1),
(325, '22', 53, '22278', 4, 'COTES-D ARMOR', 'Côtes-d Armor', 1),
(326, '23', 75, '23096', 3, 'CREUSE', 'Creuse', 1),
(327, '24', 75, '24322', 3, 'DORDOGNE', 'Dordogne', 1),
(328, '25', 27, '25056', 2, 'DOUBS', 'Doubs', 1),
(329, '26', 84, '26362', 3, 'DROME', 'Drôme', 1),
(330, '27', 28, '27229', 5, 'EURE', 'Eure', 1),
(331, '28', 24, '28085', 1, 'EURE-ET-LOIR', 'Eure-et-Loir', 1),
(332, '29', 53, '29232', 2, 'FINISTERE', 'Finistère', 1),
(333, '30', 76, '30189', 2, 'GARD', 'Gard', 1),
(334, '31', 76, '31555', 3, 'HAUTE-GARONNE', 'Haute-Garonne', 1),
(335, '32', 76, '32013', 2, 'GERS', 'Gers', 1),
(336, '33', 75, '33063', 3, 'GIRONDE', 'Gironde', 1),
(337, '34', 76, '34172', 5, 'HERAULT', 'Hérault', 1),
(338, '35', 53, '35238', 1, 'ILLE-ET-VILAINE', 'Ille-et-Vilaine', 1),
(339, '36', 24, '36044', 5, 'INDRE', 'Indre', 1),
(340, '37', 24, '37261', 1, 'INDRE-ET-LOIRE', 'Indre-et-Loire', 1),
(341, '38', 84, '38185', 5, 'ISERE', 'Isère', 1),
(342, '39', 27, '39300', 2, 'JURA', 'Jura', 1),
(343, '40', 75, '40192', 4, 'LANDES', 'Landes', 1),
(344, '41', 24, '41018', 0, 'LOIR-ET-CHER', 'Loir-et-Cher', 1),
(345, '42', 84, '42218', 3, 'LOIRE', 'Loire', 1),
(346, '43', 84, '43157', 3, 'HAUTE-LOIRE', 'Haute-Loire', 1),
(347, '44', 52, '44109', 3, 'LOIRE-ATLANTIQUE', 'Loire-Atlantique', 1),
(348, '45', 24, '45234', 2, 'LOIRET', 'Loiret', 1),
(349, '46', 76, '46042', 2, 'LOT', 'Lot', 1),
(350, '47', 75, '47001', 0, 'LOT-ET-GARONNE', 'Lot-et-Garonne', 1),
(351, '48', 76, '48095', 3, 'LOZERE', 'Lozère', 1),
(352, '49', 52, '49007', 0, 'MAINE-ET-LOIRE', 'Maine-et-Loire', 1),
(353, '50', 28, '50502', 3, 'MANCHE', 'Manche', 1),
(354, '51', 44, '51108', 3, 'MARNE', 'Marne', 1),
(355, '52', 44, '52121', 3, 'HAUTE-MARNE', 'Haute-Marne', 1),
(356, '53', 52, '53130', 3, 'MAYENNE', 'Mayenne', 1),
(357, '54', 44, '54395', 0, 'MEURTHE-ET-MOSELLE', 'Meurthe-et-Moselle', 1),
(358, '55', 44, '55029', 3, 'MEUSE', 'Meuse', 1),
(359, '56', 53, '56260', 2, 'MORBIHAN', 'Morbihan', 1),
(360, '57', 44, '57463', 3, 'MOSELLE', 'Moselle', 1),
(361, '58', 27, '58194', 3, 'NIEVRE', 'Nièvre', 1),
(362, '59', 32, '59350', 2, 'NORD', 'Nord', 1),
(363, '60', 32, '60057', 5, 'OISE', 'Oise', 1),
(364, '61', 28, '61001', 5, 'ORNE', 'Orne', 1),
(365, '62', 32, '62041', 2, 'PAS-DE-CALAIS', 'Pas-de-Calais', 1),
(366, '63', 84, '63113', 2, 'PUY-DE-DOME', 'Puy-de-Dôme', 1),
(367, '64', 75, '64445', 4, 'PYRENEES-ATLANTIQUES', 'Pyrénées-Atlantiques', 1),
(368, '65', 76, '65440', 4, 'HAUTES-PYRENEES', 'Hautes-Pyrénées', 1),
(369, '66', 76, '66136', 4, 'PYRENEES-ORIENTALES', 'Pyrénées-Orientales', 1),
(370, '67', 44, '67482', 2, 'BAS-RHIN', 'Bas-Rhin', 1),
(371, '68', 44, '68066', 2, 'HAUT-RHIN', 'Haut-Rhin', 1),
(372, '69', 84, '69123', 2, 'RHONE', 'Rhône', 1),
(373, '70', 27, '70550', 3, 'HAUTE-SAONE', 'Haute-Saône', 1),
(374, '71', 27, '71270', 0, 'SAONE-ET-LOIRE', 'Saône-et-Loire', 1),
(375, '72', 52, '72181', 3, 'SARTHE', 'Sarthe', 1),
(376, '73', 84, '73065', 3, 'SAVOIE', 'Savoie', 1),
(377, '74', 84, '74010', 3, 'HAUTE-SAVOIE', 'Haute-Savoie', 1),
(378, '75', 11, '75056', 0, 'PARIS', 'Paris', 1),
(379, '76', 28, '76540', 3, 'SEINE-MARITIME', 'Seine-Maritime', 1),
(380, '77', 11, '77288', 0, 'SEINE-ET-MARNE', 'Seine-et-Marne', 1),
(381, '78', 11, '78646', 4, 'YVELINES', 'Yvelines', 1),
(382, '79', 75, '79191', 4, 'DEUX-SEVRES', 'Deux-Sèvres', 1),
(383, '80', 32, '80021', 3, 'SOMME', 'Somme', 1),
(384, '81', 76, '81004', 2, 'TARN', 'Tarn', 1),
(385, '82', 76, '82121', 0, 'TARN-ET-GARONNE', 'Tarn-et-Garonne', 1),
(386, '83', 93, '83137', 2, 'VAR', 'Var', 1),
(387, '84', 93, '84007', 0, 'VAUCLUSE', 'Vaucluse', 1),
(388, '85', 52, '85191', 3, 'VENDEE', 'Vendée', 1),
(389, '86', 75, '86194', 3, 'VIENNE', 'Vienne', 1),
(390, '87', 75, '87085', 3, 'HAUTE-VIENNE', 'Haute-Vienne', 1),
(391, '88', 44, '88160', 4, 'VOSGES', 'Vosges', 1),
(392, '89', 27, '89024', 5, 'YONNE', 'Yonne', 1),
(393, '90', 27, '90010', 0, 'TERRITOIRE DE BELFORT', 'Territoire de Belfort', 1),
(394, '91', 11, '91228', 5, 'ESSONNE', 'Essonne', 1),
(395, '92', 11, '92050', 4, 'HAUTS-DE-SEINE', 'Hauts-de-Seine', 1),
(396, '93', 11, '93008', 3, 'SEINE-SAINT-DENIS', 'Seine-Saint-Denis', 1),
(397, '94', 11, '94028', 2, 'VAL-DE-MARNE', 'Val-de-Marne', 1),
(398, '95', 11, '95500', 2, 'VAL-D OISE', 'Val-d Oise', 1),
(399, 'BW', 501, NULL, NULL, 'BADEN-WÜRTTEMBERG', 'Baden-Württemberg', 1),
(400, 'BY', 501, NULL, NULL, 'BAYERN', 'Bayern', 1),
(401, 'BE', 501, NULL, NULL, 'BERLIN', 'Berlin', 1),
(402, 'BB', 501, NULL, NULL, 'BRANDENBURG', 'Brandenburg', 1),
(403, 'HB', 501, NULL, NULL, 'BREMEN', 'Bremen', 1),
(404, 'HH', 501, NULL, NULL, 'HAMBURG', 'Hamburg', 1),
(405, 'HE', 501, NULL, NULL, 'HESSEN', 'Hessen', 1),
(406, 'MV', 501, NULL, NULL, 'MECKLENBURG-VORPOMMERN', 'Mecklenburg-Vorpommern', 1),
(407, 'NI', 501, NULL, NULL, 'NIEDERSACHSEN', 'Niedersachsen', 1),
(408, 'NW', 501, NULL, NULL, 'NORDRHEIN-WESTFALEN', 'Nordrhein-Westfalen', 1),
(409, 'RP', 501, NULL, NULL, 'RHEINLAND-PFALZ', 'Rheinland-Pfalz', 1),
(410, 'SL', 501, NULL, NULL, 'SAARLAND', 'Saarland', 1),
(411, 'SN', 501, NULL, NULL, 'SACHSEN', 'Sachsen', 1),
(412, 'ST', 501, NULL, NULL, 'SACHSEN-ANHALT', 'Sachsen-Anhalt', 1),
(413, 'SH', 501, NULL, NULL, 'SCHLESWIG-HOLSTEIN', 'Schleswig-Holstein', 1),
(414, 'TH', 501, NULL, NULL, 'THÜRINGEN', 'Thüringen', 1),
(415, '66', 10201, '', 0, '', 'Αθήνα', 1),
(416, '67', 10205, '', 0, '', 'Δράμα', 1),
(417, '01', 10205, '', 0, '', 'Έβρος', 1),
(418, '02', 10205, '', 0, '', 'Θάσος', 1),
(419, '03', 10205, '', 0, '', 'Καβάλα', 1),
(420, '04', 10205, '', 0, '', 'Ξάνθη', 1),
(421, '05', 10205, '', 0, '', 'Ροδόπη', 1),
(422, '06', 10203, '', 0, '', 'Ημαθία', 1),
(423, '07', 10203, '', 0, '', 'Θεσσαλονίκη', 1),
(424, '08', 10203, '', 0, '', 'Κιλκίς', 1),
(425, '09', 10203, '', 0, '', 'Πέλλα', 1),
(426, '10', 10203, '', 0, '', 'Πιερία', 1),
(427, '11', 10203, '', 0, '', 'Σέρρες', 1),
(428, '12', 10203, '', 0, '', 'Χαλκιδική', 1),
(429, '13', 10206, '', 0, '', 'Άρτα', 1),
(430, '14', 10206, '', 0, '', 'Θεσπρωτία', 1),
(431, '15', 10206, '', 0, '', 'Ιωάννινα', 1),
(432, '16', 10206, '', 0, '', 'Πρέβεζα', 1),
(433, '17', 10213, '', 0, '', 'Γρεβενά', 1),
(434, '18', 10213, '', 0, '', 'Καστοριά', 1),
(435, '19', 10213, '', 0, '', 'Κοζάνη', 1),
(436, '20', 10213, '', 0, '', 'Φλώρινα', 1),
(437, '21', 10212, '', 0, '', 'Καρδίτσα', 1),
(438, '22', 10212, '', 0, '', 'Λάρισα', 1),
(439, '23', 10212, '', 0, '', 'Μαγνησία', 1),
(440, '24', 10212, '', 0, '', 'Τρίκαλα', 1),
(441, '25', 10212, '', 0, '', 'Σποράδες', 1),
(442, '26', 10212, '', 0, '', 'Βοιωτία', 1),
(443, '27', 10202, '', 0, '', 'Εύβοια', 1),
(444, '28', 10202, '', 0, '', 'Ευρυτανία', 1),
(445, '29', 10202, '', 0, '', 'Φθιώτιδα', 1),
(446, '30', 10202, '', 0, '', 'Φωκίδα', 1),
(447, '31', 10209, '', 0, '', 'Αργολίδα', 1),
(448, '32', 10209, '', 0, '', 'Αρκαδία', 1),
(449, '33', 10209, '', 0, '', 'Κορινθία', 1),
(450, '34', 10209, '', 0, '', 'Λακωνία', 1),
(451, '35', 10209, '', 0, '', 'Μεσσηνία', 1),
(452, '36', 10211, '', 0, '', 'Αιτωλοακαρνανία', 1),
(453, '37', 10211, '', 0, '', 'Αχαΐα', 1),
(454, '38', 10211, '', 0, '', 'Ηλεία', 1),
(455, '39', 10207, '', 0, '', 'Ζάκυνθος', 1),
(456, '40', 10207, '', 0, '', 'Κέρκυρα', 1),
(457, '41', 10207, '', 0, '', 'Κεφαλληνία', 1),
(458, '42', 10207, '', 0, '', 'Ιθάκη', 1),
(459, '43', 10207, '', 0, '', 'Λευκάδα', 1),
(460, '44', 10208, '', 0, '', 'Ικαρία', 1),
(461, '45', 10208, '', 0, '', 'Λέσβος', 1),
(462, '46', 10208, '', 0, '', 'Λήμνος', 1),
(463, '47', 10208, '', 0, '', 'Σάμος', 1),
(464, '48', 10208, '', 0, '', 'Χίος', 1),
(465, '49', 10210, '', 0, '', 'Άνδρος', 1),
(466, '50', 10210, '', 0, '', 'Θήρα', 1),
(467, '51', 10210, '', 0, '', 'Κάλυμνος', 1),
(468, '52', 10210, '', 0, '', 'Κάρπαθος', 1),
(469, '53', 10210, '', 0, '', 'Κέα-Κύθνος', 1),
(470, '54', 10210, '', 0, '', 'Κω', 1),
(471, '55', 10210, '', 0, '', 'Μήλος', 1),
(472, '56', 10210, '', 0, '', 'Μύκονος', 1),
(473, '57', 10210, '', 0, '', 'Νάξος', 1),
(474, '58', 10210, '', 0, '', 'Πάρος', 1),
(475, '59', 10210, '', 0, '', 'Ρόδος', 1),
(476, '60', 10210, '', 0, '', 'Σύρος', 1),
(477, '61', 10210, '', 0, '', 'Τήνος', 1),
(478, '62', 10204, '', 0, '', 'Ηράκλειο', 1),
(479, '63', 10204, '', 0, '', 'Λασίθι', 1),
(480, '64', 10204, '', 0, '', 'Ρέθυμνο', 1),
(481, '65', 10204, '', 0, '', 'Χανιά', 1),
(482, 'AT', 11401, '', 0, 'AT', 'Atlántida', 1),
(483, 'CH', 11401, '', 0, 'CH', 'Choluteca', 1),
(484, 'CL', 11401, '', 0, 'CL', 'Colón', 1),
(485, 'CM', 11401, '', 0, 'CM', 'Comayagua', 1),
(486, 'CO', 11401, '', 0, 'CO', 'Copán', 1),
(487, 'CR', 11401, '', 0, 'CR', 'Cortés', 1),
(488, 'EP', 11401, '', 0, 'EP', 'El Paraíso', 1),
(489, 'FM', 11401, '', 0, 'FM', 'Francisco Morazán', 1),
(490, 'GD', 11401, '', 0, 'GD', 'Gracias a Dios', 1),
(491, 'IN', 11401, '', 0, 'IN', 'Intibucá', 1),
(492, 'IB', 11401, '', 0, 'IB', 'Islas de la Bahía', 1),
(493, 'LP', 11401, '', 0, 'LP', 'La Paz', 1),
(494, 'LM', 11401, '', 0, 'LM', 'Lempira', 1),
(495, 'OC', 11401, '', 0, 'OC', 'Ocotepeque', 1),
(496, 'OL', 11401, '', 0, 'OL', 'Olancho', 1),
(497, 'SB', 11401, '', 0, 'SB', 'Santa Bárbara', 1),
(498, 'VL', 11401, '', 0, 'VL', 'Valle', 1),
(499, 'YO', 11401, '', 0, 'YO', 'Yoro', 1),
(500, 'DC', 11401, '', 0, 'DC', 'Distrito Central', 1),
(501, 'HU-BU', 180100, 'HU101', NULL, NULL, 'Budapest', 1),
(502, 'HU-PE', 180100, 'HU102', NULL, NULL, 'Pest', 1),
(503, 'HU-FE', 182100, 'HU211', NULL, NULL, 'Fejér', 1),
(504, 'HU-KE', 182100, 'HU212', NULL, NULL, 'Komárom-Esztergom', 1),
(505, 'HU-VE', 182100, 'HU213', NULL, NULL, 'Veszprém', 1),
(506, 'HU-GS', 182200, 'HU221', NULL, NULL, 'Győr-Moson-Sopron', 1),
(507, 'HU-VA', 182200, 'HU222', NULL, NULL, 'Vas', 1),
(508, 'HU-ZA', 182200, 'HU223', NULL, NULL, 'Zala', 1),
(509, 'HU-BA', 182300, 'HU231', NULL, NULL, 'Baranya', 1),
(510, 'HU-SO', 182300, 'HU232', NULL, NULL, 'Somogy', 1),
(511, 'HU-TO', 182300, 'HU233', NULL, NULL, 'Tolna', 1),
(512, 'HU-BZ', 183100, 'HU311', NULL, NULL, 'Borsod-Abaúj-Zemplén', 1),
(513, 'HU-HE', 183100, 'HU312', NULL, NULL, 'Heves', 1),
(514, 'HU-NO', 183100, 'HU313', NULL, NULL, 'Nógrád', 1),
(515, 'HU-HB', 183200, 'HU321', NULL, NULL, 'Hajdú-Bihar', 1),
(516, 'HU-JN', 183200, 'HU322', NULL, NULL, 'Jász-Nagykun-Szolnok', 1),
(517, 'HU-SZ', 183200, 'HU323', NULL, NULL, 'Szabolcs-Szatmár-Bereg', 1),
(518, 'HU-BK', 183300, 'HU331', NULL, NULL, 'Bács-Kiskun', 1),
(519, 'HU-BE', 183300, 'HU332', NULL, NULL, 'Békés', 1),
(520, 'HU-CS', 183300, 'HU333', NULL, NULL, 'Csongrád', 1),
(521, 'AG', 315, NULL, NULL, NULL, 'AGRIGENTO', 1),
(522, 'AL', 312, NULL, NULL, NULL, 'ALESSANDRIA', 1),
(523, 'AN', 310, NULL, NULL, NULL, 'ANCONA', 1),
(524, 'AO', 319, NULL, NULL, NULL, 'AOSTA', 1),
(525, 'AR', 316, NULL, NULL, NULL, 'AREZZO', 1),
(526, 'AP', 310, NULL, NULL, NULL, 'ASCOLI PICENO', 1),
(527, 'AT', 312, NULL, NULL, NULL, 'ASTI', 1),
(528, 'AV', 304, NULL, NULL, NULL, 'AVELLINO', 1),
(529, 'BA', 313, NULL, NULL, NULL, 'BARI', 1),
(530, 'BT', 313, NULL, NULL, NULL, 'BARLETTA-ANDRIA-TRANI', 1),
(531, 'BL', 320, NULL, NULL, NULL, 'BELLUNO', 1),
(532, 'BN', 304, NULL, NULL, NULL, 'BENEVENTO', 1),
(533, 'BG', 309, NULL, NULL, NULL, 'BERGAMO', 1),
(534, 'BI', 312, NULL, NULL, NULL, 'BIELLA', 1),
(535, 'BO', 305, NULL, NULL, NULL, 'BOLOGNA', 1),
(536, 'BZ', 317, NULL, NULL, NULL, 'BOLZANO', 1),
(537, 'BS', 309, NULL, NULL, NULL, 'BRESCIA', 1),
(538, 'BR', 313, NULL, NULL, NULL, 'BRINDISI', 1),
(539, 'CA', 314, NULL, NULL, NULL, 'CAGLIARI', 1),
(540, 'CL', 315, NULL, NULL, NULL, 'CALTANISSETTA', 1),
(541, 'CB', 311, NULL, NULL, NULL, 'CAMPOBASSO', 1),
(542, 'CI', 314, NULL, NULL, NULL, 'CARBONIA-IGLESIAS', 1),
(543, 'CE', 304, NULL, NULL, NULL, 'CASERTA', 1),
(544, 'CT', 315, NULL, NULL, NULL, 'CATANIA', 1),
(545, 'CZ', 303, NULL, NULL, NULL, 'CATANZARO', 1),
(546, 'CH', 301, NULL, NULL, NULL, 'CHIETI', 1),
(547, 'CO', 309, NULL, NULL, NULL, 'COMO', 1),
(548, 'CS', 303, NULL, NULL, NULL, 'COSENZA', 1),
(549, 'CR', 309, NULL, NULL, NULL, 'CREMONA', 1),
(550, 'KR', 303, NULL, NULL, NULL, 'CROTONE', 1),
(551, 'CN', 312, NULL, NULL, NULL, 'CUNEO', 1),
(552, 'EN', 315, NULL, NULL, NULL, 'ENNA', 1),
(553, 'FM', 310, NULL, NULL, NULL, 'FERMO', 1),
(554, 'FE', 305, NULL, NULL, NULL, 'FERRARA', 1),
(555, 'FI', 316, NULL, NULL, NULL, 'FIRENZE', 1),
(556, 'FG', 313, NULL, NULL, NULL, 'FOGGIA', 1),
(557, 'FC', 305, NULL, NULL, NULL, 'FORLI-CESENA', 1),
(558, 'FR', 307, NULL, NULL, NULL, 'FROSINONE', 1),
(559, 'GE', 308, NULL, NULL, NULL, 'GENOVA', 1),
(560, 'GO', 306, NULL, NULL, NULL, 'GORIZIA', 1),
(561, 'GR', 316, NULL, NULL, NULL, 'GROSSETO', 1),
(562, 'IM', 308, NULL, NULL, NULL, 'IMPERIA', 1),
(563, 'IS', 311, NULL, NULL, NULL, 'ISERNIA', 1),
(564, 'SP', 308, NULL, NULL, NULL, 'LA SPEZIA', 1),
(565, 'AQ', 301, NULL, NULL, NULL, 'L AQUILA', 1),
(566, 'LT', 307, NULL, NULL, NULL, 'LATINA', 1),
(567, 'LE', 313, NULL, NULL, NULL, 'LECCE', 1),
(568, 'LC', 309, NULL, NULL, NULL, 'LECCO', 1),
(569, 'LI', 316, NULL, NULL, NULL, 'LIVORNO', 1),
(570, 'LO', 309, NULL, NULL, NULL, 'LODI', 1),
(571, 'LU', 316, NULL, NULL, NULL, 'LUCCA', 1),
(572, 'MC', 310, NULL, NULL, NULL, 'MACERATA', 1),
(573, 'MN', 309, NULL, NULL, NULL, 'MANTOVA', 1),
(574, 'MS', 316, NULL, NULL, NULL, 'MASSA-CARRARA', 1),
(575, 'MT', 302, NULL, NULL, NULL, 'MATERA', 1),
(576, 'VS', 314, NULL, NULL, NULL, 'MEDIO CAMPIDANO', 1),
(577, 'ME', 315, NULL, NULL, NULL, 'MESSINA', 1),
(578, 'MI', 309, NULL, NULL, NULL, 'MILANO', 1),
(579, 'MB', 309, NULL, NULL, NULL, 'MONZA e BRIANZA', 1),
(580, 'MO', 305, NULL, NULL, NULL, 'MODENA', 1),
(581, 'NA', 304, NULL, NULL, NULL, 'NAPOLI', 1),
(582, 'NO', 312, NULL, NULL, NULL, 'NOVARA', 1),
(583, 'NU', 314, NULL, NULL, NULL, 'NUORO', 1),
(584, 'OG', 314, NULL, NULL, NULL, 'OGLIASTRA', 1),
(585, 'OT', 314, NULL, NULL, NULL, 'OLBIA-TEMPIO', 1),
(586, 'OR', 314, NULL, NULL, NULL, 'ORISTANO', 1),
(587, 'PD', 320, NULL, NULL, NULL, 'PADOVA', 1),
(588, 'PA', 315, NULL, NULL, NULL, 'PALERMO', 1),
(589, 'PR', 305, NULL, NULL, NULL, 'PARMA', 1),
(590, 'PV', 309, NULL, NULL, NULL, 'PAVIA', 1),
(591, 'PG', 318, NULL, NULL, NULL, 'PERUGIA', 1),
(592, 'PU', 310, NULL, NULL, NULL, 'PESARO e URBINO', 1),
(593, 'PE', 301, NULL, NULL, NULL, 'PESCARA', 1),
(594, 'PC', 305, NULL, NULL, NULL, 'PIACENZA', 1),
(595, 'PI', 316, NULL, NULL, NULL, 'PISA', 1),
(596, 'PT', 316, NULL, NULL, NULL, 'PISTOIA', 1),
(597, 'PN', 306, NULL, NULL, NULL, 'PORDENONE', 1),
(598, 'PZ', 302, NULL, NULL, NULL, 'POTENZA', 1),
(599, 'PO', 316, NULL, NULL, NULL, 'PRATO', 1),
(600, 'RG', 315, NULL, NULL, NULL, 'RAGUSA', 1),
(601, 'RA', 305, NULL, NULL, NULL, 'RAVENNA', 1),
(602, 'RC', 303, NULL, NULL, NULL, 'REGGIO CALABRIA', 1),
(603, 'RE', 305, NULL, NULL, NULL, 'REGGIO NELL EMILIA', 1),
(604, 'RI', 307, NULL, NULL, NULL, 'RIETI', 1),
(605, 'RN', 305, NULL, NULL, NULL, 'RIMINI', 1),
(606, 'RM', 307, NULL, NULL, NULL, 'ROMA', 1),
(607, 'RO', 320, NULL, NULL, NULL, 'ROVIGO', 1),
(608, 'SA', 304, NULL, NULL, NULL, 'SALERNO', 1),
(609, 'SS', 314, NULL, NULL, NULL, 'SASSARI', 1),
(610, 'SV', 308, NULL, NULL, NULL, 'SAVONA', 1),
(611, 'SI', 316, NULL, NULL, NULL, 'SIENA', 1),
(612, 'SR', 315, NULL, NULL, NULL, 'SIRACUSA', 1),
(613, 'SO', 309, NULL, NULL, NULL, 'SONDRIO', 1),
(614, 'TA', 313, NULL, NULL, NULL, 'TARANTO', 1),
(615, 'TE', 301, NULL, NULL, NULL, 'TERAMO', 1),
(616, 'TR', 318, NULL, NULL, NULL, 'TERNI', 1),
(617, 'TO', 312, NULL, NULL, NULL, 'TORINO', 1),
(618, 'TP', 315, NULL, NULL, NULL, 'TRAPANI', 1),
(619, 'TN', 317, NULL, NULL, NULL, 'TRENTO', 1),
(620, 'TV', 320, NULL, NULL, NULL, 'TREVISO', 1),
(621, 'TS', 306, NULL, NULL, NULL, 'TRIESTE', 1),
(622, 'UD', 306, NULL, NULL, NULL, 'UDINE', 1),
(623, 'VA', 309, NULL, NULL, NULL, 'VARESE', 1),
(624, 'VE', 320, NULL, NULL, NULL, 'VENEZIA', 1),
(625, 'VB', 312, NULL, NULL, NULL, 'VERBANO-CUSIO-OSSOLA', 1),
(626, 'VC', 312, NULL, NULL, NULL, 'VERCELLI', 1),
(627, 'VR', 320, NULL, NULL, NULL, 'VERONA', 1),
(628, 'VV', 303, NULL, NULL, NULL, 'VIBO VALENTIA', 1),
(629, 'VI', 320, NULL, NULL, NULL, 'VICENZA', 1),
(630, 'VT', 307, NULL, NULL, NULL, 'VITERBO', 1),
(631, '01', 12301, '', 0, '北海', '北海道', 1),
(632, '02', 12301, '', 0, '青森', '青森県', 1),
(633, '03', 12301, '', 0, '岩手', '岩手県', 1),
(634, '04', 12301, '', 0, '宮城', '宮城県', 1),
(635, '05', 12301, '', 0, '秋田', '秋田県', 1),
(636, '06', 12301, '', 0, '山形', '山形県', 1),
(637, '07', 12301, '', 0, '福島', '福島県', 1),
(638, '08', 12301, '', 0, '茨城', '茨城県', 1),
(639, '09', 12301, '', 0, '栃木', '栃木県', 1),
(640, '10', 12301, '', 0, '群馬', '群馬県', 1),
(641, '11', 12301, '', 0, '埼玉', '埼玉県', 1),
(642, '12', 12301, '', 0, '千葉', '千葉県', 1),
(643, '13', 12301, '', 0, '東京', '東京都', 1),
(644, '14', 12301, '', 0, '神奈川', '神奈川県', 1),
(645, '15', 12301, '', 0, '新潟', '新潟県', 1),
(646, '16', 12301, '', 0, '富山', '富山県', 1),
(647, '17', 12301, '', 0, '石川', '石川県', 1),
(648, '18', 12301, '', 0, '福井', '福井県', 1),
(649, '19', 12301, '', 0, '山梨', '山梨県', 1),
(650, '20', 12301, '', 0, '長野', '長野県', 1),
(651, '21', 12301, '', 0, '岐阜', '岐阜県', 1),
(652, '22', 12301, '', 0, '静岡', '静岡県', 1),
(653, '23', 12301, '', 0, '愛知', '愛知県', 1),
(654, '24', 12301, '', 0, '三重', '三重県', 1),
(655, '25', 12301, '', 0, '滋賀', '滋賀県', 1),
(656, '26', 12301, '', 0, '京都', '京都府', 1),
(657, '27', 12301, '', 0, '大阪', '大阪府', 1),
(658, '28', 12301, '', 0, '兵庫', '兵庫県', 1),
(659, '29', 12301, '', 0, '奈良', '奈良県', 1),
(660, '30', 12301, '', 0, '和歌山', '和歌山県', 1),
(661, '31', 12301, '', 0, '鳥取', '鳥取県', 1),
(662, '32', 12301, '', 0, '島根', '島根県', 1),
(663, '33', 12301, '', 0, '岡山', '岡山県', 1),
(664, '34', 12301, '', 0, '広島', '広島県', 1),
(665, '35', 12301, '', 0, '山口', '山口県', 1),
(666, '36', 12301, '', 0, '徳島', '徳島県', 1),
(667, '37', 12301, '', 0, '香川', '香川県', 1),
(668, '38', 12301, '', 0, '愛媛', '愛媛県', 1),
(669, '39', 12301, '', 0, '高知', '高知県', 1),
(670, '40', 12301, '', 0, '福岡', '福岡県', 1),
(671, '41', 12301, '', 0, '佐賀', '佐賀県', 1),
(672, '42', 12301, '', 0, '長崎', '長崎県', 1),
(673, '43', 12301, '', 0, '熊本', '熊本県', 1),
(674, '44', 12301, '', 0, '大分', '大分県', 1),
(675, '45', 12301, '', 0, '宮崎', '宮崎県', 1),
(676, '46', 12301, '', 0, '鹿児島', '鹿児島県', 1),
(677, '47', 12301, '', 0, '沖縄', '沖縄県', 1),
(678, 'LU0001', 14001, '', 0, '', 'Clervaux', 1),
(679, 'LU0002', 14001, '', 0, '', 'Diekirch', 1),
(680, 'LU0003', 14001, '', 0, '', 'Redange', 1),
(681, 'LU0004', 14001, '', 0, '', 'Vianden', 1),
(682, 'LU0005', 14001, '', 0, '', 'Wiltz', 1),
(683, 'LU0006', 14002, '', 0, '', 'Echternach', 1),
(684, 'LU0007', 14002, '', 0, '', 'Grevenmacher', 1),
(685, 'LU0008', 14002, '', 0, '', 'Remich', 1),
(686, 'LU0009', 14003, '', 0, '', 'Capellen', 1),
(687, 'LU0010', 14003, '', 0, '', 'Esch-sur-Alzette', 1),
(688, 'LU0011', 14003, '', 0, '', 'Luxembourg', 1),
(689, 'LU0012', 14003, '', 0, '', 'Mersch', 1),
(690, 'MA', 1209, '', 0, '', 'Province de Benslimane', 1),
(691, 'MA1', 1209, '', 0, '', 'Province de Berrechid', 1),
(692, 'MA2', 1209, '', 0, '', 'Province de Khouribga', 1),
(693, 'MA3', 1209, '', 0, '', 'Province de Settat', 1),
(694, 'MA4', 1210, '', 0, '', 'Province d\'El Jadida', 1),
(695, 'MA5', 1210, '', 0, '', 'Province de Safi', 1),
(696, 'MA6', 1210, '', 0, '', 'Province de Sidi Bennour', 1),
(697, 'MA7', 1210, '', 0, '', 'Province de Youssoufia', 1),
(698, 'MA6B', 1205, '', 0, '', 'Préfecture de Fès', 1),
(699, 'MA7B', 1205, '', 0, '', 'Province de Boulemane', 1),
(700, 'MA8', 1205, '', 0, '', 'Province de Moulay Yacoub', 1),
(701, 'MA9', 1205, '', 0, '', 'Province de Sefrou', 1),
(702, 'MA8A', 1202, '', 0, '', 'Province de Kénitra', 1),
(703, 'MA9A', 1202, '', 0, '', 'Province de Sidi Kacem', 1),
(704, 'MA10', 1202, '', 0, '', 'Province de Sidi Slimane', 1),
(705, 'MA11', 1208, '', 0, '', 'Préfecture de Casablanca', 1),
(706, 'MA12', 1208, '', 0, '', 'Préfecture de Mohammédia', 1),
(707, 'MA13', 1208, '', 0, '', 'Province de Médiouna', 1),
(708, 'MA14', 1208, '', 0, '', 'Province de Nouaceur', 1),
(709, 'MA15', 1214, '', 0, '', 'Province d\'Assa-Zag', 1),
(710, 'MA16', 1214, '', 0, '', 'Province d\'Es-Semara', 1),
(711, 'MA17A', 1214, '', 0, '', 'Province de Guelmim', 1),
(712, 'MA18', 1214, '', 0, '', 'Province de Tata', 1),
(713, 'MA19', 1214, '', 0, '', 'Province de Tan-Tan', 1),
(714, 'MA15', 1215, '', 0, '', 'Province de Boujdour', 1),
(715, 'MA16', 1215, '', 0, '', 'Province de Lâayoune', 1),
(716, 'MA17', 1215, '', 0, '', 'Province de Tarfaya', 1),
(717, 'MA18', 1211, '', 0, '', 'Préfecture de Marrakech', 1),
(718, 'MA19', 1211, '', 0, '', 'Province d\'Al Haouz', 1),
(719, 'MA20', 1211, '', 0, '', 'Province de Chichaoua', 1),
(720, 'MA21', 1211, '', 0, '', 'Province d\'El Kelâa des Sraghna', 1),
(721, 'MA22', 1211, '', 0, '', 'Province d\'Essaouira', 1),
(722, 'MA23', 1211, '', 0, '', 'Province de Rehamna', 1),
(723, 'MA24', 1206, '', 0, '', 'Préfecture de Meknès', 1),
(724, 'MA25', 1206, '', 0, '', 'Province d’El Hajeb', 1),
(725, 'MA26', 1206, '', 0, '', 'Province d\'Errachidia', 1),
(726, 'MA27', 1206, '', 0, '', 'Province d’Ifrane', 1),
(727, 'MA28', 1206, '', 0, '', 'Province de Khénifra', 1),
(728, 'MA29', 1206, '', 0, '', 'Province de Midelt', 1),
(729, 'MA30', 1204, '', 0, '', 'Préfecture d\'Oujda-Angad', 1),
(730, 'MA31', 1204, '', 0, '', 'Province de Berkane', 1),
(731, 'MA32', 1204, '', 0, '', 'Province de Driouch', 1),
(732, 'MA33', 1204, '', 0, '', 'Province de Figuig', 1),
(733, 'MA34', 1204, '', 0, '', 'Province de Jerada', 1),
(734, 'MA35', 1204, '', 0, '', 'Province de Nador', 1),
(735, 'MA36', 1204, '', 0, '', 'Province de Taourirt', 1),
(736, 'MA37', 1216, '', 0, '', 'Province d\'Aousserd', 1),
(737, 'MA38', 1216, '', 0, '', 'Province d\'Oued Ed-Dahab', 1),
(738, 'MA39', 1207, '', 0, '', 'Préfecture de Rabat', 1),
(739, 'MA40', 1207, '', 0, '', 'Préfecture de Skhirat-Témara', 1),
(740, 'MA41', 1207, '', 0, '', 'Préfecture de Salé', 1),
(741, 'MA42', 1207, '', 0, '', 'Province de Khémisset', 1),
(742, 'MA43', 1213, '', 0, '', 'Préfecture d\'Agadir Ida-Outanane', 1),
(743, 'MA44', 1213, '', 0, '', 'Préfecture d\'Inezgane-Aït Melloul', 1),
(744, 'MA45', 1213, '', 0, '', 'Province de Chtouka-Aït Baha', 1),
(745, 'MA46', 1213, '', 0, '', 'Province d\'Ouarzazate', 1),
(746, 'MA47', 1213, '', 0, '', 'Province de Sidi Ifni', 1),
(747, 'MA48', 1213, '', 0, '', 'Province de Taroudant', 1),
(748, 'MA49', 1213, '', 0, '', 'Province de Tinghir', 1),
(749, 'MA50', 1213, '', 0, '', 'Province de Tiznit', 1),
(750, 'MA51', 1213, '', 0, '', 'Province de Zagora', 1),
(751, 'MA52', 1212, '', 0, '', 'Province d\'Azilal', 1),
(752, 'MA53', 1212, '', 0, '', 'Province de Beni Mellal', 1),
(753, 'MA54', 1212, '', 0, '', 'Province de Fquih Ben Salah', 1),
(754, 'MA55', 1201, '', 0, '', 'Préfecture de M\'diq-Fnideq', 1),
(755, 'MA56', 1201, '', 0, '', 'Préfecture de Tanger-Asilah', 1),
(756, 'MA57', 1201, '', 0, '', 'Province de Chefchaouen', 1),
(757, 'MA58', 1201, '', 0, '', 'Province de Fahs-Anjra', 1),
(758, 'MA59', 1201, '', 0, '', 'Province de Larache', 1),
(759, 'MA60', 1201, '', 0, '', 'Province d\'Ouezzane', 1),
(760, 'MA61', 1201, '', 0, '', 'Province de Tétouan', 1),
(761, 'MA62', 1203, '', 0, '', 'Province de Guercif', 1),
(762, 'MA63', 1203, '', 0, '', 'Province d\'Al Hoceïma', 1),
(763, 'MA64', 1203, '', 0, '', 'Province de Taounate', 1),
(764, 'MA65', 1203, '', 0, '', 'Province de Taza', 1),
(765, 'MA6A', 1205, '', 0, '', 'Préfecture de Fès', 1),
(766, 'MA7A', 1205, '', 0, '', 'Province de Boulemane', 1),
(767, 'MA15A', 1214, '', 0, '', 'Province d\'Assa-Zag', 1),
(768, 'MA16A', 1214, '', 0, '', 'Province d\'Es-Semara', 1),
(769, 'MA18A', 1211, '', 0, '', 'Préfecture de Marrakech', 1),
(770, 'MA19A', 1214, '', 0, '', 'Province de Tan-Tan', 1),
(771, 'MA19B', 1214, '', 0, '', 'Province de Tan-Tan', 1),
(772, 'GR', 1701, NULL, NULL, NULL, 'Groningen', 1),
(773, 'FR', 1701, NULL, NULL, NULL, 'Friesland', 1),
(774, 'DR', 1701, NULL, NULL, NULL, 'Drenthe', 1),
(775, 'OV', 1701, NULL, NULL, NULL, 'Overijssel', 1),
(776, 'GD', 1701, NULL, NULL, NULL, 'Gelderland', 1),
(777, 'FL', 1701, NULL, NULL, NULL, 'Flevoland', 1),
(778, 'UT', 1701, NULL, NULL, NULL, 'Utrecht', 1),
(779, 'NH', 1701, NULL, NULL, NULL, 'Noord-Holland', 1),
(780, 'ZH', 1701, NULL, NULL, NULL, 'Zuid-Holland', 1),
(781, 'ZL', 1701, NULL, NULL, NULL, 'Zeeland', 1),
(782, 'NB', 1701, NULL, NULL, NULL, 'Noord-Brabant', 1),
(783, 'LB', 1701, NULL, NULL, NULL, 'Limburg', 1),
(784, 'PA-1', 17801, '', 0, '', 'Bocas del Toro', 1),
(785, 'PA-2', 17801, '', 0, '', 'Coclé', 1),
(786, 'PA-3', 17801, '', 0, '', 'Colón', 1),
(787, 'PA-4', 17801, '', 0, '', 'Chiriquí', 1),
(788, 'PA-5', 17801, '', 0, '', 'Darién', 1),
(789, 'PA-6', 17801, '', 0, '', 'Herrera', 1),
(790, 'PA-7', 17801, '', 0, '', 'Los Santos', 1),
(791, 'PA-8', 17801, '', 0, '', 'Panamá', 1),
(792, 'PA-9', 17801, '', 0, '', 'Veraguas', 1),
(793, 'PA-13', 17801, '', 0, '', 'Panamá Oeste', 1),
(794, '0101', 18101, '', 0, '', 'Chachapoyas', 1),
(795, '0102', 18101, '', 0, '', 'Bagua', 1),
(796, '0103', 18101, '', 0, '', 'Bongará', 1),
(797, '0104', 18101, '', 0, '', 'Condorcanqui', 1),
(798, '0105', 18101, '', 0, '', 'Luya', 1),
(799, '0106', 18101, '', 0, '', 'Rodríguez de Mendoza', 1),
(800, '0107', 18101, '', 0, '', 'Utcubamba', 1),
(801, '0201', 18102, '', 0, '', 'Huaraz', 1),
(802, '0202', 18102, '', 0, '', 'Aija', 1),
(803, '0203', 18102, '', 0, '', 'Antonio Raymondi', 1),
(804, '0204', 18102, '', 0, '', 'Asunción', 1),
(805, '0205', 18102, '', 0, '', 'Bolognesi', 1),
(806, '0206', 18102, '', 0, '', 'Carhuaz', 1),
(807, '0207', 18102, '', 0, '', 'Carlos Fermín Fitzcarrald', 1),
(808, '0208', 18102, '', 0, '', 'Casma', 1),
(809, '0209', 18102, '', 0, '', 'Corongo', 1),
(810, '0210', 18102, '', 0, '', 'Huari', 1),
(811, '0211', 18102, '', 0, '', 'Huarmey', 1),
(812, '0212', 18102, '', 0, '', 'Huaylas', 1),
(813, '0213', 18102, '', 0, '', 'Mariscal Luzuriaga', 1),
(814, '0214', 18102, '', 0, '', 'Ocros', 1),
(815, '0215', 18102, '', 0, '', 'Pallasca', 1),
(816, '0216', 18102, '', 0, '', 'Pomabamba', 1),
(817, '0217', 18102, '', 0, '', 'Recuay', 1),
(818, '0218', 18102, '', 0, '', 'Papá', 1),
(819, '0219', 18102, '', 0, '', 'Sihuas', 1),
(820, '0220', 18102, '', 0, '', 'Yungay', 1),
(821, '0301', 18103, '', 0, '', 'Abancay', 1),
(822, '0302', 18103, '', 0, '', 'Andahuaylas', 1),
(823, '0303', 18103, '', 0, '', 'Antabamba', 1),
(824, '0304', 18103, '', 0, '', 'Aymaraes', 1),
(825, '0305', 18103, '', 0, '', 'Cotabambas', 1),
(826, '0306', 18103, '', 0, '', 'Chincheros', 1),
(827, '0307', 18103, '', 0, '', 'Grau', 1),
(828, '0401', 18104, '', 0, '', 'Arequipa', 1),
(829, '0402', 18104, '', 0, '', 'Camaná', 1),
(830, '0403', 18104, '', 0, '', 'Caravelí', 1),
(831, '0404', 18104, '', 0, '', 'Castilla', 1),
(832, '0405', 18104, '', 0, '', 'Caylloma', 1),
(833, '0406', 18104, '', 0, '', 'Condesuyos', 1),
(834, '0407', 18104, '', 0, '', 'Islay', 1),
(835, '0408', 18104, '', 0, '', 'La Unión', 1),
(836, '0501', 18105, '', 0, '', 'Huamanga', 1),
(837, '0502', 18105, '', 0, '', 'Cangallo', 1),
(838, '0503', 18105, '', 0, '', 'Huanca Sancos', 1),
(839, '0504', 18105, '', 0, '', 'Huanta', 1),
(840, '0505', 18105, '', 0, '', 'La Mar', 1),
(841, '0506', 18105, '', 0, '', 'Lucanas', 1),
(842, '0507', 18105, '', 0, '', 'Parinacochas', 1),
(843, '0508', 18105, '', 0, '', 'Páucar del Sara Sara', 1),
(844, '0509', 18105, '', 0, '', 'Sucre', 1),
(845, '0510', 18105, '', 0, '', 'Víctor Fajardo', 1),
(846, '0511', 18105, '', 0, '', 'Vilcas Huamán', 1),
(847, '0601', 18106, '', 0, '', 'Cajamarca', 1),
(848, '0602', 18106, '', 0, '', 'Cajabamba', 1),
(849, '0603', 18106, '', 0, '', 'Celendín', 1),
(850, '0604', 18106, '', 0, '', 'Chota', 1),
(851, '0605', 18106, '', 0, '', 'Contumazá', 1),
(852, '0606', 18106, '', 0, '', 'Cutervo', 1),
(853, '0607', 18106, '', 0, '', 'Hualgayoc', 1),
(854, '0608', 18106, '', 0, '', 'Jaén', 1),
(855, '0609', 18106, '', 0, '', 'San Ignacio', 1),
(856, '0610', 18106, '', 0, '', 'San Marcos', 1),
(857, '0611', 18106, '', 0, '', 'San Miguel', 1),
(858, '0612', 18106, '', 0, '', 'San Pablo', 1),
(859, '0613', 18106, '', 0, '', 'Santa Cruz', 1),
(860, '0701', 18107, '', 0, '', 'Callao', 1),
(861, '0801', 18108, '', 0, '', 'Cusco', 1),
(862, '0802', 18108, '', 0, '', 'Acomayo', 1),
(863, '0803', 18108, '', 0, '', 'Anta', 1),
(864, '0804', 18108, '', 0, '', 'Calca', 1),
(865, '0805', 18108, '', 0, '', 'Canas', 1),
(866, '0806', 18108, '', 0, '', 'Canchis', 1),
(867, '0807', 18108, '', 0, '', 'Chumbivilcas', 1),
(868, '0808', 18108, '', 0, '', 'Espinar', 1),
(869, '0809', 18108, '', 0, '', 'La Convención', 1),
(870, '0810', 18108, '', 0, '', 'Paruro', 1),
(871, '0811', 18108, '', 0, '', 'Paucartambo', 1),
(872, '0812', 18108, '', 0, '', 'Quispicanchi', 1),
(873, '0813', 18108, '', 0, '', 'Urubamba', 1),
(874, '0901', 18109, '', 0, '', 'Huancavelica', 1),
(875, '0902', 18109, '', 0, '', 'Acobamba', 1),
(876, '0903', 18109, '', 0, '', 'Angaraes', 1),
(877, '0904', 18109, '', 0, '', 'Castrovirreyna', 1),
(878, '0905', 18109, '', 0, '', 'Churcampa', 1),
(879, '0906', 18109, '', 0, '', 'Huaytará', 1),
(880, '0907', 18109, '', 0, '', 'Tayacaja', 1),
(881, '1001', 18110, '', 0, '', 'Huánuco', 1),
(882, '1002', 18110, '', 0, '', 'Ambón', 1),
(883, '1003', 18110, '', 0, '', 'Dos de Mayo', 1),
(884, '1004', 18110, '', 0, '', 'Huacaybamba', 1),
(885, '1005', 18110, '', 0, '', 'Huamalíes', 1),
(886, '1006', 18110, '', 0, '', 'Leoncio Prado', 1),
(887, '1007', 18110, '', 0, '', 'Marañón', 1),
(888, '1008', 18110, '', 0, '', 'Pachitea', 1),
(889, '1009', 18110, '', 0, '', 'Puerto Inca', 1),
(890, '1010', 18110, '', 0, '', 'Lauricocha', 1),
(891, '1011', 18110, '', 0, '', 'Yarowilca', 1),
(892, '1101', 18111, '', 0, '', 'Ica', 1),
(893, '1102', 18111, '', 0, '', 'Chincha', 1),
(894, '1103', 18111, '', 0, '', 'Nazca', 1),
(895, '1104', 18111, '', 0, '', 'Palpa', 1),
(896, '1105', 18111, '', 0, '', 'Pisco', 1),
(897, '1201', 18112, '', 0, '', 'Huancayo', 1),
(898, '1202', 18112, '', 0, '', 'Concepción', 1),
(899, '1203', 18112, '', 0, '', 'Chanchamayo', 1),
(900, '1204', 18112, '', 0, '', 'Jauja', 1),
(901, '1205', 18112, '', 0, '', 'Junín', 1),
(902, '1206', 18112, '', 0, '', 'Satipo', 1),
(903, '1207', 18112, '', 0, '', 'Tarma', 1),
(904, '1208', 18112, '', 0, '', 'Yauli', 1),
(905, '1209', 18112, '', 0, '', 'Chupaca', 1),
(906, '1301', 18113, '', 0, '', 'Trujillo', 1),
(907, '1302', 18113, '', 0, '', 'Ascope', 1),
(908, '1303', 18113, '', 0, '', 'Bolívar', 1),
(909, '1304', 18113, '', 0, '', 'Chepén', 1),
(910, '1305', 18113, '', 0, '', 'Julcán', 1),
(911, '1306', 18113, '', 0, '', 'Otuzco', 1),
(912, '1307', 18113, '', 0, '', 'Pacasmayo', 1),
(913, '1308', 18113, '', 0, '', 'Pataz', 1),
(914, '1309', 18113, '', 0, '', 'Sánchez Carrión', 1),
(915, '1310', 18113, '', 0, '', 'Santiago de Chuco', 1),
(916, '1311', 18113, '', 0, '', 'Gran Chimú', 1),
(917, '1312', 18113, '', 0, '', 'Virú', 1),
(918, '1401', 18114, '', 0, '', 'Chiclayo', 1),
(919, '1402', 18114, '', 0, '', 'Ferreñafe', 1),
(920, '1403', 18114, '', 0, '', 'Lambayeque', 1),
(921, '1501', 18115, '', 0, '', 'Lima', 1),
(922, '1502', 18116, '', 0, '', 'Huaura', 1),
(923, '1503', 18116, '', 0, '', 'Barranca', 1),
(924, '1504', 18116, '', 0, '', 'Cajatambo', 1),
(925, '1505', 18116, '', 0, '', 'Canta', 1),
(926, '1506', 18116, '', 0, '', 'Cañete', 1),
(927, '1507', 18116, '', 0, '', 'Huaral', 1),
(928, '1508', 18116, '', 0, '', 'Huarochirí', 1),
(929, '1509', 18116, '', 0, '', 'Oyón', 1),
(930, '1510', 18116, '', 0, '', 'Yauyos', 1),
(931, '1601', 18117, '', 0, '', 'Maynas', 1),
(932, '1602', 18117, '', 0, '', 'Alto Amazonas', 1),
(933, '1603', 18117, '', 0, '', 'Loreto', 1),
(934, '1604', 18117, '', 0, '', 'Mariscal Ramón Castilla', 1),
(935, '1605', 18117, '', 0, '', 'Requena', 1),
(936, '1606', 18117, '', 0, '', 'Ucayali', 1),
(937, '1607', 18117, '', 0, '', 'Datem del Marañón', 1),
(938, '1701', 18118, '', 0, '', 'Tambopata', 1),
(939, '1702', 18118, '', 0, '', 'Manú', 1),
(940, '1703', 18118, '', 0, '', 'Tahuamanu', 1),
(941, '1801', 18119, '', 0, '', 'Mariscal Nieto', 1),
(942, '1802', 18119, '', 0, '', 'General Sánchez Cerro', 1),
(943, '1803', 18119, '', 0, '', 'Ilo', 1),
(944, '1901', 18120, '', 0, '', 'Pasco', 1),
(945, '1902', 18120, '', 0, '', 'Daniel Alcides Carrión', 1),
(946, '1903', 18120, '', 0, '', 'Oxapampa', 1),
(947, '2001', 18121, '', 0, '', 'Piura', 1),
(948, '2002', 18121, '', 0, '', 'Ayabaca', 1),
(949, '2003', 18121, '', 0, '', 'Huancabamba', 1),
(950, '2004', 18121, '', 0, '', 'Morropón', 1),
(951, '2005', 18121, '', 0, '', 'Paita', 1),
(952, '2006', 18121, '', 0, '', 'Sullana', 1),
(953, '2007', 18121, '', 0, '', 'Talara', 1),
(954, '2008', 18121, '', 0, '', 'Sechura', 1),
(955, '2101', 18122, '', 0, '', 'Puno', 1),
(956, '2102', 18122, '', 0, '', 'Azángaro', 1),
(957, '2103', 18122, '', 0, '', 'Carabaya', 1),
(958, '2104', 18122, '', 0, '', 'Chucuito', 1),
(959, '2105', 18122, '', 0, '', 'El Collao', 1),
(960, '2106', 18122, '', 0, '', 'Huancané', 1),
(961, '2107', 18122, '', 0, '', 'Lampa', 1),
(962, '2108', 18122, '', 0, '', 'Melgar', 1),
(963, '2109', 18122, '', 0, '', 'Moho', 1),
(964, '2110', 18122, '', 0, '', 'San Antonio de Putina', 1),
(965, '2111', 18122, '', 0, '', 'San Román', 1),
(966, '2112', 18122, '', 0, '', 'Sandia', 1),
(967, '2113', 18122, '', 0, '', 'Yunguyo', 1),
(968, '2201', 18123, '', 0, '', 'Moyobamba', 1),
(969, '2202', 18123, '', 0, '', 'Bellavista', 1),
(970, '2203', 18123, '', 0, '', 'El Dorado', 1),
(971, '2204', 18123, '', 0, '', 'Huallaga', 1),
(972, '2205', 18123, '', 0, '', 'Lamas', 1),
(973, '2206', 18123, '', 0, '', 'Mariscal Cáceres', 1),
(974, '2207', 18123, '', 0, '', 'Picota', 1),
(975, '2208', 18123, '', 0, '', 'La Rioja', 1),
(976, '2209', 18123, '', 0, '', 'San Martín', 1),
(977, '2210', 18123, '', 0, '', 'Tocache', 1),
(978, '2301', 18124, '', 0, '', 'Tacna', 1),
(979, '2302', 18124, '', 0, '', 'Candarave', 1),
(980, '2303', 18124, '', 0, '', 'Jorge Basadre', 1),
(981, '2304', 18124, '', 0, '', 'Tarata', 1),
(982, '2401', 18125, '', 0, '', 'Tumbes', 1),
(983, '2402', 18125, '', 0, '', 'Contralmirante Villar', 1),
(984, '2403', 18125, '', 0, '', 'Zarumilla', 1),
(985, '2501', 18126, '', 0, '', 'Coronel Portillo', 1),
(986, '2502', 18126, '', 0, '', 'Atalaya', 1),
(987, '2503', 18126, '', 0, '', 'Padre Abad', 1),
(988, '2504', 18126, '', 0, '', 'Purús', 1),
(989, 'PT-AV', 15001, NULL, NULL, 'AVEIRO', 'Aveiro', 1),
(990, 'PT-AC', 15002, NULL, NULL, 'AZORES', 'Azores', 1),
(991, 'PT-BE', 15001, NULL, NULL, 'BEJA', 'Beja', 1),
(992, 'PT-BR', 15001, NULL, NULL, 'BRAGA', 'Braga', 1);
INSERT INTO `llx_c_departements` (`rowid`, `code_departement`, `fk_region`, `cheflieu`, `tncc`, `ncc`, `nom`, `active`) VALUES
(993, 'PT-BA', 15001, NULL, NULL, 'BRAGANCA', 'Bragança', 1),
(994, 'PT-CB', 15001, NULL, NULL, 'CASTELO BRANCO', 'Castelo Branco', 1),
(995, 'PT-CO', 15001, NULL, NULL, 'COIMBRA', 'Coimbra', 1),
(996, 'PT-EV', 15001, NULL, NULL, 'EVORA', 'Évora', 1),
(997, 'PT-FA', 15001, NULL, NULL, 'FARO', 'Faro', 1),
(998, 'PT-GU', 15001, NULL, NULL, 'GUARDA', 'Guarda', 1),
(999, 'PT-LE', 15001, NULL, NULL, 'LEIRIA', 'Leiria', 1),
(1000, 'PT-LI', 15001, NULL, NULL, 'LISBON', 'Lisboa', 1),
(1001, 'PT-AML', 15001, NULL, NULL, 'AREA METROPOLITANA LISBOA', 'Área Metropolitana de Lisboa', 1),
(1002, 'PT-MA', 15002, NULL, NULL, 'MADEIRA', 'Madeira', 1),
(1003, 'PT-PA', 15001, NULL, NULL, 'PORTALEGRE', 'Portalegre', 1),
(1004, 'PT-PO', 15001, NULL, NULL, 'PORTO', 'Porto', 1),
(1005, 'PT-SA', 15001, NULL, NULL, 'SANTAREM', 'Santarém', 1),
(1006, 'PT-SE', 15001, NULL, NULL, 'SETUBAL', 'Setúbal', 1),
(1007, 'PT-VC', 15001, NULL, NULL, 'VIANA DO CASTELO', 'Viana Do Castelo', 1),
(1008, 'PT-VR', 15001, NULL, NULL, 'VILA REAL', 'Vila Real', 1),
(1009, 'PT-VI', 15001, NULL, NULL, 'VISEU', 'Viseu', 1),
(1010, 'AB', 18801, '', 0, '', 'Alba', 1),
(1011, 'AR', 18801, '', 0, '', 'Arad', 1),
(1012, 'AG', 18801, '', 0, '', 'Argeș', 1),
(1013, 'BC', 18801, '', 0, '', 'Bacău', 1),
(1014, 'BH', 18801, '', 0, '', 'Bihor', 1),
(1015, 'BN', 18801, '', 0, '', 'Bistrița-Năsăud', 1),
(1016, 'BT', 18801, '', 0, '', 'Botoșani', 1),
(1017, 'BV', 18801, '', 0, '', 'Brașov', 1),
(1018, 'BR', 18801, '', 0, '', 'Brăila', 1),
(1019, 'BU', 18801, '', 0, '', 'Bucuresti', 1),
(1020, 'BZ', 18801, '', 0, '', 'Buzău', 1),
(1021, 'CL', 18801, '', 0, '', 'Călărași', 1),
(1022, 'CS', 18801, '', 0, '', 'Caraș-Severin', 1),
(1023, 'CJ', 18801, '', 0, '', 'Cluj', 1),
(1024, 'CT', 18801, '', 0, '', 'Constanța', 1),
(1025, 'CV', 18801, '', 0, '', 'Covasna', 1),
(1026, 'DB', 18801, '', 0, '', 'Dâmbovița', 1),
(1027, 'DJ', 18801, '', 0, '', 'Dolj', 1),
(1028, 'GL', 18801, '', 0, '', 'Galați', 1),
(1029, 'GR', 18801, '', 0, '', 'Giurgiu', 1),
(1030, 'GJ', 18801, '', 0, '', 'Gorj', 1),
(1031, 'HR', 18801, '', 0, '', 'Harghita', 1),
(1032, 'HD', 18801, '', 0, '', 'Hunedoara', 1),
(1033, 'IL', 18801, '', 0, '', 'Ialomița', 1),
(1034, 'IS', 18801, '', 0, '', 'Iași', 1),
(1035, 'IF', 18801, '', 0, '', 'Ilfov', 1),
(1036, 'MM', 18801, '', 0, '', 'Maramureș', 1),
(1037, 'MH', 18801, '', 0, '', 'Mehedinți', 1),
(1038, 'MS', 18801, '', 0, '', 'Mureș', 1),
(1039, 'NT', 18801, '', 0, '', 'Neamț', 1),
(1040, 'OT', 18801, '', 0, '', 'Olt', 1),
(1041, 'PH', 18801, '', 0, '', 'Prahova', 1),
(1042, 'SM', 18801, '', 0, '', 'Satu Mare', 1),
(1043, 'SJ', 18801, '', 0, '', 'Sălaj', 1),
(1044, 'SB', 18801, '', 0, '', 'Sibiu', 1),
(1045, 'SV', 18801, '', 0, '', 'Suceava', 1),
(1046, 'TR', 18801, '', 0, '', 'Teleorman', 1),
(1047, 'TM', 18801, '', 0, '', 'Timiș', 1),
(1048, 'TL', 18801, '', 0, '', 'Tulcea', 1),
(1049, 'VS', 18801, '', 0, '', 'Vaslui', 1),
(1050, 'VL', 18801, '', 0, '', 'Vâlcea', 1),
(1051, 'VN', 18801, '', 0, '', 'Vrancea', 1),
(1052, 'SS', 8601, '', 0, '', 'San Salvador', 1),
(1053, 'LL', 8601, '', 0, '', 'La Libertad', 1),
(1054, 'CH', 8601, '', 0, '', 'Chalatenango', 1),
(1055, 'CA', 8601, '', 0, '', 'Cabañas', 1),
(1056, 'LP', 8601, '', 0, '', 'La Paz', 1),
(1057, 'SV', 8601, '', 0, '', 'San Vicente', 1),
(1058, 'CU', 8601, '', 0, '', 'Cuscatlan', 1),
(1059, 'US', 8602, '', 0, '', 'Usulutan', 1),
(1060, 'SM', 8602, '', 0, '', 'San Miguel', 1),
(1061, 'MO', 8602, '', 0, '', 'Morazan', 1),
(1062, 'LU', 8602, '', 0, '', 'La Union', 1),
(1063, 'AH', 8603, '', 0, '', 'Ahuachapan', 1),
(1064, 'SA', 8603, '', 0, '', 'Santa Ana', 1),
(1065, 'SO', 8603, '', 0, '', 'Sonsonate', 1),
(1066, 'SI031', 20203, NULL, NULL, 'MURA', 'Mura', 1),
(1067, 'SI032', 20203, NULL, NULL, 'DRAVA', 'Drava', 1),
(1068, 'SI033', 20203, NULL, NULL, 'CARINTHIA', 'Carinthia', 1),
(1069, 'SI034', 20203, NULL, NULL, 'SAVINJA', 'Savinja', 1),
(1070, 'SI035', 20203, NULL, NULL, 'CENTRAL SAVA', 'Central Sava', 1),
(1071, 'SI036', 20203, NULL, NULL, 'LOWER SAVA', 'Lower Sava', 1),
(1072, 'SI037', 20203, NULL, NULL, 'SOUTHEAST SLOVENIA', 'Southeast Slovenia', 1),
(1073, 'SI038', 20203, NULL, NULL, 'LITTORAL–INNER CARNIOLA', 'Littoral–Inner Carniola', 1),
(1074, 'SI041', 20204, NULL, NULL, 'CENTRAL SLOVENIA', 'Central Slovenia', 1),
(1075, 'SI038', 20204, NULL, NULL, 'UPPER CARNIOLA', 'Upper Carniola', 1),
(1076, 'SI043', 20204, NULL, NULL, 'GORIZIA', 'Gorizia', 1),
(1077, 'SI044', 20204, NULL, NULL, 'COASTAL–KARST', 'Coastal–Karst', 1),
(1078, 'AG', 601, NULL, NULL, 'ARGOVIE', 'Argovie', 1),
(1079, 'AI', 601, NULL, NULL, 'APPENZELL RHODES INTERIEURES', 'Appenzell Rhodes intérieures', 1),
(1080, 'AR', 601, NULL, NULL, 'APPENZELL RHODES EXTERIEURES', 'Appenzell Rhodes extérieures', 1),
(1081, 'BE', 601, NULL, NULL, 'BERNE', 'Berne', 1),
(1082, 'BL', 601, NULL, NULL, 'BALE CAMPAGNE', 'Bâle Campagne', 1),
(1083, 'BS', 601, NULL, NULL, 'BALE VILLE', 'Bâle Ville', 1),
(1084, 'FR', 601, NULL, NULL, 'FRIBOURG', 'Fribourg', 1),
(1085, 'GE', 601, NULL, NULL, 'GENEVE', 'Genève', 1),
(1086, 'GL', 601, NULL, NULL, 'GLARIS', 'Glaris', 1),
(1087, 'GR', 601, NULL, NULL, 'GRISONS', 'Grisons', 1),
(1088, 'JU', 601, NULL, NULL, 'JURA', 'Jura', 1),
(1089, 'LU', 601, NULL, NULL, 'LUCERNE', 'Lucerne', 1),
(1090, 'NE', 601, NULL, NULL, 'NEUCHATEL', 'Neuchâtel', 1),
(1091, 'NW', 601, NULL, NULL, 'NIDWALD', 'Nidwald', 1),
(1092, 'OW', 601, NULL, NULL, 'OBWALD', 'Obwald', 1),
(1093, 'SG', 601, NULL, NULL, 'SAINT-GALL', 'Saint-Gall', 1),
(1094, 'SH', 601, NULL, NULL, 'SCHAFFHOUSE', 'Schaffhouse', 1),
(1095, 'SO', 601, NULL, NULL, 'SOLEURE', 'Soleure', 1),
(1096, 'SZ', 601, NULL, NULL, 'SCHWYZ', 'Schwyz', 1),
(1097, 'TG', 601, NULL, NULL, 'THURGOVIE', 'Thurgovie', 1),
(1098, 'TI', 601, NULL, NULL, 'TESSIN', 'Tessin', 1),
(1099, 'UR', 601, NULL, NULL, 'URI', 'Uri', 1),
(1100, 'VD', 601, NULL, NULL, 'VAUD', 'Vaud', 1),
(1101, 'VS', 601, NULL, NULL, 'VALAIS', 'Valais', 1),
(1102, 'ZG', 601, NULL, NULL, 'ZUG', 'Zug', 1),
(1103, 'ZH', 601, NULL, NULL, 'ZURICH', 'Zürich', 1),
(1104, 'TW-KLU', 21301, 'KLU', NULL, NULL, '基隆市', 1),
(1105, 'TW-TPE', 21301, 'TPE', NULL, NULL, '臺北市', 1),
(1106, 'TW-TPH', 21301, 'TPH', NULL, NULL, '新北市', 1),
(1107, 'TW-TYC', 21301, 'TYC', NULL, NULL, '桃園市', 1),
(1108, 'TW-HSH', 21301, 'HSH', NULL, NULL, '新竹縣', 1),
(1109, 'TW-HSC', 21301, 'HSC', NULL, NULL, '新竹市', 1),
(1110, 'TW-MAL', 21301, 'MAL', NULL, NULL, '苗栗縣', 1),
(1111, 'TW-MAC', 21301, 'MAC', NULL, NULL, '苗栗市', 1),
(1112, 'TW-TXG', 21301, 'TXG', NULL, NULL, '臺中市', 1),
(1113, 'TW-CWH', 21301, 'CWH', NULL, NULL, '彰化縣', 1),
(1114, 'TW-CWS', 21301, 'CWS', NULL, NULL, '彰化市', 1),
(1115, 'TW-NTC', 21301, 'NTC', NULL, NULL, '南投市', 1),
(1116, 'TW-NTO', 21301, 'NTO', NULL, NULL, '南投縣', 1),
(1117, 'TW-YLH', 21301, 'YLH', NULL, NULL, '雲林縣', 1),
(1118, 'TW-CHY', 21301, 'CHY', NULL, NULL, '嘉義縣', 1),
(1119, 'TW-CYI', 21301, 'CYI', NULL, NULL, '嘉義市', 1),
(1120, 'TW-TNN', 21301, 'TNN', NULL, NULL, '臺南市', 1),
(1121, 'TW-KHH', 21301, 'KHH', NULL, NULL, '高雄市', 1),
(1122, 'TW-IUH', 21301, 'IUH', NULL, NULL, '屏東縣', 1),
(1123, 'TW-PTS', 21301, 'PTS', NULL, NULL, '屏東市', 1),
(1124, 'TW-ILN', 21301, 'ILN', NULL, NULL, '宜蘭縣', 1),
(1125, 'TW-ILC', 21301, 'ILC', NULL, NULL, '宜蘭市', 1),
(1126, 'TW-HWA', 21301, 'HWA', NULL, NULL, '花蓮縣', 1),
(1127, 'TW-HWC', 21301, 'HWC', NULL, NULL, '花蓮市', 1),
(1128, 'TW-TTC', 21301, 'TTC', NULL, NULL, '臺東市', 1),
(1129, 'TW-TTT', 21301, 'TTT', NULL, NULL, '臺東縣', 1),
(1130, 'TW-PEH', 21301, 'PEH', NULL, NULL, '澎湖縣', 1),
(1131, 'TW-GNI', 21301, 'GNI', NULL, NULL, '綠島', 1),
(1132, 'TW-KYD', 21301, 'KYD', NULL, NULL, '蘭嶼', 1),
(1133, 'TW-KMN', 21301, 'KMN', NULL, NULL, '金門縣', 1),
(1134, 'TW-LNN', 21301, 'LNN', NULL, NULL, '連江縣', 1),
(1135, 'TN01', 1001, '', 0, '', 'Ariana', 1),
(1136, 'TN02', 1001, '', 0, '', 'Béja', 1),
(1137, 'TN03', 1001, '', 0, '', 'Ben Arous', 1),
(1138, 'TN04', 1001, '', 0, '', 'Bizerte', 1),
(1139, 'TN05', 1001, '', 0, '', 'Gabès', 1),
(1140, 'TN06', 1001, '', 0, '', 'Gafsa', 1),
(1141, 'TN07', 1001, '', 0, '', 'Jendouba', 1),
(1142, 'TN08', 1001, '', 0, '', 'Kairouan', 1),
(1143, 'TN09', 1001, '', 0, '', 'Kasserine', 1),
(1144, 'TN10', 1001, '', 0, '', 'Kébili', 1),
(1145, 'TN11', 1001, '', 0, '', 'La Manouba', 1),
(1146, 'TN12', 1001, '', 0, '', 'Le Kef', 1),
(1147, 'TN13', 1001, '', 0, '', 'Mahdia', 1),
(1148, 'TN14', 1001, '', 0, '', 'Médenine', 1),
(1149, 'TN15', 1001, '', 0, '', 'Monastir', 1),
(1150, 'TN16', 1001, '', 0, '', 'Nabeul', 1),
(1151, 'TN17', 1001, '', 0, '', 'Sfax', 1),
(1152, 'TN18', 1001, '', 0, '', 'Sidi Bouzid', 1),
(1153, 'TN19', 1001, '', 0, '', 'Siliana', 1),
(1154, 'TN20', 1001, '', 0, '', 'Sousse', 1),
(1155, 'TN21', 1001, '', 0, '', 'Tataouine', 1),
(1156, 'TN22', 1001, '', 0, '', 'Tozeur', 1),
(1157, 'TN23', 1001, '', 0, '', 'Tunis', 1),
(1158, 'TN24', 1001, '', 0, '', 'Zaghouan', 1),
(1159, 'AL', 1101, '', 0, 'ALABAMA', 'Alabama', 1),
(1160, 'AK', 1101, '', 0, 'ALASKA', 'Alaska', 1),
(1161, 'AZ', 1101, '', 0, 'ARIZONA', 'Arizona', 1),
(1162, 'AR', 1101, '', 0, 'ARKANSAS', 'Arkansas', 1),
(1163, 'CA', 1101, '', 0, 'CALIFORNIA', 'California', 1),
(1164, 'CO', 1101, '', 0, 'COLORADO', 'Colorado', 1),
(1165, 'CT', 1101, '', 0, 'CONNECTICUT', 'Connecticut', 1),
(1166, 'DE', 1101, '', 0, 'DELAWARE', 'Delaware', 1),
(1167, 'FL', 1101, '', 0, 'FLORIDA', 'Florida', 1),
(1168, 'GA', 1101, '', 0, 'GEORGIA', 'Georgia', 1),
(1169, 'HI', 1101, '', 0, 'HAWAII', 'Hawaii', 1),
(1170, 'ID', 1101, '', 0, 'IDAHO', 'Idaho', 1),
(1171, 'IL', 1101, '', 0, 'ILLINOIS', 'Illinois', 1),
(1172, 'IN', 1101, '', 0, 'INDIANA', 'Indiana', 1),
(1173, 'IA', 1101, '', 0, 'IOWA', 'Iowa', 1),
(1174, 'KS', 1101, '', 0, 'KANSAS', 'Kansas', 1),
(1175, 'KY', 1101, '', 0, 'KENTUCKY', 'Kentucky', 1),
(1176, 'LA', 1101, '', 0, 'LOUISIANA', 'Louisiana', 1),
(1177, 'ME', 1101, '', 0, 'MAINE', 'Maine', 1),
(1178, 'MD', 1101, '', 0, 'MARYLAND', 'Maryland', 1),
(1179, 'MA', 1101, '', 0, 'MASSACHUSSETTS', 'Massachusetts', 1),
(1180, 'MI', 1101, '', 0, 'MICHIGAN', 'Michigan', 1),
(1181, 'MN', 1101, '', 0, 'MINNESOTA', 'Minnesota', 1),
(1182, 'MS', 1101, '', 0, 'MISSISSIPPI', 'Mississippi', 1),
(1183, 'MO', 1101, '', 0, 'MISSOURI', 'Missouri', 1),
(1184, 'MT', 1101, '', 0, 'MONTANA', 'Montana', 1),
(1185, 'NE', 1101, '', 0, 'NEBRASKA', 'Nebraska', 1),
(1186, 'NV', 1101, '', 0, 'NEVADA', 'Nevada', 1),
(1187, 'NH', 1101, '', 0, 'NEW HAMPSHIRE', 'New Hampshire', 1),
(1188, 'NJ', 1101, '', 0, 'NEW JERSEY', 'New Jersey', 1),
(1189, 'NM', 1101, '', 0, 'NEW MEXICO', 'New Mexico', 1),
(1190, 'NY', 1101, '', 0, 'NEW YORK', 'New York', 1),
(1191, 'NC', 1101, '', 0, 'NORTH CAROLINA', 'North Carolina', 1),
(1192, 'ND', 1101, '', 0, 'NORTH DAKOTA', 'North Dakota', 1),
(1193, 'OH', 1101, '', 0, 'OHIO', 'Ohio', 1),
(1194, 'OK', 1101, '', 0, 'OKLAHOMA', 'Oklahoma', 1),
(1195, 'OR', 1101, '', 0, 'OREGON', 'Oregon', 1),
(1196, 'PA', 1101, '', 0, 'PENNSYLVANIA', 'Pennsylvania', 1),
(1197, 'RI', 1101, '', 0, 'RHODE ISLAND', 'Rhode Island', 1),
(1198, 'SC', 1101, '', 0, 'SOUTH CAROLINA', 'South Carolina', 1),
(1199, 'SD', 1101, '', 0, 'SOUTH DAKOTA', 'South Dakota', 1),
(1200, 'TN', 1101, '', 0, 'TENNESSEE', 'Tennessee', 1),
(1201, 'TX', 1101, '', 0, 'TEXAS', 'Texas', 1),
(1202, 'UT', 1101, '', 0, 'UTAH', 'Utah', 1),
(1203, 'VT', 1101, '', 0, 'VERMONT', 'Vermont', 1),
(1204, 'VA', 1101, '', 0, 'VIRGINIA', 'Virginia', 1),
(1205, 'WA', 1101, '', 0, 'WASHINGTON', 'Washington', 1),
(1206, 'WV', 1101, '', 0, 'WEST VIRGINIA', 'West Virginia', 1),
(1207, 'WI', 1101, '', 0, 'WISCONSIN', 'Wisconsin', 1),
(1208, 'WY', 1101, '', 0, 'WYOMING', 'Wyoming', 1),
(1209, '001', 5201, '', 0, '', 'Belisario Boeto', 1),
(1210, '002', 5201, '', 0, '', 'Hernando Siles', 1),
(1211, '003', 5201, '', 0, '', 'Jaime Zudáñez', 1),
(1212, '004', 5201, '', 0, '', 'Juana Azurduy de Padilla', 1),
(1213, '005', 5201, '', 0, '', 'Luis Calvo', 1),
(1214, '006', 5201, '', 0, '', 'Nor Cinti', 1),
(1215, '007', 5201, '', 0, '', 'Oropeza', 1),
(1216, '008', 5201, '', 0, '', 'Sud Cinti', 1),
(1217, '009', 5201, '', 0, '', 'Tomina', 1),
(1218, '010', 5201, '', 0, '', 'Yamparáez', 1),
(1219, '011', 5202, '', 0, '', 'Abel Iturralde', 1),
(1220, '012', 5202, '', 0, '', 'Aroma', 1),
(1221, '013', 5202, '', 0, '', 'Bautista Saavedra', 1),
(1222, '014', 5202, '', 0, '', 'Caranavi', 1),
(1223, '015', 5202, '', 0, '', 'Eliodoro Camacho', 1),
(1224, '016', 5202, '', 0, '', 'Franz Tamayo', 1),
(1225, '017', 5202, '', 0, '', 'Gualberto Villarroel', 1),
(1226, '018', 5202, '', 0, '', 'Ingaví', 1),
(1227, '019', 5202, '', 0, '', 'Inquisivi', 1),
(1228, '020', 5202, '', 0, '', 'José Ramón Loayza', 1),
(1229, '021', 5202, '', 0, '', 'Larecaja', 1),
(1230, '022', 5202, '', 0, '', 'Los Andes (Bolivia)', 1),
(1231, '023', 5202, '', 0, '', 'Manco Kapac', 1),
(1232, '024', 5202, '', 0, '', 'Muñecas', 1),
(1233, '025', 5202, '', 0, '', 'Nor Yungas', 1),
(1234, '026', 5202, '', 0, '', 'Omasuyos', 1),
(1235, '027', 5202, '', 0, '', 'Pacajes', 1),
(1236, '028', 5202, '', 0, '', 'Pedro Domingo Murillo', 1),
(1237, '029', 5202, '', 0, '', 'Sud Yungas', 1),
(1238, '030', 5202, '', 0, '', 'General José Manuel Pando', 1),
(1239, '031', 5203, '', 0, '', 'Arani', 1),
(1240, '032', 5203, '', 0, '', 'Arque', 1),
(1241, '033', 5203, '', 0, '', 'Ayopaya', 1),
(1242, '034', 5203, '', 0, '', 'Bolívar (Bolivia)', 1),
(1243, '035', 5203, '', 0, '', 'Campero', 1),
(1244, '036', 5203, '', 0, '', 'Capinota', 1),
(1245, '037', 5203, '', 0, '', 'Cercado (Cochabamba)', 1),
(1246, '038', 5203, '', 0, '', 'Esteban Arze', 1),
(1247, '039', 5203, '', 0, '', 'Germán Jordán', 1),
(1248, '040', 5203, '', 0, '', 'José Carrasco', 1),
(1249, '041', 5203, '', 0, '', 'Mizque', 1),
(1250, '042', 5203, '', 0, '', 'Punata', 1),
(1251, '043', 5203, '', 0, '', 'Quillacollo', 1),
(1252, '044', 5203, '', 0, '', 'Tapacarí', 1),
(1253, '045', 5203, '', 0, '', 'Tiraque', 1),
(1254, '046', 5203, '', 0, '', 'Chapare', 1),
(1255, '047', 5204, '', 0, '', 'Carangas', 1),
(1256, '048', 5204, '', 0, '', 'Cercado (Oruro)', 1),
(1257, '049', 5204, '', 0, '', 'Eduardo Avaroa', 1),
(1258, '050', 5204, '', 0, '', 'Ladislao Cabrera', 1),
(1259, '051', 5204, '', 0, '', 'Litoral de Atacama', 1),
(1260, '052', 5204, '', 0, '', 'Mejillones', 1),
(1261, '053', 5204, '', 0, '', 'Nor Carangas', 1),
(1262, '054', 5204, '', 0, '', 'Pantaleón Dalence', 1),
(1263, '055', 5204, '', 0, '', 'Poopó', 1),
(1264, '056', 5204, '', 0, '', 'Sabaya', 1),
(1265, '057', 5204, '', 0, '', 'Sajama', 1),
(1266, '058', 5204, '', 0, '', 'San Pedro de Totora', 1),
(1267, '059', 5204, '', 0, '', 'Saucarí', 1),
(1268, '060', 5204, '', 0, '', 'Sebastián Pagador', 1),
(1269, '061', 5204, '', 0, '', 'Sud Carangas', 1),
(1270, '062', 5204, '', 0, '', 'Tomás Barrón', 1),
(1271, '063', 5205, '', 0, '', 'Alonso de Ibáñez', 1),
(1272, '064', 5205, '', 0, '', 'Antonio Quijarro', 1),
(1273, '065', 5205, '', 0, '', 'Bernardino Bilbao', 1),
(1274, '066', 5205, '', 0, '', 'Charcas (Potosí)', 1),
(1275, '067', 5205, '', 0, '', 'Chayanta', 1),
(1276, '068', 5205, '', 0, '', 'Cornelio Saavedra', 1),
(1277, '069', 5205, '', 0, '', 'Daniel Campos', 1),
(1278, '070', 5205, '', 0, '', 'Enrique Baldivieso', 1),
(1279, '071', 5205, '', 0, '', 'José María Linares', 1),
(1280, '072', 5205, '', 0, '', 'Modesto Omiste', 1),
(1281, '073', 5205, '', 0, '', 'Nor Chichas', 1),
(1282, '074', 5205, '', 0, '', 'Nor Lípez', 1),
(1283, '075', 5205, '', 0, '', 'Rafael Bustillo', 1),
(1284, '076', 5205, '', 0, '', 'Sud Chichas', 1),
(1285, '077', 5205, '', 0, '', 'Sud Lípez', 1),
(1286, '078', 5205, '', 0, '', 'Tomás Frías', 1),
(1287, '079', 5206, '', 0, '', 'Aniceto Arce', 1),
(1288, '080', 5206, '', 0, '', 'Burdet O\'Connor', 1),
(1289, '081', 5206, '', 0, '', 'Cercado (Tarija)', 1),
(1290, '082', 5206, '', 0, '', 'Eustaquio Méndez', 1),
(1291, '083', 5206, '', 0, '', 'José María Avilés', 1),
(1292, '084', 5206, '', 0, '', 'Gran Chaco', 1),
(1293, '085', 5207, '', 0, '', 'Andrés Ibáñez', 1),
(1294, '086', 5207, '', 0, '', 'Caballero', 1),
(1295, '087', 5207, '', 0, '', 'Chiquitos', 1),
(1296, '088', 5207, '', 0, '', 'Cordillera (Bolivia)', 1),
(1297, '089', 5207, '', 0, '', 'Florida', 1),
(1298, '090', 5207, '', 0, '', 'Germán Busch', 1),
(1299, '091', 5207, '', 0, '', 'Guarayos', 1),
(1300, '092', 5207, '', 0, '', 'Ichilo', 1),
(1301, '093', 5207, '', 0, '', 'Obispo Santistevan', 1),
(1302, '094', 5207, '', 0, '', 'Sara', 1),
(1303, '095', 5207, '', 0, '', 'Vallegrande', 1),
(1304, '096', 5207, '', 0, '', 'Velasco', 1),
(1305, '097', 5207, '', 0, '', 'Warnes', 1),
(1306, '098', 5207, '', 0, '', 'Ángel Sandóval', 1),
(1307, '099', 5207, '', 0, '', 'Ñuflo de Chaves', 1),
(1308, '100', 5208, '', 0, '', 'Cercado (Beni)', 1),
(1309, '101', 5208, '', 0, '', 'Iténez', 1),
(1310, '102', 5208, '', 0, '', 'Mamoré', 1),
(1311, '103', 5208, '', 0, '', 'Marbán', 1),
(1312, '104', 5208, '', 0, '', 'Moxos', 1),
(1313, '105', 5208, '', 0, '', 'Vaca Díez', 1),
(1314, '106', 5208, '', 0, '', 'Yacuma', 1),
(1315, '107', 5208, '', 0, '', 'General José Ballivián Segurola', 1),
(1316, '108', 5209, '', 0, '', 'Abuná', 1),
(1317, '109', 5209, '', 0, '', 'Madre de Dios', 1),
(1318, '110', 5209, '', 0, '', 'Manuripi', 1),
(1319, '111', 5209, '', 0, '', 'Nicolás Suárez', 1),
(1320, '112', 5209, '', 0, '', 'General Federico Román', 1),
(1321, 'VI', 419, '01', 19, 'ALAVA', 'Álava', 1),
(1322, 'AB', 404, '02', 4, 'ALBACETE', 'Albacete', 1),
(1323, 'A', 411, '03', 11, 'ALICANTE', 'Alicante', 1),
(1324, 'AL', 401, '04', 1, 'ALMERIA', 'Almería', 1),
(1325, 'O', 418, '33', 18, 'ASTURIAS', 'Asturias', 1),
(1326, 'AV', 403, '05', 3, 'AVILA', 'Ávila', 1),
(1327, 'BA', 412, '06', 12, 'BADAJOZ', 'Badajoz', 1),
(1328, 'B', 406, '08', 6, 'BARCELONA', 'Barcelona', 1),
(1329, 'BU', 403, '09', 8, 'BURGOS', 'Burgos', 1),
(1330, 'CC', 412, '10', 12, 'CACERES', 'Cáceres', 1),
(1331, 'CA', 401, '11', 1, 'CADIZ', 'Cádiz', 1),
(1332, 'S', 410, '39', 10, 'CANTABRIA', 'Cantabria', 1),
(1333, 'CS', 411, '12', 11, 'CASTELLON', 'Castellón', 1),
(1334, 'CE', 407, '51', 7, 'CEUTA', 'Ceuta', 1),
(1335, 'CR', 404, '13', 4, 'CIUDAD REAL', 'Ciudad Real', 1),
(1336, 'CO', 401, '14', 1, 'CORDOBA', 'Córdoba', 1),
(1337, 'CU', 404, '16', 4, 'CUENCA', 'Cuenca', 1),
(1338, 'GI', 406, '17', 6, 'GERONA', 'Gerona', 1),
(1339, 'GR', 401, '18', 1, 'GRANADA', 'Granada', 1),
(1340, 'GU', 404, '19', 4, 'GUADALAJARA', 'Guadalajara', 1),
(1341, 'SS', 419, '20', 19, 'GUIPUZCOA', 'Guipúzcoa', 1),
(1342, 'H', 401, '21', 1, 'HUELVA', 'Huelva', 1),
(1343, 'HU', 402, '22', 2, 'HUESCA', 'Huesca', 1),
(1344, 'PM', 414, '07', 14, 'ISLAS BALEARES', 'Islas Baleares', 1),
(1345, 'J', 401, '23', 1, 'JAEN', 'Jaén', 1),
(1346, 'C', 413, '15', 13, 'LA CORUÑA', 'La Coruña', 1),
(1347, 'LO', 415, '26', 15, 'LA RIOJA', 'La Rioja', 1),
(1348, 'GC', 405, '35', 5, 'LAS PALMAS', 'Las Palmas', 1),
(1349, 'LE', 403, '24', 3, 'LEON', 'León', 1),
(1350, 'L', 406, '25', 6, 'LERIDA', 'Lérida', 1),
(1351, 'LU', 413, '27', 13, 'LUGO', 'Lugo', 1),
(1352, 'M', 416, '28', 16, 'MADRID', 'Madrid', 1),
(1353, 'MA', 401, '29', 1, 'MALAGA', 'Málaga', 1),
(1354, 'ML', 409, '52', 9, 'MELILLA', 'Melilla', 1),
(1355, 'MU', 417, '30', 17, 'MURCIA', 'Murcia', 1),
(1356, 'NA', 408, '31', 8, 'NAVARRA', 'Navarra', 1),
(1357, 'OR', 413, '32', 13, 'ORENSE', 'Orense', 1),
(1358, 'P', 403, '34', 3, 'PALENCIA', 'Palencia', 1),
(1359, 'PO', 413, '36', 13, 'PONTEVEDRA', 'Pontevedra', 1),
(1360, 'SA', 403, '37', 3, 'SALAMANCA', 'Salamanca', 1),
(1361, 'TF', 405, '38', 5, 'STA. CRUZ DE TENERIFE', 'Santa Cruz de Tenerife', 1),
(1362, 'SG', 403, '40', 3, 'SEGOVIA', 'Segovia', 1),
(1363, 'SE', 401, '41', 1, 'SEVILLA', 'Sevilla', 1),
(1364, 'SO', 403, '42', 3, 'SORIA', 'Soria', 1),
(1365, 'T', 406, '43', 6, 'TARRAGONA', 'Tarragona', 1),
(1366, 'TE', 402, '44', 2, 'TERUEL', 'Teruel', 1),
(1367, 'TO', 404, '45', 5, 'TOLEDO', 'Toledo', 1),
(1368, 'V', 411, '46', 11, 'VALENCIA', 'Valencia', 1),
(1369, 'VA', 403, '47', 3, 'VALLADOLID', 'Valladolid', 1),
(1370, 'BI', 419, '48', 19, 'VIZCAYA', 'Vizcaya', 1),
(1371, 'ZA', 403, '49', 3, 'ZAMORA', 'Zamora', 1),
(1372, 'Z', 402, '50', 1, 'ZARAGOZA', 'Zaragoza', 1),
(1373, '701', 701, NULL, 0, NULL, 'Bedfordshire', 1),
(1374, '702', 701, NULL, 0, NULL, 'Berkshire', 1),
(1375, '703', 701, NULL, 0, NULL, 'Bristol, City of', 1),
(1376, '704', 701, NULL, 0, NULL, 'Buckinghamshire', 1),
(1377, '705', 701, NULL, 0, NULL, 'Cambridgeshire', 1),
(1378, '706', 701, NULL, 0, NULL, 'Cheshire', 1),
(1379, '707', 701, NULL, 0, NULL, 'Cleveland', 1),
(1380, '708', 701, NULL, 0, NULL, 'Cornwall', 1),
(1381, '709', 701, NULL, 0, NULL, 'Cumberland', 1),
(1382, '710', 701, NULL, 0, NULL, 'Cumbria', 1),
(1383, '711', 701, NULL, 0, NULL, 'Derbyshire', 1),
(1384, '712', 701, NULL, 0, NULL, 'Devon', 1),
(1385, '713', 701, NULL, 0, NULL, 'Dorset', 1),
(1386, '714', 701, NULL, 0, NULL, 'Co. Durham', 1),
(1387, '715', 701, NULL, 0, NULL, 'East Riding of Yorkshire', 1),
(1388, '716', 701, NULL, 0, NULL, 'East Sussex', 1),
(1389, '717', 701, NULL, 0, NULL, 'Essex', 1),
(1390, '718', 701, NULL, 0, NULL, 'Gloucestershire', 1),
(1391, '719', 701, NULL, 0, NULL, 'Greater Manchester', 1),
(1392, '720', 701, NULL, 0, NULL, 'Hampshire', 1),
(1393, '721', 701, NULL, 0, NULL, 'Hertfordshire', 1),
(1394, '722', 701, NULL, 0, NULL, 'Hereford and Worcester', 1),
(1395, '723', 701, NULL, 0, NULL, 'Herefordshire', 1),
(1396, '724', 701, NULL, 0, NULL, 'Huntingdonshire', 1),
(1397, '725', 701, NULL, 0, NULL, 'Isle of Man', 1),
(1398, '726', 701, NULL, 0, NULL, 'Isle of Wight', 1),
(1399, '727', 701, NULL, 0, NULL, 'Jersey', 1),
(1400, '728', 701, NULL, 0, NULL, 'Kent', 1),
(1401, '729', 701, NULL, 0, NULL, 'Lancashire', 1),
(1402, '730', 701, NULL, 0, NULL, 'Leicestershire', 1),
(1403, '731', 701, NULL, 0, NULL, 'Lincolnshire', 1),
(1404, '732', 701, NULL, 0, NULL, 'London - City of London', 1),
(1405, '733', 701, NULL, 0, NULL, 'Merseyside', 1),
(1406, '734', 701, NULL, 0, NULL, 'Middlesex', 1),
(1407, '735', 701, NULL, 0, NULL, 'Norfolk', 1),
(1408, '736', 701, NULL, 0, NULL, 'North Yorkshire', 1),
(1409, '737', 701, NULL, 0, NULL, 'North Riding of Yorkshire', 1),
(1410, '738', 701, NULL, 0, NULL, 'Northamptonshire', 1),
(1411, '739', 701, NULL, 0, NULL, 'Northumberland', 1),
(1412, '740', 701, NULL, 0, NULL, 'Nottinghamshire', 1),
(1413, '741', 701, NULL, 0, NULL, 'Oxfordshire', 1),
(1414, '742', 701, NULL, 0, NULL, 'Rutland', 1),
(1415, '743', 701, NULL, 0, NULL, 'Shropshire', 1),
(1416, '744', 701, NULL, 0, NULL, 'Somerset', 1),
(1417, '745', 701, NULL, 0, NULL, 'Staffordshire', 1),
(1418, '746', 701, NULL, 0, NULL, 'Suffolk', 1),
(1419, '747', 701, NULL, 0, NULL, 'Surrey', 1),
(1420, '748', 701, NULL, 0, NULL, 'Sussex', 1),
(1421, '749', 701, NULL, 0, NULL, 'Tyne and Wear', 1),
(1422, '750', 701, NULL, 0, NULL, 'Warwickshire', 1),
(1423, '751', 701, NULL, 0, NULL, 'West Midlands', 1),
(1424, '752', 701, NULL, 0, NULL, 'West Sussex', 1),
(1425, '753', 701, NULL, 0, NULL, 'West Yorkshire', 1),
(1426, '754', 701, NULL, 0, NULL, 'West Riding of Yorkshire', 1),
(1427, '755', 701, NULL, 0, NULL, 'Wiltshire', 1),
(1428, '756', 701, NULL, 0, NULL, 'Worcestershire', 1),
(1429, '757', 701, NULL, 0, NULL, 'Yorkshire', 1),
(1430, '758', 702, NULL, 0, NULL, 'Anglesey', 1),
(1431, '759', 702, NULL, 0, NULL, 'Breconshire', 1),
(1432, '760', 702, NULL, 0, NULL, 'Caernarvonshire', 1),
(1433, '761', 702, NULL, 0, NULL, 'Cardiganshire', 1),
(1434, '762', 702, NULL, 0, NULL, 'Carmarthenshire', 1),
(1435, '763', 702, NULL, 0, NULL, 'Ceredigion', 1),
(1436, '764', 702, NULL, 0, NULL, 'Denbighshire', 1),
(1437, '765', 702, NULL, 0, NULL, 'Flintshire', 1),
(1438, '766', 702, NULL, 0, NULL, 'Glamorgan', 1),
(1439, '767', 702, NULL, 0, NULL, 'Gwent', 1),
(1440, '768', 702, NULL, 0, NULL, 'Gwynedd', 1),
(1441, '769', 702, NULL, 0, NULL, 'Merionethshire', 1),
(1442, '770', 702, NULL, 0, NULL, 'Monmouthshire', 1),
(1443, '771', 702, NULL, 0, NULL, 'Mid Glamorgan', 1),
(1444, '772', 702, NULL, 0, NULL, 'Montgomeryshire', 1),
(1445, '773', 702, NULL, 0, NULL, 'Pembrokeshire', 1),
(1446, '774', 702, NULL, 0, NULL, 'Powys', 1),
(1447, '775', 702, NULL, 0, NULL, 'Radnorshire', 1),
(1448, '776', 702, NULL, 0, NULL, 'South Glamorgan', 1),
(1449, '777', 703, NULL, 0, NULL, 'Aberdeen, City of', 1),
(1450, '778', 703, NULL, 0, NULL, 'Angus', 1),
(1451, '779', 703, NULL, 0, NULL, 'Argyll', 1),
(1452, '780', 703, NULL, 0, NULL, 'Ayrshire', 1),
(1453, '781', 703, NULL, 0, NULL, 'Banffshire', 1),
(1454, '782', 703, NULL, 0, NULL, 'Berwickshire', 1),
(1455, '783', 703, NULL, 0, NULL, 'Bute', 1),
(1456, '784', 703, NULL, 0, NULL, 'Caithness', 1),
(1457, '785', 703, NULL, 0, NULL, 'Clackmannanshire', 1),
(1458, '786', 703, NULL, 0, NULL, 'Dumfriesshire', 1),
(1459, '787', 703, NULL, 0, NULL, 'Dumbartonshire', 1),
(1460, '788', 703, NULL, 0, NULL, 'Dundee, City of', 1),
(1461, '789', 703, NULL, 0, NULL, 'East Lothian', 1),
(1462, '790', 703, NULL, 0, NULL, 'Fife', 1),
(1463, '791', 703, NULL, 0, NULL, 'Inverness', 1),
(1464, '792', 703, NULL, 0, NULL, 'Kincardineshire', 1),
(1465, '793', 703, NULL, 0, NULL, 'Kinross-shire', 1),
(1466, '794', 703, NULL, 0, NULL, 'Kirkcudbrightshire', 1),
(1467, '795', 703, NULL, 0, NULL, 'Lanarkshire', 1),
(1468, '796', 703, NULL, 0, NULL, 'Midlothian', 1),
(1469, '797', 703, NULL, 0, NULL, 'Morayshire', 1),
(1470, '798', 703, NULL, 0, NULL, 'Nairnshire', 1),
(1471, '799', 703, NULL, 0, NULL, 'Orkney', 1),
(1472, '800', 703, NULL, 0, NULL, 'Peebleshire', 1),
(1473, '801', 703, NULL, 0, NULL, 'Perthshire', 1),
(1474, '802', 703, NULL, 0, NULL, 'Renfrewshire', 1),
(1475, '803', 703, NULL, 0, NULL, 'Ross & Cromarty', 1),
(1476, '804', 703, NULL, 0, NULL, 'Roxburghshire', 1),
(1477, '805', 703, NULL, 0, NULL, 'Selkirkshire', 1),
(1478, '806', 703, NULL, 0, NULL, 'Shetland', 1),
(1479, '807', 703, NULL, 0, NULL, 'Stirlingshire', 1),
(1480, '808', 703, NULL, 0, NULL, 'Sutherland', 1),
(1481, '809', 703, NULL, 0, NULL, 'West Lothian', 1),
(1482, '810', 703, NULL, 0, NULL, 'Wigtownshire', 1),
(1483, '811', 704, NULL, 0, NULL, 'Antrim', 1),
(1484, '812', 704, NULL, 0, NULL, 'Armagh', 1),
(1485, '813', 704, NULL, 0, NULL, 'Co. Down', 1),
(1486, '814', 704, NULL, 0, NULL, 'Co. Fermanagh', 1),
(1487, '815', 704, NULL, 0, NULL, 'Co. Londonderry', 1),
(1488, 'AN', 11701, NULL, 0, 'AN', 'Andaman & Nicobar', 1),
(1489, 'AP', 11701, NULL, 0, 'AP', 'Andhra Pradesh', 1),
(1490, 'AR', 11701, NULL, 0, 'AR', 'Arunachal Pradesh', 1),
(1491, 'AS', 11701, NULL, 0, 'AS', 'Assam', 1),
(1492, 'BR', 11701, NULL, 0, 'BR', 'Bihar', 1),
(1493, 'CG', 11701, NULL, 0, 'CG', 'Chattisgarh', 1),
(1494, 'CH', 11701, NULL, 0, 'CH', 'Chandigarh', 1),
(1495, 'DD', 11701, NULL, 0, 'DD', 'Daman & Diu', 1),
(1496, 'DL', 11701, NULL, 0, 'DL', 'Delhi', 1),
(1497, 'DN', 11701, NULL, 0, 'DN', 'Dadra and Nagar Haveli', 1),
(1498, 'GA', 11701, NULL, 0, 'GA', 'Goa', 1),
(1499, 'GJ', 11701, NULL, 0, 'GJ', 'Gujarat', 1),
(1500, 'HP', 11701, NULL, 0, 'HP', 'Himachal Pradesh', 1),
(1501, 'HR', 11701, NULL, 0, 'HR', 'Haryana', 1),
(1502, 'JH', 11701, NULL, 0, 'JH', 'Jharkhand', 1),
(1503, 'JK', 11701, NULL, 0, 'JK', 'Jammu & Kashmir', 1),
(1504, 'KA', 11701, NULL, 0, 'KA', 'Karnataka', 1),
(1505, 'KL', 11701, NULL, 0, 'KL', 'Kerala', 1),
(1506, 'LD', 11701, NULL, 0, 'LD', 'Lakshadweep', 1),
(1507, 'MH', 11701, NULL, 0, 'MH', 'Maharashtra', 1),
(1508, 'ML', 11701, NULL, 0, 'ML', 'Meghalaya', 1),
(1509, 'MN', 11701, NULL, 0, 'MN', 'Manipur', 1),
(1510, 'MP', 11701, NULL, 0, 'MP', 'Madhya Pradesh', 1),
(1511, 'MZ', 11701, NULL, 0, 'MZ', 'Mizoram', 1),
(1512, 'NL', 11701, NULL, 0, 'NL', 'Nagaland', 1),
(1513, 'OR', 11701, NULL, 0, 'OR', 'Orissa', 1),
(1514, 'PB', 11701, NULL, 0, 'PB', 'Punjab', 1),
(1515, 'PY', 11701, NULL, 0, 'PY', 'Puducherry', 1),
(1516, 'RJ', 11701, NULL, 0, 'RJ', 'Rajasthan', 1),
(1517, 'SK', 11701, NULL, 0, 'SK', 'Sikkim', 1),
(1518, 'TE', 11701, NULL, 0, 'TE', 'Telangana', 1),
(1519, 'TN', 11701, NULL, 0, 'TN', 'Tamil Nadu', 1),
(1520, 'TR', 11701, NULL, 0, 'TR', 'Tripura', 1),
(1521, 'UL', 11701, NULL, 0, 'UL', 'Uttarakhand', 1),
(1522, 'UP', 11701, NULL, 0, 'UP', 'Uttar Pradesh', 1),
(1523, 'WB', 11701, NULL, 0, 'WB', 'West Bengal', 1),
(1524, 'BA', 11801, NULL, 0, 'BA', 'Bali', 1),
(1525, 'BB', 11801, NULL, 0, 'BB', 'Bangka Belitung', 1),
(1526, 'BT', 11801, NULL, 0, 'BT', 'Banten', 1),
(1527, 'BE', 11801, NULL, 0, 'BA', 'Bengkulu', 1),
(1528, 'YO', 11801, NULL, 0, 'YO', 'DI Yogyakarta', 1),
(1529, 'JK', 11801, NULL, 0, 'JK', 'DKI Jakarta', 1),
(1530, 'GO', 11801, NULL, 0, 'GO', 'Gorontalo', 1),
(1531, 'JA', 11801, NULL, 0, 'JA', 'Jambi', 1),
(1532, 'JB', 11801, NULL, 0, 'JB', 'Jawa Barat', 1),
(1533, 'JT', 11801, NULL, 0, 'JT', 'Jawa Tengah', 1),
(1534, 'JI', 11801, NULL, 0, 'JI', 'Jawa Timur', 1),
(1535, 'KB', 11801, NULL, 0, 'KB', 'Kalimantan Barat', 1),
(1536, 'KS', 11801, NULL, 0, 'KS', 'Kalimantan Selatan', 1),
(1537, 'KT', 11801, NULL, 0, 'KT', 'Kalimantan Tengah', 1),
(1538, 'KI', 11801, NULL, 0, 'KI', 'Kalimantan Timur', 1),
(1539, 'KU', 11801, NULL, 0, 'KU', 'Kalimantan Utara', 1),
(1540, 'KR', 11801, NULL, 0, 'KR', 'Kepulauan Riau', 1),
(1541, 'LA', 11801, NULL, 0, 'LA', 'Lampung', 1),
(1542, 'MA', 11801, NULL, 0, 'MA', 'Maluku', 1),
(1543, 'MU', 11801, NULL, 0, 'MU', 'Maluku Utara', 1),
(1544, 'AC', 11801, NULL, 0, 'AC', 'Nanggroe Aceh Darussalam', 1),
(1545, 'NB', 11801, NULL, 0, 'NB', 'Nusa Tenggara Barat', 1),
(1546, 'NT', 11801, NULL, 0, 'NT', 'Nusa Tenggara Timur', 1),
(1547, 'PA', 11801, NULL, 0, 'PA', 'Papua', 1),
(1548, 'PB', 11801, NULL, 0, 'PB', 'Papua Barat', 1),
(1549, 'RI', 11801, NULL, 0, 'RI', 'Riau', 1),
(1550, 'SR', 11801, NULL, 0, 'SR', 'Sulawesi Barat', 1),
(1551, 'SN', 11801, NULL, 0, 'SN', 'Sulawesi Selatan', 1),
(1552, 'ST', 11801, NULL, 0, 'ST', 'Sulawesi Tengah', 1),
(1553, 'SG', 11801, NULL, 0, 'SG', 'Sulawesi Tenggara', 1),
(1554, 'SA', 11801, NULL, 0, 'SA', 'Sulawesi Utara', 1),
(1555, 'SB', 11801, NULL, 0, 'SB', 'Sumatera Barat', 1),
(1556, 'SS', 11801, NULL, 0, 'SS', 'Sumatera Selatan', 1),
(1557, 'SU', 11801, NULL, 0, 'SU', 'Sumatera Utara	', 1),
(1558, 'CMX', 15401, '', 0, 'CMX', 'Ciudad de México', 1),
(1559, 'AGS', 15401, '', 0, 'AGS', 'Aguascalientes', 1),
(1560, 'BCN', 15401, '', 0, 'BCN', 'Baja California Norte', 1),
(1561, 'BCS', 15401, '', 0, 'BCS', 'Baja California Sur', 1),
(1562, 'CAM', 15401, '', 0, 'CAM', 'Campeche', 1),
(1563, 'CHP', 15401, '', 0, 'CHP', 'Chiapas', 1),
(1564, 'CHI', 15401, '', 0, 'CHI', 'Chihuahua', 1),
(1565, 'COA', 15401, '', 0, 'COA', 'Coahuila', 1),
(1566, 'COL', 15401, '', 0, 'COL', 'Colima', 1),
(1567, 'DUR', 15401, '', 0, 'DUR', 'Durango', 1),
(1568, 'GTO', 15401, '', 0, 'GTO', 'Guanajuato', 1),
(1569, 'GRO', 15401, '', 0, 'GRO', 'Guerrero', 1),
(1570, 'HGO', 15401, '', 0, 'HGO', 'Hidalgo', 1),
(1571, 'JAL', 15401, '', 0, 'JAL', 'Jalisco', 1),
(1572, 'MEX', 15401, '', 0, 'MEX', 'México', 1),
(1573, 'MIC', 15401, '', 0, 'MIC', 'Michoacán de Ocampo', 1),
(1574, 'MOR', 15401, '', 0, 'MOR', 'Morelos', 1),
(1575, 'NAY', 15401, '', 0, 'NAY', 'Nayarit', 1),
(1576, 'NLE', 15401, '', 0, 'NLE', 'Nuevo León', 1),
(1577, 'OAX', 15401, '', 0, 'OAX', 'Oaxaca', 1),
(1578, 'PUE', 15401, '', 0, 'PUE', 'Puebla', 1),
(1579, 'QRO', 15401, '', 0, 'QRO', 'Querétaro', 1),
(1580, 'ROO', 15401, '', 0, 'ROO', 'Quintana Roo', 1),
(1581, 'SLP', 15401, '', 0, 'SLP', 'San Luis Potosí', 1),
(1582, 'SIN', 15401, '', 0, 'SIN', 'Sinaloa', 1),
(1583, 'SON', 15401, '', 0, 'SON', 'Sonora', 1),
(1584, 'TAB', 15401, '', 0, 'TAB', 'Tabasco', 1),
(1585, 'TAM', 15401, '', 0, 'TAM', 'Tamaulipas', 1),
(1586, 'TLX', 15401, '', 0, 'TLX', 'Tlaxcala', 1),
(1587, 'VER', 15401, '', 0, 'VER', 'Veracruz', 1),
(1588, 'YUC', 15401, '', 0, 'YUC', 'Yucatán', 1),
(1589, 'ZAC', 15401, '', 0, 'ZAC', 'Zacatecas', 1),
(1590, 'VE-L', 23201, '', 0, 'VE-L', 'Mérida', 1),
(1591, 'VE-T', 23201, '', 0, 'VE-T', 'Trujillo', 1),
(1592, 'VE-E', 23201, '', 0, 'VE-E', 'Barinas', 1),
(1593, 'VE-M', 23202, '', 0, 'VE-M', 'Miranda', 1),
(1594, 'VE-W', 23202, '', 0, 'VE-W', 'Vargas', 1),
(1595, 'VE-A', 23202, '', 0, 'VE-A', 'Distrito Capital', 1),
(1596, 'VE-D', 23203, '', 0, 'VE-D', 'Aragua', 1),
(1597, 'VE-G', 23203, '', 0, 'VE-G', 'Carabobo', 1),
(1598, 'VE-I', 23204, '', 0, 'VE-I', 'Falcón', 1),
(1599, 'VE-K', 23204, '', 0, 'VE-K', 'Lara', 1),
(1600, 'VE-U', 23204, '', 0, 'VE-U', 'Yaracuy', 1),
(1601, 'VE-F', 23205, '', 0, 'VE-F', 'Bolívar', 1),
(1602, 'VE-X', 23205, '', 0, 'VE-X', 'Amazonas', 1),
(1603, 'VE-Y', 23205, '', 0, 'VE-Y', 'Delta Amacuro', 1),
(1604, 'VE-O', 23206, '', 0, 'VE-O', 'Nueva Esparta', 1),
(1605, 'VE-Z', 23206, '', 0, 'VE-Z', 'Dependencias Federales', 1),
(1606, 'VE-C', 23207, '', 0, 'VE-C', 'Apure', 1),
(1607, 'VE-J', 23207, '', 0, 'VE-J', 'Guárico', 1),
(1608, 'VE-H', 23207, '', 0, 'VE-H', 'Cojedes', 1),
(1609, 'VE-P', 23207, '', 0, 'VE-P', 'Portuguesa', 1),
(1610, 'VE-B', 23208, '', 0, 'VE-B', 'Anzoátegui', 1),
(1611, 'VE-N', 23208, '', 0, 'VE-N', 'Monagas', 1),
(1612, 'VE-R', 23208, '', 0, 'VE-R', 'Sucre', 1),
(1613, 'VE-V', 23209, '', 0, 'VE-V', 'Zulia', 1),
(1614, 'VE-S', 23209, '', 0, 'VE-S', 'Táchira', 1),
(1615, 'BI0001', 6101, '', 0, '', 'Bubanza', 1),
(1616, 'BI0002', 6101, '', 0, '', 'Gihanga', 1),
(1617, 'BI0003', 6101, '', 0, '', 'Musigati', 1),
(1618, 'BI0004', 6101, '', 0, '', 'Mpanda', 1),
(1619, 'BI0005', 6101, '', 0, '', 'Rugazi', 1),
(1620, 'BI0006', 6102, '', 0, '', 'Muha', 1),
(1621, 'BI0007', 6102, '', 0, '', 'Mukaza', 1),
(1622, 'BI0008', 6102, '', 0, '', 'Ntahangwa', 1),
(1623, 'BI0009', 6103, '', 0, '', 'Isale', 1),
(1624, 'BI0010', 6103, '', 0, '', 'Kabezi', 1),
(1625, 'BI0011', 6103, '', 0, '', 'Kanyosha', 1),
(1626, 'BI0012', 6103, '', 0, '', 'Mubimbi', 1),
(1627, 'BI0013', 6103, '', 0, '', 'Mugongomanga', 1),
(1628, 'BI0014', 6103, '', 0, '', 'Mukike', 1),
(1629, 'BI0015', 6103, '', 0, '', 'Mutambu', 1),
(1630, 'BI0016', 6103, '', 0, '', 'Mutimbuzi', 1),
(1631, 'BI0017', 6103, '', 0, '', 'Nyabiraba', 1),
(1632, 'BI0018', 6104, '', 0, '', 'Bururi', 1),
(1633, 'BI0019', 6104, '', 0, '', 'Matana', 1),
(1634, 'BI0020', 6104, '', 0, '', 'Mugamba', 1),
(1635, 'BI0021', 6104, '', 0, '', 'Rutovu', 1),
(1636, 'BI0022', 6104, '', 0, '', 'Songa', 1),
(1637, 'BI0023', 6104, '', 0, '', 'Vyanda', 1),
(1638, 'BI0024', 6105, '', 0, '', 'Cankuzo', 1),
(1639, 'BI0025', 6105, '', 0, '', 'Cendajuru', 1),
(1640, 'BI0026', 6105, '', 0, '', 'Gisagara', 1),
(1641, 'BI0027', 6105, '', 0, '', 'Kigamba', 1),
(1642, 'BI0028', 6105, '', 0, '', 'Mishiha', 1),
(1643, 'BI0029', 6106, '', 0, '', 'Buganda', 1),
(1644, 'BI0030', 6106, '', 0, '', 'Bukinanyana', 1),
(1645, 'BI0031', 6106, '', 0, '', 'Mabayi', 1),
(1646, 'BI0032', 6106, '', 0, '', 'Mugina', 1),
(1647, 'BI0033', 6106, '', 0, '', 'Murwi', 1),
(1648, 'BI0034', 6106, '', 0, '', 'Rugombo', 1),
(1649, 'BI0035', 6107, '', 0, '', 'Bugendana', 1),
(1650, 'BI0036', 6107, '', 0, '', 'Bukirasazi', 1),
(1651, 'BI0037', 6107, '', 0, '', 'Buraza', 1),
(1652, 'BI0038', 6107, '', 0, '', 'Giheta', 1),
(1653, 'BI0039', 6107, '', 0, '', 'Gishubi', 1),
(1654, 'BI0040', 6107, '', 0, '', 'Gitega', 1),
(1655, 'BI0041', 6107, '', 0, '', 'Itaba', 1),
(1656, 'BI0042', 6107, '', 0, '', 'Makebuko', 1),
(1657, 'BI0043', 6107, '', 0, '', 'Mutaho', 1),
(1658, 'BI0044', 6107, '', 0, '', 'Nyanrusange', 1),
(1659, 'BI0045', 6107, '', 0, '', 'Ryansoro', 1),
(1660, 'BI0046', 6108, '', 0, '', 'Bugenyuzi', 1),
(1661, 'BI0047', 6108, '', 0, '', 'Buhiga', 1),
(1662, 'BI0048', 6108, '', 0, '', 'Gihogazi', 1),
(1663, 'BI0049', 6108, '', 0, '', 'Gitaramuka', 1),
(1664, 'BI0050', 6108, '', 0, '', 'Mutumba', 1),
(1665, 'BI0051', 6108, '', 0, '', 'Nyabikere', 1),
(1666, 'BI0052', 6108, '', 0, '', 'Shombo', 1),
(1667, 'BI0053', 6109, '', 0, '', 'Butaganzwa', 1),
(1668, 'BI0054', 6109, '', 0, '', 'Gahombo', 1),
(1669, 'BI0055', 6109, '', 0, '', 'Gatara', 1),
(1670, 'BI0056', 6109, '', 0, '', 'Kabarore', 1),
(1671, 'BI0057', 6109, '', 0, '', 'Kayanza', 1),
(1672, 'BI0058', 6109, '', 0, '', 'Matongo', 1),
(1673, 'BI0059', 6109, '', 0, '', 'Muhanga', 1),
(1674, 'BI0060', 6109, '', 0, '', 'Muruta', 1),
(1675, 'BI0061', 6109, '', 0, '', 'Rango', 1),
(1676, 'BI0062', 6110, '', 0, '', 'Bugabira', 1),
(1677, 'BI0063', 6110, '', 0, '', 'Busoni', 1),
(1678, 'BI0064', 6110, '', 0, '', 'Bwambarangwe', 1),
(1679, 'BI0065', 6110, '', 0, '', 'Gitobe', 1),
(1680, 'BI0066', 6110, '', 0, '', 'Kirundo', 1),
(1681, 'BI0067', 6110, '', 0, '', 'Ntega', 1),
(1682, 'BI0068', 6110, '', 0, '', 'Vumbi', 1),
(1683, 'BI0069', 6111, '', 0, '', 'Kayogoro', 1),
(1684, 'BI0070', 6111, '', 0, '', 'Kibago', 1),
(1685, 'BI0071', 6111, '', 0, '', 'Mabanda', 1),
(1686, 'BI0072', 6111, '', 0, '', 'Makamba', 1),
(1687, 'BI0073', 6111, '', 0, '', 'Nyanza-Lac', 1),
(1688, 'BI0074', 6111, '', 0, '', 'Vugizo', 1),
(1689, 'BI0075', 6112, '', 0, '', 'Bukeye', 1),
(1690, 'BI0076', 6112, '', 0, '', 'Kiganda', 1),
(1691, 'BI0077', 6112, '', 0, '', 'Mbuye', 1),
(1692, 'BI0078', 6112, '', 0, '', 'Muramvya', 1),
(1693, 'BI0079', 6112, '', 0, '', 'Rutegama', 1),
(1694, 'BI0080', 6113, '', 0, '', 'Buhinyuza', 1),
(1695, 'BI0081', 6113, '', 0, '', 'Butihinda', 1),
(1696, 'BI0082', 6113, '', 0, '', 'Gashoho', 1),
(1697, 'BI0083', 6113, '', 0, '', 'Gasorwe', 1),
(1698, 'BI0084', 6113, '', 0, '', 'Giteranyi', 1),
(1699, 'BI0085', 6113, '', 0, '', 'Muyinga', 1),
(1700, 'BI0086', 6113, '', 0, '', 'Mwakiro', 1),
(1701, 'BI0087', 6114, '', 0, '', 'Bisoro', 1),
(1702, 'BI0088', 6114, '', 0, '', 'Gisozi', 1),
(1703, 'BI0089', 6114, '', 0, '', 'Kayokwe', 1),
(1704, 'BI0090', 6114, '', 0, '', 'Ndava', 1),
(1705, 'BI0091', 6114, '', 0, '', 'Nyabihanga', 1),
(1706, 'BI0092', 6114, '', 0, '', 'Rusaka', 1),
(1707, 'BI0093', 6115, '', 0, '', 'Busiga', 1),
(1708, 'BI0094', 6115, '', 0, '', 'Gashikanwa', 1),
(1709, 'BI0095', 6115, '', 0, '', 'Kiremba', 1),
(1710, 'BI0096', 6115, '', 0, '', 'Marangara', 1),
(1711, 'BI0097', 6115, '', 0, '', 'Mwumba', 1),
(1712, 'BI0098', 6115, '', 0, '', 'Ngozi', 1),
(1713, 'BI0099', 6115, '', 0, '', 'Nyamurenza', 1),
(1714, 'BI0100', 6115, '', 0, '', 'Ruhororo', 1),
(1715, 'BI0101', 6115, '', 0, '', 'Tangara', 1),
(1716, 'BI0102', 6116, '', 0, '', 'Bugarama', 1),
(1717, 'BI0103', 6116, '', 0, '', 'Burambi', 1),
(1718, 'BI0104', 6116, '', 0, '', 'Buyengero', 1),
(1719, 'BI0105', 6116, '', 0, '', 'Muhuta', 1),
(1720, 'BI0106', 6116, '', 0, '', 'Rumonge', 1),
(1721, 'BI0107', 6117, '', 0, '', 'Bukemba', 1),
(1722, 'BI0108', 6117, '', 0, '', 'Giharo', 1),
(1723, 'BI0109', 6117, '', 0, '', 'Gitanga', 1),
(1724, 'BI0110', 6117, '', 0, '', 'Mpinga-Kayove', 1),
(1725, 'BI0111', 6117, '', 0, '', 'Musongati', 1),
(1726, 'BI0112', 6117, '', 0, '', 'Rutana', 1),
(1727, 'BI0113', 6118, '', 0, '', 'Butaganzwa', 1),
(1728, 'BI0114', 6118, '', 0, '', 'Butezi', 1),
(1729, 'BI0115', 6118, '', 0, '', 'Bweru', 1),
(1730, 'BI0116', 6118, '', 0, '', 'Gisuru', 1),
(1731, 'BI0117', 6118, '', 0, '', 'Kinyinya', 1),
(1732, 'BI0118', 6118, '', 0, '', 'Nyabitsinda', 1),
(1733, 'BI0119', 6118, '', 0, '', 'Ruyigi', 1),
(1734, 'AE-1', 22701, '', 0, '', 'Abu Dhabi', 1),
(1735, 'AE-2', 22701, '', 0, '', 'Dubai', 1),
(1736, 'AE-3', 22701, '', 0, '', 'Ajman', 1),
(1737, 'AE-4', 22701, '', 0, '', 'Fujairah', 1),
(1738, 'AE-5', 22701, '', 0, '', 'Ras al-Khaimah', 1),
(1739, 'AE-6', 22701, '', 0, '', 'Sharjah', 1),
(1740, 'AE-7', 22701, '', 0, '', 'Umm al-Quwain', 1),
(1741, 'TR-01', 22104, NULL, NULL, NULL, 'Adana', 1),
(1742, 'TR-02', 22107, NULL, NULL, NULL, 'Adıyaman', 1),
(1743, 'TR-03', 22103, NULL, NULL, NULL, 'Afyon', 1),
(1744, 'TR-04', 22107, NULL, NULL, NULL, 'Ağrı', 1),
(1745, 'TR-05', 22106, NULL, NULL, NULL, 'Amasya', 1),
(1746, 'TR-06', 22102, NULL, NULL, NULL, 'Ankara', 1),
(1747, 'TR-07', 22104, NULL, NULL, NULL, 'Antalya', 1),
(1748, 'TR-08', 22106, NULL, NULL, NULL, 'Artvin', 1),
(1749, 'TR-09', 22103, NULL, NULL, NULL, 'Aydın', 1),
(1750, 'TR-10', 22101, NULL, NULL, NULL, 'Balıkesir', 1),
(1751, 'TR-11', 22101, NULL, NULL, NULL, 'Bilecik', 1),
(1752, 'TR-12', 22107, NULL, NULL, NULL, 'Bingöl', 1),
(1753, 'TR-13', 22107, NULL, NULL, NULL, 'Bitlis', 1),
(1754, 'TR-14', 22106, NULL, NULL, NULL, 'Bolu', 1),
(1755, 'TR-15', 22104, NULL, NULL, NULL, 'Burdur', 1),
(1756, 'TR-16', 22101, NULL, NULL, NULL, 'Bursa', 1),
(1757, 'TR-17', 22101, NULL, NULL, NULL, 'Çanakkale', 1),
(1758, 'TR-18', 22102, NULL, NULL, NULL, 'Çankırı', 1),
(1759, 'TR-19', 22106, NULL, NULL, NULL, 'Çorum', 1),
(1760, 'TR-20', 22104, NULL, NULL, NULL, 'Denizli', 1),
(1761, 'TR-21', 22105, NULL, NULL, NULL, 'Diyarbakır', 1),
(1762, 'TR-22', 22101, NULL, NULL, NULL, 'Edirne', 1),
(1763, 'TR-23', 22107, NULL, NULL, NULL, 'Elazığ', 1),
(1764, 'TR-24', 22107, NULL, NULL, NULL, 'Erzincan', 1),
(1765, 'TR-25', 22107, NULL, NULL, NULL, 'Erzurum', 1),
(1766, 'TR-26', 22102, NULL, NULL, NULL, 'Eskişehir', 1),
(1767, 'TR-27', 22105, NULL, NULL, NULL, 'Gaziantep', 1),
(1768, 'TR-28', 22106, NULL, NULL, NULL, 'Giresun', 1),
(1769, 'TR-29', 22106, NULL, NULL, NULL, 'Gümüşhane', 1),
(1770, 'TR-30', 22107, NULL, NULL, NULL, 'Hakkari', 1),
(1771, 'TR-31', 22104, NULL, NULL, NULL, 'Hatay', 1),
(1772, 'TR-32', 22104, NULL, NULL, NULL, 'Isparta', 1),
(1773, 'TR-33', 22104, NULL, NULL, NULL, 'İçel', 1),
(1774, 'TR-34', 22101, NULL, NULL, NULL, 'İstanbul', 1),
(1775, 'TR-35', 22103, NULL, NULL, NULL, 'İzmir', 1),
(1776, 'TR-36', 22107, NULL, NULL, NULL, 'Kars', 1),
(1777, 'TR-37', 22106, NULL, NULL, NULL, 'Kastamonu', 1),
(1778, 'TR-38', 22102, NULL, NULL, NULL, 'Kayseri', 1),
(1779, 'TR-39', 22101, NULL, NULL, NULL, 'Kırklareli', 1),
(1780, 'TR-40', 22102, NULL, NULL, NULL, 'Kırşehir', 1),
(1781, 'TR-41', 22101, NULL, NULL, NULL, 'Kocaeli', 1),
(1782, 'TR-42', 22102, NULL, NULL, NULL, 'Konya', 1),
(1783, 'TR-43', 22103, NULL, NULL, NULL, 'Kütahya', 1),
(1784, 'TR-44', 22107, NULL, NULL, NULL, 'Malatya', 1),
(1785, 'TR-45', 22103, NULL, NULL, NULL, 'Manisa', 1),
(1786, 'TR-46', 22104, NULL, NULL, NULL, 'Kahramanmaraş', 1),
(1787, 'TR-47', 22105, NULL, NULL, NULL, 'Mardin', 1),
(1788, 'TR-48', 22103, NULL, NULL, NULL, 'Muğla', 1),
(1789, 'TR-49', 22107, NULL, NULL, NULL, 'Muş', 1),
(1790, 'TR-50', 22102, NULL, NULL, NULL, 'Nevşehir', 1),
(1791, 'TR-51', 22102, NULL, NULL, NULL, 'Niğde', 1),
(1792, 'TR-52', 22106, NULL, NULL, NULL, 'Ordu', 1),
(1793, 'TR-53', 22106, NULL, NULL, NULL, 'Rize', 1),
(1794, 'TR-54', 22101, NULL, NULL, NULL, 'Sakarya', 1),
(1795, 'TR-55', 22106, NULL, NULL, NULL, 'Samsun', 1),
(1796, 'TR-56', 22105, NULL, NULL, NULL, 'Siirt', 1),
(1797, 'TR-57', 22106, NULL, NULL, NULL, 'Sinop', 1),
(1798, 'TR-58', 22102, NULL, NULL, NULL, 'Sivas', 1),
(1799, 'TR-59', 22101, NULL, NULL, NULL, 'Tekirdağ', 1),
(1800, 'TR-60', 22106, NULL, NULL, NULL, 'Tokat', 1),
(1801, 'TR-61', 22106, NULL, NULL, NULL, 'Trabzon', 1),
(1802, 'TR-62', 22107, NULL, NULL, NULL, 'Tunceli', 1),
(1803, 'TR-63', 22105, NULL, NULL, NULL, 'Şanlıurfa', 1),
(1804, 'TR-63', 22103, NULL, NULL, NULL, 'Uşak', 1),
(1805, 'TR-65', 22107, NULL, NULL, NULL, 'Van', 1),
(1806, 'TR-66', 22102, NULL, NULL, NULL, 'Yozgat', 1),
(1807, 'TR-67', 22106, NULL, NULL, NULL, 'Zonguldak', 1),
(1808, 'TR-68', 22102, NULL, NULL, NULL, 'Aksaray', 1),
(1809, 'TR-69', 22106, NULL, NULL, NULL, 'Bayburt', 1),
(1810, 'TR-70', 22102, NULL, NULL, NULL, 'Karaman', 1),
(1811, 'TR-71', 22102, NULL, NULL, NULL, 'Kırıkkale', 1),
(1812, 'TR-72', 22105, NULL, NULL, NULL, 'Batman', 1),
(1813, 'TR-73', 22105, NULL, NULL, NULL, 'Şırnak', 1),
(1814, 'TR-74', 22106, NULL, NULL, NULL, 'Bartın', 1),
(1815, 'TR-75', 22107, NULL, NULL, NULL, 'Ardahan', 1),
(1816, 'TR-76', 22107, NULL, NULL, NULL, 'Iğdır', 1),
(1817, 'TR-77', 22101, NULL, NULL, NULL, 'Yalova', 1),
(1818, 'TR-78', 22106, NULL, NULL, NULL, 'Karabük', 1),
(1819, 'TR-79', 22105, NULL, NULL, NULL, 'Kilis', 1),
(1820, 'TR-80', 22104, NULL, NULL, NULL, 'Osmaniye', 1),
(1821, 'TR-81', 22106, NULL, NULL, NULL, 'Düzce', 1),
(1822, 'CU-PRI', 7701, NULL, NULL, NULL, 'Pinar del Rio', 1),
(1823, 'CU-ART', 7701, NULL, NULL, NULL, 'Artemisa', 1),
(1824, 'CU-HAB', 7701, NULL, NULL, NULL, 'La Habana', 1),
(1825, 'CU-MYB', 7701, NULL, NULL, NULL, 'Mayabeque', 1),
(1826, 'CU-MTZ', 7701, NULL, NULL, NULL, 'Matanzas', 1),
(1827, 'CU-IJV', 7701, NULL, NULL, NULL, 'Isla de la Juventud', 1),
(1828, 'CU-VLC', 7702, NULL, NULL, NULL, 'Villa Calra', 1),
(1829, 'CU-CFG', 7702, NULL, NULL, NULL, 'Cienfuegos', 1),
(1830, 'CU-SSP', 7702, NULL, NULL, NULL, 'Sancti Spiritus', 1),
(1831, 'CU-CAV', 7702, NULL, NULL, NULL, 'Ciego de Avila', 1),
(1832, 'CU-CMG', 7702, NULL, NULL, NULL, 'Camagüey', 1),
(1833, 'CU-LTU', 7703, NULL, NULL, NULL, 'Las Tunas', 1),
(1834, 'CU-GRM', 7703, NULL, NULL, NULL, 'Granma', 1),
(1835, 'CU-SCU', 7703, NULL, NULL, NULL, 'Santiago de Cuba', 1),
(1836, 'CU-GTM', 7703, NULL, NULL, NULL, 'Guantanamo', 1),
(1837, 'CU-HLG', 7703, NULL, NULL, NULL, 'Holguin', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_ecotaxe`
--

CREATE TABLE `llx_c_ecotaxe` (
  `rowid` int(11) NOT NULL,
  `code` varchar(64) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `price` double(24,8) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `fk_pays` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_ecotaxe`
--

INSERT INTO `llx_c_ecotaxe` (`rowid`, `code`, `label`, `price`, `organization`, `fk_pays`, `active`) VALUES
(1, '25040', 'PETIT APPAREILS MENAGERS', 0.25000000, 'Eco-systèmes', 1, 1),
(2, '25050', 'TRES PETIT APPAREILS MENAGERS', 0.08000000, 'Eco-systèmes', 1, 1),
(3, '32070', 'ECRAN POIDS < 5 KG', 2.08000000, 'Eco-systèmes', 1, 1),
(4, '32080', 'ECRAN POIDS > 5 KG', 1.25000000, 'Eco-systèmes', 1, 1),
(5, '32051', 'ORDINATEUR PORTABLE', 0.42000000, 'Eco-systèmes', 1, 1),
(6, '32061', 'TABLETTE INFORMATIQUE', 0.84000000, 'Eco-systèmes', 1, 1),
(7, '36011', 'ORDINATEUR FIXE (UC)', 1.15000000, 'Eco-systèmes', 1, 1),
(8, '36021', 'IMPRIMANTES', 0.83000000, 'Eco-systèmes', 1, 1),
(9, '36030', 'IT (INFORMATIQUE ET TELECOMS)', 0.83000000, 'Eco-systèmes', 1, 1),
(10, '36040', 'PETIT IT (CLAVIERS / SOURIS)', 0.08000000, 'Eco-systèmes', 1, 1),
(11, '36050', 'TELEPHONIE MOBILE', 0.02000000, 'Eco-systèmes', 1, 1),
(12, '36060', 'CONNECTIQUE CABLES', 0.02000000, 'Eco-systèmes', 1, 1),
(13, '45010', 'GROS MATERIEL GRAND PUBLIC (TELEAGRANDISSEURS)', 1.67000000, 'Eco-systèmes', 1, 1),
(14, '45020', 'MOYEN MATERIEL GRAND PUBLIC (LOUPES ELECTRONIQUES)', 0.42000000, 'Eco-systèmes', 1, 1),
(15, '45030', 'PETIT MATERIEL GRAND PUBLIC (VIE QUOTIDIENNE)', 0.08000000, 'Eco-systèmes', 1, 1),
(16, '75030', 'JOUETS < 0,5 KG', 0.08000000, 'Eco-systèmes', 1, 1),
(17, '75040', 'JOUETS ENTRE 0,5 KG ET 10 KG', 0.17000000, 'Eco-systèmes', 1, 1),
(18, '74050', 'JOUETS > 10 KG', 1.67000000, 'Eco-systèmes', 1, 1),
(19, '85010', 'EQUIPEMENT MEDICAL < 0,5 KG', 0.08000000, 'Eco-systèmes', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_effectif`
--

CREATE TABLE `llx_c_effectif` (
  `id` int(11) NOT NULL,
  `code` varchar(12) NOT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `module` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_effectif`
--

INSERT INTO `llx_c_effectif` (`id`, `code`, `libelle`, `active`, `module`) VALUES
(0, 'EF0', '-', 1, NULL),
(1, 'EF1-5', '1 - 5', 1, NULL),
(2, 'EF6-10', '6 - 10', 1, NULL),
(3, 'EF11-50', '11 - 50', 1, NULL),
(4, 'EF51-100', '51 - 100', 1, NULL),
(5, 'EF101-500', '101 - 500', 1, NULL),
(6, 'EF500-', '> 500', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_email_senderprofile`
--

CREATE TABLE `llx_c_email_senderprofile` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `private` smallint(6) NOT NULL DEFAULT 0,
  `date_creation` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `label` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `signature` text DEFAULT NULL,
  `position` smallint(6) DEFAULT 0,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_email_templates`
--

CREATE TABLE `llx_c_email_templates` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `module` varchar(32) DEFAULT NULL,
  `type_template` varchar(32) DEFAULT NULL,
  `lang` varchar(6) DEFAULT '',
  `private` smallint(6) NOT NULL DEFAULT 0,
  `fk_user` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `label` varchar(180) DEFAULT NULL,
  `position` smallint(6) DEFAULT NULL,
  `defaultfortype` smallint(6) DEFAULT 0,
  `enabled` varchar(255) DEFAULT '1',
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `email_from` varchar(255) DEFAULT NULL,
  `email_to` varchar(255) DEFAULT NULL,
  `email_tocc` varchar(255) DEFAULT NULL,
  `email_tobcc` varchar(255) DEFAULT NULL,
  `topic` text DEFAULT NULL,
  `joinfiles` text DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `content_lines` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_email_templates`
--

INSERT INTO `llx_c_email_templates` (`rowid`, `entity`, `module`, `type_template`, `lang`, `private`, `fk_user`, `datec`, `tms`, `label`, `position`, `defaultfortype`, `enabled`, `active`, `email_from`, `email_to`, `email_tocc`, `email_tobcc`, `topic`, `joinfiles`, `content`, `content_lines`) VALUES
(1, 0, 'banque', 'thirdparty', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(YourSEPAMandate)', 1, 0, 'isModEnabled(\"societe\") && isModEnabled(\"banque\") && isModEnabled(\"prelevement\")', 0, NULL, NULL, NULL, NULL, '__(YourSEPAMandate)__', '0', '__(Hello)__,<br><br>\n\n__(FindYourSEPAMandate)__ :<br>\n__MYCOMPANY_NAME__<br>\n__MYCOMPANY_FULLADDRESS__<br><br>\n__(Sincerely)__<br>\\__SENDEREMAIL_SIGNATURE__', NULL),
(2, 0, 'adherent', 'member', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(SendingEmailOnAutoSubscription)', 10, 0, 'isModEnabled(\"adherent\")', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] __(YourMembershipRequestWasReceived)__', '0', '__(Hello)__ __MEMBER_FULLNAME__,<br><br>\n\n__(ThisIsContentOfYourMembershipRequestWasReceived)__<br>\n<br>__ONLINE_PAYMENT_TEXT_AND_URL__<br>\n<br><br>\n__(Sincerely)__<br>__SENDEREMAIL_SIGNATURE__', NULL),
(3, 0, 'adherent', 'member', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(SendingEmailOnMemberValidation)', 20, 0, 'isModEnabled(\"adherent\")', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] __(YourMembershipWasValidated)__', '0', '__(Hello)__ __MEMBER_FULLNAME__,<br><br>\n\n__(ThisIsContentOfYourMembershipWasValidated)__<br>__(FirstName)__ : __MEMBER_FIRSTNAME__<br>__(LastName)__ : __MEMBER_LASTNAME__<br>__(ID)__ : __MEMBER_ID__<br>\n<br>__ONLINE_PAYMENT_TEXT_AND_URL__<br>\n<br><br>\n__(Sincerely)__<br>__SENDEREMAIL_SIGNATURE__', NULL),
(4, 0, 'adherent', 'member', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(SendingEmailOnNewSubscription)', 30, 0, 'isModEnabled(\"adherent\")', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] __(YourSubscriptionWasRecorded)__', '1', '__(Hello)__ __MEMBER_FULLNAME__,<br><br>\n\n__(ThisIsContentOfYourSubscriptionWasRecorded)__<br>\n\n<br><br>\n__(Sincerely)__<br>__SENDEREMAIL_SIGNATURE__', NULL),
(5, 0, 'adherent', 'member', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(SendingReminderForExpiredSubscription)', 40, 0, 'isModEnabled(\"adherent\")', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] __(SubscriptionReminderEmail)__', '0', '__(Hello)__ __MEMBER_FULLNAME__,<br><br>\n\n__(ThisIsContentOfSubscriptionReminderEmail)__<br>\n<br>__ONLINE_PAYMENT_TEXT_AND_URL__<br>\n<br><br>\n__(Sincerely)__<br>__SENDEREMAIL_SIGNATURE__', NULL),
(6, 0, 'adherent', 'member', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(SendingEmailOnCancelation)', 50, 0, 'isModEnabled(\"adherent\")', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] __(YourMembershipWasCanceled)__', '0', '__(Hello)__ __MEMBER_FULLNAME__,<br><br>\n\n__(YourMembershipWasCanceled)__<br>\n<br><br>\n__(Sincerely)__<br>__SENDEREMAIL_SIGNATURE__', NULL),
(7, 0, 'adherent', 'member', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(SendingAnEMailToMember)', 60, 0, 'isModEnabled(\"adherent\")', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] __(CardContent)__', '0', '__(Hello)__,<br><br>\n\n__(ThisIsContentOfYourCard)__<br>\n__(ID)__ : __ID__<br>\n__(Civility)__ : __MEMBER_CIVILITY__<br>\n__(Firstname)__ : __MEMBER_FIRSTNAME__<br>\n__(Lastname)__ : __MEMBER_LASTNAME__<br>\n__(Fullname)__ : __MEMBER_FULLNAME__<br>\n__(Company)__ : __MEMBER_COMPANY__<br>\n__(Address)__ : __MEMBER_ADDRESS__<br>\n__(Zip)__ : __MEMBER_ZIP__<br>\n__(Town)__ : __MEMBER_TOWN__<br>\n__(Country)__ : __MEMBER_COUNTRY__<br>\n__(Email)__ : __MEMBER_EMAIL__<br>\n__(Birthday)__ : __MEMBER_BIRTH__<br>\n__(Photo)__ : __MEMBER_PHOTO__<br>\n__(Login)__ : __MEMBER_LOGIN__<br>\n__(Phone)__ : __MEMBER_PHONE__<br>\n__(PhonePerso)__ : __MEMBER_PHONEPRO__<br>\n__(PhoneMobile)__ : __MEMBER_PHONEMOBILE__<br><br>\n__(Sincerely)__<br>__SENDEREMAIL_SIGNATURE__', NULL),
(8, 0, 'recruitment', 'recruitmentcandidature_send', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(AnswerCandidature)', 100, 0, 'isModEnabled(\"recruitment\")', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] __(YourCandidature)__', '0', '__(Hello)__ __CANDIDATE_FULLNAME__,<br><br>\n\n__(YourCandidatureAnswerMessage)__<br>__ONLINE_INTERVIEW_SCHEDULER_TEXT_AND_URL__\n<br><br>\n__(Sincerely)__<br>__SENDEREMAIL_SIGNATURE__', NULL),
(9, 0, '', 'conferenceorbooth', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(EventOrganizationEmailAskConf)', 10, 0, '1', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] __(EventOrganizationEmailAskConf)__', NULL, '__(Hello)__,<br /><br />__(OrganizationEventConfRequestWasReceived)__<br /><br /><br />__(Sincerely)__<br />__SENDEREMAIL_SIGNATURE__', NULL),
(10, 0, '', 'conferenceorbooth', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(EventOrganizationEmailAskBooth)', 20, 0, '1', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] __(EventOrganizationEmailAskBooth)__', NULL, '__(Hello)__,<br /><br />__(OrganizationEventBoothRequestWasReceived)__<br /><br /><br />__(Sincerely)__<br />__SENDEREMAIL_SIGNATURE__', NULL),
(11, 0, '', 'conferenceorbooth', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(EventOrganizationEmailBoothPayment)', 30, 0, '1', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] __(EventOrganizationEmailBoothPayment)__', NULL, '__(Hello)__,<br /><br />__(OrganizationEventPaymentOfBoothWasReceived)__<br /><br /><br />__(Sincerely)__<br />__SENDEREMAIL_SIGNATURE__', NULL),
(12, 0, '', 'conferenceorbooth', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(EventOrganizationEmailRegistrationPayment)', 40, 0, '1', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] __(EventOrganizationEmailRegistrationPayment)__', NULL, '__(Hello)__,<br /><br />__(OrganizationEventPaymentOfRegistrationWasReceived)__<br /><br />__(Sincerely)__<br />__SENDEREMAIL_SIGNATURE__', NULL),
(13, 0, '', 'conferenceorbooth', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(EventOrganizationMassEmailAttendees)', 50, 0, '1', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] __(EventOrganizationMassEmailAttendees)__', NULL, '__(Hello)__,<br /><br />__(OrganizationEventBulkMailToAttendees)__<br /><br />__(Sincerely)__<br />__SENDEREMAIL_SIGNATURE__', NULL),
(14, 0, '', 'conferenceorbooth', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(EventOrganizationMassEmailSpeakers)', 60, 0, '1', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] __(EventOrganizationMassEmailSpeakers)__', NULL, '__(Hello)__,<br /><br />__(OrganizationEventBulkMailToSpeakers)__<br /><br />__(Sincerely)__<br />__SENDEREMAIL_SIGNATURE__', NULL),
(15, 0, 'partnership', 'partnership_send', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(SendingEmailOnPartnershipWillSoonBeCanceled)', 100, 0, '1', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] - __(YourPartnershipWillSoonBeCanceledTopic)__', '0', '<body>\n <p>__(Hello)__,<br><br>\n__(YourPartnershipWillSoonBeCanceledContent)__</p>\n<br />\n\n<br />\n\n            __(Sincerely)__ <br />\n            __[MAIN_INFO_SOCIETE_NOM]__ <br />\n </body>\n', NULL),
(16, 0, 'partnership', 'partnership_send', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(SendingEmailOnPartnershipCanceled)', 100, 0, '1', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] - __(YourPartnershipCanceledTopic)__', '0', '<body>\n <p>__(Hello)__,<br><br>\n__(YourPartnershipCanceledContent)__</p>\n<br />\n\n<br />\n\n            __(Sincerely)__ <br />\n            __[MAIN_INFO_SOCIETE_NOM]__ <br />\n </body>\n', NULL),
(17, 0, 'partnership', 'partnership_send', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(SendingEmailOnPartnershipRefused)', 100, 0, '1', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] - __(YourPartnershipRefusedTopic)__', '0', '<body>\n <p>__(Hello)__,<br><br>\n__(YourPartnershipRefusedContent)__</p>\n<br />\n\n<br />\n\n            __(Sincerely)__ <br />\n            __[MAIN_INFO_SOCIETE_NOM]__ <br />\n </body>\n', NULL),
(18, 0, 'partnership', 'partnership_send', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(SendingEmailOnPartnershipAccepted)', 100, 0, '1', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] - __(YourPartnershipAcceptedTopic)__', '0', '<body>\n <p>__(Hello)__,<br><br>\n__(YourPartnershipAcceptedContent)__</p>\n<br />\n\n<br />\n\n            __(Sincerely)__ <br />\n            __[MAIN_INFO_SOCIETE_NOM]__ <br />\n </body>\n', NULL),
(19, 0, 'supplier_invoice', 'invoice_supplier_send', '', 0, NULL, NULL, '2025-08-08 01:15:52', '(SendingReminderEmailOnUnpaidSupplierInvoice)', 100, 0, 'isModEnabled(\"supplier_invoice\")', 1, NULL, NULL, NULL, NULL, '[__[MAIN_INFO_SOCIETE_NOM]__] - __(SupplierInvoice)__', '0', '__(Hello)__,<br /><br />__(SupplierInvoiceUnpaidContent)__<br />__URL_SUPPLIER_INVOICE__<br /><br />__(Sincerely)__<br />__SENDEREMAIL_SIGNATURE__', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_field_list`
--

CREATE TABLE `llx_c_field_list` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `element` varchar(64) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `name` varchar(32) NOT NULL,
  `alias` varchar(32) NOT NULL,
  `title` varchar(32) NOT NULL,
  `align` varchar(6) DEFAULT 'left',
  `sort` tinyint(4) NOT NULL DEFAULT 1,
  `search` tinyint(4) NOT NULL DEFAULT 0,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `enabled` varchar(255) DEFAULT '1',
  `rang` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_format_cards`
--

CREATE TABLE `llx_c_format_cards` (
  `rowid` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `paper_size` varchar(20) NOT NULL,
  `orientation` varchar(1) NOT NULL,
  `metric` varchar(5) NOT NULL,
  `leftmargin` double(24,8) NOT NULL,
  `topmargin` double(24,8) NOT NULL,
  `nx` int(11) NOT NULL,
  `ny` int(11) NOT NULL,
  `spacex` double(24,8) NOT NULL,
  `spacey` double(24,8) NOT NULL,
  `width` double(24,8) NOT NULL,
  `height` double(24,8) NOT NULL,
  `font_size` int(11) NOT NULL,
  `custom_x` double(24,8) NOT NULL,
  `custom_y` double(24,8) NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_format_cards`
--

INSERT INTO `llx_c_format_cards` (`rowid`, `code`, `name`, `paper_size`, `orientation`, `metric`, `leftmargin`, `topmargin`, `nx`, `ny`, `spacex`, `spacey`, `width`, `height`, `font_size`, `custom_x`, `custom_y`, `active`) VALUES
(1, '5160', 'Avery-5160, WL-875WX', 'letter', 'P', 'mm', 5.58165000, 12.70000000, 3, 10, 3.55600000, 0.00000000, 65.87490000, 25.40000000, 7, 0.00000000, 0.00000000, 1),
(2, '5161', 'Avery-5161, WL-75WX', 'letter', 'P', 'mm', 4.44500000, 12.70000000, 2, 10, 3.96800000, 0.00000000, 101.60000000, 25.40000000, 7, 0.00000000, 0.00000000, 1),
(3, '5162', 'Avery-5162, WL-100WX', 'letter', 'P', 'mm', 3.87350000, 22.35200000, 2, 7, 4.95400000, 0.00000000, 101.60000000, 33.78100000, 8, 0.00000000, 0.00000000, 1),
(4, '5163', 'Avery-5163, WL-125WX', 'letter', 'P', 'mm', 4.57200000, 12.70000000, 2, 5, 3.55600000, 0.00000000, 101.60000000, 50.80000000, 10, 0.00000000, 0.00000000, 1),
(5, '5164', 'Avery-5164 (inch)', 'letter', 'P', 'in', 0.14800000, 0.50000000, 2, 3, 0.20310000, 0.00000000, 4.00000000, 3.33000000, 12, 0.00000000, 0.00000000, 0),
(6, '8600', 'Avery-8600', 'letter', 'P', 'mm', 7.10000000, 19.00000000, 3, 10, 9.50000000, 3.10000000, 66.60000000, 25.40000000, 7, 0.00000000, 0.00000000, 1),
(7, '99012', 'DYMO 99012 89*36mm', 'custom', 'L', 'mm', 1.00000000, 1.00000000, 1, 1, 0.00000000, 0.00000000, 36.00000000, 89.00000000, 10, 36.00000000, 89.00000000, 1),
(8, '99014', 'DYMO 99014 101*54mm', 'custom', 'L', 'mm', 1.00000000, 1.00000000, 1, 1, 0.00000000, 0.00000000, 54.00000000, 101.00000000, 10, 54.00000000, 101.00000000, 1),
(9, 'AVERYC32010', 'Avery-C32010', 'A4', 'P', 'mm', 15.00000000, 13.00000000, 2, 5, 10.00000000, 0.00000000, 85.00000000, 54.00000000, 10, 0.00000000, 0.00000000, 1),
(10, 'CARD', 'Dolibarr Business cards', 'A4', 'P', 'mm', 15.00000000, 15.00000000, 2, 5, 0.00000000, 0.00000000, 85.00000000, 54.00000000, 10, 0.00000000, 0.00000000, 1),
(11, 'L7163', 'Avery-L7163', 'A4', 'P', 'mm', 5.00000000, 15.00000000, 2, 7, 2.50000000, 0.00000000, 99.10000000, 38.10000000, 8, 0.00000000, 0.00000000, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_forme_juridique`
--

CREATE TABLE `llx_c_forme_juridique` (
  `rowid` int(11) NOT NULL,
  `code` int(11) NOT NULL,
  `fk_pays` int(11) NOT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `isvatexempted` tinyint(4) NOT NULL DEFAULT 0,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `module` varchar(32) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_forme_juridique`
--

INSERT INTO `llx_c_forme_juridique` (`rowid`, `code`, `fk_pays`, `libelle`, `isvatexempted`, `active`, `module`, `position`) VALUES
(1, 0, 0, '-', 0, 1, NULL, 0),
(2, 2301, 23, 'Monotributista', 0, 1, NULL, 0),
(3, 2302, 23, 'Sociedad Civil', 0, 1, NULL, 0),
(4, 2303, 23, 'Sociedades Comerciales', 0, 1, NULL, 0),
(5, 2304, 23, 'Sociedades de Hecho', 0, 1, NULL, 0),
(6, 2305, 23, 'Sociedades Irregulares', 0, 1, NULL, 0),
(7, 2306, 23, 'Sociedad Colectiva', 0, 1, NULL, 0),
(8, 2307, 23, 'Sociedad en Comandita Simple', 0, 1, NULL, 0),
(9, 2308, 23, 'Sociedad de Capital e Industria', 0, 1, NULL, 0),
(10, 2309, 23, 'Sociedad Accidental o en participación', 0, 1, NULL, 0),
(11, 2310, 23, 'Sociedad de Responsabilidad Limitada', 0, 1, NULL, 0),
(12, 2311, 23, 'Sociedad Anónima', 0, 1, NULL, 0),
(13, 2312, 23, 'Sociedad Anónima con Participación Estatal Mayoritaria', 0, 1, NULL, 0),
(14, 2313, 23, 'Sociedad en Comandita por Acciones (arts. 315 a 324, LSC)', 0, 1, NULL, 0),
(15, 4100, 41, 'GmbH - Gesellschaft mit beschränkter Haftung', 0, 1, NULL, 0),
(16, 4101, 41, 'GesmbH - Gesellschaft mit beschränkter Haftung', 0, 1, NULL, 0),
(17, 4102, 41, 'AG - Aktiengesellschaft', 0, 1, NULL, 0),
(18, 4103, 41, 'EWIV - Europäische wirtschaftliche Interessenvereinigung', 0, 1, NULL, 0),
(19, 4104, 41, 'KEG - Kommanditerwerbsgesellschaft', 0, 1, NULL, 0),
(20, 4105, 41, 'OEG - Offene Erwerbsgesellschaft', 0, 1, NULL, 0),
(21, 4106, 41, 'OHG - Offene Handelsgesellschaft', 0, 1, NULL, 0),
(22, 4107, 41, 'AG & Co KG - Kommanditgesellschaft', 0, 1, NULL, 0),
(23, 4108, 41, 'GmbH & Co KG - Kommanditgesellschaft', 0, 1, NULL, 0),
(24, 4109, 41, 'KG - Kommanditgesellschaft', 0, 1, NULL, 0),
(25, 4110, 41, 'OG - Offene Gesellschaft', 0, 1, NULL, 0),
(26, 4111, 41, 'GbR - Gesellschaft nach bürgerlichem Recht', 0, 1, NULL, 0),
(27, 4112, 41, 'GesbR - Gesellschaft nach bürgerlichem Recht', 0, 1, NULL, 0),
(28, 4113, 41, 'GesnbR - Gesellschaft nach bürgerlichem Recht', 0, 1, NULL, 0),
(29, 4114, 41, 'e.U. - eingetragener Einzelunternehmer', 0, 1, NULL, 0),
(30, 200, 2, 'Indépendant', 0, 1, NULL, 0),
(31, 201, 2, 'SRL - Société à responsabilité limitée', 0, 1, NULL, 0),
(32, 202, 2, 'SA   - Société Anonyme', 0, 1, NULL, 0),
(33, 203, 2, 'SCRL - Société coopérative à responsabilité limitée', 0, 1, NULL, 0),
(34, 204, 2, 'ASBL - Association sans but Lucratif', 0, 1, NULL, 0),
(35, 205, 2, 'SCRI - Société coopérative à responsabilité illimitée', 0, 1, NULL, 0),
(36, 206, 2, 'SCS  - Société en commandite simple', 0, 1, NULL, 0),
(37, 207, 2, 'SCA  - Société en commandite par action', 0, 1, NULL, 0),
(38, 208, 2, 'SNC  - Société en nom collectif', 0, 1, NULL, 0),
(39, 209, 2, 'GIE  - Groupement d intérêt économique', 0, 1, NULL, 0),
(40, 210, 2, 'GEIE - Groupement européen d intérêt économique', 0, 1, NULL, 0),
(41, 220, 2, 'Eenmanszaak', 0, 1, NULL, 0),
(42, 221, 2, 'BVBA - Besloten vennootschap met beperkte aansprakelijkheid', 0, 1, NULL, 0),
(43, 222, 2, 'NV   - Naamloze Vennootschap', 0, 1, NULL, 0),
(44, 223, 2, 'CVBA - Coöperatieve vennootschap met beperkte aansprakelijkheid', 0, 1, NULL, 0),
(45, 224, 2, 'VZW  - Vereniging zonder winstoogmerk', 0, 1, NULL, 0),
(46, 225, 2, 'CVOA - Coöperatieve vennootschap met onbeperkte aansprakelijkheid ', 0, 1, NULL, 0),
(47, 226, 2, 'GCV  - Gewone commanditaire vennootschap', 0, 1, NULL, 0),
(48, 227, 2, 'Comm.VA - Commanditaire vennootschap op aandelen', 0, 1, NULL, 0),
(49, 228, 2, 'VOF  - Vennootschap onder firma', 0, 1, NULL, 0),
(50, 229, 2, 'VS0  - Vennootschap met sociaal oogmerk', 0, 1, NULL, 0),
(51, 9, 1, 'Organisme de placement collectif en valeurs mobilières sans personnalité morale', 0, 1, NULL, 0),
(52, 10, 1, 'Entrepreneur individuel', 0, 1, NULL, 0),
(53, 21, 1, 'Indivision', 0, 1, NULL, 0),
(54, 22, 1, 'Société créée de fait', 0, 1, NULL, 0),
(55, 23, 1, 'Société en participation', 0, 1, NULL, 0),
(56, 24, 1, 'Fiducie', 0, 1, NULL, 0),
(57, 27, 1, 'Paroisse hors zone concordataire', 0, 1, NULL, 0),
(58, 28, 1, 'Assujetti unique à la TVA', 0, 1, NULL, 0),
(59, 29, 1, 'Autre groupement de droit privé non doté de la personnalité morale', 0, 1, NULL, 0),
(60, 31, 1, 'Personne morale de droit étranger, immatriculée au RCS', 0, 1, NULL, 0),
(61, 32, 1, 'Personne morale de droit étranger, non immatriculée au RCS', 0, 1, NULL, 0),
(62, 41, 1, 'Etablissement public ou régie à caractère industriel ou commercial', 0, 1, NULL, 0),
(63, 51, 1, 'Société coopérative commerciale particulière', 0, 1, NULL, 0),
(64, 52, 1, 'Société en nom collectif', 0, 1, NULL, 0),
(65, 53, 1, 'Société en commandite', 0, 1, NULL, 0),
(66, 54, 1, 'Société à responsabilité limitée (SARL)', 0, 1, NULL, 0),
(67, 55, 1, 'Société anonyme à conseil d\'administration', 0, 1, NULL, 0),
(68, 56, 1, 'Société anonyme à directoire', 0, 1, NULL, 0),
(69, 57, 1, 'Société par actions simplifiée (SAS)', 0, 1, NULL, 0),
(70, 58, 1, 'Société européenne', 0, 1, NULL, 0),
(71, 61, 1, 'Caisse d\'épargne et de prévoyance', 0, 1, NULL, 0),
(72, 62, 1, 'Groupement d\'intérêt économique (GIE)', 0, 1, NULL, 0),
(73, 63, 1, 'Société coopérative agricole', 0, 1, NULL, 0),
(74, 64, 1, 'Société d\'assurance mutuelle', 0, 1, NULL, 0),
(75, 65, 1, 'Société civile', 0, 1, NULL, 0),
(76, 66, 1, 'Société publiques locales', 0, 1, NULL, 0),
(77, 69, 1, 'Autre personne morale de droit privé inscrite au RCS', 0, 1, NULL, 0),
(78, 71, 1, 'Administration de l état', 0, 1, NULL, 0),
(79, 72, 1, 'Collectivité territoriale', 0, 1, NULL, 0),
(80, 73, 1, 'Etablissement public administratif', 0, 1, NULL, 0),
(81, 74, 1, 'Personne morale de droit public administratif', 0, 1, NULL, 0),
(82, 81, 1, 'Organisme gérant régime de protection social à adhésion obligatoire', 0, 1, NULL, 0),
(83, 82, 1, 'Organisme mutualiste', 0, 1, NULL, 0),
(84, 83, 1, 'Comité d entreprise', 0, 1, NULL, 0),
(85, 84, 1, 'Organisme professionnel', 0, 1, NULL, 0),
(86, 85, 1, 'Organisme de retraite à adhésion non obligatoire', 0, 1, NULL, 0),
(87, 91, 1, 'Syndicat de propriétaires', 0, 1, NULL, 0),
(88, 92, 1, 'Association loi 1901 ou assimilé', 0, 1, NULL, 0),
(89, 93, 1, 'Fondation', 0, 1, NULL, 0),
(90, 99, 1, 'Autre personne morale de droit privé', 0, 1, NULL, 0),
(91, 500, 5, 'GmbH - Gesellschaft mit beschränkter Haftung', 0, 1, NULL, 0),
(92, 501, 5, 'AG - Aktiengesellschaft ', 0, 1, NULL, 0),
(93, 502, 5, 'GmbH&Co. KG - Gesellschaft mit beschränkter Haftung & Compagnie Kommanditgesellschaft', 0, 1, NULL, 0),
(94, 503, 5, 'Gewerbe - Personengesellschaft', 0, 1, NULL, 0),
(95, 504, 5, 'UG - Unternehmergesellschaft -haftungsbeschränkt-', 0, 1, NULL, 0),
(96, 505, 5, 'GbR - Gesellschaft des bürgerlichen Rechts', 0, 1, NULL, 0),
(97, 506, 5, 'KG - Kommanditgesellschaft', 0, 1, NULL, 0),
(98, 507, 5, 'Ltd. - Limited Company', 0, 1, NULL, 0),
(99, 508, 5, 'OHG - Offene Handelsgesellschaft', 0, 1, NULL, 0),
(100, 509, 5, 'eG - eingetragene Genossenschaft', 0, 1, NULL, 0),
(101, 510, 5, 'e.V. - eingetragener Verein', 0, 1, NULL, 0),
(102, 8001, 80, 'Aktieselvskab A/S', 0, 1, NULL, 0),
(103, 8002, 80, 'Anparts Selvskab ApS', 0, 1, NULL, 0),
(104, 8003, 80, 'Personlig ejet selvskab', 0, 1, NULL, 0),
(105, 8004, 80, 'Iværksætterselvskab IVS', 0, 1, NULL, 0),
(106, 8005, 80, 'Interessentskab I/S', 0, 1, NULL, 0),
(107, 8006, 80, 'Holdingselskab', 0, 1, NULL, 0),
(108, 8007, 80, 'Selskab Med Begrænset Hæftelse SMBA', 0, 1, NULL, 0),
(109, 8008, 80, 'Kommanditselskab K/S', 0, 1, NULL, 0),
(110, 8009, 80, 'SPE-selskab', 0, 1, NULL, 0),
(111, 8010, 80, 'Forening med begrænset ansvar (f.m.b.a.)', 0, 1, NULL, 0),
(112, 8011, 80, 'Frivillig forening', 0, 1, NULL, 0),
(113, 8012, 80, 'Almindelig forening', 0, 1, NULL, 0),
(114, 8013, 80, 'Andelsboligforening', 0, 1, NULL, 0),
(115, 8014, 80, 'Særlig forening', 0, 1, NULL, 0),
(116, 10201, 102, 'Ατομική επιχείρηση', 0, 1, NULL, 0),
(117, 10202, 102, 'Εταιρική  επιχείρηση', 0, 1, NULL, 0),
(118, 10203, 102, 'Ομόρρυθμη Εταιρεία Ο.Ε', 0, 1, NULL, 0),
(119, 10204, 102, 'Ετερόρρυθμη Εταιρεία Ε.Ε', 0, 1, NULL, 0),
(120, 10205, 102, 'Εταιρεία Περιορισμένης Ευθύνης Ε.Π.Ε', 0, 1, NULL, 0),
(121, 10206, 102, 'Ανώνυμη Εταιρεία Α.Ε', 0, 1, NULL, 0),
(122, 10207, 102, 'Ανώνυμη ναυτιλιακή εταιρεία Α.Ν.Ε', 0, 1, NULL, 0),
(123, 10208, 102, 'Συνεταιρισμός', 0, 1, NULL, 0),
(124, 10209, 102, 'Συμπλοιοκτησία', 0, 1, NULL, 0),
(125, 301, 3, 'Società semplice', 0, 1, NULL, 0),
(126, 302, 3, 'Società in nome collettivo s.n.c.', 0, 1, NULL, 0),
(127, 303, 3, 'Società in accomandita semplice s.a.s.', 0, 1, NULL, 0),
(128, 304, 3, 'Società per azioni s.p.a.', 0, 1, NULL, 0),
(129, 305, 3, 'Società a responsabilità limitata s.r.l.', 0, 1, NULL, 0),
(130, 306, 3, 'Società in accomandita per azioni s.a.p.a.', 0, 1, NULL, 0),
(131, 307, 3, 'Società cooperativa a r.l.', 0, 1, NULL, 0),
(132, 308, 3, 'Società consortile', 0, 1, NULL, 0),
(133, 309, 3, 'Società europea', 0, 1, NULL, 0),
(134, 310, 3, 'Società cooperativa europea', 0, 1, NULL, 0),
(135, 311, 3, 'Società unipersonale', 0, 1, NULL, 0),
(136, 312, 3, 'Società di professionisti', 0, 1, NULL, 0),
(137, 313, 3, 'Società di fatto', 0, 1, NULL, 0),
(138, 315, 3, 'Società apparente', 0, 1, NULL, 0),
(139, 316, 3, 'Impresa individuale ', 0, 1, NULL, 0),
(140, 317, 3, 'Impresa coniugale', 0, 1, NULL, 0),
(141, 318, 3, 'Impresa familiare', 0, 1, NULL, 0),
(142, 319, 3, 'Consorzio cooperativo', 0, 1, NULL, 0),
(143, 320, 3, 'Società cooperativa sociale', 0, 1, NULL, 0),
(144, 321, 3, 'Società cooperativa di consumo', 0, 1, NULL, 0),
(145, 322, 3, 'Società cooperativa agricola', 0, 1, NULL, 0),
(146, 323, 3, 'A.T.I. Associazione temporanea di imprese', 0, 1, NULL, 0),
(147, 324, 3, 'R.T.I. Raggruppamento temporaneo di imprese', 0, 1, NULL, 0),
(148, 325, 3, 'Studio associato', 0, 1, NULL, 0),
(149, 600, 6, 'Raison Individuelle', 0, 1, NULL, 0),
(150, 601, 6, 'Société Simple', 0, 1, NULL, 0),
(151, 602, 6, 'Société en nom collectif', 0, 1, NULL, 0),
(152, 603, 6, 'Société en commandite', 0, 1, NULL, 0),
(153, 604, 6, 'Société anonyme (SA)', 0, 1, NULL, 0),
(154, 605, 6, 'Société en commandite par actions', 0, 1, NULL, 0),
(155, 606, 6, 'Société à responsabilité limitée (SARL)', 0, 1, NULL, 0),
(156, 607, 6, 'Société coopérative', 0, 1, NULL, 0),
(157, 608, 6, 'Association', 0, 1, NULL, 0),
(158, 609, 6, 'Fondation', 0, 1, NULL, 0),
(159, 700, 7, 'Sole Trader', 0, 1, NULL, 0),
(160, 701, 7, 'Partnership', 0, 1, NULL, 0),
(161, 702, 7, 'Private Limited Company by shares (LTD)', 0, 1, NULL, 0),
(162, 703, 7, 'Public Limited Company', 0, 1, NULL, 0),
(163, 704, 7, 'Workers Cooperative', 0, 1, NULL, 0),
(164, 705, 7, 'Limited Liability Partnership', 0, 1, NULL, 0),
(165, 706, 7, 'Franchise', 0, 1, NULL, 0),
(166, 1000, 10, 'Société à responsabilité limitée (SARL)', 0, 1, NULL, 0),
(167, 1001, 10, 'Société en Nom Collectif (SNC)', 0, 1, NULL, 0),
(168, 1002, 10, 'Société en Commandite Simple (SCS)', 0, 1, NULL, 0),
(169, 1003, 10, 'société en participation', 0, 1, NULL, 0),
(170, 1004, 10, 'Société Anonyme (SA)', 0, 1, NULL, 0),
(171, 1005, 10, 'Société Unipersonnelle à Responsabilité Limitée (SUARL)', 0, 1, NULL, 0),
(172, 1006, 10, 'Groupement d\'intérêt économique (GEI)', 0, 1, NULL, 0),
(173, 1007, 10, 'Groupe de sociétés', 0, 1, NULL, 0),
(174, 1701, 17, 'Eenmanszaak', 0, 1, NULL, 0),
(175, 1702, 17, 'Maatschap', 0, 1, NULL, 0),
(176, 1703, 17, 'Vennootschap onder firma', 0, 1, NULL, 0),
(177, 1704, 17, 'Commanditaire vennootschap', 0, 1, NULL, 0),
(178, 1705, 17, 'Besloten vennootschap (BV)', 0, 1, NULL, 0),
(179, 1706, 17, 'Naamloze Vennootschap (NV)', 0, 1, NULL, 0),
(180, 1707, 17, 'Vereniging', 0, 1, NULL, 0),
(181, 1708, 17, 'Stichting', 0, 1, NULL, 0),
(182, 1709, 17, 'Coöperatie met beperkte aansprakelijkheid (BA)', 0, 1, NULL, 0),
(183, 1710, 17, 'Coöperatie met uitgesloten aansprakelijkheid (UA)', 0, 1, NULL, 0),
(184, 1711, 17, 'Coöperatie met wettelijke aansprakelijkheid (WA)', 0, 1, NULL, 0),
(185, 1712, 17, 'Onderlinge waarborgmaatschappij', 0, 1, NULL, 0),
(186, 401, 4, 'Empresario Individual', 0, 1, NULL, 0),
(187, 402, 4, 'Comunidad de Bienes', 0, 1, NULL, 0),
(188, 403, 4, 'Sociedad Civil', 0, 1, NULL, 0),
(189, 404, 4, 'Sociedad Colectiva', 0, 1, NULL, 0),
(190, 405, 4, 'Sociedad Limitada', 0, 1, NULL, 0),
(191, 406, 4, 'Sociedad Anónima', 0, 1, NULL, 0),
(192, 407, 4, 'Sociedad Comanditaria por Acciones', 0, 1, NULL, 0),
(193, 408, 4, 'Sociedad Comanditaria Simple', 0, 1, NULL, 0),
(194, 409, 4, 'Sociedad Laboral', 0, 1, NULL, 0),
(195, 410, 4, 'Sociedad Cooperativa', 0, 1, NULL, 0),
(196, 411, 4, 'Sociedad de Garantía Recíproca', 0, 1, NULL, 0),
(197, 412, 4, 'Entidad de Capital-Riesgo', 0, 1, NULL, 0),
(198, 413, 4, 'Agrupación de Interés Económico', 0, 1, NULL, 0),
(199, 414, 4, 'Sociedad de Inversión Mobiliaria', 0, 1, NULL, 0),
(200, 415, 4, 'Agrupación sin Ánimo de Lucro', 0, 1, NULL, 0),
(201, 15201, 152, 'Mauritius Private Company Limited By Shares', 0, 1, NULL, 0),
(202, 15202, 152, 'Mauritius Company Limited By Guarantee', 0, 1, NULL, 0),
(203, 15203, 152, 'Mauritius Public Company Limited By Shares', 0, 1, NULL, 0),
(204, 15204, 152, 'Mauritius Foreign Company', 0, 1, NULL, 0),
(205, 15205, 152, 'Mauritius GBC1 (Offshore Company)', 0, 1, NULL, 0),
(206, 15206, 152, 'Mauritius GBC2 (International Company)', 0, 1, NULL, 0),
(207, 15207, 152, 'Mauritius General Partnership', 0, 1, NULL, 0),
(208, 15208, 152, 'Mauritius Limited Partnership', 0, 1, NULL, 0),
(209, 15209, 152, 'Mauritius Sole Proprietorship', 0, 1, NULL, 0),
(210, 15210, 152, 'Mauritius Trusts', 0, 1, NULL, 0),
(211, 15401, 154, '601 - General de Ley Personas Morales', 0, 1, NULL, 0),
(212, 15402, 154, '603 - Personas Morales con Fines no Lucrativos', 0, 1, NULL, 0),
(213, 15403, 154, '605 - Sueldos y Salarios e Ingresos Asimilados a Salarios', 0, 1, NULL, 0),
(214, 15404, 154, '606 - Arrendamiento', 0, 1, NULL, 0),
(215, 15405, 154, '607 - Régimen de Enajenación o Adquisición de Bienes', 0, 1, NULL, 0),
(216, 15406, 154, '608 - Demás ingresos', 0, 1, NULL, 0),
(217, 15407, 154, '610 - Residentes en el Extranjero sin Establecimiento Permanente en México', 0, 1, NULL, 0),
(218, 15408, 154, '611 - Ingresos por Dividendos (socios y accionistas)', 0, 1, NULL, 0),
(219, 15409, 154, '612 - Personas Físicas con Actividades Empresariales y Profesionales', 0, 1, NULL, 0),
(220, 15410, 154, '614 - Ingresos por intereses', 0, 1, NULL, 0),
(221, 15411, 154, '615 - Régimen de los ingresos por obtención de premios', 0, 1, NULL, 0),
(222, 15412, 154, '616 - Sin obligaciones fiscales', 0, 1, NULL, 0),
(223, 15413, 154, '620 - Sociedades Cooperativas de Producción que optan por diferir sus ingresos', 0, 1, NULL, 0),
(224, 15414, 154, '621 - Incorporación Fiscal', 0, 1, NULL, 0),
(225, 15415, 154, '622 - Actividades Agrícolas, Ganaderas, Silvícolas y Pesqueras', 0, 1, NULL, 0),
(226, 15416, 154, '623 - Opcional para Grupos de Sociedades', 0, 1, NULL, 0),
(227, 15417, 154, '624 - Coordinados', 0, 1, NULL, 0),
(228, 15418, 154, '625 - Régimen de las Actividades Empresariales con ingresos a través de Plataformas Tecnológicas', 0, 1, NULL, 0),
(229, 15419, 154, '626 - Régimen Simplificado de Confianza', 0, 1, NULL, 0),
(230, 14001, 140, 'Entreprise individuelle', 0, 1, NULL, 0),
(231, 14002, 140, 'Société en nom collectif (SENC)', 0, 1, NULL, 0),
(232, 14003, 140, 'Société en commandite simple (SECS)', 0, 1, NULL, 0),
(233, 14004, 140, 'Société en commandite par actions (SECA)', 0, 1, NULL, 0),
(234, 14005, 140, 'Société à responsabilité limitée (SARL)', 0, 1, NULL, 0),
(235, 14006, 140, 'Société anonyme (SA)', 0, 1, NULL, 0),
(236, 14007, 140, 'Société coopérative (SC)', 0, 1, NULL, 0),
(237, 14008, 140, 'Société européenne (SE)', 0, 1, NULL, 0),
(238, 14009, 140, 'Société à responsabilité limitée simplifiée (SARL-S)', 0, 1, NULL, 0),
(239, 18801, 188, 'AFJ - Alte forme juridice', 0, 1, NULL, 0),
(240, 18802, 188, 'ASF - Asociatie familialã', 0, 1, NULL, 0),
(241, 18803, 188, 'CON - Concesiune', 0, 1, NULL, 0),
(242, 18804, 188, 'CRL - Soc civilã profesionala cu pers. juridica si rãspundere limitata (SPRL)', 0, 1, NULL, 0),
(243, 18805, 188, 'INC - Închiriere', 0, 1, NULL, 0),
(244, 18806, 188, 'LOC - Locaţie de gestiune', 0, 1, NULL, 0),
(245, 18807, 188, 'OC1 - Organizaţie cooperatistã meşteşugãreascã', 0, 1, NULL, 0),
(246, 18808, 188, 'OC2 - Organizaţie cooperatistã de consum', 0, 1, NULL, 0),
(247, 18809, 188, 'OC3 - Organizaţie cooperatistã de credit', 0, 1, NULL, 0),
(248, 18810, 188, 'PFA - Persoanã fizicã independentã', 0, 1, NULL, 0),
(249, 18811, 188, 'RA - Regie autonomã', 0, 1, NULL, 0),
(250, 18812, 188, 'SA - Societate comercialã pe acţiuni', 0, 1, NULL, 0),
(251, 18813, 188, 'SCS - Societate comercialã în comanditã simplã', 0, 1, NULL, 0),
(252, 18814, 188, 'SNC - Societate comercialã în nume colectiv', 0, 1, NULL, 0),
(253, 18815, 188, 'SPI - Societate profesionala practicieni in insolventa (SPPI)', 0, 1, NULL, 0),
(254, 18816, 188, 'SRL - Societate comercialã cu rãspundere limitatã', 0, 1, NULL, 0),
(255, 18817, 188, 'URL - Intreprindere profesionala unipersonala cu rãspundere limitata (IPURL)', 0, 1, NULL, 0),
(256, 17801, 178, 'Empresa individual', 0, 1, NULL, 0),
(257, 17802, 178, 'Asociación General', 0, 1, NULL, 0),
(258, 17803, 178, 'Sociedad de Responsabilidad Limitada', 0, 1, NULL, 0),
(259, 17804, 178, 'Sociedad Civil', 0, 1, NULL, 0),
(260, 17805, 178, 'Sociedad Anónima', 0, 1, NULL, 0),
(261, 1300, 13, 'Personne physique', 0, 1, NULL, 0),
(262, 1301, 13, 'Société à responsabilité limitée (SARL)', 0, 1, NULL, 0),
(263, 1302, 13, 'Entreprise unipersonnelle à responsabilité limitée (EURL)', 0, 1, NULL, 0),
(264, 1303, 13, 'Société en Nom Collectif (SNC)', 0, 1, NULL, 0),
(265, 1304, 13, 'société par actions (SPA)', 0, 1, NULL, 0),
(266, 1305, 13, 'Société en Commandite Simple (SCS)', 0, 1, NULL, 0),
(267, 1306, 13, 'Société en commandite par actions (SCA)', 0, 1, NULL, 0),
(268, 1307, 13, 'Société en participation', 0, 1, NULL, 0),
(269, 1308, 13, 'Groupe de sociétés', 0, 1, NULL, 0),
(270, 2001, 20, 'Aktiebolag', 0, 1, NULL, 0),
(271, 2002, 20, 'Publikt aktiebolag (AB publ)', 0, 1, NULL, 0),
(272, 2003, 20, 'Ekonomisk förening (ek. för.)', 0, 1, NULL, 0),
(273, 2004, 20, 'Bostadsrättsförening (BRF)', 0, 1, NULL, 0),
(274, 2005, 20, 'Hyresrättsförening (HRF)', 0, 1, NULL, 0),
(275, 2006, 20, 'Kooperativ', 0, 1, NULL, 0),
(276, 2007, 20, 'Enskild firma (EF)', 0, 1, NULL, 0),
(277, 2008, 20, 'Handelsbolag (HB)', 0, 1, NULL, 0),
(278, 2009, 20, 'Kommanditbolag (KB)', 0, 1, NULL, 0),
(279, 2010, 20, 'Enkelt bolag', 0, 1, NULL, 0),
(280, 2011, 20, 'Ideell förening', 0, 1, NULL, 0),
(281, 2012, 20, 'Stiftelse', 0, 1, NULL, 0),
(282, 6100, 61, 'Indépendant - Personne physique', 0, 1, NULL, 0),
(283, 6101, 61, 'Société Unipersonnelle', 0, 1, NULL, 0),
(284, 6102, 61, 'Société de personne à responsabilité limité (SPRL)', 0, 1, NULL, 0),
(285, 6103, 61, 'Société anonyme (SA)', 0, 1, NULL, 0),
(286, 6104, 61, 'Société coopérative', 0, 1, NULL, 0),
(287, 7601, 76, 'Društvo s ograničenom odgovornošću (d.o.o.)', 0, 1, NULL, 0),
(288, 7602, 76, 'Jednostavno društvo s ograničenom odgovornošću (j.d.o.o.)', 0, 1, NULL, 0),
(289, 7603, 76, 'Dioničko društvo (d.d.)', 0, 1, NULL, 0),
(290, 7604, 76, 'Obrt', 0, 1, NULL, 0),
(291, 7605, 76, 'Javno trgovačko društvo (j.t.d.)', 0, 1, NULL, 0),
(292, 7606, 76, 'Komanditno društvo (k.d.)', 0, 1, NULL, 0),
(293, 7607, 76, 'Gospodarsko interesno udruženje (GIU)', 0, 1, NULL, 0),
(294, 7608, 76, 'Predstavništvo', 0, 1, NULL, 0),
(295, 7609, 76, 'Državno tijelo', 0, 1, NULL, 0),
(296, 7610, 76, 'Kućna radinost', 0, 1, NULL, 0),
(297, 7611, 76, 'Sporedno zanimanje', 0, 1, NULL, 0),
(298, 12301, 123, '株式会社', 0, 1, NULL, 0),
(299, 12302, 123, '有限会社', 0, 1, NULL, 0),
(300, 12303, 123, '合資会社', 0, 1, NULL, 0),
(301, 12304, 123, '合名会社', 0, 1, NULL, 0),
(302, 12305, 123, '相互会社', 0, 1, NULL, 0),
(303, 12306, 123, '医療法人', 0, 1, NULL, 0),
(304, 12307, 123, '財団法人', 0, 1, NULL, 0),
(305, 12308, 123, '社団法人', 0, 1, NULL, 0),
(306, 12309, 123, '社会福祉法人', 0, 1, NULL, 0),
(307, 12310, 123, '学校法人', 0, 1, NULL, 0),
(308, 12311, 123, '特定非営利活動法人', 0, 1, NULL, 0),
(309, 12312, 123, 'ＮＰＯ法人', 0, 1, NULL, 0),
(310, 12313, 123, '商工組合', 0, 1, NULL, 0),
(311, 12314, 123, '林業組合', 0, 1, NULL, 0),
(312, 12315, 123, '同業組合', 0, 1, NULL, 0),
(313, 12316, 123, '農業協同組合', 0, 1, NULL, 0),
(314, 12317, 123, '漁業協同組合', 0, 1, NULL, 0),
(315, 12318, 123, '農事組合法人', 0, 1, NULL, 0),
(316, 12319, 123, '生活互助会', 0, 1, NULL, 0),
(317, 12320, 123, '協業組合', 0, 1, NULL, 0),
(318, 12321, 123, '協同組合', 0, 1, NULL, 0),
(319, 12322, 123, '生活協同組合', 0, 1, NULL, 0),
(320, 12323, 123, '連合会', 0, 1, NULL, 0),
(321, 12324, 123, '組合連合会', 0, 1, NULL, 0),
(322, 12325, 123, '協同組合連合会', 0, 1, NULL, 0),
(323, 12329, 123, '一般社団法人', 0, 1, NULL, 0),
(324, 12330, 123, '公益社団法人', 0, 1, NULL, 0),
(325, 12331, 123, '一般財団法人', 0, 1, NULL, 0),
(326, 12332, 123, '公益財団法人', 0, 1, NULL, 0),
(327, 12333, 123, '合同会社', 0, 1, NULL, 0),
(328, 12399, 123, '個人又はその他の法人', 0, 1, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_holiday_types`
--

CREATE TABLE `llx_c_holiday_types` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `code` varchar(16) NOT NULL,
  `label` varchar(255) NOT NULL,
  `affect` int(11) NOT NULL,
  `delay` int(11) NOT NULL,
  `newbymonth` double(8,5) NOT NULL DEFAULT 0.00000,
  `fk_country` int(11) DEFAULT NULL,
  `block_if_negative` int(11) NOT NULL DEFAULT 0,
  `sortorder` smallint(6) DEFAULT NULL,
  `active` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_holiday_types`
--

INSERT INTO `llx_c_holiday_types` (`rowid`, `entity`, `code`, `label`, `affect`, `delay`, `newbymonth`, `fk_country`, `block_if_negative`, `sortorder`, `active`) VALUES
(1, 1, 'LEAVE_SICK', 'Sick leave', 0, 0, 0.00000, NULL, 0, 1, 1),
(2, 1, 'LEAVE_OTHER', 'Other leave', 0, 0, 0.00000, NULL, 0, 2, 1),
(3, 1, 'LEAVE_PAID', 'Paid vacation', 1, 7, 0.00000, NULL, 0, 3, 0),
(4, 1, 'LEAVE_RTT_FR', 'RTT', 1, 7, 0.83000, 1, 0, 4, 1),
(5, 1, 'LEAVE_PAID_FR', 'Paid vacation', 1, 30, 2.08334, 1, 0, 5, 1),
(6, 1, '5D1Y', 'Κανονική άδεια(Πενθήμερο 1ο έτος)', 1, 0, 1.66700, 102, 0, 6, 1),
(7, 1, '5D2Y', 'Κανονική άδεια(Πενθήμερο 2ο έτος)', 1, 0, 1.75000, 102, 0, 7, 1),
(8, 1, '5D3-10Y', 'Κανονική άδεια(Πενθήμερο 3ο έως 10ο έτος)', 1, 0, 1.83300, 102, 0, 8, 1),
(9, 1, '5D10-25Y', 'Κανονική άδεια(Πενθήμερο 10ο έως 25ο έτος)', 1, 0, 2.08300, 102, 0, 9, 1),
(10, 1, '5D25+Y', 'Κανονική άδεια(Πενθήμερο 25+ έτη)', 1, 0, 2.16600, 102, 0, 10, 1),
(11, 1, '6D1Y', 'Κανονική άδεια(Εξαήμερο 1ο έτος)', 1, 0, 2.00000, 102, 0, 11, 1),
(12, 1, '6D2Y', 'Κανονική άδεια(Εξαήμερο 2ο έτος)', 1, 0, 2.08300, 102, 0, 12, 1),
(13, 1, '6D3-10Y', 'Κανονική άδεια(Εξαήμερο 3ο έως 10ο έτος)', 1, 0, 2.16600, 102, 0, 13, 1),
(14, 1, '6D10-25Y', 'Κανονική άδεια(Εξαήμερο 10ο έως 25ο έτος)', 1, 0, 2.08300, 102, 0, 14, 1),
(15, 1, '6D25+Y', 'Κανονική άδεια(Εξαήμερο 25+ έτη)', 1, 0, 2.16600, 102, 0, 15, 1),
(16, 1, '5D-WED', 'Πενθήμερη άδεια γάμου(με αποδοχές)', 0, 0, 0.00000, 102, 0, 16, 0),
(17, 1, '6D-WED', 'Εξαήμερη άδεια γάμου(με αποδοχές)', 0, 0, 0.00000, 102, 0, 17, 0),
(18, 1, '7D-AR', 'Επταήμερη άδεια ιατρικώς υποβοηθούμενης αναπαραγωγής(με αποδοχές)', 0, 0, 0.00000, 102, 0, 18, 0),
(19, 1, '1D-BC', 'Μονοήμερη άδεια προγεννητικών εξετάσεων(με αποδοχές)', 0, 0, 0.00000, 102, 0, 19, 0),
(20, 1, '1D-GYN', 'Μονοήμερη άδεια γυναικολογικού ελέγχου(με αποδοχές)', 0, 0, 0.00000, 102, 0, 20, 0),
(21, 1, '149D-ML', 'Άδεια Μητρότητας (Άδεια κύησης – λοχείας)56 ημέρες πριν-93 ημέρες μετα(με αποδοχές)', 0, 0, 0.00000, 102, 0, 21, 0),
(22, 1, '14D-PL', '14ήμερη Άδεια πατρότητας(με αποδοχές)', 0, 0, 0.00000, 102, 0, 22, 0),
(23, 1, '1-2H-CC', 'Άδεια φροντίδας παιδιών (μειωμένο ωράριο  https://www.kepea.gr/aarticle.php?id=1984)', 0, 0, 0.00000, 102, 0, 23, 0),
(24, 1, '9M-M', 'Ειδική άδεια προστασίας μητρότητας 9 μηνών(χωρίς αποδοχές)', 0, 0, 0.00000, 102, 0, 24, 0),
(25, 1, '4M-M', 'Τετράμηνη γονική Άδεια Ανατροφής Τέκνων(χωρίς αποδοχές)', 0, 0, 0.00000, 102, 0, 25, 0),
(26, 1, '6-8D-SP', 'Εξαήμερη ή Οκταήμερη Άδεια για μονογονεϊκές οικογένειες(με αποδοχές)', 0, 0, 0.00000, 102, 0, 26, 0),
(27, 1, '6-8-14D-FC', 'Αναρρωτική άδεια (άνευ αποδοχών, 6 ημέρες/έτος για ένα παιδί - 8 ημέρες/έτος για δύο και 14 ημέρες/έτος για τρία ή περισσότερα)', 0, 0, 0.00000, 102, 0, 27, 0),
(28, 1, '10D-CD', 'Δεκαήμερη Γονική Άδεια για παιδί με σοβαρά νοσήματα και λόγω νοσηλείας παιδιών(με αποδοχές)', 0, 0, 0.00000, 102, 0, 28, 0),
(29, 1, '30D-CD', 'Άδεια λόγω νοσηλείας των παιδιών(έως 30 ημέρες/έτος χωρίς αποδοχές)', 0, 0, 0.00000, 102, 0, 29, 0),
(30, 1, '5D-CG', 'Άδεια φροντιστή(έως 5 ημέρες/έτος χωρίς αποδοχές)', 0, 0, 0.00000, 102, 0, 30, 0),
(31, 1, '2D-CG', 'Άδεια απουσίας από την εργασία για λόγους ανωτέρας βίας(έως 2 ημέρες/έτος με αποδοχές)', 0, 0, 0.00000, 102, 0, 31, 0),
(32, 1, '2D-SC', 'Άδεια για παρακολούθηση σχολικής επίδοσης(έως 2 ημέρες/έτος με αποδοχές)', 0, 0, 0.00000, 102, 0, 32, 0),
(33, 1, '1D-BD', 'Μονοήμερη άδεια αιμοδοσίας(με αποδοχές)', 0, 0, 0.00000, 102, 0, 33, 0),
(34, 1, '22D-BT', 'Άδεια για μετάγγιση αίματος & αιμοκάθαρση(έως 22 ημέρες/έτος με αποδοχές)', 0, 0, 0.00000, 102, 0, 34, 0),
(35, 1, '30D-HIV', 'Άδεια λόγω AIDS(έως ένα (1) μήνα/έτος με αποδοχές)', 0, 0, 0.00000, 102, 0, 35, 0),
(36, 1, '20D-CD', 'Άδεια πενθούντων γονέων(20 ημέρες με αποδοχές)', 0, 0, 0.00000, 102, 0, 36, 0),
(37, 1, '2D-FD', 'Άδεια λόγω θανάτου συγγενούς(2 ημέρες με αποδοχές)', 0, 0, 0.00000, 102, 0, 37, 0),
(38, 1, 'DIS', 'Άδειες αναπήρων(30 ημέρες με αποδοχές)', 0, 0, 0.00000, 102, 0, 38, 0),
(39, 1, 'SE', 'Άδεια εξετάσεων μαθητών, σπουδαστών, φοιτητών(30 ημέρες χωρίς αποδοχές)', 0, 0, 0.00000, 102, 0, 39, 0),
(40, 1, 'NOT PAID', 'Άδεια άνευ αποδοχών(έως ένα (1) έτος)', 0, 0, 0.00000, 102, 0, 40, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_hrm_department`
--

CREATE TABLE `llx_c_hrm_department` (
  `rowid` int(11) NOT NULL,
  `pos` tinyint(4) NOT NULL DEFAULT 0,
  `code` varchar(16) NOT NULL,
  `label` varchar(128) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_hrm_department`
--

INSERT INTO `llx_c_hrm_department` (`rowid`, `pos`, `code`, `label`, `active`) VALUES
(1, 5, 'MANAGEMENT', 'Management', 1),
(3, 15, 'TRAINING', 'Training', 1),
(4, 20, 'IT', 'Inform. Technology (IT)', 0),
(5, 25, 'MARKETING', 'Marketing', 0),
(6, 30, 'SALES', 'Sales', 1),
(7, 35, 'LEGAL', 'Legal', 0),
(8, 40, 'FINANCIAL', 'Financial accounting', 1),
(9, 45, 'HUMANRES', 'Human resources', 1),
(10, 50, 'PURCHASING', 'Purchasing', 1),
(12, 60, 'CUSTOMSERV', 'Customer service', 0),
(14, 70, 'LOGISTIC', 'Logistics', 1),
(15, 75, 'CONSTRUCT', 'Engineering/design', 0),
(16, 80, 'PRODUCTION', 'Production', 1),
(17, 85, 'QUALITY', 'Quality assurance', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_hrm_function`
--

CREATE TABLE `llx_c_hrm_function` (
  `rowid` int(11) NOT NULL,
  `pos` tinyint(4) NOT NULL DEFAULT 0,
  `code` varchar(16) NOT NULL,
  `label` varchar(128) DEFAULT NULL,
  `c_level` tinyint(4) NOT NULL DEFAULT 0,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_hrm_function`
--

INSERT INTO `llx_c_hrm_function` (`rowid`, `pos`, `code`, `label`, `c_level`, `active`) VALUES
(1, 5, 'EXECBOARD', 'Executive board', 0, 1),
(2, 10, 'MANAGDIR', 'Managing director', 1, 1),
(3, 15, 'ACCOUNTMANAG', 'Account manager', 0, 1),
(4, 20, 'ENGAGDIR', 'Engagement director', 1, 1),
(5, 25, 'DIRECTOR', 'Director', 1, 1),
(6, 30, 'PROJMANAG', 'Project manager', 0, 1),
(7, 35, 'DEPHEAD', 'Department head', 0, 1),
(8, 40, 'SECRETAR', 'Secretary', 0, 1),
(9, 45, 'EMPLOYEE', 'Department employee', 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_hrm_public_holiday`
--

CREATE TABLE `llx_c_hrm_public_holiday` (
  `id` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_country` int(11) DEFAULT NULL,
  `fk_departement` int(11) DEFAULT NULL,
  `code` varchar(62) DEFAULT NULL,
  `dayrule` varchar(64) DEFAULT '',
  `day` int(11) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `active` int(11) DEFAULT 1,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_hrm_public_holiday`
--

INSERT INTO `llx_c_hrm_public_holiday` (`id`, `entity`, `fk_country`, `fk_departement`, `code`, `dayrule`, `day`, `month`, `year`, `active`, `import_key`) VALUES
(1, 1, 0, NULL, 'NEWYEARDAY1', '', 1, 1, 0, 1, NULL),
(2, 1, 0, NULL, 'LABORDAY1', '', 1, 5, 0, 1, NULL),
(3, 1, 0, NULL, 'ASSOMPTIONDAY1', '', 15, 8, 0, 1, NULL),
(4, 1, 0, NULL, 'CHRISTMASDAY1', '', 25, 12, 0, 1, NULL),
(5, 1, 1, NULL, 'FR-VICTORYDAY', '', 8, 5, 0, 1, NULL),
(6, 1, 1, NULL, 'FR-NATIONALDAY', '', 14, 7, 0, 1, NULL),
(7, 1, 1, NULL, 'FR-ASSOMPTION', '', 15, 8, 0, 1, NULL),
(8, 1, 1, NULL, 'FR-TOUSSAINT', '', 1, 11, 0, 1, NULL),
(9, 1, 1, NULL, 'FR-ARMISTICE', '', 11, 11, 0, 1, NULL),
(10, 1, 1, NULL, 'FR-EASTER', 'eastermonday', 0, 0, 0, 1, NULL),
(11, 1, 1, NULL, 'FR-ASCENSION', 'ascension', 0, 0, 0, 1, NULL),
(12, 1, 1, NULL, 'FR-PENTECOST', 'pentecost', 0, 0, 0, 1, NULL),
(13, 1, 2, NULL, 'BE-VICTORYDAY', '', 8, 5, 0, 1, NULL),
(14, 1, 2, NULL, 'BE-NATIONALDAY', '', 21, 7, 0, 1, NULL),
(15, 1, 2, NULL, 'BE-ASSOMPTION', '', 15, 8, 0, 1, NULL),
(16, 1, 2, NULL, 'BE-TOUSSAINT', '', 1, 11, 0, 1, NULL),
(17, 1, 2, NULL, 'BE-ARMISTICE', '', 11, 11, 0, 1, NULL),
(18, 1, 2, NULL, 'BE-EASTER', 'eastermonday', 0, 0, 0, 1, NULL),
(19, 1, 2, NULL, 'BE-ASCENSION', 'ascension', 0, 0, 0, 1, NULL),
(20, 1, 2, NULL, 'BE-PENTECOST', 'pentecost', 0, 0, 0, 1, NULL),
(21, 1, 3, NULL, 'IT-LIBEAZIONE', '', 25, 4, 0, 1, NULL),
(22, 1, 3, NULL, 'IT-EPIPHANY', '', 1, 6, 0, 1, NULL),
(23, 1, 3, NULL, 'IT-REPUBBLICA', '', 2, 6, 0, 1, NULL),
(24, 1, 3, NULL, 'IT-TUTTISANTIT', '', 1, 11, 0, 1, NULL),
(25, 1, 3, NULL, 'IT-IMMACULE', '', 8, 12, 0, 1, NULL),
(26, 1, 3, NULL, 'IT-SAINTSTEFAN', '', 26, 12, 0, 1, NULL),
(27, 1, 4, NULL, 'ES-EASTER', 'easter', 0, 0, 0, 1, NULL),
(28, 1, 4, NULL, 'ES-REYE', '', 1, 6, 0, 1, NULL),
(29, 1, 4, NULL, 'ES-HISPANIDAD', '', 12, 10, 0, 1, NULL),
(30, 1, 4, NULL, 'ES-TOUSSAINT', '', 1, 11, 0, 1, NULL),
(31, 1, 4, NULL, 'ES-CONSTITUIZION', '', 6, 12, 0, 1, NULL),
(32, 1, 4, NULL, 'ES-IMMACULE', '', 8, 12, 0, 1, NULL),
(33, 1, 5, NULL, 'DE-NEUJAHR', '', 1, 1, 0, 1, NULL),
(34, 1, 5, NULL, 'DE-HL3KOEN--TLW', '', 6, 1, 0, 0, NULL),
(35, 1, 5, NULL, 'DE-INTFRAUENTAG--TLW', '', 8, 3, 0, 0, NULL),
(36, 1, 5, NULL, 'DE-KARFREITAG', 'goodfriday', 0, 0, 0, 1, NULL),
(37, 1, 5, NULL, 'DE-OSTERMONTAG', 'eastermonday', 0, 0, 0, 1, NULL),
(38, 1, 5, NULL, 'DE-TAGDERARBEIT', '', 1, 5, 0, 1, NULL),
(39, 1, 5, NULL, 'DE-HIMMELFAHRT', 'ascension', 0, 0, 0, 1, NULL),
(40, 1, 5, NULL, 'DE-PFINGSTEN', 'pentecotemonday', 0, 0, 0, 1, NULL),
(41, 1, 5, NULL, 'DE-FRONLEICHNAM--TLW', 'fronleichnam', 0, 0, 0, 0, NULL),
(42, 1, 5, NULL, 'DE-MARIAEHIMMEL--TLW', '', 15, 8, 0, 0, NULL),
(43, 1, 5, NULL, 'DE-WELTKINDERTAG--TLW', '', 20, 9, 0, 0, NULL),
(44, 1, 5, NULL, 'DE-TAGDERDEUTEINHEIT', '', 3, 10, 0, 1, NULL),
(45, 1, 5, NULL, 'DE-REFORMATIONSTAG--TLW', '', 31, 10, 0, 0, NULL),
(46, 1, 5, NULL, 'DE-ALLERHEILIGEN--TLW', '', 1, 11, 0, 0, NULL),
(47, 1, 5, NULL, 'DE-WEIHNACHTSTAG1', '', 25, 12, 0, 1, NULL),
(48, 1, 5, NULL, 'DE-WEIHNACHTSTAG2', '', 26, 12, 0, 1, NULL),
(49, 1, 41, NULL, 'AT-EASTER', 'eastermonday', 0, 0, 0, 1, NULL),
(50, 1, 41, NULL, 'AT-ASCENSION', 'ascension', 0, 0, 0, 1, NULL),
(51, 1, 41, NULL, 'AT-PENTECOST', 'pentecost', 0, 0, 0, 1, NULL),
(52, 1, 41, NULL, 'AT-FRONLEICHNAM', 'fronleichnam', 0, 0, 0, 1, NULL),
(53, 1, 41, NULL, 'AT-KONEGIE', '', 1, 6, 0, 1, NULL),
(54, 1, 41, NULL, 'AT-26OKT', '', 26, 10, 0, 1, NULL),
(55, 1, 41, NULL, 'AT-TOUSSAINT', '', 1, 11, 0, 1, NULL),
(56, 1, 41, NULL, 'AT-IMMACULE', '', 8, 12, 0, 1, NULL),
(57, 1, 41, NULL, 'AT-24DEC', '', 24, 12, 0, 1, NULL),
(58, 1, 41, NULL, 'AT-SAINTSTEFAN', '', 26, 12, 0, 1, NULL),
(59, 1, 41, NULL, 'AT-Silvester', '', 31, 12, 0, 1, NULL),
(60, 1, 102, NULL, 'GR-ΠΡΩΤΟΧΡΟΝΙΑ', '', 1, 1, 0, 1, NULL),
(61, 1, 102, NULL, 'GR-ΘΕΟΦΑΝΕΙΑ', '', 6, 1, 0, 1, NULL),
(62, 1, 102, NULL, 'GR-25Η ΜΑΡΤΙΟΥ', '', 25, 3, 0, 1, NULL),
(63, 1, 102, NULL, 'GR-ΠΡΩΤΟΜΑΓΙΑ', '', 1, 5, 0, 1, NULL),
(64, 1, 102, NULL, 'GR-ΚΑΘΑΡΑ ΔΕΥΤΕΡΑ', 'ΚΑΘΑΡΑ_ΔΕΥΤΕΡΑ', 0, 0, 0, 1, NULL),
(65, 1, 102, NULL, 'GR-ΜΕΓΑΛΗ ΠΑΡΑΣΚΕΥΗ', 'ΜΕΓΑΛΗ_ΠΑΡΑΣΚΕΥΗ', 0, 0, 0, 1, NULL),
(66, 1, 102, NULL, 'GR-ΔΕΥΤΕΡΑ ΤΟΥ ΠΑΣΧΑ', 'ΔΕΥΤΕΡΑ_ΤΟΥ_ΠΑΣΧΑ', 0, 0, 0, 1, NULL),
(67, 1, 102, NULL, 'GR-ΤΟΥ ΑΓΙΟΥ ΠΝΕΥΜΑΤΟΣ', 'ΤΟΥ_ΑΓΙΟΥ_ΠΝΕΥΜΑΤΟΣ', 0, 0, 0, 1, NULL),
(68, 1, 102, NULL, 'GR-ΚΟΙΜΗΣΗ ΤΗΣ ΘΕΟΤΟΚΟΥ', '', 15, 8, 0, 1, NULL),
(69, 1, 102, NULL, 'GR-28Η ΟΚΤΩΒΡΙΟΥ', '', 28, 10, 0, 1, NULL),
(70, 1, 102, NULL, 'GR-ΧΡΙΣΤΟΥΓΕΝΝΑ', '', 25, 12, 0, 1, NULL),
(71, 1, 102, NULL, 'GR-ΣΥΝΑΞΗ ΘΕΟΤΟΚΟΥ', '', 26, 12, 0, 1, NULL),
(72, 1, 117, NULL, 'IN-REPUBLICDAY', '', 26, 1, 0, 1, NULL),
(73, 1, 117, NULL, 'IN-GANDI', '', 2, 10, 0, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_incoterms`
--

CREATE TABLE `llx_c_incoterms` (
  `rowid` int(11) NOT NULL,
  `code` varchar(3) NOT NULL,
  `label` varchar(100) DEFAULT NULL,
  `libelle` varchar(255) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_incoterms`
--

INSERT INTO `llx_c_incoterms` (`rowid`, `code`, `label`, `libelle`, `active`) VALUES
(1, 'EXW', 'Ex Works', 'Ex Works, au départ non chargé, non dédouané sortie d\'usine (uniquement adapté aux flux domestiques, nationaux)', 1),
(2, 'FCA', 'Free Carrier', 'Free Carrier, marchandises dédouanées et chargées dans le pays de départ, chez le vendeur ou chez le commissionnaire de transport de l\'acheteur', 1),
(3, 'FAS', 'Free Alongside Ship', 'Free Alongside Ship, sur le quai du port de départ', 1),
(4, 'FOB', 'Free On Board', 'Free On Board, chargé sur le bateau, les frais de chargement dans celui-ci étant fonction du liner term indiqué par la compagnie maritime (à la charge du vendeur)', 1),
(5, 'CFR', 'Cost and Freight', 'Cost and Freight, chargé dans le bateau, livraison au port de départ, frais payés jusqu\'au port d\'arrivée, sans assurance pour le transport, non déchargé du navire à destination (les frais de déchargement sont inclus ou non au port d\'arrivée)', 1),
(6, 'CIF', 'Cost, Insurance, Freight', 'Cost, Insurance and Freight, chargé sur le bateau, frais jusqu\'au port d\'arrivée, avec l\'assurance marchandise transportée souscrite par le vendeur pour le compte de l\'acheteur', 1),
(7, 'CPT', 'Carriage Paid To', 'Carriage Paid To, livraison au premier transporteur, frais jusqu\'au déchargement du mode de transport, sans assurance pour le transport', 1),
(8, 'CIP', 'Carriage Insurance Paid', 'Carriage and Insurance Paid to, idem CPT, avec assurance marchandise transportée souscrite par le vendeur pour le compte de l\'acheteur', 1),
(9, 'DAT', 'Delivered At Terminal', 'Delivered At Terminal, marchandises (déchargées) livrées sur quai, dans un terminal maritime, fluvial, aérien, routier ou ferroviaire désigné (dédouanement import, et post-acheminement payés par l\'acheteur)', 1),
(10, 'DAP', 'Delivered At Place', 'Delivered At Place, marchandises (non déchargées) mises à disposition de l\'acheteur dans le pays d\'importation au lieu précisé dans le contrat (déchargement, dédouanement import payé par l\'acheteur)', 1),
(11, 'DDP', 'Delivered Duty Paid', 'Delivered Duty Paid, marchandises (non déchargées) livrées à destination finale, dédouanement import et taxes à la charge du vendeur ; l\'acheteur prend en charge uniquement le déchargement (si exclusion des taxes type TVA, le préciser clairement)', 1),
(12, 'DPU', 'Delivered at Place Unloaded', 'Delivered at Place unloaded', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_input_method`
--

CREATE TABLE `llx_c_input_method` (
  `rowid` int(11) NOT NULL,
  `code` varchar(30) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `module` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_input_method`
--

INSERT INTO `llx_c_input_method` (`rowid`, `code`, `libelle`, `active`, `module`) VALUES
(1, 'OrderByMail', 'Courrier', 1, NULL),
(2, 'OrderByFax', 'Fax', 1, NULL),
(3, 'OrderByEMail', 'EMail', 1, NULL),
(4, 'OrderByPhone', 'Téléphone', 1, NULL),
(5, 'OrderByWWW', 'En ligne', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_input_reason`
--

CREATE TABLE `llx_c_input_reason` (
  `rowid` int(11) NOT NULL,
  `code` varchar(30) DEFAULT NULL,
  `label` varchar(128) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `module` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_input_reason`
--

INSERT INTO `llx_c_input_reason` (`rowid`, `code`, `label`, `active`, `module`) VALUES
(1, 'SRC_INTE', 'Web site', 1, NULL),
(2, 'SRC_CAMP_MAIL', 'Mailing campaign', 1, NULL),
(3, 'SRC_CAMP_PHO', 'Phone campaign', 1, NULL),
(4, 'SRC_CAMP_FAX', 'Fax campaign', 0, NULL),
(5, 'SRC_COMM', 'Commercial contact', 1, NULL),
(6, 'SRC_SHOP', 'Shop contact', 1, NULL),
(7, 'SRC_CAMP_EMAIL', 'EMailing campaign', 1, NULL),
(8, 'SRC_WOM', 'Word of mouth', 1, NULL),
(9, 'SRC_PARTNER', 'Partner', 1, NULL),
(10, 'SRC_EMPLOYEE', 'Employee', 1, NULL),
(11, 'SRC_SPONSORING', 'Sponsorship', 1, NULL),
(12, 'SRC_CUSTOMER', 'Incoming contact of a customer', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_invoice_subtype`
--

CREATE TABLE `llx_c_invoice_subtype` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_country` int(11) NOT NULL,
  `code` varchar(5) NOT NULL,
  `label` varchar(200) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_invoice_subtype`
--

INSERT INTO `llx_c_invoice_subtype` (`rowid`, `entity`, `fk_country`, `code`, `label`, `active`) VALUES
(1, 1, 102, '1.1', 'Τιμολόγιο Πώλησης', 1),
(2, 1, 102, '1.2', 'Τιμολόγιο Πώλησης / Ενδοκοινοτικές Παραδόσεις', 1),
(3, 1, 102, '1.3', 'Τιμολόγιο Πώλησης / Παραδόσεις Τρίτων Χωρών', 1),
(4, 1, 102, '1.4', 'Τιμολόγιο Πώλησης / Πώληση για Λογαριασμό Τρίτων', 0),
(5, 1, 102, '1.5', 'Τιμολόγιο Πώλησης / Εκκαθάριση Πωλήσεων Τρίτων - Αμοιβή από Πωλήσεις Τρίτων', 0),
(6, 1, 102, '1.6', 'Τιμολόγιο Πώλησης / Συμπληρωματικό Παραστατικό', 0),
(7, 1, 102, '2.1', 'Τιμολόγιο Παροχής', 1),
(8, 1, 102, '2.2', 'Τιμολόγιο Παροχής / Ενδοκοινοτική Παροχή Υπηρεσιών', 1),
(9, 1, 102, '2.3', 'Τιμολόγιο Παροχής / Παροχή Υπηρεσιών σε λήπτη Τρίτης Χώρας', 1),
(10, 1, 102, '2.4', 'Τιμολόγιο Παροχής / Συμπληρωματικό Παραστατικό', 0),
(11, 1, 102, '3.1', 'Τίτλος Κτήσης (μη υπόχρεος Εκδότης)', 0),
(12, 1, 102, '3.2', 'Τίτλος Κτήσης (άρνηση έκδοσης από υπόχρεο Εκδότη)', 0),
(13, 1, 102, '6.1', 'Στοιχείο Αυτοπαράδοσης', 0),
(14, 1, 102, '6.2', 'Στοιχείο Ιδιοχρησιμοποίησης', 0),
(15, 1, 102, '7.1', 'Συμβόλαιο - Έσοδο', 0),
(16, 1, 102, '8.1', 'Ενοίκια - Έσοδο', 0),
(17, 1, 102, '8.2', 'Ειδικό Στοιχείο – Απόδειξης Είσπραξης Φόρου Διαμονής', 0),
(18, 1, 102, '11.1', 'ΑΛΠ', 1),
(19, 1, 102, '11.2', 'ΑΠΥ', 1),
(20, 1, 102, '11.3', 'Απλοποιημένο Τιμολόγιο', 0),
(21, 1, 102, '11.5', 'Απόδειξη Λιανικής Πώλησης για Λογ/σμό Τρίτων', 0),
(22, 1, 102, '5.1', 'Πιστωτικό Τιμολόγιο / Συσχετιζόμενο', 0),
(23, 1, 102, '5.2', 'Πιστωτικό Τιμολόγιο / Μη Συσχετιζόμενο', 1),
(24, 1, 102, '11.4', 'Πιστωτικό Στοιχείο Λιανικής', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_lead_status`
--

CREATE TABLE `llx_c_lead_status` (
  `rowid` int(11) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `label` varchar(128) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `percent` double(5,2) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_lead_status`
--

INSERT INTO `llx_c_lead_status` (`rowid`, `code`, `label`, `position`, `percent`, `active`) VALUES
(1, 'PROSP', 'Prospection', 10, 0.00, 1),
(2, 'QUAL', 'Qualification', 20, 20.00, 1),
(3, 'PROPO', 'Proposal', 30, 40.00, 1),
(4, 'NEGO', 'Negotiation', 40, 60.00, 1),
(5, 'PENDING', 'Pending', 50, 50.00, 0),
(6, 'WON', 'Won', 60, 100.00, 1),
(7, 'LOST', 'Lost', 70, 0.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_paiement`
--

CREATE TABLE `llx_c_paiement` (
  `id` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `code` varchar(6) NOT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `accountancy_code` varchar(32) DEFAULT NULL,
  `module` varchar(32) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_paiement`
--

INSERT INTO `llx_c_paiement` (`id`, `entity`, `code`, `libelle`, `type`, `active`, `accountancy_code`, `module`, `position`) VALUES
(1, 1, 'TIP', 'TIP', 2, 0, NULL, NULL, 0),
(2, 1, 'VIR', 'Credit Transfer', 2, 1, NULL, NULL, 0),
(3, 1, 'PRE', 'Direct Debit', 2, 1, NULL, NULL, 0),
(4, 1, 'LIQ', 'Cash', 2, 1, NULL, NULL, 0),
(6, 1, 'CB', 'Credit card', 2, 1, NULL, NULL, 0),
(7, 1, 'CHQ', 'Cheque', 2, 1, NULL, NULL, 0),
(50, 1, 'VAD', 'Online payment', 2, 0, NULL, NULL, 0),
(51, 1, 'TRA', 'Traite', 2, 0, NULL, NULL, 0),
(52, 1, 'LCR', 'LCR', 2, 0, NULL, NULL, 0),
(53, 1, 'FAC', 'Factor', 2, 0, NULL, NULL, 0),
(100, 1, 'KLA', 'Klarna', 1, 0, NULL, NULL, 0),
(101, 1, 'SOF', 'Sofort', 1, 0, NULL, NULL, 0),
(102, 1, 'BANCON', 'Bancontact', 1, 0, NULL, NULL, 0),
(103, 1, 'IDE', 'iDeal', 1, 0, NULL, NULL, 0),
(104, 1, 'GIR', 'Giropay', 1, 0, NULL, NULL, 0),
(105, 1, 'PPL', 'PayPal', 1, 0, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_paper_format`
--

CREATE TABLE `llx_c_paper_format` (
  `rowid` int(11) NOT NULL,
  `code` varchar(16) NOT NULL,
  `label` varchar(128) NOT NULL,
  `width` float(6,2) DEFAULT 0.00,
  `height` float(6,2) DEFAULT 0.00,
  `unit` varchar(5) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `module` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_paper_format`
--

INSERT INTO `llx_c_paper_format` (`rowid`, `code`, `label`, `width`, `height`, `unit`, `active`, `module`) VALUES
(1, 'EU4A0', 'Format 4A0', 1682.00, 2378.00, 'mm', 1, NULL),
(2, 'EU2A0', 'Format 2A0', 1189.00, 1682.00, 'mm', 1, NULL),
(3, 'EUA0', 'Format A0', 840.00, 1189.00, 'mm', 1, NULL),
(4, 'EUA1', 'Format A1', 594.00, 840.00, 'mm', 1, NULL),
(5, 'EUA2', 'Format A2', 420.00, 594.00, 'mm', 1, NULL),
(6, 'EUA3', 'Format A3', 297.00, 420.00, 'mm', 1, NULL),
(7, 'EUA4', 'Format A4', 210.00, 297.00, 'mm', 1, NULL),
(8, 'EUA5', 'Format A5', 148.00, 210.00, 'mm', 1, NULL),
(9, 'EUA6', 'Format A6', 105.00, 148.00, 'mm', 1, NULL),
(100, 'USLetter', 'Format Letter (A)', 216.00, 279.00, 'mm', 1, NULL),
(105, 'USLegal', 'Format Legal', 216.00, 356.00, 'mm', 1, NULL),
(110, 'USExecutive', 'Format Executive', 190.00, 254.00, 'mm', 1, NULL),
(115, 'USLedger', 'Format Ledger/Tabloid (B)', 279.00, 432.00, 'mm', 1, NULL),
(200, 'CAP1', 'Format Canadian P1', 560.00, 860.00, 'mm', 1, NULL),
(205, 'CAP2', 'Format Canadian P2', 430.00, 560.00, 'mm', 1, NULL),
(210, 'CAP3', 'Format Canadian P3', 280.00, 430.00, 'mm', 1, NULL),
(215, 'CAP4', 'Format Canadian P4', 215.00, 280.00, 'mm', 1, NULL),
(220, 'CAP5', 'Format Canadian P5', 140.00, 215.00, 'mm', 1, NULL),
(225, 'CAP6', 'Format Canadian P6', 107.00, 140.00, 'mm', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_payment_term`
--

CREATE TABLE `llx_c_payment_term` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `code` varchar(16) DEFAULT NULL,
  `sortorder` smallint(6) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 1,
  `libelle` varchar(255) DEFAULT NULL,
  `libelle_facture` text DEFAULT NULL,
  `type_cdr` tinyint(4) DEFAULT NULL,
  `nbjour` smallint(6) DEFAULT NULL,
  `decalage` smallint(6) DEFAULT NULL,
  `deposit_percent` varchar(63) DEFAULT NULL,
  `module` varchar(32) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_payment_term`
--

INSERT INTO `llx_c_payment_term` (`rowid`, `entity`, `code`, `sortorder`, `active`, `libelle`, `libelle_facture`, `type_cdr`, `nbjour`, `decalage`, `deposit_percent`, `module`, `position`) VALUES
(1, 1, 'RECEP', 1, 1, 'Due upon receipt', 'Due upon receipt', 0, 1, NULL, NULL, NULL, 0),
(2, 1, '30D', 2, 1, '30 days', 'Due in 30 days', 0, 30, NULL, NULL, NULL, 0),
(3, 1, '30DENDMONTH', 3, 1, '30 days end of month', 'Due in 30 days, end of month', 1, 30, NULL, NULL, NULL, 0),
(4, 1, '60D', 4, 1, '60 days', 'Due in 60 days, end of month', 0, 60, NULL, NULL, NULL, 0),
(5, 1, '60DENDMONTH', 5, 1, '60 days end of month', 'Due in 60 days, end of month', 1, 60, NULL, NULL, NULL, 0),
(6, 1, 'PT_ORDER', 6, 1, 'Due on order', 'Due on order', 0, 1, NULL, NULL, NULL, 0),
(7, 1, 'PT_DELIVERY', 7, 1, 'Due on delivery', 'Due on delivery', 0, 1, NULL, NULL, NULL, 0),
(8, 1, 'PT_5050', 8, 1, '50 and 50', '50% on order, 50% on delivery', 0, 1, NULL, NULL, NULL, 0),
(9, 1, '10D', 9, 1, '10 days', 'Due in 10 days', 0, 10, NULL, NULL, NULL, 0),
(10, 1, '10DENDMONTH', 10, 1, '10 days end of month', 'Due in 10 days, end of month', 1, 10, NULL, NULL, NULL, 0),
(11, 1, '14D', 11, 1, '14 days', 'Due in 14 days', 0, 14, NULL, NULL, NULL, 0),
(12, 1, '14DENDMONTH', 12, 1, '14 days end of month', 'Due in 14 days, end of month', 1, 14, NULL, NULL, NULL, 0),
(13, 1, 'DEP30PCTDEL', 13, 0, '__DEPOSIT_PERCENT__% deposit', '__DEPOSIT_PERCENT__% deposit, remainder on delivery', 0, 1, NULL, '30', NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_product_nature`
--

CREATE TABLE `llx_c_product_nature` (
  `rowid` int(11) NOT NULL,
  `code` tinyint(4) NOT NULL,
  `label` varchar(128) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_product_nature`
--

INSERT INTO `llx_c_product_nature` (`rowid`, `code`, `label`, `active`) VALUES
(1, 0, 'RowMaterial', 1),
(2, 1, 'Finished', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_product_thirdparty_relation_type`
--

CREATE TABLE `llx_c_product_thirdparty_relation_type` (
  `rowid` int(11) NOT NULL,
  `code` varchar(24) NOT NULL,
  `label` varchar(128) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_propalst`
--

CREATE TABLE `llx_c_propalst` (
  `id` smallint(6) NOT NULL,
  `code` varchar(12) NOT NULL,
  `label` varchar(128) DEFAULT NULL,
  `sortorder` smallint(6) DEFAULT 0,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_propalst`
--

INSERT INTO `llx_c_propalst` (`id`, `code`, `label`, `sortorder`, `active`) VALUES
(0, 'PR_DRAFT', 'Brouillon', 0, 1),
(1, 'PR_OPEN', 'Ouverte', 0, 1),
(2, 'PR_SIGNED', 'Signée', 0, 1),
(3, 'PR_NOTSIGNED', 'Non Signée', 0, 1),
(4, 'PR_FAC', 'Facturée', 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_prospectcontactlevel`
--

CREATE TABLE `llx_c_prospectcontactlevel` (
  `code` varchar(12) NOT NULL,
  `label` varchar(128) DEFAULT NULL,
  `sortorder` smallint(6) DEFAULT NULL,
  `active` smallint(6) NOT NULL DEFAULT 1,
  `module` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_prospectcontactlevel`
--

INSERT INTO `llx_c_prospectcontactlevel` (`code`, `label`, `sortorder`, `active`, `module`) VALUES
('PL_HIGH', 'High', 4, 1, NULL),
('PL_LOW', 'Low', 2, 1, NULL),
('PL_MEDIUM', 'Medium', 3, 1, NULL),
('PL_NONE', 'None', 1, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_prospectlevel`
--

CREATE TABLE `llx_c_prospectlevel` (
  `code` varchar(12) NOT NULL,
  `label` varchar(128) DEFAULT NULL,
  `sortorder` smallint(6) DEFAULT NULL,
  `active` smallint(6) NOT NULL DEFAULT 1,
  `module` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_prospectlevel`
--

INSERT INTO `llx_c_prospectlevel` (`code`, `label`, `sortorder`, `active`, `module`) VALUES
('PL_HIGH', 'High', 4, 1, NULL),
('PL_LOW', 'Low', 2, 1, NULL),
('PL_MEDIUM', 'Medium', 3, 1, NULL),
('PL_NONE', 'None', 1, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_regions`
--

CREATE TABLE `llx_c_regions` (
  `rowid` int(11) NOT NULL,
  `code_region` int(11) NOT NULL,
  `fk_pays` int(11) NOT NULL,
  `cheflieu` varchar(50) DEFAULT NULL,
  `tncc` int(11) DEFAULT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_regions`
--

INSERT INTO `llx_c_regions` (`rowid`, `code_region`, `fk_pays`, `cheflieu`, `tncc`, `nom`, `active`) VALUES
(1, 0, 0, '0', 0, '-', 1),
(2, 1301, 13, '', 0, 'Algerie', 1),
(3, 34000, 34, 'AD', NULL, 'Andorra', 1),
(4, 35001, 35, 'AO', NULL, 'Angola', 1),
(5, 2301, 23, '', 0, 'Norte', 1),
(6, 2302, 23, '', 0, 'Litoral', 1),
(7, 2303, 23, '', 0, 'Cuyana', 1),
(8, 2304, 23, '', 0, 'Central', 1),
(9, 2305, 23, '', 0, 'Patagonia', 1),
(10, 2801, 28, '', 0, 'Australia', 1),
(11, 4101, 41, '', 0, 'Österreich', 1),
(12, 4601, 46, '', 0, 'Barbados', 1),
(13, 201, 2, '', 1, 'Flandre', 1),
(14, 202, 2, '', 2, 'Wallonie', 1),
(15, 203, 2, '', 3, 'Bruxelles-Capitale', 1),
(16, 5201, 52, '', 0, 'Chuquisaca', 1),
(17, 5202, 52, '', 0, 'La Paz', 1),
(18, 5203, 52, '', 0, 'Cochabamba', 1),
(19, 5204, 52, '', 0, 'Oruro', 1),
(20, 5205, 52, '', 0, 'Potosí', 1),
(21, 5206, 52, '', 0, 'Tarija', 1),
(22, 5207, 52, '', 0, 'Santa Cruz', 1),
(23, 5208, 52, '', 0, 'El Beni', 1),
(24, 5209, 52, '', 0, 'Pando', 1),
(25, 5601, 56, '', 0, 'Brasil', 1),
(26, 6101, 61, '', 0, 'Bubanza', 1),
(27, 6102, 61, '', 0, 'Bujumbura Mairie', 1),
(28, 6103, 61, '', 0, 'Bujumbura Rural', 1),
(29, 6104, 61, '', 0, 'Bururi', 1),
(30, 6105, 61, '', 0, 'Cankuzo', 1),
(31, 6106, 61, '', 0, 'Cibitoke', 1),
(32, 6107, 61, '', 0, 'Gitega', 1),
(33, 6108, 61, '', 0, 'Karuzi', 1),
(34, 6109, 61, '', 0, 'Kayanza', 1),
(35, 6110, 61, '', 0, 'Kirundo', 1),
(36, 6111, 61, '', 0, 'Makamba', 1),
(37, 6112, 61, '', 0, 'Muramvya', 1),
(38, 6113, 61, '', 0, 'Muyinga', 1),
(39, 6114, 61, '', 0, 'Mwaro', 1),
(40, 6115, 61, '', 0, 'Ngozi', 1),
(41, 6116, 61, '', 0, 'Rumonge', 1),
(42, 6117, 61, '', 0, 'Rutana', 1),
(43, 6118, 61, '', 0, 'Ruyigi', 1),
(44, 1401, 14, '', 0, 'Canada', 1),
(45, 6701, 67, NULL, NULL, 'Tarapacá', 1),
(46, 6702, 67, NULL, NULL, 'Antofagasta', 1),
(47, 6703, 67, NULL, NULL, 'Atacama', 1),
(48, 6704, 67, NULL, NULL, 'Coquimbo', 1),
(49, 6705, 67, NULL, NULL, 'Valparaíso', 1),
(50, 6706, 67, NULL, NULL, 'General Bernardo O Higgins', 1),
(51, 6707, 67, NULL, NULL, 'Maule', 1),
(52, 6708, 67, NULL, NULL, 'Biobío', 1),
(53, 6709, 67, NULL, NULL, 'Raucanía', 1),
(54, 6710, 67, NULL, NULL, 'Los Lagos', 1),
(55, 6711, 67, NULL, NULL, 'Aysén General Carlos Ibáñez del Campo', 1),
(56, 6712, 67, NULL, NULL, 'Magallanes y Antártica Chilena', 1),
(57, 6713, 67, NULL, NULL, 'Metropolitana de Santiago', 1),
(58, 6714, 67, NULL, NULL, 'Los Ríos', 1),
(59, 6715, 67, NULL, NULL, 'Arica y Parinacota', 1),
(60, 901, 9, '京', 0, '北京市', 1),
(61, 902, 9, '津', 0, '天津市', 1),
(62, 903, 9, '沪', 0, '上海市', 1),
(63, 904, 9, '渝', 0, '重庆市', 1),
(64, 905, 9, '冀', 0, '河北省', 1),
(65, 906, 9, '晋', 0, '山西省', 1),
(66, 907, 9, '辽', 0, '辽宁省', 1),
(67, 908, 9, '吉', 0, '吉林省', 1),
(68, 909, 9, '黑', 0, '黑龙江省', 1),
(69, 910, 9, '苏', 0, '江苏省', 1),
(70, 911, 9, '浙', 0, '浙江省', 1),
(71, 912, 9, '皖', 0, '安徽省', 1),
(72, 913, 9, '闽', 0, '福建省', 1),
(73, 914, 9, '赣', 0, '江西省', 1),
(74, 915, 9, '鲁', 0, '山东省', 1),
(75, 916, 9, '豫', 0, '河南省', 1),
(76, 917, 9, '鄂', 0, '湖北省', 1),
(77, 918, 9, '湘', 0, '湖南省', 1),
(78, 919, 9, '粤', 0, '广东省', 1),
(79, 920, 9, '琼', 0, '海南省', 1),
(80, 921, 9, '川', 0, '四川省', 1),
(81, 922, 9, '贵', 0, '贵州省', 1),
(82, 923, 9, '云', 0, '云南省', 1),
(83, 924, 9, '陕', 0, '陕西省', 1),
(84, 925, 9, '甘', 0, '甘肃省', 1),
(85, 926, 9, '青', 0, '青海省', 1),
(86, 927, 9, '台', 0, '台湾省', 1),
(87, 928, 9, '蒙', 0, '内蒙古自治区', 1),
(88, 929, 9, '桂', 0, '广西壮族自治区', 1),
(89, 930, 9, '藏', 0, '西藏自治区', 1),
(90, 931, 9, '宁', 0, '宁夏回族自治区', 1),
(91, 932, 9, '新', 0, '新疆维吾尔自治区', 1),
(92, 933, 9, '港', 0, '香港特别行政区', 1),
(93, 934, 9, '澳', 0, '澳门特别行政区', 1),
(94, 7001, 70, '', 0, 'Colombie', 1),
(95, 7601, 76, '', 0, 'Središnja', 1),
(96, 7602, 76, '', 0, 'Dalmacija', 1),
(97, 7603, 76, '', 0, 'Slavonija', 1),
(98, 7604, 76, '', 0, 'Istra', 1),
(99, 8001, 80, '', 0, 'Nordjylland', 1),
(100, 8002, 80, '', 0, 'Midtjylland', 1),
(101, 8003, 80, '', 0, 'Syddanmark', 1),
(102, 8004, 80, '', 0, 'Hovedstaden', 1),
(103, 8005, 80, '', 0, 'Sjælland', 1),
(104, 1, 1, '97105', 3, 'Guadeloupe', 1),
(105, 2, 1, '97209', 3, 'Martinique', 1),
(106, 3, 1, '97302', 3, 'Guyane', 1),
(107, 4, 1, '97411', 3, 'Réunion', 1),
(108, 6, 1, '97601', 3, 'Mayotte', 1),
(109, 11, 1, '75056', 1, 'Île-de-France', 1),
(110, 24, 1, '45234', 2, 'Centre-Val de Loire', 1),
(111, 27, 1, '21231', 0, 'Bourgogne-Franche-Comté', 1),
(112, 28, 1, '76540', 0, 'Normandie', 1),
(113, 32, 1, '59350', 4, 'Hauts-de-France', 1),
(114, 44, 1, '67482', 2, 'Grand Est', 1),
(115, 52, 1, '44109', 4, 'Pays de la Loire', 1),
(116, 53, 1, '35238', 0, 'Bretagne', 1),
(117, 75, 1, '33063', 0, 'Nouvelle-Aquitaine', 1),
(118, 76, 1, '31355', 1, 'Occitanie', 1),
(119, 84, 1, '69123', 1, 'Auvergne-Rhône-Alpes', 1),
(120, 93, 1, '13055', 0, 'Provence-Alpes-Côte d\'Azur', 1),
(121, 94, 1, '2A004', 0, 'Corse', 1),
(122, 501, 5, '', 0, 'Deutschland', 1),
(123, 10201, 102, NULL, NULL, 'Αττική', 1),
(124, 10202, 102, NULL, NULL, 'Στερεά Ελλάδα', 1),
(125, 10203, 102, NULL, NULL, 'Κεντρική Μακεδονία', 1),
(126, 10204, 102, NULL, NULL, 'Κρήτη', 1),
(127, 10205, 102, NULL, NULL, 'Ανατολική Μακεδονία και Θράκη', 1),
(128, 10206, 102, NULL, NULL, 'Ήπειρος', 1),
(129, 10207, 102, NULL, NULL, 'Ιόνια νησιά', 1),
(130, 10208, 102, NULL, NULL, 'Βόρειο Αιγαίο', 1),
(131, 10209, 102, NULL, NULL, 'Πελοπόννησος', 1),
(132, 10210, 102, NULL, NULL, 'Νότιο Αιγαίο', 1),
(133, 10211, 102, NULL, NULL, 'Δυτική Ελλάδα', 1),
(134, 10212, 102, NULL, NULL, 'Θεσσαλία', 1),
(135, 10213, 102, NULL, NULL, 'Δυτική Μακεδονία', 1),
(136, 11401, 114, '', 0, 'Honduras', 1),
(137, 180100, 18, 'HU1', NULL, 'Közép-Magyarország', 1),
(138, 182100, 18, 'HU21', NULL, 'Közép-Dunántúl', 1),
(139, 182200, 18, 'HU22', NULL, 'Nyugat-Dunántúl', 1),
(140, 182300, 18, 'HU23', NULL, 'Dél-Dunántúl', 1),
(141, 183100, 18, 'HU31', NULL, 'Észak-Magyarország', 1),
(142, 183200, 18, 'HU32', NULL, 'Észak-Alföld', 1),
(143, 183300, 18, 'HU33', NULL, 'Dél-Alföld', 1),
(144, 11701, 117, '', 0, 'India', 1),
(145, 11801, 118, '', 0, 'Indonesia', 1),
(146, 301, 3, NULL, 1, 'Abruzzo', 1),
(147, 302, 3, NULL, 1, 'Basilicata', 1),
(148, 303, 3, NULL, 1, 'Calabria', 1),
(149, 304, 3, NULL, 1, 'Campania', 1),
(150, 305, 3, NULL, 1, 'Emilia-Romagna', 1),
(151, 306, 3, NULL, 1, 'Friuli-Venezia Giulia', 1),
(152, 307, 3, NULL, 1, 'Lazio', 1),
(153, 308, 3, NULL, 1, 'Liguria', 1),
(154, 309, 3, NULL, 1, 'Lombardia', 1),
(155, 310, 3, NULL, 1, 'Marche', 1),
(156, 311, 3, NULL, 1, 'Molise', 1),
(157, 312, 3, NULL, 1, 'Piemonte', 1),
(158, 313, 3, NULL, 1, 'Puglia', 1),
(159, 314, 3, NULL, 1, 'Sardegna', 1),
(160, 315, 3, NULL, 1, 'Sicilia', 1),
(161, 316, 3, NULL, 1, 'Toscana', 1),
(162, 317, 3, NULL, 1, 'Trentino-Alto Adige', 1),
(163, 318, 3, NULL, 1, 'Umbria', 1),
(164, 319, 3, NULL, 1, 'Valle d Aosta', 1),
(165, 320, 3, NULL, 1, 'Veneto', 1),
(166, 12301, 123, '', 0, '日本', 1),
(167, 14001, 140, '', 0, 'Diekirch', 1),
(168, 14002, 140, '', 0, 'Grevenmacher', 1),
(169, 14003, 140, '', 0, 'Luxembourg', 1),
(170, 15201, 152, '', 0, 'Rivière Noire', 1),
(171, 15202, 152, '', 0, 'Flacq', 1),
(172, 15203, 152, '', 0, 'Grand Port', 1),
(173, 15204, 152, '', 0, 'Moka', 1),
(174, 15205, 152, '', 0, 'Pamplemousses', 1),
(175, 15206, 152, '', 0, 'Plaines Wilhems', 1),
(176, 15207, 152, '', 0, 'Port-Louis', 1),
(177, 15208, 152, '', 0, 'Rivière du Rempart', 1),
(178, 15209, 152, '', 0, 'Savanne', 1),
(179, 15210, 152, '', 0, 'Rodrigues', 1),
(180, 15211, 152, '', 0, 'Les îles Agaléga', 1),
(181, 15212, 152, '', 0, 'Les écueils des Cargados Carajos', 1),
(182, 15401, 154, '', 0, 'Mexique', 1),
(183, 1201, 12, '', 0, 'Tanger-Tétouan', 1),
(184, 1202, 12, '', 0, 'Gharb-Chrarda-Beni Hssen', 1),
(185, 1203, 12, '', 0, 'Taza-Al Hoceima-Taounate', 1),
(186, 1204, 12, '', 0, 'L\'Oriental', 1),
(187, 1205, 12, '', 0, 'Fès-Boulemane', 1),
(188, 1206, 12, '', 0, 'Meknès-Tafialet', 1),
(189, 1207, 12, '', 0, 'Rabat-Salé-Zemour-Zaër', 1),
(190, 1208, 12, '', 0, 'Grand Cassablanca', 1),
(191, 1209, 12, '', 0, 'Chaouia-Ouardigha', 1),
(192, 1210, 12, '', 0, 'Doukahla-Adba', 1),
(193, 1211, 12, '', 0, 'Marrakech-Tensift-Al Haouz', 1),
(194, 1212, 12, '', 0, 'Tadla-Azilal', 1),
(195, 1213, 12, '', 0, 'Sous-Massa-Drâa', 1),
(196, 1214, 12, '', 0, 'Guelmim-Es Smara', 1),
(197, 1215, 12, '', 0, 'Laâyoune-Boujdour-Sakia el Hamra', 1),
(198, 1216, 12, '', 0, 'Oued Ed-Dahab Lagouira', 1),
(199, 1701, 17, '', 0, 'Provincies van Nederland ', 1),
(200, 17801, 178, '', 0, 'Panama', 1),
(201, 18101, 181, '', 0, 'Amazonas', 1),
(202, 18102, 181, '', 0, 'Ancash', 1),
(203, 18103, 181, '', 0, 'Apurimac', 1),
(204, 18104, 181, '', 0, 'Arequipa', 1),
(205, 18105, 181, '', 0, 'Ayacucho', 1),
(206, 18106, 181, '', 0, 'Cajamarca', 1),
(207, 18107, 181, '', 0, 'Callao', 1),
(208, 18108, 181, '', 0, 'Cuzco', 1),
(209, 18109, 181, '', 0, 'Huancavelica', 1),
(210, 18110, 181, '', 0, 'Huanuco', 1),
(211, 18111, 181, '', 0, 'Ica', 1),
(212, 18112, 181, '', 0, 'Junin', 1),
(213, 18113, 181, '', 0, 'La Libertad', 1),
(214, 18114, 181, '', 0, 'Lambayeque', 1),
(215, 18115, 181, '', 0, 'Lima Metropolitana', 1),
(216, 18116, 181, '', 0, 'Lima', 1),
(217, 18117, 181, '', 0, 'Loreto', 1),
(218, 18118, 181, '', 0, 'Madre de Dios', 1),
(219, 18119, 181, '', 0, 'Moquegua', 1),
(220, 18120, 181, '', 0, 'Pasco', 1),
(221, 18121, 181, '', 0, 'Piura', 1),
(222, 18122, 181, '', 0, 'Puno', 1),
(223, 18123, 181, '', 0, 'San Martín', 1),
(224, 18124, 181, '', 0, 'Tacna', 1),
(225, 18125, 181, '', 0, 'Tumbes', 1),
(226, 18126, 181, '', 0, 'Ucayali', 1),
(227, 15001, 25, 'PT', NULL, 'Portugal', 1),
(228, 15002, 25, 'PT9', NULL, 'Azores-Madeira', 1),
(229, 18801, 188, '', 0, 'Romania', 1),
(230, 8601, 86, NULL, NULL, 'Central', 1),
(231, 8602, 86, NULL, NULL, 'Oriental', 1),
(232, 8603, 86, NULL, NULL, 'Occidental', 1),
(233, 20101, 201, 'SK01', NULL, 'Bratislava Region', 1),
(234, 20102, 201, 'SK02', NULL, 'Western Slovakia', 1),
(235, 20103, 201, 'SK03', NULL, 'Central Slovakia', 1),
(236, 20104, 201, 'SK04', NULL, 'Eastern Slovakia', 1),
(237, 20203, 202, 'SI03', NULL, 'East Slovenia', 1),
(238, 20204, 202, 'SI04', NULL, 'West Slovenia', 1),
(239, 401, 4, '', 0, 'Andalucia', 1),
(240, 402, 4, '', 0, 'Aragón', 1),
(241, 403, 4, '', 0, 'Castilla y León', 1),
(242, 404, 4, '', 0, 'Castilla la Mancha', 1),
(243, 405, 4, '', 0, 'Canarias', 1),
(244, 406, 4, '', 0, 'Cataluña', 1),
(245, 407, 4, '', 0, 'Comunidad de Ceuta', 1),
(246, 408, 4, '', 0, 'Comunidad Foral de Navarra', 1),
(247, 409, 4, '', 0, 'Comunidad de Melilla', 1),
(248, 410, 4, '', 0, 'Cantabria', 1),
(249, 411, 4, '', 0, 'Comunidad Valenciana', 1),
(250, 412, 4, '', 0, 'Extemadura', 1),
(251, 413, 4, '', 0, 'Galicia', 1),
(252, 414, 4, '', 0, 'Islas Baleares', 1),
(253, 415, 4, '', 0, 'La Rioja', 1),
(254, 416, 4, '', 0, 'Comunidad de Madrid', 1),
(255, 417, 4, '', 0, 'Región de Murcia', 1),
(256, 418, 4, '', 0, 'Principado de Asturias', 1),
(257, 419, 4, '', 0, 'Pais Vasco', 1),
(258, 420, 4, '', 0, 'Otros', 1),
(259, 601, 6, '', 1, 'Cantons', 1),
(260, 21301, 213, 'TW', NULL, 'Taiwan', 1),
(261, 1001, 10, '', 0, 'Ariana', 1),
(262, 1002, 10, '', 0, 'Béja', 1),
(263, 1003, 10, '', 0, 'Ben Arous', 1),
(264, 1004, 10, '', 0, 'Bizerte', 1),
(265, 1005, 10, '', 0, 'Gabès', 1),
(266, 1006, 10, '', 0, 'Gafsa', 1),
(267, 1007, 10, '', 0, 'Jendouba', 1),
(268, 1008, 10, '', 0, 'Kairouan', 1),
(269, 1009, 10, '', 0, 'Kasserine', 1),
(270, 1010, 10, '', 0, 'Kébili', 1),
(271, 1011, 10, '', 0, 'La Manouba', 1),
(272, 1012, 10, '', 0, 'Le Kef', 1),
(273, 1013, 10, '', 0, 'Mahdia', 1),
(274, 1014, 10, '', 0, 'Médenine', 1),
(275, 1015, 10, '', 0, 'Monastir', 1),
(276, 1016, 10, '', 0, 'Nabeul', 1),
(277, 1017, 10, '', 0, 'Sfax', 1),
(278, 1018, 10, '', 0, 'Sidi Bouzid', 1),
(279, 1019, 10, '', 0, 'Siliana', 1),
(280, 1020, 10, '', 0, 'Sousse', 1),
(281, 1021, 10, '', 0, 'Tataouine', 1),
(282, 1022, 10, '', 0, 'Tozeur', 1),
(283, 1023, 10, '', 0, 'Tunis', 1),
(284, 1024, 10, '', 0, 'Zaghouan', 1),
(285, 22101, 221, '', 0, 'Marmara', 1),
(286, 22102, 221, '', 0, 'İç Anadolu', 1),
(287, 22103, 221, '', 0, 'Ege', 1),
(288, 22104, 221, '', 0, 'Akdeniz', 1),
(289, 22105, 221, '', 0, 'Güneydoğu', 1),
(290, 22106, 221, '', 0, 'Karadeniz', 1),
(291, 22107, 221, '', 0, 'Doğu Anadolu', 1),
(292, 22701, 227, '', 0, 'United Arab Emirates', 1),
(293, 701, 7, '', 0, 'England', 1),
(294, 702, 7, '', 0, 'Wales', 1),
(295, 703, 7, '', 0, 'Scotland', 1),
(296, 704, 7, '', 0, 'Northern Ireland', 1),
(297, 1101, 11, '', 0, 'United-States', 1),
(298, 23201, 232, '', 0, 'Los Andes', 1),
(299, 23202, 232, '', 0, 'Capital', 1),
(300, 23203, 232, '', 0, 'Central', 1),
(301, 23204, 232, '', 0, 'Cento Occidental', 1),
(302, 23205, 232, '', 0, 'Guayana', 1),
(303, 23206, 232, '', 0, 'Insular', 1),
(304, 23207, 232, '', 0, 'Los Llanos', 1),
(305, 23208, 232, '', 0, 'Nor-Oriental', 1),
(306, 23209, 232, '', 0, 'Zuliana', 1),
(307, 7700, 77, '', 0, 'Cuba', 1),
(308, 7701, 77, '', 0, 'Occidente', 1),
(309, 7702, 77, '', 0, 'Centro', 1),
(310, 7703, 77, '', 0, 'Occidente', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_revenuestamp`
--

CREATE TABLE `llx_c_revenuestamp` (
  `rowid` int(11) NOT NULL,
  `fk_pays` int(11) NOT NULL,
  `taux` double NOT NULL,
  `revenuestamp_type` varchar(16) NOT NULL DEFAULT 'fixed',
  `note` varchar(128) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `accountancy_code_sell` varchar(32) DEFAULT NULL,
  `accountancy_code_buy` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_revenuestamp`
--

INSERT INTO `llx_c_revenuestamp` (`rowid`, `fk_pays`, `taux`, `revenuestamp_type`, `note`, `active`, `accountancy_code_sell`, `accountancy_code_buy`) VALUES
(101, 10, 0.4, 'fixed', 'Revenue stamp tunisia', 1, NULL, NULL),
(1021, 102, 1.2, 'percent', 'Συντελεστής 1,2 %', 1, NULL, NULL),
(1022, 102, 2.4, 'percent', 'Συντελεστής 2,4 %', 1, NULL, NULL),
(1023, 102, 3.6, 'percent', 'Συντελεστής 3,6 %', 1, NULL, NULL),
(1024, 102, 1, 'fixed', 'Λοιπές περιπτώσεις Χαρτοσήμου', 1, NULL, NULL),
(1541, 154, 1.5, 'percent', 'Revenue stamp mexico', 1, NULL, NULL),
(1542, 154, 3, 'percent', 'Revenue stamp mexico', 1, NULL, NULL),
(22101, 221, 0.00948, 'percent', 'Mukavelenameler Damga Vergisi', 1, NULL, NULL),
(22102, 221, 0.00189, 'percent', 'Kira mukavelenameleri Damga Vergisi', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_shipment_mode`
--

CREATE TABLE `llx_c_shipment_mode` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `code` varchar(30) NOT NULL,
  `libelle` varchar(128) NOT NULL,
  `description` text DEFAULT NULL,
  `tracking` varchar(255) DEFAULT NULL,
  `active` tinyint(4) DEFAULT 0,
  `module` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_shipment_mode`
--

INSERT INTO `llx_c_shipment_mode` (`rowid`, `entity`, `tms`, `code`, `libelle`, `description`, `tracking`, `active`, `module`) VALUES
(1, 1, '2025-08-08 01:15:52', 'CATCH', 'In-Store Collection', 'In-store collection by the customer', '', 1, NULL),
(2, 1, '2025-08-08 01:15:52', 'TRANS', 'Generic transport service', 'Generic transport service', '', 1, NULL),
(3, 1, '2025-08-08 01:15:52', 'COLSUI', 'Colissimo Suivi', 'Colissimo Suivi', 'https://www.laposte.fr/outils/suivre-vos-envois?code={TRACKID}', 0, NULL),
(4, 1, '2025-08-08 01:15:52', 'LETTREMAX', 'Lettre Max', 'Courrier Suivi et Lettre Max', 'https://www.laposte.fr/outils/suivre-vos-envois?code={TRACKID}', 0, NULL),
(5, 1, '2025-08-08 01:15:52', 'UPS', 'UPS', 'United Parcel Service', 'http://wwwapps.ups.com/etracking/tracking.cgi?InquiryNumber2=&InquiryNumber3=&tracknums_displayed=3&loc=fr_FR&TypeOfInquiryNumber=T&HTMLVersion=4.0&InquiryNumber22=&InquiryNumber32=&track=Track&Suivi.x=64&Suivi.y=7&Suivi=Valider&InquiryNumber1={TRACKID}', 1, NULL),
(6, 1, '2025-08-08 01:15:52', 'KIALA', 'KIALA', 'Relais Kiala', 'http://www.kiala.fr/tnt/delivery/{TRACKID}', 0, NULL),
(7, 1, '2025-08-08 01:15:52', 'GLS', 'GLS', 'General Logistics Systems', 'https://gls-group.eu/FR/fr/suivi-colis?match={TRACKID}', 0, NULL),
(8, 1, '2025-08-08 01:15:52', 'CHRONO', 'Chronopost', 'Chronopost', 'http://www.chronopost.fr/expedier/inputLTNumbersNoJahia.do?listeNumeros={TRACKID}', 0, NULL),
(9, 1, '2025-08-08 01:15:52', 'INPERSON', 'In person at your site', NULL, NULL, 0, NULL),
(10, 1, '2025-08-08 01:15:52', 'FEDEX', 'Fedex', NULL, 'https://www.fedex.com/apps/fedextrack/index.html?tracknumbers={TRACKID}', 0, NULL),
(11, 1, '2025-08-08 01:15:52', 'TNT', 'TNT', NULL, 'https://www.tnt.com/express/fr_fr/site/outils-expedition/suivi.html?searchType=con&cons=={TRACKID}', 0, NULL),
(12, 1, '2025-08-08 01:15:52', 'DHL', 'DHL', NULL, 'https://www.dhl.com/fr-fr/home/tracking/tracking-global-forwarding.html?submit=1&tracking-id={TRACKID}', 0, NULL),
(13, 1, '2025-08-08 01:15:52', 'DPD', 'DPD', NULL, 'https://www.dpd.fr/trace/{TRACKID}', 0, NULL),
(14, 1, '2025-08-08 01:15:52', 'MAINFREIGHT', 'Mainfreight', NULL, 'https://www.mainfreight.com/track?{TRACKID}', 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_shipment_package_type`
--

CREATE TABLE `llx_c_shipment_package_type` (
  `rowid` int(11) NOT NULL,
  `label` varchar(128) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT 1,
  `entity` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_socialnetworks`
--

CREATE TABLE `llx_c_socialnetworks` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `code` varchar(100) DEFAULT NULL,
  `label` varchar(150) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `icon` varchar(20) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_socialnetworks`
--

INSERT INTO `llx_c_socialnetworks` (`rowid`, `entity`, `code`, `label`, `url`, `icon`, `active`) VALUES
(1, 1, '500px', '500px', '{socialid}', 'fa-500px', 0),
(2, 1, 'dailymotion', 'Dailymotion', '{socialid}', '', 0),
(3, 1, 'diaspora', 'Diaspora', '{socialid}', '', 0),
(4, 1, 'discord', 'Discord', '{socialid}', 'fa-discord', 0),
(5, 1, 'facebook', 'Facebook', 'https://www.facebook.com/{socialid}', 'fa-facebook', 1),
(6, 1, 'flickr', 'Flickr', '{socialid}', 'fa-flickr', 0),
(7, 1, 'gifycat', 'Gificat', '{socialid}', '', 0),
(8, 1, 'giphy', 'Giphy', '{socialid}', '', 0),
(9, 1, 'github', 'GitHub', 'https://www.github.com/{socialid}', '', 0),
(10, 1, 'instagram', 'Instagram', 'https://www.instagram.com/{socialid}', 'fa-instagram', 1),
(11, 1, 'linkedin', 'LinkedIn', 'https://www.linkedin.com/in/{socialid}', 'fa-linkedin', 1),
(12, 1, 'mastodon', 'Mastodon', '{socialid}', '', 0),
(13, 1, 'meetup', 'Meetup', '{socialid}', 'fa-meetup', 0),
(14, 1, 'periscope', 'Periscope', '{socialid}', '', 0),
(15, 1, 'pinterest', 'Pinterest', '{socialid}', 'fa-pinterest', 0),
(16, 1, 'quora', 'Quora', '{socialid}', '', 0),
(17, 1, 'reddit', 'Reddit', '{socialid}', 'fa-reddit', 0),
(18, 1, 'slack', 'Slack', '{socialid}', 'fa-slack', 0),
(19, 1, 'snapchat', 'Snapchat', '{socialid}', 'fa-snapchat', 1),
(20, 1, 'skype', 'Skype', 'https://www.skype.com/{socialid}', 'fa-skype', 1),
(21, 1, 'tripadvisor', 'Tripadvisor', '{socialid}', '', 0),
(22, 1, 'tumblr', 'Tumblr', 'https://www.tumblr.com/{socialid}', 'fa-tumblr', 0),
(23, 1, 'twitch', 'Twitch', '{socialid}', '', 0),
(24, 1, 'twitter', 'X-Twitter', 'https://www.x.com/{socialid}', 'fa-twitter', 1),
(25, 1, 'vero', 'Vero', 'https://vero.co/{socialid}', '', 0),
(26, 1, 'viadeo', 'Viadeo', 'https://fr.viadeo.com/fr/{socialid}', 'fa-viadeo', 0),
(27, 1, 'viber', 'Viber', '{socialid}', '', 0),
(28, 1, 'vimeo', 'Vimeo', '{socialid}', 'fa-vimeo', 0),
(29, 1, 'whatsapp', 'Whatsapp', 'https://web.whatsapp.com/send?phone={socialid}', 'fa-whatsapp', 1),
(30, 1, 'wikipedia', 'Wikipedia', '{socialid}', 'fa-wikipedia-w', 0),
(31, 1, 'xing', 'Xing', '{socialid}', 'fa-xing', 0),
(32, 1, 'youtube', 'Youtube', 'https://www.youtube.com/{socialid}', 'fa-youtube', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_stcomm`
--

CREATE TABLE `llx_c_stcomm` (
  `id` int(11) NOT NULL,
  `code` varchar(24) NOT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `picto` varchar(128) DEFAULT NULL,
  `sortorder` smallint(6) DEFAULT 0,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_stcomm`
--

INSERT INTO `llx_c_stcomm` (`id`, `code`, `libelle`, `picto`, `sortorder`, `active`) VALUES
(-1, 'ST_NO', 'Do not contact', NULL, 0, 1),
(0, 'ST_NEVER', 'Never contacted', NULL, 0, 1),
(1, 'ST_TODO', 'To contact', NULL, 0, 1),
(2, 'ST_PEND', 'Contact in progress', NULL, 0, 1),
(3, 'ST_DONE', 'Contacted', NULL, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_stcommcontact`
--

CREATE TABLE `llx_c_stcommcontact` (
  `id` int(11) NOT NULL,
  `code` varchar(12) NOT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `picto` varchar(128) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_stcommcontact`
--

INSERT INTO `llx_c_stcommcontact` (`id`, `code`, `libelle`, `picto`, `active`) VALUES
(-1, 'ST_NO', 'Do not contact', NULL, 1),
(0, 'ST_NEVER', 'Never contacted', NULL, 1),
(1, 'ST_TODO', 'To contact', NULL, 1),
(2, 'ST_PEND', 'Contact in progress', NULL, 1),
(3, 'ST_DONE', 'Contacted', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_transport_mode`
--

CREATE TABLE `llx_c_transport_mode` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `code` varchar(3) NOT NULL,
  `label` varchar(255) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_transport_mode`
--

INSERT INTO `llx_c_transport_mode` (`rowid`, `entity`, `code`, `label`, `active`) VALUES
(1, 1, 'MAR', 'Transport maritime (y compris camions ou wagons sur bateau)', 1),
(2, 1, 'TRA', 'Transport par chemin de fer (y compris camions sur wagon)', 1),
(3, 1, 'ROU', 'Transport par route', 1),
(4, 1, 'AIR', 'Transport par air', 1),
(5, 1, 'POS', 'Envois postaux', 1),
(6, 1, 'OLE', 'Installations de transport fixe (oléoduc)', 1),
(7, 1, 'NAV', 'Transport par navigation intérieure', 1),
(8, 1, 'PRO', 'Propulsion propre', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_tva`
--

CREATE TABLE `llx_c_tva` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_pays` int(11) NOT NULL,
  `fk_department_buyer` int(11) DEFAULT NULL,
  `code` varchar(10) DEFAULT '',
  `type_vat` smallint(6) NOT NULL DEFAULT 0,
  `taux` double NOT NULL,
  `localtax1` varchar(20) NOT NULL DEFAULT '0',
  `localtax1_type` varchar(10) NOT NULL DEFAULT '0',
  `localtax2` varchar(20) NOT NULL DEFAULT '0',
  `localtax2_type` varchar(10) NOT NULL DEFAULT '0',
  `use_default` tinyint(4) DEFAULT 0,
  `recuperableonly` int(11) NOT NULL DEFAULT 0,
  `note` varchar(128) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `accountancy_code_sell` varchar(32) DEFAULT NULL,
  `accountancy_code_buy` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_tva`
--

INSERT INTO `llx_c_tva` (`rowid`, `entity`, `fk_pays`, `fk_department_buyer`, `code`, `type_vat`, `taux`, `localtax1`, `localtax1_type`, `localtax2`, `localtax2_type`, `use_default`, `recuperableonly`, `note`, `active`, `accountancy_code_sell`, `accountancy_code_buy`) VALUES
(11, 1, 1, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0 ou non applicable', 1, NULL, NULL),
(12, 1, 1, NULL, '', 0, 20, '0', '0', '0', '0', 0, 0, 'VAT rate - standard (France hors DOM-TOM)', 1, NULL, NULL),
(13, 1, 1, NULL, '', 0, 10, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(14, 1, 1, NULL, '', 0, 5.5, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced (France hors DOM-TOM)', 1, NULL, NULL),
(15, 1, 1, NULL, '', 0, 2.1, '0', '0', '0', '0', 0, 0, 'VAT rate - super-reduced', 1, NULL, NULL),
(16, 1, 1, NULL, '85', 0, 8.5, '0', '0', '0', '0', 0, 0, 'VAT rate - standard (DOM sauf Guyane et Saint-Martin)', 0, NULL, NULL),
(17, 1, 1, NULL, '85NPR', 0, 8.5, '0', '0', '0', '0', 0, 1, 'VAT rate - standard (DOM sauf Guyane et Saint-Martin), non perçu par le vendeur mais récupérable par acheteur', 0, NULL, NULL),
(18, 1, 1, NULL, '85NPROM', 0, 8.5, '2', '3', '0', '0', 0, 1, 'VAT rate - standard (DOM sauf Guyane et Saint-Martin), NPR, Octroi de Mer', 0, NULL, NULL),
(19, 1, 1, NULL, '85NPROMOMR', 0, 8.5, '2', '3', '2.5', '3', 0, 1, 'VAT rate - standard (DOM sauf Guyane et Saint-Martin), NPR, Octroi de Mer et Octroi de Mer Regional', 0, NULL, NULL),
(21, 1, 2, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0 ou non applicable', 1, NULL, NULL),
(22, 1, 2, NULL, '', 0, 6, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(23, 1, 2, NULL, '', 0, 21, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(24, 1, 2, NULL, '', 0, 12, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(31, 1, 3, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(32, 1, 3, NULL, '', 0, 10, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(33, 1, 3, NULL, '', 0, 4, '0', '0', '0', '0', 0, 0, 'VAT rate - super-reduced', 1, NULL, NULL),
(34, 1, 3, NULL, '', 0, 22, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(41, 1, 4, NULL, '', 0, 0, '0', '3', '-19:-15:-9', '5', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(42, 1, 4, NULL, '', 0, 10, '1.4', '3', '-19:-15:-9', '5', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(43, 1, 4, NULL, '', 0, 4, '0.5', '3', '-19:-15:-9', '5', 0, 0, 'VAT rate - super-reduced', 1, NULL, NULL),
(44, 1, 4, NULL, '', 0, 21, '5.2', '3', '-19:-15:-9', '5', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(51, 1, 5, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'No VAT', 1, NULL, NULL),
(52, 1, 5, NULL, '', 0, 7, '0', '0', '0', '0', 0, 0, 'ermäßigte USt.', 1, NULL, NULL),
(54, 1, 5, NULL, '', 0, 5.5, '0', '0', '0', '0', 0, 0, 'USt. Forst', 0, NULL, NULL),
(55, 1, 5, NULL, '', 0, 10.7, '0', '0', '0', '0', 0, 0, 'USt. Landwirtschaft', 0, NULL, NULL),
(56, 1, 5, NULL, '', 0, 19, '0', '0', '0', '0', 0, 0, 'allgemeine Ust.', 1, NULL, NULL),
(61, 1, 6, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(62, 1, 6, NULL, '', 0, 3.8, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(63, 1, 6, NULL, '', 0, 2.6, '0', '0', '0', '0', 0, 0, 'VAT rate - super-reduced', 1, NULL, NULL),
(64, 1, 6, NULL, '', 0, 8.1, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(71, 1, 7, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(72, 1, 7, NULL, '', 0, 17.5, '0', '0', '0', '0', 0, 0, 'VAT rate - standard before 2011', 1, NULL, NULL),
(73, 1, 7, NULL, '', 0, 5, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(74, 1, 7, NULL, '', 0, 20, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(81, 1, 8, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(82, 1, 8, NULL, '', 0, 23, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(83, 1, 8, NULL, '', 0, 13.5, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(84, 1, 8, NULL, '', 0, 9, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(85, 1, 8, NULL, '', 0, 4.8, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(91, 1, 9, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(92, 1, 9, NULL, '', 0, 13, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced 0', 1, NULL, NULL),
(93, 1, 9, NULL, '', 0, 3, '0', '0', '0', '0', 0, 0, 'VAT rate -  super-reduced 0', 1, NULL, NULL),
(94, 1, 9, NULL, '', 0, 17, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(101, 1, 10, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(102, 1, 10, NULL, '', 0, 12, '0', '0', '0', '0', 0, 0, 'VAT 12%', 1, NULL, NULL),
(103, 1, 10, NULL, '', 0, 18, '0', '0', '0', '0', 0, 0, 'VAT 18%', 1, NULL, NULL),
(104, 1, 10, NULL, '', 0, 7.5, '0', '0', '0', '0', 0, 0, 'VAT 6% Majoré à 25% (7.5%)', 1, NULL, NULL),
(105, 1, 10, NULL, '', 0, 15, '0', '0', '0', '0', 0, 0, 'VAT 12% Majoré à 25% (15%)', 1, NULL, NULL),
(106, 1, 10, NULL, '', 0, 22.5, '0', '0', '0', '0', 0, 0, 'VAT 18% Majoré à 25% (22.5%)', 1, NULL, NULL),
(107, 1, 10, NULL, '', 0, 6, '0', '0', '0', '0', 0, 0, 'VAT 6%', 1, NULL, NULL),
(108, 1, 10, NULL, '', 0, 18.18, '1', '4', '0', '0', 0, 0, 'VAT 18%+FODEC', 1, NULL, NULL),
(111, 1, 11, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'No Sales Tax', 1, NULL, NULL),
(112, 1, 11, NULL, '', 0, 4, '0', '0', '0', '0', 0, 0, 'Sales Tax 4%', 1, NULL, NULL),
(113, 1, 11, NULL, '', 0, 6, '0', '0', '0', '0', 0, 0, 'Sales Tax 6%', 1, NULL, NULL),
(121, 1, 12, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(122, 1, 12, NULL, '', 0, 14, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(123, 1, 12, NULL, '', 0, 10, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(124, 1, 12, NULL, '', 0, 7, '0', '0', '0', '0', 0, 0, 'VAT rate - super-reduced', 1, NULL, NULL),
(125, 1, 12, NULL, '', 0, 20, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(131, 1, 13, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'TVA 0%', 1, NULL, NULL),
(132, 1, 13, NULL, '', 0, 9, '0', '0', '0', '0', 0, 0, 'TVA 9%', 1, NULL, NULL),
(133, 1, 13, NULL, '', 0, 19, '0', '0', '0', '0', 0, 0, 'TVA 19%', 1, NULL, NULL),
(141, 1, 14, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(142, 1, 14, NULL, '', 0, 7, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(143, 1, 14, NULL, '', 0, 5, '9.975', '1', '0', '0', 0, 0, 'GST/TPS and PST/TVQ rate for Province', 1, NULL, NULL),
(161, 1, 16, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(162, 1, 16, NULL, 'TPS95', 0, 10, '0', '0', '0', '0', 0, 0, 'VAT 9.5', 1, NULL, NULL),
(163, 1, 16, NULL, 'TPS95C', 0, 10, '1', '1', '0', '0', 0, 0, 'VAT 9.5+CSS', 1, NULL, NULL),
(164, 1, 16, NULL, 'TPS10', 0, 10, '0', '0', '0', '0', 0, 0, 'VAT 10', 1, NULL, NULL),
(165, 1, 16, NULL, 'TPS10C', 0, 10, '1', '1', '0', '0', 0, 0, 'VAT 10+CSS', 1, NULL, NULL),
(166, 1, 16, NULL, 'TPS18', 0, 18, '0', '0', '0', '0', 0, 0, 'VAT 18', 1, NULL, NULL),
(167, 1, 16, NULL, 'TPS18C', 0, 18, '1', '1', '0', '0', 0, 0, 'VAT 18+CSS', 1, NULL, NULL),
(171, 1, 17, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, '0 BTW tarief', 1, NULL, NULL),
(172, 1, 17, NULL, '', 0, 6, '0', '0', '0', '0', 0, 0, 'Verlaagd BTW tarief', 1, NULL, NULL),
(173, 1, 17, NULL, '', 0, 19, '0', '0', '0', '0', 0, 0, 'Algemeen BTW tarief', 1, NULL, NULL),
(174, 1, 17, NULL, '', 0, 21, '0', '0', '0', '0', 0, 0, 'Algemeen BTW tarief (vanaf 1 oktober 2012)', 0, NULL, NULL),
(201, 1, 20, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(202, 1, 20, NULL, '', 0, 12, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(203, 1, 20, NULL, '', 0, 6, '0', '0', '0', '0', 0, 0, 'VAT rate - super-reduced', 1, NULL, NULL),
(204, 1, 20, NULL, '', 0, 25, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(211, 1, 21, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'IVA Rate 0', 1, NULL, NULL),
(212, 1, 21, NULL, '', 0, 18, '7.5', '2', '0', '0', 0, 0, 'IVA standard rate', 1, NULL, NULL),
(221, 1, 22, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(222, 1, 22, NULL, '', 0, 10, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(223, 1, 22, NULL, '', 0, 18, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(231, 1, 23, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'IVA Rate 0', 1, NULL, NULL),
(232, 1, 23, NULL, '', 0, 10.5, '0', '0', '0', '0', 0, 0, 'IVA reduced rate', 1, NULL, NULL),
(233, 1, 23, NULL, '', 0, 21, '0', '0', '0', '0', 0, 0, 'IVA standard rate', 1, NULL, NULL),
(241, 1, 24, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(242, 1, 24, NULL, '', 0, 19.25, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(251, 1, 25, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(252, 1, 25, NULL, '', 0, 13, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(253, 1, 25, NULL, '', 0, 23, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(254, 1, 25, NULL, '', 0, 6, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(261, 1, 26, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(262, 1, 26, NULL, '', 0, 5, '0', '0', '0', '0', 0, 0, 'VAT rate 5', 1, NULL, NULL),
(271, 1, 27, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0 ou non applicable', 1, NULL, NULL),
(272, 1, 27, NULL, '', 0, 8.5, '0', '0', '0', '0', 0, 0, 'VAT rate - standard (DOM sauf Guyane et Saint-Martin)', 0, NULL, NULL),
(273, 1, 27, NULL, '', 0, 8.5, '0', '0', '0', '0', 0, 1, 'VAT rate - standard (DOM sauf Guyane et Saint-Martin), non perçu par le vendeur mais récupérable par acheteur', 0, NULL, NULL),
(274, 1, 27, NULL, '', 0, 5.5, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced (France hors DOM-TOM)', 0, NULL, NULL),
(275, 1, 27, NULL, '', 0, 19.6, '0', '0', '0', '0', 0, 0, 'VAT rate - standard (France hors DOM-TOM)', 1, NULL, NULL),
(276, 1, 27, NULL, '', 0, 2.1, '0', '0', '0', '0', 0, 0, 'VAT rate - super-reduced', 1, NULL, NULL),
(277, 1, 27, NULL, '', 0, 7, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(281, 1, 28, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(282, 1, 28, NULL, '', 0, 10, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(351, 1, 35, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(352, 1, 35, NULL, '', 0, 7, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(353, 1, 35, NULL, '', 0, 14, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(411, 1, 41, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(412, 1, 41, NULL, '', 0, 10, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(413, 1, 41, NULL, '', 0, 20, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(461, 1, 46, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'No VAT', 1, NULL, NULL),
(462, 1, 46, NULL, '', 0, 15, '0', '0', '0', '0', 0, 0, 'VAT 15%', 1, NULL, NULL),
(463, 1, 46, NULL, '', 0, 7.5, '0', '0', '0', '0', 0, 0, 'VAT 7.5%', 1, NULL, NULL),
(561, 1, 56, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(591, 1, 59, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(592, 1, 59, NULL, '', 0, 7, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(593, 1, 59, NULL, '', 0, 20, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(671, 1, 67, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(672, 1, 67, NULL, '', 0, 19, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(721, 1, 72, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(722, 1, 72, NULL, '', 0, 18, '0.9', '1', '0', '0', 0, 0, 'VAT rate 18+0.9', 1, NULL, NULL),
(761, 1, 76, NULL, '', 0, 25, '0', '0', '0', '0', 0, 0, 'PDV 25%', 1, NULL, NULL),
(762, 1, 76, NULL, '', 0, 13, '0', '0', '0', '0', 0, 0, 'PDV 13%', 1, NULL, NULL),
(763, 1, 76, NULL, '', 0, 5, '0', '0', '0', '0', 0, 0, 'PDV 5%', 1, NULL, NULL),
(764, 1, 76, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'PDV 0%', 1, NULL, NULL),
(781, 1, 78, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(782, 1, 78, NULL, '', 0, 9, '0', '0', '0', '0', 0, 0, 'VAT rate 9', 1, NULL, NULL),
(783, 1, 78, NULL, '', 0, 5, '0', '0', '0', '0', 0, 0, 'VAT rate 5', 1, NULL, NULL),
(784, 1, 78, NULL, '', 0, 19, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(801, 1, 80, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(802, 1, 80, NULL, '', 0, 25, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(861, 1, 86, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'SIN IVA', 1, NULL, NULL),
(862, 1, 86, NULL, '', 0, 13, '0', '0', '0', '0', 0, 0, 'IVA 13', 1, NULL, NULL),
(1021, 1, 102, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'Μηδενικό Φ.Π.Α.', 1, NULL, NULL),
(1022, 1, 102, NULL, '', 0, 24, '0', '0', '0', '0', 0, 0, 'Κανονικός Φ.Π.Α.', 1, NULL, NULL),
(1023, 1, 102, NULL, '', 0, 13, '0', '0', '0', '0', 0, 0, 'Μειωμένος Φ.Π.Α.', 1, NULL, NULL),
(1024, 1, 102, NULL, '', 0, 6, '0', '0', '0', '0', 0, 0, 'Υπερμειωμένος Φ.Π.Α.', 1, NULL, NULL),
(1025, 1, 102, NULL, '', 0, 3, '0', '0', '0', '0', 0, 0, 'Νήσων υπερμειωμένος Φ.Π.Α.', 1, NULL, NULL),
(1026, 1, 102, NULL, '', 0, 9, '0', '0', '0', '0', 0, 0, 'Νήσων μειωμένος Φ.Π.Α.', 1, NULL, NULL),
(1027, 1, 102, NULL, '', 0, 4, '0', '0', '0', '0', 0, 0, 'Νήσων υπερμειωμένος Φ.Π.Α.', 1, NULL, NULL),
(1028, 1, 102, NULL, '', 0, 17, '0', '0', '0', '0', 0, 0, 'Νήσων υπερμειωμένος Φ.Π.Α.', 1, NULL, NULL),
(1141, 1, 114, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'No ISV', 1, NULL, NULL),
(1142, 1, 114, NULL, '', 0, 12, '0', '0', '0', '0', 0, 0, 'ISV 12%', 1, NULL, NULL),
(1161, 1, 116, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1162, 1, 116, NULL, '', 0, 7, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(1163, 1, 116, NULL, '', 0, 25.5, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(1171, 1, 117, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 0, NULL, NULL),
(1172, 1, 117, NULL, 'C+S-5', 0, 0, '2.5', '1', '2.5', '1', 0, 0, 'CGST+SGST - Same state sales', 1, NULL, NULL),
(1173, 1, 117, NULL, 'I-5', 0, 5, '0', '0', '0', '0', 0, 0, 'IGST', 1, NULL, NULL),
(1174, 1, 117, NULL, 'C+S-12', 0, 0, '6', '1', '6', '1', 0, 0, 'CGST+SGST - Same state sales', 1, NULL, NULL),
(1175, 1, 117, NULL, 'I-12', 0, 12, '0', '0', '0', '0', 0, 0, 'IGST', 1, NULL, NULL),
(1176, 1, 117, NULL, 'C+S-18', 0, 0, '9', '1', '9', '1', 0, 0, 'CGST+SGST - Same state sales', 1, NULL, NULL),
(1177, 1, 117, NULL, 'I-18', 0, 18, '0', '0', '0', '0', 0, 0, 'IGST', 1, NULL, NULL),
(1178, 1, 117, NULL, 'C+S-28', 0, 0, '14', '1', '14', '1', 0, 0, 'CGST+SGST - Same state sales', 1, NULL, NULL),
(1179, 1, 117, NULL, 'I-28', 0, 28, '0', '0', '0', '0', 0, 0, 'IGST', 1, NULL, NULL),
(1231, 1, 123, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1232, 1, 123, NULL, '', 0, 5, '0', '0', '0', '0', 0, 0, 'VAT rate 5', 1, NULL, NULL),
(1401, 1, 140, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1402, 1, 140, NULL, '', 0, 14, '0', '0', '0', '0', 0, 0, 'VAT rate - intermediary', 1, NULL, NULL),
(1403, 1, 140, NULL, '', 0, 8, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(1404, 1, 140, NULL, '', 0, 3, '0', '0', '0', '0', 0, 0, 'VAT rate - super-reduced', 1, NULL, NULL),
(1405, 1, 140, NULL, '', 0, 16, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(1471, 1, 147, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1472, 1, 147, NULL, '', 0, 18, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(1481, 1, 148, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1482, 1, 148, NULL, '', 0, 7, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(1483, 1, 148, NULL, '', 0, 5, '0', '0', '0', '0', 0, 0, 'VAT rate - super-reduced', 1, NULL, NULL),
(1484, 1, 148, NULL, '', 0, 18, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(1511, 1, 151, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1512, 1, 151, NULL, '', 0, 14, '0', '0', '0', '0', 0, 0, 'VAT rate 14', 1, NULL, NULL),
(1521, 1, 152, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1522, 1, 152, NULL, '', 0, 15, '0', '0', '0', '0', 0, 0, 'VAT rate 15', 1, NULL, NULL),
(1541, 1, 154, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'No VAT', 1, NULL, NULL),
(1542, 1, 154, NULL, '', 0, 16, '0', '0', '0', '0', 0, 0, 'VAT 16%', 1, NULL, NULL),
(1543, 1, 154, NULL, '', 0, 10, '0', '0', '0', '0', 0, 0, 'VAT Frontero', 1, NULL, NULL),
(1651, 1, 165, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1652, 1, 165, NULL, '', 0, 3, '0', '0', '0', '0', 0, 0, 'VAT standard 3', 1, NULL, NULL),
(1653, 1, 165, NULL, '', 0, 6, '0', '0', '0', '0', 0, 0, 'VAT standard 6', 1, NULL, NULL),
(1654, 1, 165, NULL, '', 0, 11, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(1655, 1, 165, NULL, '', 0, 22, '0', '0', '0', '0', 0, 0, 'VAT standard high', 1, NULL, NULL),
(1661, 1, 166, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1662, 1, 166, NULL, '', 0, 15, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(1691, 1, 169, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1692, 1, 169, NULL, '', 0, 5, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(1731, 1, 173, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1732, 1, 173, NULL, '', 0, 14, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(1733, 1, 173, NULL, '', 0, 8, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(1734, 1, 173, NULL, '', 0, 25, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(1781, 1, 178, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'ITBMS Rate 0', 1, NULL, NULL),
(1782, 1, 178, NULL, '', 0, 7, '0', '0', '0', '0', 0, 0, 'ITBMS standard rate', 1, NULL, NULL),
(1811, 1, 181, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1818, 1, 181, NULL, '', 0, 18, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(1841, 1, 184, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1842, 1, 184, NULL, '', 0, 8, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(1843, 1, 184, NULL, '', 0, 3, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(1844, 1, 184, NULL, '', 0, 23, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(1881, 1, 188, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(1882, 1, 188, NULL, '', 0, 9, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(1883, 1, 188, NULL, '', 0, 19, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(1884, 1, 188, NULL, '', 0, 5, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(1931, 1, 193, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'No VAT in SPM', 1, NULL, NULL),
(2011, 1, 201, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(2012, 1, 201, NULL, '', 0, 10, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(2013, 1, 201, NULL, '', 0, 20, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(2021, 1, 202, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(2022, 1, 202, NULL, '', 0, 9.5, '0', '0', '0', '0', 0, 0, 'VAT rate - reduced', 1, NULL, NULL),
(2023, 1, 202, NULL, '', 0, 22, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(2051, 1, 205, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(2052, 1, 205, NULL, '', 0, 15, '0', '0', '0', '0', 0, 0, 'VAT rate - standard', 1, NULL, NULL),
(2071, 1, 207, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT 0', 1, NULL, NULL),
(2072, 1, 207, NULL, '', 0, 15, '0', '0', '0', '0', 0, 0, 'VAT 15%', 1, NULL, NULL),
(2131, 1, 213, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT 0', 1, NULL, NULL),
(2132, 1, 213, NULL, '', 0, 5, '0', '0', '0', '0', 0, 0, 'VAT 5%', 1, NULL, NULL),
(2261, 1, 226, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(2262, 1, 226, NULL, '', 0, 20, '0', '0', '0', '0', 0, 0, 'VAT standart rate', 1, NULL, NULL),
(2321, 1, 232, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'No VAT', 1, NULL, NULL),
(2322, 1, 232, NULL, '', 0, 12, '0', '0', '0', '0', 0, 0, 'VAT 12%', 1, NULL, NULL),
(2323, 1, 232, NULL, '', 0, 8, '0', '0', '0', '0', 0, 0, 'VAT 8%', 1, NULL, NULL),
(2331, 1, 233, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'Thuế GTGT đươc khấu trừ 0%', 1, NULL, NULL),
(2332, 1, 233, NULL, '', 0, 5, '0', '0', '0', '0', 0, 0, 'Thuế GTGT đươc khấu trừ 5%', 1, NULL, NULL),
(2333, 1, 233, NULL, '', 0, 8, '0', '0', '0', '0', 0, 0, 'Thuế GTGT đươc khấu trừ 8%', 1, NULL, NULL),
(2334, 1, 233, NULL, '', 0, 10, '0', '0', '0', '0', 0, 0, 'Thuế GTGT đươc khấu trừ 10%', 1, NULL, NULL),
(2335, 1, 61, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'No VAT', 1, NULL, NULL),
(2336, 1, 61, NULL, '', 0, 10, '0', '0', '0', '0', 0, 0, 'VAT 10%', 1, NULL, NULL),
(2337, 1, 61, NULL, '', 0, 18, '0', '0', '0', '0', 0, 0, 'VAT 18%', 1, NULL, NULL),
(2461, 1, 246, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'VAT rate 0', 1, NULL, NULL),
(22101, 1, 221, NULL, '', 0, 0, '0', '0', '0', '0', 0, 0, 'No VAT', 1, NULL, NULL),
(22102, 1, 221, NULL, '', 0, 1, '0', '0', '0', '0', 0, 0, 'VAT 1%', 1, NULL, NULL),
(22103, 1, 221, NULL, '', 0, 8, '0', '0', '0', '0', 0, 0, 'VAT 8%', 1, NULL, NULL),
(22104, 1, 221, NULL, '', 0, 18, '0', '0', '0', '0', 0, 0, 'VAT 18%', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_typent`
--

CREATE TABLE `llx_c_typent` (
  `id` int(11) NOT NULL,
  `code` varchar(12) NOT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `fk_country` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `module` varchar(32) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_typent`
--

INSERT INTO `llx_c_typent` (`id`, `code`, `libelle`, `fk_country`, `active`, `module`, `position`) VALUES
(1, 'TE_STARTUP', 'Start-up', NULL, 0, NULL, 0),
(2, 'TE_GROUP', 'Grand groupe', NULL, 1, NULL, 0),
(3, 'TE_MEDIUM', 'PME/PMI', NULL, 1, NULL, 0),
(4, 'TE_SMALL', 'TPE', NULL, 1, NULL, 0),
(5, 'TE_ADMIN', 'Administration', NULL, 1, NULL, 0),
(6, 'TE_WHOLE', 'Grossiste', NULL, 0, NULL, 0),
(7, 'TE_RETAIL', 'Revendeur', NULL, 0, NULL, 0),
(8, 'TE_PRIVATE', 'Particulier', NULL, 1, NULL, 0),
(100, 'TE_OTHER', 'Autres', NULL, 1, NULL, 0),
(231, 'TE_A_RI', 'Responsable Inscripto (typo A)', 23, 0, NULL, 0),
(232, 'TE_B_RNI', 'Responsable No Inscripto (typo B)', 23, 0, NULL, 0),
(233, 'TE_C_FE', 'Consumidor Final/Exento (typo C)', 23, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_type_contact`
--

CREATE TABLE `llx_c_type_contact` (
  `rowid` int(11) NOT NULL,
  `element` varchar(64) NOT NULL,
  `source` varchar(8) NOT NULL DEFAULT 'external',
  `code` varchar(32) NOT NULL,
  `libelle` varchar(128) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `module` varchar(32) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_type_contact`
--

INSERT INTO `llx_c_type_contact` (`rowid`, `element`, `source`, `code`, `libelle`, `active`, `module`, `position`) VALUES
(1, 'contrat', 'internal', 'SALESREPSIGN', 'Commercial signataire du contrat', 1, NULL, 0),
(2, 'contrat', 'internal', 'SALESREPFOLL', 'Commercial suivi du contrat', 1, NULL, 0),
(3, 'contrat', 'external', 'BILLING', 'Contact client facturation contrat', 1, NULL, 0),
(4, 'contrat', 'external', 'CUSTOMER', 'Contact client suivi contrat', 1, NULL, 0),
(5, 'contrat', 'external', 'SALESREPSIGN', 'Contact client signataire contrat', 1, NULL, 0),
(6, 'propal', 'internal', 'SALESREPFOLL', 'Commercial à l\'origine de la propale', 1, NULL, 0),
(7, 'propal', 'external', 'BILLING', 'Contact client facturation propale', 1, NULL, 0),
(8, 'propal', 'external', 'CUSTOMER', 'Contact client suivi propale', 1, NULL, 0),
(9, 'propal', 'external', 'SHIPPING', 'Contact client livraison propale', 1, NULL, 0),
(10, 'facture', 'internal', 'SALESREPFOLL', 'Responsable suivi du paiement', 1, NULL, 0),
(11, 'facture', 'external', 'BILLING', 'Contact client facturation', 1, NULL, 0),
(12, 'facture', 'external', 'SHIPPING', 'Contact client livraison', 1, NULL, 0),
(13, 'facture', 'external', 'SERVICE', 'Contact client prestation', 1, NULL, 0),
(14, 'invoice_supplier', 'internal', 'SALESREPFOLL', 'Responsable suivi du paiement', 1, NULL, 0),
(15, 'invoice_supplier', 'external', 'BILLING', 'Contact fournisseur facturation', 1, NULL, 0),
(16, 'invoice_supplier', 'external', 'SHIPPING', 'Contact fournisseur livraison', 1, NULL, 0),
(17, 'invoice_supplier', 'external', 'SERVICE', 'Contact fournisseur prestation', 1, NULL, 0),
(18, 'agenda', 'internal', 'ACTOR', 'Responsable', 1, NULL, 0),
(19, 'agenda', 'internal', 'GUEST', 'Guest', 1, NULL, 0),
(20, 'agenda', 'external', 'ACTOR', 'Responsable', 1, NULL, 0),
(21, 'agenda', 'external', 'GUEST', 'Guest', 1, NULL, 0),
(22, 'commande', 'internal', 'SALESREPFOLL', 'Responsable suivi de la commande', 1, NULL, 0),
(23, 'commande', 'external', 'BILLING', 'Contact client facturation commande', 1, NULL, 0),
(24, 'commande', 'external', 'CUSTOMER', 'Contact client suivi commande', 1, NULL, 0),
(25, 'commande', 'external', 'SHIPPING', 'Contact client livraison commande', 1, NULL, 0),
(26, 'expedition', 'external', 'CUSTOMER', 'Customer shipping contact', 1, NULL, 0),
(27, 'expedition', 'external', 'SHIPPING', 'Loading facility', 1, NULL, 0),
(28, 'expedition', 'external', 'DELIVERY', 'Delivery facility', 1, NULL, 0),
(29, 'fichinter', 'internal', 'INTERREPFOLL', 'Responsable suivi de l\'intervention', 1, NULL, 0),
(30, 'fichinter', 'internal', 'INTERVENING', 'Intervenant', 1, NULL, 0),
(31, 'fichinter', 'external', 'BILLING', 'Contact client facturation intervention', 1, NULL, 0),
(32, 'fichinter', 'external', 'CUSTOMER', 'Contact client suivi de l\'intervention', 1, NULL, 0),
(33, 'order_supplier', 'internal', 'SALESREPFOLL', 'Responsable suivi de la commande', 1, NULL, 0),
(34, 'order_supplier', 'internal', 'SHIPPING', 'Responsable réception de la commande', 1, NULL, 0),
(35, 'order_supplier', 'external', 'BILLING', 'Contact fournisseur facturation commande', 1, NULL, 0),
(36, 'order_supplier', 'external', 'CUSTOMER', 'Contact fournisseur suivi commande', 1, NULL, 0),
(37, 'order_supplier', 'external', 'SHIPPING', 'Contact fournisseur livraison commande', 1, NULL, 0),
(38, 'dolresource', 'internal', 'USERINCHARGE', 'In charge of resource', 1, NULL, 0),
(39, 'dolresource', 'external', 'THIRDINCHARGE', 'In charge of resource', 1, NULL, 0),
(40, 'ticket', 'internal', 'SUPPORTTEC', 'Utilisateur contact support', 1, NULL, 0),
(41, 'ticket', 'internal', 'CONTRIBUTOR', 'Intervenant', 1, NULL, 0),
(42, 'ticket', 'external', 'SUPPORTCLI', 'Contact client suivi incident', 1, NULL, 0),
(43, 'ticket', 'external', 'CONTRIBUTOR', 'Intervenant', 1, NULL, 0),
(44, 'project', 'internal', 'PROJECTLEADER', 'Chef de Projet', 1, NULL, 0),
(45, 'project', 'internal', 'PROJECTCONTRIBUTOR', 'Intervenant', 1, NULL, 0),
(46, 'project', 'external', 'PROJECTLEADER', 'Chef de Projet', 1, NULL, 0),
(47, 'project', 'external', 'PROJECTCONTRIBUTOR', 'Intervenant', 1, NULL, 0),
(48, 'project_task', 'internal', 'TASKEXECUTIVE', 'Responsable', 1, NULL, 0),
(49, 'project_task', 'internal', 'TASKCONTRIBUTOR', 'Intervenant', 1, NULL, 0),
(50, 'project_task', 'external', 'TASKEXECUTIVE', 'Responsable', 1, NULL, 0),
(51, 'project_task', 'external', 'TASKCONTRIBUTOR', 'Intervenant', 1, NULL, 0),
(52, 'supplier_proposal', 'internal', 'SALESREPFOLL', 'Responsable suivi de la demande', 1, NULL, 0),
(53, 'supplier_proposal', 'external', 'BILLING', 'Contact fournisseur facturation', 1, NULL, 0),
(54, 'supplier_proposal', 'external', 'SHIPPING', 'Contact fournisseur livraison', 1, NULL, 0),
(55, 'supplier_proposal', 'external', 'SERVICE', 'Contact fournisseur prestation', 1, NULL, 0),
(56, 'conferenceorbooth', 'internal', 'MANAGER', 'Conference or Booth manager', 1, NULL, 0),
(57, 'conferenceorbooth', 'external', 'SPEAKER', 'Conference Speaker', 1, NULL, 0),
(58, 'conferenceorbooth', 'external', 'RESPONSIBLE', 'Booth responsible', 1, NULL, 0),
(59, 'societe', 'external', 'SALESREPTHIRD', 'Sales Representative', 1, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_type_fees`
--

CREATE TABLE `llx_c_type_fees` (
  `id` int(11) NOT NULL,
  `code` varchar(12) NOT NULL,
  `label` varchar(128) DEFAULT NULL,
  `type` int(11) DEFAULT 0,
  `accountancy_code` varchar(32) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `module` varchar(32) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_type_fees`
--

INSERT INTO `llx_c_type_fees` (`id`, `code`, `label`, `type`, `accountancy_code`, `active`, `module`, `position`) VALUES
(1, 'TF_OTHER', 'Other', 0, NULL, 1, NULL, 0),
(2, 'TF_TRIP', 'Transportation', 0, NULL, 1, NULL, 0),
(3, 'TF_LUNCH', 'Lunch', 0, NULL, 1, NULL, 0),
(4, 'EX_KME', 'ExpLabelKm', 0, NULL, 1, NULL, 0),
(5, 'EX_FUE', 'ExpLabelFuelCV', 0, NULL, 0, NULL, 0),
(6, 'EX_HOT', 'ExpLabelHotel', 0, NULL, 0, NULL, 0),
(7, 'EX_PAR', 'ExpLabelParkingCV', 0, NULL, 0, NULL, 0),
(8, 'EX_TOL', 'ExpLabelTollCV', 0, NULL, 0, NULL, 0),
(9, 'EX_TAX', 'ExpLabelVariousTaxes', 0, NULL, 0, NULL, 0),
(10, 'EX_IND', 'ExpLabelIndemnityTransSubscrip', 0, NULL, 0, NULL, 0),
(11, 'EX_SUM', 'ExpLabelMaintenanceSupply', 0, NULL, 0, NULL, 0),
(12, 'EX_SUO', 'ExpLabelOfficeSupplies', 0, NULL, 0, NULL, 0),
(13, 'EX_CAR', 'ExpLabelCarRental', 0, NULL, 0, NULL, 0),
(14, 'EX_DOC', 'ExpLabelDocumentation', 0, NULL, 0, NULL, 0),
(15, 'EX_CUR', 'ExpLabelCustomersReceiving', 0, NULL, 0, NULL, 0),
(16, 'EX_OTR', 'ExpLabelOtherReceiving', 0, NULL, 0, NULL, 0),
(17, 'EX_POS', 'ExpLabelPostage', 0, NULL, 0, NULL, 0),
(18, 'EX_CAM', 'ExpLabelMaintenanceRepairCV', 0, NULL, 0, NULL, 0),
(19, 'EX_EMM', 'ExpLabelEmployeesMeal', 0, NULL, 0, NULL, 0),
(20, 'EX_GUM', 'ExpLabelGuestsMeal', 0, NULL, 0, NULL, 0),
(21, 'EX_BRE', 'ExpLabelBreakfast', 0, NULL, 0, NULL, 0),
(22, 'EX_FUE_VP', 'ExpLabelFuelPV', 0, NULL, 0, NULL, 0),
(23, 'EX_TOL_VP', 'ExpLabelTollPV', 0, NULL, 0, NULL, 0),
(24, 'EX_PAR_VP', 'ExpLabelParkingPV', 0, NULL, 0, NULL, 0),
(25, 'EX_CAM_VP', 'ExpLabelMaintenanceRepairPV', 0, NULL, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_type_resource`
--

CREATE TABLE `llx_c_type_resource` (
  `rowid` int(11) NOT NULL,
  `code` varchar(32) NOT NULL,
  `label` varchar(128) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_type_resource`
--

INSERT INTO `llx_c_type_resource` (`rowid`, `code`, `label`, `active`) VALUES
(1, 'RES_ROOMS', 'Rooms', 1),
(2, 'RES_CARS', 'Cars', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_units`
--

CREATE TABLE `llx_c_units` (
  `rowid` int(11) NOT NULL,
  `code` varchar(3) DEFAULT NULL,
  `sortorder` smallint(6) DEFAULT NULL,
  `scale` int(11) DEFAULT NULL,
  `label` varchar(128) DEFAULT NULL,
  `short_label` varchar(5) DEFAULT NULL,
  `unit_type` varchar(10) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_c_units`
--

INSERT INTO `llx_c_units` (`rowid`, `code`, `sortorder`, `scale`, `label`, `short_label`, `unit_type`, `active`) VALUES
(1, 'T', 100, 3, 'WeightUnitton', 'T', 'weight', 1),
(2, 'KG', 110, 0, 'WeightUnitkg', 'kg', 'weight', 1),
(3, 'G', 120, -3, 'WeightUnitg', 'g', 'weight', 1),
(4, 'MG', 130, -6, 'WeightUnitmg', 'mg', 'weight', 1),
(5, 'OZ', 140, 98, 'WeightUnitounce', 'Oz', 'weight', 1),
(6, 'LB', 150, 99, 'WeightUnitpound', 'lb', 'weight', 1),
(7, 'M', 200, 0, 'SizeUnitm', 'm', 'size', 1),
(8, 'DM', 210, -1, 'SizeUnitdm', 'dm', 'size', 1),
(9, 'CM', 220, -2, 'SizeUnitcm', 'cm', 'size', 1),
(10, 'MM', 230, -3, 'SizeUnitmm', 'mm', 'size', 1),
(11, 'FT', 240, 98, 'SizeUnitfoot', 'ft', 'size', 1),
(12, 'IN', 250, 99, 'SizeUnitinch', 'in', 'size', 1),
(13, 'M2', 300, 0, 'SurfaceUnitm2', 'm2', 'surface', 1),
(14, 'DM2', 310, -2, 'SurfaceUnitdm2', 'dm2', 'surface', 1),
(15, 'CM2', 320, -4, 'SurfaceUnitcm2', 'cm2', 'surface', 1),
(16, 'MM2', 330, -6, 'SurfaceUnitmm2', 'mm2', 'surface', 1),
(17, 'FT2', 340, 98, 'SurfaceUnitfoot2', 'ft2', 'surface', 1),
(18, 'IN2', 350, 99, 'SurfaceUnitinch2', 'in2', 'surface', 1),
(19, 'M3', 400, 0, 'VolumeUnitm3', 'm3', 'volume', 1),
(20, 'DM3', 410, -3, 'VolumeUnitdm3', 'dm3', 'volume', 1),
(21, 'CM3', 420, -6, 'VolumeUnitcm3', 'cm3', 'volume', 1),
(22, 'MM3', 430, -9, 'VolumeUnitmm3', 'mm3', 'volume', 1),
(23, 'FT3', 440, 88, 'VolumeUnitfoot3', 'ft3', 'volume', 1),
(24, 'IN3', 450, 89, 'VolumeUnitinch3', 'in3', 'volume', 1),
(25, 'OZ3', 460, 97, 'VolumeUnitounce', 'Oz', 'volume', 1),
(26, 'L', 470, 98, 'VolumeUnitlitre', 'L', 'volume', 1),
(27, 'GAL', 480, 99, 'VolumeUnitgallon', 'gal', 'volume', 1),
(28, 'P', 500, 0, 'Piece', 'p', 'qty', 1),
(29, 'SET', 510, 0, 'Set', 'set', 'qty', 1),
(30, 'S', 600, 1, 'second', 's', 'time', 1),
(31, 'MI', 610, 60, 'minute', 'mn', 'time', 1),
(32, 'H', 620, 3600, 'hour', 'h', 'time', 1),
(33, 'D', 630, 86400, 'day', 'd', 'time', 1),
(34, 'W', 640, 604800, 'week', 'w', 'time', 1),
(35, 'MO', 650, 2629800, 'month', 'm', 'time', 1),
(36, 'Y', 660, 31557600, 'year', 'y', 'time', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_c_ziptown`
--

CREATE TABLE `llx_c_ziptown` (
  `rowid` int(11) NOT NULL,
  `code` varchar(5) DEFAULT NULL,
  `fk_county` int(11) DEFAULT NULL,
  `fk_pays` int(11) NOT NULL DEFAULT 0,
  `zip` varchar(10) NOT NULL,
  `town` varchar(180) NOT NULL,
  `town_up` varchar(180) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_default_values`
--

CREATE TABLE `llx_default_values` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `type` varchar(10) DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `page` varchar(255) DEFAULT NULL,
  `param` varchar(255) DEFAULT NULL,
  `value` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_delivery`
--

CREATE TABLE `llx_delivery` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_soc` int(11) NOT NULL,
  `ref_ext` varchar(255) DEFAULT NULL,
  `ref_customer` varchar(255) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `date_delivery` datetime DEFAULT NULL,
  `fk_address` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT 0,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_deliverydet`
--

CREATE TABLE `llx_deliverydet` (
  `rowid` int(11) NOT NULL,
  `fk_delivery` int(11) DEFAULT NULL,
  `fk_origin_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `subprice` double(24,8) DEFAULT 0.00000000,
  `subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `rang` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_deliverydet_extrafields`
--

CREATE TABLE `llx_deliverydet_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_delivery_extrafields`
--

CREATE TABLE `llx_delivery_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_document_model`
--

CREATE TABLE `llx_document_model` (
  `rowid` int(11) NOT NULL,
  `nom` varchar(50) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `type` varchar(64) NOT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_document_model`
--

INSERT INTO `llx_document_model` (`rowid`, `nom`, `entity`, `type`, `libelle`, `description`) VALUES
(5, 'standard_stock', 1, 'stock', NULL, NULL),
(6, 'standard_movement_stock', 1, 'mouvement', NULL, NULL),
(7, 'eratosthene', 1, 'order', NULL, NULL),
(8, 'cyan', 1, 'propal', NULL, NULL),
(10, 'sponge', 1, 'invoice', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_ecm_directories`
--

CREATE TABLE `llx_ecm_directories` (
  `rowid` int(11) NOT NULL,
  `label` varchar(64) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_parent` int(11) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `cachenbofdoc` int(11) NOT NULL DEFAULT 0,
  `fullpath` varchar(750) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL,
  `date_c` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_c` int(11) DEFAULT NULL,
  `fk_user_m` int(11) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `acl` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_ecm_directories_extrafields`
--

CREATE TABLE `llx_ecm_directories_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_ecm_files`
--

CREATE TABLE `llx_ecm_files` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(128) DEFAULT NULL,
  `label` varchar(128) NOT NULL,
  `share` varchar(128) DEFAULT NULL,
  `share_pass` varchar(32) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `filepath` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `src_object_type` varchar(64) DEFAULT NULL,
  `src_object_id` int(11) DEFAULT NULL,
  `agenda_id` int(11) DEFAULT NULL,
  `fullpath_orig` varchar(750) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `keywords` varchar(750) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `cover` varchar(32) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `gen_or_uploaded` varchar(12) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL,
  `date_c` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_c` int(11) DEFAULT NULL,
  `fk_user_m` int(11) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `acl` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_ecm_files`
--

INSERT INTO `llx_ecm_files` (`rowid`, `ref`, `label`, `share`, `share_pass`, `entity`, `filepath`, `filename`, `src_object_type`, `src_object_id`, `agenda_id`, `fullpath_orig`, `description`, `keywords`, `content`, `cover`, `position`, `gen_or_uploaded`, `extraparams`, `date_c`, `tms`, `fk_user_c`, `fk_user_m`, `note_private`, `note_public`, `acl`) VALUES
(8, '645524a286c4c2b1b52dde6bedd606f4', '9aa949de5a6fd8c017d1705b3f0fda3e', NULL, NULL, 1, 'produit/SILLA-TIFF', 'SILLA-TIFF-SILLATIFF ICONO.png', 'product', 6, NULL, 'SILLATIFF ICONO.png', '', '', NULL, NULL, 1, 'uploaded', NULL, '2025-12-28 18:37:20', '2025-12-29 00:37:20', 1, NULL, NULL, NULL, NULL),
(10, '01f548f45fbe2de286c9f267098c6af2', '3827d24c04cd1f4eb132ff7003dc5eb2', NULL, NULL, 1, 'produit/MESA-R', 'MESA-R-MESAREDONDA ICONO.png', 'product', 8, NULL, 'MESAREDONDA ICONO.png', '', '', NULL, NULL, 1, 'uploaded', NULL, '2025-12-28 18:37:54', '2025-12-29 00:37:54', 1, NULL, NULL, NULL, NULL),
(11, '950d43e142402e1d05138b99f111c8b9', '54284492a93c77ef5a3c73cff49200d9', NULL, NULL, 1, 'produit/CM5X5A3', 'CM5X5A3-CARPA ICONO.png', 'product', 5, NULL, 'CARPA ICONO.png', '', '', NULL, NULL, 1, 'uploaded', NULL, '2025-12-28 18:38:11', '2025-12-29 00:38:11', 1, NULL, NULL, NULL, NULL),
(12, '18937060e9b4b61316d486f5b06bb5f7', '033f66211e8d2ece8fe5cb3251d8b9f7', 'pEZzxCvo1IoxHo8T7R7XS7xq5FH551g8', NULL, 1, 'produit/SILLA-C-P', 'SILLA-C-P.jpg', 'product', 7, NULL, 'SILLA-C-P.jpg', '', '', NULL, NULL, 1, 'uploaded', NULL, '2025-12-28 19:06:13', '2025-12-28 18:10:25', 1, 1, NULL, NULL, NULL),
(27, 'd7d01bad51b20758e5d852658889dce1', '3be54385ba29e35303f67f06ee83d81e', NULL, NULL, 1, 'produit/CM5X5A3', 'CM5X5A3.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/CM5X5A3/CM5X5A3.jpg', '', '', NULL, NULL, 2, 'unknown', NULL, '2026-01-18 19:49:47', '2026-01-19 01:49:47', 1, NULL, NULL, NULL, NULL),
(28, '199772b906047522c66f009890c9eaff', '1f7cdb764b90a6fb2eb08dae33a389c7', NULL, NULL, 1, 'produit/SILLA-TIFF', 'SILLA-TIFF.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/SILLA-TIFF/SILLA-TIFF.jpg', '', '', NULL, NULL, 2, 'unknown', NULL, '2026-01-18 19:49:47', '2026-01-19 01:49:47', 1, NULL, NULL, NULL, NULL),
(29, 'b3cc78a8d1a0c5dbad0e81040e2b9f1e', '12ba1bd0d23777ed18f98c8567de99f8', NULL, NULL, 1, 'produit/MESA-R', 'MESA-R.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/MESA-R/MESA-R.jpg', '', '', NULL, NULL, 2, 'unknown', NULL, '2026-01-18 19:49:49', '2026-01-19 01:49:49', 1, NULL, NULL, NULL, NULL),
(30, 'b1b4526375d2dab7581e8afa4d53b378', 'a739193639749061c617f14b6c4ec48f', NULL, NULL, 1, 'produit/PISTA-P', 'PISTA-P.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/PISTA-P/PISTA-P.jpg', '', '', NULL, NULL, 1, 'unknown', NULL, '2026-01-18 19:49:49', '2026-01-19 01:49:49', 1, NULL, NULL, NULL, NULL),
(31, '4b36d229e0f45a0a5b9d07dfe7e3930c', '3f6e26afa7a866cbb48219dfa5f49a7a', NULL, NULL, 1, 'produit/C15X15-4A', 'C15X15-4A.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/C15X15-4A/C15X15-4A.jpg', '', '', NULL, NULL, 1, 'unknown', NULL, '2026-01-18 19:57:23', '2026-01-19 01:57:23', 1, NULL, NULL, NULL, NULL),
(32, 'b46ec4713346789dc7a5372db8f33f2e', '6c46317939e3b4bfa013bd25ef3404e9', NULL, NULL, 1, 'produit/P-BA', 'P-BA.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/P-BA/P-BA.jpg', '', '', NULL, NULL, 1, 'unknown', NULL, '2026-01-18 20:17:55', '2026-01-19 02:17:55', 1, NULL, NULL, NULL, NULL),
(33, 'f93a7c1f04a05915ff6ca5c5d98fcc1c', 'caffc1ebcd9f0a1ae2081c206cddd916', NULL, NULL, 1, 'produit/SL-B', 'SL-B.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/SL-B/SL-B.jpg', '', '', NULL, NULL, 1, 'unknown', NULL, '2026-01-20 02:31:40', '2026-01-20 08:31:40', 1, NULL, NULL, NULL, NULL),
(34, '4493606dfcbfa9ebf082564db3eda10b', 'e5d433fb3f6ab480885b6748b40bca04', NULL, NULL, 1, 'produit/MR-V', 'MR-V.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/MR-V/MR-V.jpg', '', '', NULL, NULL, 1, 'unknown', NULL, '2026-01-20 02:32:11', '2026-01-20 08:32:11', 1, NULL, NULL, NULL, NULL),
(35, 'e4eddf612a815999fd9b70eb80b84284', '4c8f4b1b833c8403089fb692e2314c4e', NULL, NULL, 1, 'produit/C12A-3H', 'C12A-3H.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/C12A-3H/C12A-3H.jpg', '', '', NULL, NULL, 1, 'unknown', NULL, '2026-01-20 02:33:51', '2026-01-20 08:33:51', 1, NULL, NULL, NULL, NULL),
(36, '811860f62f375b8b99889035e400fdc9', '78f3a87cf22bd810a8d2c3c0f9f2df05', NULL, NULL, 1, 'produit/CM10A-3H', 'CM10A-3H.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/CM10A-3H/CM10A-3H.jpg', '', '', NULL, NULL, 1, 'unknown', NULL, '2026-01-20 02:34:45', '2026-01-20 08:34:45', 1, NULL, NULL, NULL, NULL),
(37, '642afde45fa6ec791ed4c1c9bd305ba2', '2e3cdaf796dca10954c25babbfac3bb5', NULL, NULL, 1, 'produit/CM8A3H-A', 'CM8A3H-A.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/CM8A3H-A/CM8A3H-A.jpg', '', '', NULL, NULL, 1, 'unknown', NULL, '2026-01-20 02:35:05', '2026-01-20 08:35:05', 1, NULL, NULL, NULL, NULL),
(38, '43fcb1691a8c416ce81deea3e2c1e559', 'ae1436d2f70ae0c44fc02549d77e2c40', NULL, NULL, 1, 'produit/C15A-HL', 'C15A-HL.jpg', 'product', 17, NULL, 'C15A-HL.jpg', '', '', NULL, NULL, 1, 'uploaded', NULL, '2026-01-20 02:39:07', '2026-01-20 08:39:07', 1, NULL, NULL, NULL, NULL),
(39, '6e639481690375b90be39d2336c1e0ca', '5eb27236cac1948ac7308db0c629fff3', NULL, NULL, 1, 'produit/PLFN-C', 'PLFN-C.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/PLFN-C/PLFN-C.jpg', '', '', NULL, NULL, 1, 'unknown', NULL, '2026-01-20 02:41:28', '2026-01-20 08:41:28', 1, NULL, NULL, NULL, NULL),
(40, '48c0a6b5069e521f0d6d9ac5e5bf2d79', 'd7bddaf29c0f15ae625b0c3ecd2ab812', NULL, NULL, 1, 'produit/INFL-TORO', 'INFL-TORO.jpg', 'product', 19, NULL, 'INFL-TORO.jpg', '', '', NULL, NULL, 1, 'uploaded', NULL, '2026-01-20 02:43:48', '2026-01-20 08:43:48', 1, NULL, NULL, NULL, NULL),
(41, '13856e48c83be172c56e8f8870e34946', '649ab5ffe0d45d41b5fb67be0edf2aea', NULL, NULL, 1, 'produit/INFL-CASTILLO', 'INFL-CASTILLO.jpg', 'product', 20, NULL, 'INFL-CASTILLO.jpg', '', '', NULL, NULL, 1, 'uploaded', NULL, '2026-01-20 02:49:44', '2026-01-20 08:49:44', 1, NULL, NULL, NULL, NULL),
(42, '4b2d82eb15b3a1c2429801445c28bc56', 'b99cd8e5e34bf25b85aea72852bc694c', NULL, NULL, 1, 'produit/TBLN', 'TBLN.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/TBLN/TBLN.jpg', '', '', NULL, NULL, 1, 'unknown', NULL, '2026-01-20 02:50:39', '2026-01-20 08:50:39', 1, NULL, NULL, NULL, NULL),
(43, '4534b3a7564fec265dfb847f9774c647', '540def287d220aa04dcc54a022b47fe2', NULL, NULL, 1, 'produit/MCI', 'MCI.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/MCI/MCI.jpg', '', '', NULL, NULL, 1, 'unknown', NULL, '2026-01-20 02:51:14', '2026-01-20 08:51:14', 1, NULL, NULL, NULL, NULL),
(44, 'f9c64ed7d088bf24146bef06ab8e6cdd', 'd217bdcfda1c392464d5eaaa3325834a', NULL, NULL, 1, 'produit/SILLA-PLASTICO-N', 'SILLA-PLASTICO-N.jpg', NULL, NULL, NULL, 'C:/xampp/htdocs/dolibarr/documents/produit/SILLA-PLASTICO-N/SILLA-PLASTICO-N.jpg', '', '', NULL, NULL, 1, 'unknown', NULL, '2026-01-20 02:51:42', '2026-01-20 08:51:42', 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_ecm_files_extrafields`
--

CREATE TABLE `llx_ecm_files_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_element_categorie`
--

CREATE TABLE `llx_element_categorie` (
  `rowid` int(11) NOT NULL,
  `fk_categorie` int(11) NOT NULL,
  `fk_element` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_element_contact`
--

CREATE TABLE `llx_element_contact` (
  `rowid` int(11) NOT NULL,
  `datecreate` datetime DEFAULT NULL,
  `statut` smallint(6) DEFAULT 5,
  `element_id` int(11) NOT NULL,
  `fk_c_type_contact` int(11) NOT NULL,
  `fk_socpeople` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_element_element`
--

CREATE TABLE `llx_element_element` (
  `rowid` int(11) NOT NULL,
  `fk_source` int(11) NOT NULL,
  `sourcetype` varchar(64) NOT NULL,
  `fk_target` int(11) NOT NULL,
  `targettype` varchar(64) NOT NULL,
  `relationtype` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_element_resources`
--

CREATE TABLE `llx_element_resources` (
  `rowid` int(11) NOT NULL,
  `element_id` int(11) DEFAULT NULL,
  `element_type` varchar(64) DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `resource_type` varchar(64) DEFAULT NULL,
  `busy` int(11) DEFAULT NULL,
  `mandatory` int(11) DEFAULT NULL,
  `duree` double DEFAULT NULL,
  `fk_user_create` int(11) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_element_time`
--

CREATE TABLE `llx_element_time` (
  `rowid` int(11) NOT NULL,
  `ref_ext` varchar(32) DEFAULT NULL,
  `fk_element` int(11) NOT NULL,
  `elementtype` varchar(32) NOT NULL,
  `element_date` date DEFAULT NULL,
  `element_datehour` datetime DEFAULT NULL,
  `element_date_withhour` int(11) DEFAULT NULL,
  `element_duration` double DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `thm` double(24,8) DEFAULT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `invoice_line_id` int(11) DEFAULT NULL,
  `intervention_id` int(11) DEFAULT NULL,
  `intervention_line_id` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_emailcollector_emailcollector`
--

CREATE TABLE `llx_emailcollector_emailcollector` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref` varchar(128) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `port` varchar(10) DEFAULT '993',
  `hostcharset` varchar(16) DEFAULT 'UTF-8',
  `imap_encryption` varchar(16) DEFAULT 'ssl',
  `norsh` int(11) DEFAULT 0,
  `login` varchar(128) DEFAULT NULL,
  `acces_type` int(11) DEFAULT 0,
  `oauth_service` varchar(128) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `source_directory` varchar(255) NOT NULL DEFAULT 'Inbox',
  `target_directory` varchar(255) DEFAULT NULL,
  `maxemailpercollect` int(11) DEFAULT 100,
  `datelastresult` datetime DEFAULT NULL,
  `codelastresult` varchar(16) DEFAULT NULL,
  `lastresult` text DEFAULT NULL,
  `datelastok` datetime DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `import_key` varchar(14) DEFAULT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_emailcollector_emailcollectoraction`
--

CREATE TABLE `llx_emailcollector_emailcollectoraction` (
  `rowid` int(11) NOT NULL,
  `fk_emailcollector` int(11) NOT NULL,
  `type` varchar(128) NOT NULL,
  `actionparam` text DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT 0,
  `import_key` varchar(14) DEFAULT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_emailcollector_emailcollectorfilter`
--

CREATE TABLE `llx_emailcollector_emailcollectorfilter` (
  `rowid` int(11) NOT NULL,
  `fk_emailcollector` int(11) NOT NULL,
  `type` varchar(128) NOT NULL,
  `rulevalue` varchar(128) DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_entrepot`
--

CREATE TABLE `llx_entrepot` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(255) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_project` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `lieu` varchar(64) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `fk_departement` int(11) DEFAULT NULL,
  `fk_pays` int(11) DEFAULT 0,
  `phone` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `barcode` varchar(180) DEFAULT NULL,
  `fk_barcode_type` int(11) DEFAULT NULL,
  `warehouse_usage` int(11) DEFAULT 1,
  `statut` tinyint(4) DEFAULT 1,
  `fk_user_author` int(11) DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `fk_parent` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_entrepot`
--

INSERT INTO `llx_entrepot` (`rowid`, `ref`, `datec`, `tms`, `entity`, `fk_project`, `description`, `lieu`, `address`, `zip`, `town`, `fk_departement`, `fk_pays`, `phone`, `fax`, `barcode`, `fk_barcode_type`, `warehouse_usage`, `statut`, `fk_user_author`, `model_pdf`, `import_key`, `fk_parent`) VALUES
(3, 'ALM-GRAL', '2025-12-31 04:30:22', '2025-12-31 03:30:22', 1, NULL, '', 'Almacén Principal', '', '', '', NULL, 154, '', '', NULL, NULL, 1, 1, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_entrepot_extrafields`
--

CREATE TABLE `llx_entrepot_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_establishment`
--

CREATE TABLE `llx_establishment` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref` varchar(30) DEFAULT NULL,
  `label` varchar(255) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `zip` varchar(25) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `fk_state` int(11) DEFAULT 0,
  `fk_country` int(11) DEFAULT 0,
  `profid1` varchar(20) DEFAULT NULL,
  `profid2` varchar(20) DEFAULT NULL,
  `profid3` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `fk_user_author` int(11) NOT NULL,
  `fk_user_mod` int(11) DEFAULT NULL,
  `datec` datetime NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_eventorganization_conferenceorboothattendee`
--

CREATE TABLE `llx_eventorganization_conferenceorboothattendee` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(128) NOT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_actioncomm` int(11) DEFAULT NULL,
  `fk_project` int(11) NOT NULL,
  `fk_invoice` int(11) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `email_company` varchar(128) DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `date_subscription` datetime DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `ip` varchar(250) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `status` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_eventorganization_conferenceorboothattendee_extrafields`
--

CREATE TABLE `llx_eventorganization_conferenceorboothattendee_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_events`
--

CREATE TABLE `llx_events` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `type` varchar(32) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `prefix_session` varchar(255) DEFAULT NULL,
  `dateevent` datetime DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `description` varchar(250) NOT NULL,
  `ip` varchar(250) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `fk_object` int(11) DEFAULT NULL,
  `authentication_method` varchar(64) DEFAULT NULL,
  `fk_oauth_token` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_event_element`
--

CREATE TABLE `llx_event_element` (
  `rowid` int(11) NOT NULL,
  `fk_source` int(11) NOT NULL,
  `fk_target` int(11) NOT NULL,
  `targettype` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_expedition`
--

CREATE TABLE `llx_expedition` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `ref_ext` varchar(255) DEFAULT NULL,
  `ref_customer` varchar(255) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `date_delivery` datetime DEFAULT NULL,
  `date_expedition` datetime DEFAULT NULL,
  `fk_address` int(11) DEFAULT NULL,
  `fk_shipping_method` int(11) DEFAULT NULL,
  `tracking_number` varchar(50) DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT 0,
  `billed` smallint(6) DEFAULT 0,
  `height` float DEFAULT NULL,
  `width` float DEFAULT NULL,
  `size_units` int(11) DEFAULT NULL,
  `size` float DEFAULT NULL,
  `weight_units` int(11) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `signed_status` smallint(6) DEFAULT NULL,
  `online_sign_ip` varchar(48) DEFAULT NULL,
  `online_sign_name` varchar(64) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_expeditiondet`
--

CREATE TABLE `llx_expeditiondet` (
  `rowid` int(11) NOT NULL,
  `fk_expedition` int(11) NOT NULL,
  `fk_element` int(11) DEFAULT NULL,
  `fk_elementdet` int(11) DEFAULT NULL,
  `element_type` varchar(50) NOT NULL DEFAULT 'commande',
  `fk_product` int(11) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `fk_unit` int(11) DEFAULT NULL,
  `fk_entrepot` int(11) DEFAULT NULL,
  `rang` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_expeditiondet_batch`
--

CREATE TABLE `llx_expeditiondet_batch` (
  `rowid` int(11) NOT NULL,
  `fk_expeditiondet` int(11) NOT NULL,
  `eatby` date DEFAULT NULL,
  `sellby` date DEFAULT NULL,
  `batch` varchar(128) DEFAULT NULL,
  `qty` double NOT NULL DEFAULT 0,
  `fk_origin_stock` int(11) NOT NULL,
  `fk_warehouse` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_expeditiondet_extrafields`
--

CREATE TABLE `llx_expeditiondet_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_expedition_extrafields`
--

CREATE TABLE `llx_expedition_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_expedition_package`
--

CREATE TABLE `llx_expedition_package` (
  `rowid` int(11) NOT NULL,
  `fk_expedition` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `value` double(24,8) DEFAULT 0.00000000,
  `fk_package_type` int(11) DEFAULT NULL,
  `height` float DEFAULT NULL,
  `width` float DEFAULT NULL,
  `size` float DEFAULT NULL,
  `size_units` int(11) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `weight_units` int(11) DEFAULT NULL,
  `dangerous_goods` varchar(20) DEFAULT '0',
  `tail_lift` smallint(6) DEFAULT 0,
  `rang` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_expensereport`
--

CREATE TABLE `llx_expensereport` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(50) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref_number_int` int(11) DEFAULT NULL,
  `ref_ext` int(11) DEFAULT NULL,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `localtax1` double(24,8) DEFAULT 0.00000000,
  `localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `date_create` datetime NOT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_approve` datetime DEFAULT NULL,
  `date_refuse` datetime DEFAULT NULL,
  `date_cancel` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_author` int(11) NOT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_validator` int(11) DEFAULT NULL,
  `fk_user_approve` int(11) DEFAULT NULL,
  `fk_user_refuse` int(11) DEFAULT NULL,
  `fk_user_cancel` int(11) DEFAULT NULL,
  `fk_statut` int(11) NOT NULL,
  `fk_c_paiement` int(11) DEFAULT NULL,
  `paid` smallint(6) NOT NULL DEFAULT 0,
  `note_public` text DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `detail_refuse` varchar(255) DEFAULT NULL,
  `detail_cancel` varchar(255) DEFAULT NULL,
  `integration_compta` int(11) DEFAULT NULL,
  `fk_bank_account` int(11) DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_expensereport_det`
--

CREATE TABLE `llx_expensereport_det` (
  `rowid` int(11) NOT NULL,
  `fk_expensereport` int(11) NOT NULL,
  `docnumber` varchar(128) DEFAULT NULL,
  `fk_c_type_fees` int(11) NOT NULL,
  `fk_c_exp_tax_cat` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `comments` text NOT NULL,
  `product_type` int(11) DEFAULT -1,
  `qty` double NOT NULL,
  `subprice` double(24,8) NOT NULL DEFAULT 0.00000000,
  `subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `value_unit` double(24,8) NOT NULL,
  `remise_percent` double DEFAULT NULL,
  `vat_src_code` varchar(10) DEFAULT '',
  `tva_tx` double(7,4) DEFAULT NULL,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) DEFAULT NULL,
  `total_ht` double(24,8) NOT NULL DEFAULT 0.00000000,
  `total_tva` double(24,8) NOT NULL DEFAULT 0.00000000,
  `total_localtax1` double(24,8) DEFAULT 0.00000000,
  `total_localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) NOT NULL DEFAULT 0.00000000,
  `date` date NOT NULL,
  `info_bits` int(11) DEFAULT 0,
  `special_code` int(11) DEFAULT 0,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT 0.00000000,
  `multicurrency_subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000,
  `fk_facture` int(11) DEFAULT 0,
  `fk_ecm_files` int(11) DEFAULT NULL,
  `fk_code_ventilation` int(11) DEFAULT 0,
  `rang` int(11) DEFAULT 0,
  `import_key` varchar(14) DEFAULT NULL,
  `rule_warning_message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_expensereport_extrafields`
--

CREATE TABLE `llx_expensereport_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_export_model`
--

CREATE TABLE `llx_export_model` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) DEFAULT 0,
  `fk_user` int(11) NOT NULL DEFAULT 0,
  `label` varchar(50) NOT NULL,
  `type` varchar(64) NOT NULL,
  `field` text NOT NULL,
  `filter` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_extrafields`
--

CREATE TABLE `llx_extrafields` (
  `rowid` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `elementtype` varchar(64) NOT NULL DEFAULT 'member',
  `label` varchar(255) NOT NULL,
  `type` varchar(8) DEFAULT NULL,
  `size` varchar(8) DEFAULT NULL,
  `fieldcomputed` text DEFAULT NULL,
  `fielddefault` text DEFAULT NULL,
  `fieldunique` int(11) DEFAULT 0,
  `fieldrequired` int(11) DEFAULT 0,
  `perms` varchar(255) DEFAULT NULL,
  `enabled` varchar(255) DEFAULT NULL,
  `module` varchar(64) DEFAULT NULL,
  `pos` int(11) DEFAULT 0,
  `alwayseditable` int(11) DEFAULT 0,
  `param` text DEFAULT NULL,
  `list` varchar(255) DEFAULT '1',
  `printable` int(11) DEFAULT 0,
  `totalizable` tinyint(1) DEFAULT 0,
  `langs` varchar(64) DEFAULT NULL,
  `help` text DEFAULT NULL,
  `css` varchar(128) DEFAULT NULL,
  `cssview` varchar(128) DEFAULT NULL,
  `csslist` varchar(128) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facture`
--

CREATE TABLE `llx_facture` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref_ext` varchar(255) DEFAULT NULL,
  `ref_client` varchar(255) DEFAULT NULL,
  `type` smallint(6) NOT NULL DEFAULT 0,
  `subtype` smallint(6) DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `datef` date DEFAULT NULL,
  `date_pointoftax` date DEFAULT NULL,
  `date_valid` date DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_closing` datetime DEFAULT NULL,
  `paye` smallint(6) NOT NULL DEFAULT 0,
  `remise_percent` double DEFAULT 0,
  `remise_absolue` double DEFAULT 0,
  `remise` double DEFAULT 0,
  `close_code` varchar(16) DEFAULT NULL,
  `close_missing_amount` double(24,8) DEFAULT NULL,
  `close_note` varchar(128) DEFAULT NULL,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `localtax1` double(24,8) DEFAULT 0.00000000,
  `localtax2` double(24,8) DEFAULT 0.00000000,
  `revenuestamp` double(24,8) DEFAULT 0.00000000,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `fk_statut` smallint(6) NOT NULL DEFAULT 0,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_closing` int(11) DEFAULT NULL,
  `module_source` varchar(32) DEFAULT NULL,
  `pos_source` varchar(32) DEFAULT NULL,
  `fk_fac_rec_source` int(11) DEFAULT NULL,
  `fk_facture_source` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `increment` varchar(10) DEFAULT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `fk_currency` varchar(3) DEFAULT NULL,
  `fk_cond_reglement` int(11) NOT NULL DEFAULT 1,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `date_lim_reglement` date DEFAULT NULL,
  `payment_reference` varchar(25) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) DEFAULT NULL,
  `fk_transport_mode` int(11) DEFAULT NULL,
  `prorata_discount` double DEFAULT NULL,
  `situation_cycle_ref` int(11) DEFAULT NULL,
  `situation_counter` smallint(6) DEFAULT NULL,
  `situation_final` smallint(6) DEFAULT NULL,
  `retained_warranty` double DEFAULT NULL,
  `retained_warranty_date_limit` date DEFAULT NULL,
  `retained_warranty_fk_cond_reglement` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL,
  `is_also_delivery_note` tinyint(4) NOT NULL DEFAULT 0,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facturedet`
--

CREATE TABLE `llx_facturedet` (
  `rowid` int(11) NOT NULL,
  `fk_facture` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `vat_src_code` varchar(10) DEFAULT '',
  `tva_tx` double(7,4) DEFAULT NULL,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT 0,
  `remise` double DEFAULT 0,
  `fk_remise_except` int(11) DEFAULT NULL,
  `subprice` double(24,8) DEFAULT NULL,
  `subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `price` double(24,8) DEFAULT NULL,
  `total_ht` double(24,8) DEFAULT NULL,
  `total_tva` double(24,8) DEFAULT NULL,
  `total_localtax1` double(24,8) DEFAULT 0.00000000,
  `total_localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT NULL,
  `product_type` int(11) DEFAULT 0,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT 0,
  `buy_price_ht` double(24,8) DEFAULT 0.00000000,
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `batch` varchar(128) DEFAULT NULL,
  `fk_warehouse` int(11) DEFAULT NULL,
  `special_code` int(11) DEFAULT 0,
  `rang` int(11) DEFAULT 0,
  `fk_contract_line` int(11) DEFAULT NULL,
  `fk_unit` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `fk_code_ventilation` int(11) NOT NULL DEFAULT 0,
  `situation_percent` double DEFAULT 100,
  `fk_prev_id` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT 0.00000000,
  `multicurrency_subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000,
  `ref_ext` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facturedet_extrafields`
--

CREATE TABLE `llx_facturedet_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facturedet_rec`
--

CREATE TABLE `llx_facturedet_rec` (
  `rowid` int(11) NOT NULL,
  `fk_facture` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `product_type` int(11) DEFAULT 0,
  `label` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `vat_src_code` varchar(10) DEFAULT '',
  `tva_tx` double(7,4) DEFAULT NULL,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT 0,
  `remise` double DEFAULT 0,
  `subprice` double(24,8) NOT NULL DEFAULT 0.00000000,
  `subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `price` double(24,8) DEFAULT NULL,
  `total_ht` double(24,8) DEFAULT NULL,
  `total_tva` double(24,8) DEFAULT NULL,
  `total_localtax1` double(24,8) DEFAULT 0.00000000,
  `total_localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT NULL,
  `date_start_fill` int(11) DEFAULT 0,
  `date_end_fill` int(11) DEFAULT 0,
  `info_bits` int(11) DEFAULT 0,
  `buy_price_ht` double(24,8) DEFAULT 0.00000000,
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `special_code` int(10) UNSIGNED DEFAULT 0,
  `rang` int(11) DEFAULT 0,
  `fk_contract_line` int(11) DEFAULT NULL,
  `fk_unit` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT 0.00000000,
  `multicurrency_subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facturedet_rec_extrafields`
--

CREATE TABLE `llx_facturedet_rec_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facture_extrafields`
--

CREATE TABLE `llx_facture_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facture_fourn`
--

CREATE TABLE `llx_facture_fourn` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(180) NOT NULL,
  `ref_supplier` varchar(180) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref_ext` varchar(255) DEFAULT NULL,
  `type` smallint(6) NOT NULL DEFAULT 0,
  `subtype` smallint(6) DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `datef` date DEFAULT NULL,
  `date_pointoftax` date DEFAULT NULL,
  `date_valid` date DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_closing` datetime DEFAULT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `paye` smallint(6) NOT NULL DEFAULT 0,
  `amount` double(24,8) NOT NULL DEFAULT 0.00000000,
  `remise` double(24,8) DEFAULT 0.00000000,
  `close_code` varchar(16) DEFAULT NULL,
  `close_missing_amount` double(24,8) DEFAULT NULL,
  `close_note` varchar(128) DEFAULT NULL,
  `vat_reverse_charge` tinyint(4) DEFAULT 0,
  `tva` double(24,8) DEFAULT 0.00000000,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `localtax1` double(24,8) DEFAULT 0.00000000,
  `localtax2` double(24,8) DEFAULT 0.00000000,
  `revenuestamp` double(24,8) DEFAULT 0.00000000,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `fk_statut` smallint(6) NOT NULL DEFAULT 0,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_closing` int(11) DEFAULT NULL,
  `fk_fac_rec_source` int(11) DEFAULT NULL,
  `fk_facture_source` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `date_lim_reglement` date DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) DEFAULT NULL,
  `fk_transport_mode` int(11) DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facture_fourn_det`
--

CREATE TABLE `llx_facture_fourn_det` (
  `rowid` int(11) NOT NULL,
  `fk_facture_fourn` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `ref` varchar(128) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `pu_ht` double(24,8) DEFAULT NULL,
  `pu_ttc` double(24,8) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT 0,
  `fk_remise_except` int(11) DEFAULT NULL,
  `vat_src_code` varchar(10) DEFAULT '',
  `tva_tx` double(7,4) DEFAULT NULL,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) DEFAULT NULL,
  `total_ht` double(24,8) DEFAULT NULL,
  `tva` double(24,8) DEFAULT NULL,
  `total_localtax1` double(24,8) DEFAULT 0.00000000,
  `total_localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT NULL,
  `product_type` int(11) DEFAULT 0,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT 0,
  `fk_code_ventilation` int(11) NOT NULL DEFAULT 0,
  `special_code` int(11) DEFAULT 0,
  `rang` int(11) DEFAULT 0,
  `import_key` varchar(14) DEFAULT NULL,
  `fk_unit` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT 0.00000000,
  `multicurrency_subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facture_fourn_det_extrafields`
--

CREATE TABLE `llx_facture_fourn_det_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facture_fourn_det_rec`
--

CREATE TABLE `llx_facture_fourn_det_rec` (
  `rowid` int(11) NOT NULL,
  `fk_facture_fourn` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `ref` varchar(50) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `pu_ht` double(24,8) DEFAULT NULL,
  `pu_ttc` double(24,8) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT 0,
  `fk_remise_except` int(11) DEFAULT NULL,
  `vat_src_code` varchar(10) DEFAULT '',
  `tva_tx` double(7,4) DEFAULT NULL,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) DEFAULT NULL,
  `total_ht` double(24,8) DEFAULT NULL,
  `total_tva` double(24,8) DEFAULT NULL,
  `total_localtax1` double(24,8) DEFAULT 0.00000000,
  `total_localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT NULL,
  `product_type` int(11) DEFAULT 0,
  `date_start` int(11) DEFAULT NULL,
  `date_end` int(11) DEFAULT NULL,
  `info_bits` int(11) DEFAULT 0,
  `special_code` int(10) UNSIGNED DEFAULT 0,
  `rang` int(11) DEFAULT 0,
  `fk_unit` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT 0.00000000,
  `multicurrency_subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facture_fourn_det_rec_extrafields`
--

CREATE TABLE `llx_facture_fourn_det_rec_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facture_fourn_extrafields`
--

CREATE TABLE `llx_facture_fourn_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facture_fourn_rec`
--

CREATE TABLE `llx_facture_fourn_rec` (
  `rowid` int(11) NOT NULL,
  `titre` varchar(200) NOT NULL,
  `ref_supplier` varchar(180) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `subtype` smallint(6) DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `suspended` int(11) DEFAULT 0,
  `libelle` varchar(255) DEFAULT NULL,
  `amount` double(24,8) NOT NULL DEFAULT 0.00000000,
  `remise` double DEFAULT 0,
  `vat_src_code` varchar(10) DEFAULT '',
  `localtax1` double(24,8) DEFAULT 0.00000000,
  `localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `date_lim_reglement` date DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `modelpdf` varchar(255) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000,
  `usenewprice` int(11) DEFAULT 0,
  `frequency` int(11) DEFAULT NULL,
  `unit_frequency` varchar(2) DEFAULT 'm',
  `date_when` datetime DEFAULT NULL,
  `date_last_gen` datetime DEFAULT NULL,
  `nb_gen_done` int(11) DEFAULT NULL,
  `nb_gen_max` int(11) DEFAULT NULL,
  `auto_validate` int(11) DEFAULT 0,
  `generate_pdf` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facture_fourn_rec_extrafields`
--

CREATE TABLE `llx_facture_fourn_rec_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facture_rec`
--

CREATE TABLE `llx_facture_rec` (
  `rowid` int(11) NOT NULL,
  `titre` varchar(200) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `subtype` smallint(6) DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `suspended` int(11) DEFAULT 0,
  `amount` double(24,8) NOT NULL DEFAULT 0.00000000,
  `remise` double DEFAULT 0,
  `remise_percent` double DEFAULT 0,
  `remise_absolue` double DEFAULT 0,
  `vat_src_code` varchar(10) DEFAULT '',
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `localtax1` double(24,8) DEFAULT 0.00000000,
  `localtax2` double(24,8) DEFAULT 0.00000000,
  `revenuestamp` double(24,8) DEFAULT 0.00000000,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_cond_reglement` int(11) NOT NULL DEFAULT 1,
  `fk_mode_reglement` int(11) DEFAULT 0,
  `date_lim_reglement` date DEFAULT NULL,
  `fk_account` int(11) DEFAULT NULL,
  `fk_societe_rib` int(11) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `modelpdf` varchar(255) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000,
  `usenewprice` int(11) DEFAULT 0,
  `frequency` int(11) DEFAULT NULL,
  `unit_frequency` varchar(2) DEFAULT 'm',
  `date_when` datetime DEFAULT NULL,
  `date_last_gen` datetime DEFAULT NULL,
  `nb_gen_done` int(11) DEFAULT NULL,
  `nb_gen_max` int(11) DEFAULT NULL,
  `auto_validate` int(11) DEFAULT 0,
  `generate_pdf` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_facture_rec_extrafields`
--

CREATE TABLE `llx_facture_rec_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_fichinter`
--

CREATE TABLE `llx_fichinter` (
  `rowid` int(11) NOT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT 0,
  `fk_contrat` int(11) DEFAULT 0,
  `ref` varchar(30) NOT NULL,
  `ref_ext` varchar(255) DEFAULT NULL,
  `ref_client` varchar(255) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `datei` date DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT 0,
  `dateo` date DEFAULT NULL,
  `datee` date DEFAULT NULL,
  `datet` date DEFAULT NULL,
  `duree` double DEFAULT NULL,
  `description` text DEFAULT NULL,
  `signed_status` smallint(6) DEFAULT NULL,
  `online_sign_ip` varchar(48) DEFAULT NULL,
  `online_sign_name` varchar(64) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_fichinterdet`
--

CREATE TABLE `llx_fichinterdet` (
  `rowid` int(11) NOT NULL,
  `fk_fichinter` int(11) DEFAULT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `description` text DEFAULT NULL,
  `duree` int(11) DEFAULT NULL,
  `rang` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_fichinterdet_extrafields`
--

CREATE TABLE `llx_fichinterdet_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_fichinterdet_rec`
--

CREATE TABLE `llx_fichinterdet_rec` (
  `rowid` int(11) NOT NULL,
  `fk_fichinter` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `description` text DEFAULT NULL,
  `duree` int(11) DEFAULT NULL,
  `rang` int(11) DEFAULT 0,
  `total_ht` double(24,8) DEFAULT NULL,
  `subprice` double(24,8) DEFAULT NULL,
  `subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `tva_tx` double(6,3) DEFAULT NULL,
  `localtax1_tx` double(6,3) DEFAULT 0.000,
  `localtax1_type` varchar(1) DEFAULT NULL,
  `localtax2_tx` double(6,3) DEFAULT 0.000,
  `localtax2_type` varchar(1) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT 0,
  `fk_remise_except` int(11) DEFAULT NULL,
  `price` double(24,8) DEFAULT NULL,
  `total_tva` double(24,8) DEFAULT NULL,
  `total_localtax1` double(24,8) DEFAULT 0.00000000,
  `total_localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT NULL,
  `product_type` int(11) DEFAULT 0,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT 0,
  `buy_price_ht` double(24,8) DEFAULT 0.00000000,
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `fk_code_ventilation` int(11) NOT NULL DEFAULT 0,
  `special_code` int(10) UNSIGNED DEFAULT 0,
  `fk_unit` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_fichinter_extrafields`
--

CREATE TABLE `llx_fichinter_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_fichinter_rec`
--

CREATE TABLE `llx_fichinter_rec` (
  `rowid` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_soc` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `fk_contrat` int(11) DEFAULT 0,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `duree` double DEFAULT NULL,
  `description` text DEFAULT NULL,
  `modelpdf` varchar(255) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `unit_frequency` varchar(2) DEFAULT 'm',
  `date_when` datetime DEFAULT NULL,
  `date_last_gen` datetime DEFAULT NULL,
  `nb_gen_done` int(11) DEFAULT NULL,
  `nb_gen_max` int(11) DEFAULT NULL,
  `auto_validate` int(11) DEFAULT NULL,
  `status` smallint(6) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_holiday`
--

CREATE TABLE `llx_holiday` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(30) NOT NULL,
  `ref_ext` varchar(255) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_user` int(11) NOT NULL,
  `fk_user_create` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_type` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  `description` varchar(255) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `halfday` int(11) DEFAULT 0,
  `nb_open_day` double(24,8) DEFAULT NULL,
  `statut` int(11) NOT NULL DEFAULT 1,
  `fk_validator` int(11) NOT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `date_approval` datetime DEFAULT NULL,
  `fk_user_approve` int(11) DEFAULT NULL,
  `date_refuse` datetime DEFAULT NULL,
  `fk_user_refuse` int(11) DEFAULT NULL,
  `date_cancel` datetime DEFAULT NULL,
  `fk_user_cancel` int(11) DEFAULT NULL,
  `detail_refuse` varchar(250) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_holiday_config`
--

CREATE TABLE `llx_holiday_config` (
  `rowid` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_holiday_config`
--

INSERT INTO `llx_holiday_config` (`rowid`, `name`, `value`) VALUES
(1, 'lastUpdate', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_holiday_extrafields`
--

CREATE TABLE `llx_holiday_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_holiday_logs`
--

CREATE TABLE `llx_holiday_logs` (
  `rowid` int(11) NOT NULL,
  `date_action` datetime NOT NULL,
  `fk_user_action` int(11) NOT NULL,
  `fk_user_update` int(11) NOT NULL,
  `fk_type` int(11) NOT NULL,
  `type_action` varchar(255) NOT NULL,
  `prev_solde` varchar(255) NOT NULL,
  `new_solde` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_holiday_users`
--

CREATE TABLE `llx_holiday_users` (
  `fk_user` int(11) NOT NULL,
  `fk_type` int(11) NOT NULL,
  `nb_holiday` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_import_model`
--

CREATE TABLE `llx_import_model` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 0,
  `fk_user` int(11) NOT NULL DEFAULT 0,
  `label` varchar(50) NOT NULL,
  `type` varchar(64) NOT NULL,
  `field` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_inventory`
--

CREATE TABLE `llx_inventory` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) DEFAULT 0,
  `ref` varchar(48) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_warehouse` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `categories_product` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `title` varchar(255) NOT NULL,
  `date_inventory` datetime DEFAULT NULL,
  `date_validation` datetime DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_inventorydet`
--

CREATE TABLE `llx_inventorydet` (
  `rowid` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_inventory` int(11) DEFAULT 0,
  `fk_warehouse` int(11) DEFAULT 0,
  `fk_product` int(11) DEFAULT 0,
  `batch` varchar(128) DEFAULT NULL,
  `qty_stock` double DEFAULT NULL,
  `qty_view` double DEFAULT NULL,
  `qty_regulated` double DEFAULT NULL,
  `pmp_real` double DEFAULT NULL,
  `pmp_expected` double DEFAULT NULL,
  `fk_movement` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_inventory_extrafields`
--

CREATE TABLE `llx_inventory_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_links`
--

CREATE TABLE `llx_links` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `datea` datetime NOT NULL,
  `url` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `objecttype` varchar(255) NOT NULL,
  `objectid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_localtax`
--

CREATE TABLE `llx_localtax` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `localtaxtype` tinyint(4) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datep` date DEFAULT NULL,
  `datev` date DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `fk_bank` int(11) DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_mailing_unsubscribe`
--

CREATE TABLE `llx_mailing_unsubscribe` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `email` varchar(255) DEFAULT NULL,
  `unsubscribegroup` varchar(128) DEFAULT '',
  `ip` varchar(128) DEFAULT NULL,
  `date_creat` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_menu`
--

CREATE TABLE `llx_menu` (
  `rowid` int(11) NOT NULL,
  `menu_handler` varchar(16) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `module` varchar(255) DEFAULT NULL,
  `type` varchar(4) NOT NULL,
  `mainmenu` varchar(100) NOT NULL,
  `leftmenu` varchar(100) DEFAULT NULL,
  `fk_menu` int(11) NOT NULL,
  `fk_mainmenu` varchar(100) DEFAULT NULL,
  `fk_leftmenu` varchar(100) DEFAULT NULL,
  `position` int(11) NOT NULL,
  `url` text NOT NULL,
  `target` varchar(100) DEFAULT NULL,
  `titre` varchar(255) NOT NULL,
  `prefix` varchar(255) DEFAULT NULL,
  `langs` varchar(100) DEFAULT NULL,
  `level` smallint(6) DEFAULT NULL,
  `perms` text DEFAULT NULL,
  `enabled` text DEFAULT NULL,
  `usertype` int(11) NOT NULL DEFAULT 0,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_menu`
--

INSERT INTO `llx_menu` (`rowid`, `menu_handler`, `entity`, `module`, `type`, `mainmenu`, `leftmenu`, `fk_menu`, `fk_mainmenu`, `fk_leftmenu`, `position`, `url`, `target`, `titre`, `prefix`, `langs`, `level`, `perms`, `enabled`, `usertype`, `tms`) VALUES
(1, 'all', 1, 'agenda', 'top', 'agenda', NULL, 0, NULL, NULL, 86, '/comm/action/index.php', '', 'TMenuAgenda', '<span class=\"fas fa-calendar-alt infobox-action pictofixedwidth\" style=\"\"></span>', 'agenda', NULL, '$user->hasRight(\"agenda\", \"myactions\", \"read\") || $user->hasRight(\"resource\", \"read\")', 'isModEnabled(\"agenda\") || isModEnabled(\"resource\")', 2, '2025-08-08 01:21:11'),
(2, 'all', 1, 'agenda', 'left', 'agenda', NULL, 1, NULL, NULL, 100, '/comm/action/index.php?mainmenu=agenda&amp;leftmenu=agenda', '', 'Actions', '<span class=\"fas fa-calendar-alt infobox-action paddingright pictofixedwidth\" style=\"\"></span>', 'agenda', NULL, '$user->hasRight(\"agenda\", \"myactions\", \"read\")', 'isModEnabled(\"agenda\")', 2, '2025-08-08 01:21:11'),
(3, 'all', 1, 'agenda', 'left', 'agenda', NULL, 2, NULL, NULL, 101, '/comm/action/card.php?mainmenu=agenda&amp;leftmenu=agenda&action=create', '', 'NewAction', '', 'commercial', NULL, '($user->hasRight(\"agenda\", \"myactions\", \"create\") || $user->hasRight(\"agenda\", \"allactions\", \"create\"))', 'isModEnabled(\"agenda\")', 2, '2025-08-08 01:21:11'),
(4, 'all', 1, 'agenda', 'left', 'agenda', NULL, 2, NULL, NULL, 140, '/comm/action/index.php?mainmenu=agenda&amp;leftmenu=agenda', '', 'Calendar', '', 'agenda', NULL, '$user->hasRight(\"agenda\", \"myactions\", \"read\")', 'isModEnabled(\"agenda\")', 2, '2025-08-08 01:21:11'),
(5, 'all', 1, 'agenda', 'left', 'agenda', NULL, 4, NULL, NULL, 141, '/comm/action/index.php?mainmenu=agenda&amp;leftmenu=agenda&amp;status=todo&amp;filter=mine', '', 'MenuToDoMyActions', '', 'agenda', NULL, '$user->hasRight(\"agenda\", \"myactions\", \"read\")', 'isModEnabled(\"agenda\")', 2, '2025-08-08 01:21:11'),
(6, 'all', 1, 'agenda', 'left', 'agenda', NULL, 4, NULL, NULL, 142, '/comm/action/index.php?mainmenu=agenda&amp;leftmenu=agenda&amp;status=done&amp;filter=mine', '', 'MenuDoneMyActions', '', 'agenda', NULL, '$user->hasRight(\"agenda\", \"myactions\", \"read\")', 'isModEnabled(\"agenda\")', 2, '2025-08-08 01:21:11'),
(7, 'all', 1, 'agenda', 'left', 'agenda', NULL, 4, NULL, NULL, 143, '/comm/action/index.php?mainmenu=agenda&amp;leftmenu=agenda&amp;status=todo&amp;filtert=-1', '', 'MenuToDoActions', '', 'agenda', NULL, '$user->hasRight(\"agenda\", \"allactions\", \"read\")', 'isModEnabled(\"agenda\")', 2, '2025-08-08 01:21:11'),
(8, 'all', 1, 'agenda', 'left', 'agenda', NULL, 4, NULL, NULL, 144, '/comm/action/index.php?mainmenu=agenda&amp;leftmenu=agenda&amp;status=done&amp;filtert=-1', '', 'MenuDoneActions', '', 'agenda', NULL, '$user->hasRight(\"agenda\", \"allactions\", \"read\")', 'isModEnabled(\"agenda\")', 2, '2025-08-08 01:21:11'),
(9, 'all', 1, 'agenda', 'left', 'agenda', NULL, 2, NULL, NULL, 110, '/comm/action/list.php?mode=show_list&amp;mainmenu=agenda&amp;leftmenu=agenda', '', 'List', '', 'agenda', NULL, '$user->hasRight(\"agenda\", \"myactions\", \"read\")', 'isModEnabled(\"agenda\")', 2, '2025-08-08 01:21:11'),
(10, 'all', 1, 'agenda', 'left', 'agenda', NULL, 9, NULL, NULL, 111, '/comm/action/list.php?mode=show_list&amp;mainmenu=agenda&amp;leftmenu=agenda&amp;status=todo&amp;filter=mine', '', 'MenuToDoMyActions', '', 'agenda', NULL, '$user->hasRight(\"agenda\", \"myactions\", \"read\")', 'isModEnabled(\"agenda\")', 2, '2025-08-08 01:21:11'),
(11, 'all', 1, 'agenda', 'left', 'agenda', NULL, 9, NULL, NULL, 112, '/comm/action/list.php?mode=show_list&amp;mainmenu=agenda&amp;leftmenu=agenda&amp;status=done&amp;filter=mine', '', 'MenuDoneMyActions', '', 'agenda', NULL, '$user->hasRight(\"agenda\", \"myactions\", \"read\")', 'isModEnabled(\"agenda\")', 2, '2025-08-08 01:21:11'),
(12, 'all', 1, 'agenda', 'left', 'agenda', NULL, 9, NULL, NULL, 113, '/comm/action/list.php?mode=show_list&amp;mainmenu=agenda&amp;leftmenu=agenda&amp;status=todo&amp;filtert=-1', '', 'MenuToDoActions', '', 'agenda', NULL, '$user->hasRight(\"agenda\", \"allactions\", \"read\")', 'isModEnabled(\"agenda\")', 2, '2025-08-08 01:21:11'),
(13, 'all', 1, 'agenda', 'left', 'agenda', NULL, 9, NULL, NULL, 114, '/comm/action/list.php?mode=show_list&amp;mainmenu=agenda&amp;leftmenu=agenda&amp;status=done&amp;filtert=-1', '', 'MenuDoneActions', '', 'agenda', NULL, '$user->hasRight(\"agenda\", \"allactions\", \"read\")', 'isModEnabled(\"agenda\")', 2, '2025-08-08 01:21:11'),
(14, 'all', 1, 'agenda', 'left', 'agenda', NULL, 2, NULL, NULL, 160, '/comm/action/rapport/index.php?mainmenu=agenda&amp;leftmenu=agenda', '', 'Reportings', '', 'agenda', NULL, '$user->hasRight(\"agenda\", \"allactions\", \"read\")', 'isModEnabled(\"agenda\")', 2, '2025-08-08 01:21:11'),
(15, 'all', 1, 'agenda', 'left', 'agenda', NULL, 2, NULL, NULL, 170, '/categories/index.php?mainmenu=agenda&amp;leftmenu=agenda&type=10', '', 'Categories', '', 'agenda', NULL, '$user->hasRight(\"agenda\", \"allactions\", \"read\")', 'isModEnabled(\"category\")', 2, '2025-08-08 01:21:11'),
(16, 'all', 0, 'api', 'left', 'tools', 'devtools_api', -1, 'tools', NULL, 100, '/api/index.php/explorer', '_apiexplorer', 'ApiExplorer', '<span class=\"fas fa-cogs  em080 paddingright pictofixedwidth\" style=\" color: #999;\"></span>', 'modulebuilder', NULL, '1', 'isModEnabled(\"api\")', 0, '2025-12-28 16:45:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_multicurrency`
--

CREATE TABLE `llx_multicurrency` (
  `rowid` int(11) NOT NULL,
  `date_create` datetime DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `entity` int(11) DEFAULT 1,
  `fk_user` int(11) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_multicurrency_rate`
--

CREATE TABLE `llx_multicurrency_rate` (
  `rowid` int(11) NOT NULL,
  `date_sync` datetime DEFAULT NULL,
  `rate` double NOT NULL DEFAULT 0,
  `rate_indirect` double DEFAULT 0,
  `fk_multicurrency` int(11) NOT NULL,
  `entity` int(11) DEFAULT 1,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_notify`
--

CREATE TABLE `llx_notify` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `daten` datetime DEFAULT NULL,
  `fk_action` int(11) NOT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_contact` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `type` varchar(16) DEFAULT 'email',
  `type_target` varchar(16) DEFAULT NULL,
  `objet_type` varchar(24) NOT NULL,
  `objet_id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_notify_def`
--

CREATE TABLE `llx_notify_def` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) DEFAULT 1,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` date DEFAULT NULL,
  `fk_action` int(11) NOT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_contact` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `threshold` double(24,8) DEFAULT NULL,
  `context` varchar(128) DEFAULT NULL,
  `type` varchar(16) DEFAULT 'email'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_notify_def_object`
--

CREATE TABLE `llx_notify_def_object` (
  `id` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `objet_type` varchar(16) DEFAULT NULL,
  `objet_id` int(11) NOT NULL,
  `type_notif` varchar(16) DEFAULT 'browser',
  `date_notif` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `moreparam` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_oauth_state`
--

CREATE TABLE `llx_oauth_state` (
  `rowid` int(11) NOT NULL,
  `service` varchar(36) DEFAULT NULL,
  `state` varchar(128) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `fk_adherent` int(11) DEFAULT NULL,
  `entity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_oauth_token`
--

CREATE TABLE `llx_oauth_token` (
  `rowid` int(11) NOT NULL,
  `service` varchar(36) DEFAULT NULL,
  `token` text DEFAULT NULL,
  `tokenstring` text DEFAULT NULL,
  `state` text DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `fk_adherent` int(11) DEFAULT NULL,
  `restricted_ips` varchar(200) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `entity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_object_lang`
--

CREATE TABLE `llx_object_lang` (
  `rowid` int(11) NOT NULL,
  `fk_object` int(11) NOT NULL DEFAULT 0,
  `type_object` varchar(32) NOT NULL,
  `property` varchar(32) NOT NULL,
  `lang` varchar(5) NOT NULL DEFAULT '',
  `value` text DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_onlinesignature`
--

CREATE TABLE `llx_onlinesignature` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `object_type` varchar(32) NOT NULL,
  `object_id` int(11) NOT NULL,
  `datec` datetime NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `name` varchar(255) NOT NULL,
  `ip` varchar(128) DEFAULT NULL,
  `pathoffile` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_overwrite_trans`
--

CREATE TABLE `llx_overwrite_trans` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `lang` varchar(5) DEFAULT NULL,
  `transkey` varchar(128) DEFAULT NULL,
  `transvalue` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_paiement`
--

CREATE TABLE `llx_paiement` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(30) DEFAULT NULL,
  `ref_ext` varchar(255) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datep` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT 0.00000000,
  `multicurrency_amount` double(24,8) DEFAULT 0.00000000,
  `fk_paiement` int(11) NOT NULL,
  `num_paiement` varchar(50) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `ext_payment_id` varchar(255) DEFAULT NULL,
  `ext_payment_site` varchar(128) DEFAULT NULL,
  `fk_bank` int(11) NOT NULL DEFAULT 0,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `statut` smallint(6) NOT NULL DEFAULT 0,
  `fk_export_compta` int(11) NOT NULL DEFAULT 0,
  `pos_change` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_paiementcharge`
--

CREATE TABLE `llx_paiementcharge` (
  `rowid` int(11) NOT NULL,
  `fk_charge` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datep` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT 0.00000000,
  `fk_typepaiement` int(11) NOT NULL,
  `num_paiement` varchar(50) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `fk_bank` int(11) NOT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_paiementfourn`
--

CREATE TABLE `llx_paiementfourn` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(30) DEFAULT NULL,
  `entity` int(11) DEFAULT 1,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `datep` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT 0.00000000,
  `multicurrency_amount` double(24,8) DEFAULT 0.00000000,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_paiement` int(11) NOT NULL,
  `num_paiement` varchar(50) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `fk_bank` int(11) NOT NULL,
  `statut` smallint(6) NOT NULL DEFAULT 0,
  `model_pdf` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_paiementfourn_facturefourn`
--

CREATE TABLE `llx_paiementfourn_facturefourn` (
  `rowid` int(11) NOT NULL,
  `fk_paiementfourn` int(11) DEFAULT NULL,
  `fk_facturefourn` int(11) DEFAULT NULL,
  `amount` double(24,8) DEFAULT 0.00000000,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_amount` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_paiement_facture`
--

CREATE TABLE `llx_paiement_facture` (
  `rowid` int(11) NOT NULL,
  `fk_paiement` int(11) DEFAULT NULL,
  `fk_facture` int(11) DEFAULT NULL,
  `amount` double(24,8) DEFAULT 0.00000000,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_amount` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_paymentexpensereport_expensereport`
--

CREATE TABLE `llx_paymentexpensereport_expensereport` (
  `rowid` int(11) NOT NULL,
  `fk_payment` int(11) DEFAULT NULL,
  `fk_expensereport` int(11) DEFAULT NULL,
  `amount` double(24,8) DEFAULT 0.00000000,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_amount` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_payment_donation`
--

CREATE TABLE `llx_payment_donation` (
  `rowid` int(11) NOT NULL,
  `fk_donation` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datep` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT 0.00000000,
  `fk_typepayment` int(11) NOT NULL,
  `num_payment` varchar(50) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `ext_payment_id` varchar(255) DEFAULT NULL,
  `ext_payment_site` varchar(128) DEFAULT NULL,
  `fk_bank` int(11) NOT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_payment_expensereport`
--

CREATE TABLE `llx_payment_expensereport` (
  `rowid` int(11) NOT NULL,
  `fk_expensereport` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datep` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT 0.00000000,
  `fk_typepayment` int(11) NOT NULL,
  `num_payment` varchar(50) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `fk_bank` int(11) NOT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_payment_loan`
--

CREATE TABLE `llx_payment_loan` (
  `rowid` int(11) NOT NULL,
  `fk_loan` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datep` datetime DEFAULT NULL,
  `amount_capital` double(24,8) DEFAULT 0.00000000,
  `amount_insurance` double(24,8) DEFAULT 0.00000000,
  `amount_interest` double(24,8) DEFAULT 0.00000000,
  `fk_typepayment` int(11) NOT NULL,
  `num_payment` varchar(50) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `fk_bank` int(11) NOT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_payment_salary`
--

CREATE TABLE `llx_payment_salary` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(30) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `datep` datetime DEFAULT NULL,
  `datev` date DEFAULT NULL,
  `salary` double(24,8) DEFAULT NULL,
  `amount` double(24,8) NOT NULL DEFAULT 0.00000000,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_typepayment` int(11) NOT NULL,
  `num_payment` varchar(50) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `datesp` date DEFAULT NULL,
  `dateep` date DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `note` text DEFAULT NULL,
  `fk_bank` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_salary` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_payment_various`
--

CREATE TABLE `llx_payment_various` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(30) DEFAULT NULL,
  `num_payment` varchar(50) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `datep` date DEFAULT NULL,
  `datev` date DEFAULT NULL,
  `sens` smallint(6) NOT NULL DEFAULT 0,
  `amount` double(24,8) NOT NULL DEFAULT 0.00000000,
  `fk_typepayment` int(11) NOT NULL,
  `accountancy_code` varchar(32) DEFAULT NULL,
  `subledger_account` varchar(32) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `note` text DEFAULT NULL,
  `fk_bank` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_payment_vat`
--

CREATE TABLE `llx_payment_vat` (
  `rowid` int(11) NOT NULL,
  `fk_tva` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datep` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT 0.00000000,
  `fk_typepaiement` int(11) NOT NULL,
  `num_paiement` varchar(50) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `fk_bank` int(11) NOT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_pos_cash_fence`
--

CREATE TABLE `llx_pos_cash_fence` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref` varchar(64) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `opening` double(24,8) DEFAULT 0.00000000,
  `cash` double(24,8) DEFAULT 0.00000000,
  `card` double(24,8) DEFAULT 0.00000000,
  `cheque` double(24,8) DEFAULT 0.00000000,
  `status` int(11) DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `date_valid` datetime DEFAULT NULL,
  `day_close` int(11) DEFAULT NULL,
  `month_close` int(11) DEFAULT NULL,
  `year_close` int(11) DEFAULT NULL,
  `posmodule` varchar(30) DEFAULT NULL,
  `posnumber` varchar(30) DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_pos_cash_fence_extrafields`
--

CREATE TABLE `llx_pos_cash_fence_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_prelevement`
--

CREATE TABLE `llx_prelevement` (
  `rowid` int(11) NOT NULL,
  `fk_facture` int(11) DEFAULT NULL,
  `fk_facture_fourn` int(11) DEFAULT NULL,
  `fk_salary` int(11) DEFAULT NULL,
  `fk_prelevement_lignes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_prelevement_bons`
--

CREATE TABLE `llx_prelevement_bons` (
  `rowid` int(11) NOT NULL,
  `type` varchar(16) DEFAULT 'debit-order',
  `ref` varchar(12) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `datec` datetime DEFAULT NULL,
  `amount` double(24,8) DEFAULT 0.00000000,
  `statut` smallint(6) DEFAULT 0,
  `credite` smallint(6) DEFAULT 0,
  `note` text DEFAULT NULL,
  `date_trans` datetime DEFAULT NULL,
  `method_trans` smallint(6) DEFAULT NULL,
  `fk_user_trans` int(11) DEFAULT NULL,
  `date_credit` datetime DEFAULT NULL,
  `fk_user_credit` int(11) DEFAULT NULL,
  `fk_bank_account` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_prelevement_demande`
--

CREATE TABLE `llx_prelevement_demande` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_facture` int(11) DEFAULT NULL,
  `fk_facture_fourn` int(11) DEFAULT NULL,
  `fk_salary` int(11) DEFAULT NULL,
  `sourcetype` varchar(32) DEFAULT NULL,
  `amount` double(24,8) NOT NULL,
  `date_demande` datetime NOT NULL,
  `traite` smallint(6) DEFAULT 0,
  `date_traite` datetime DEFAULT NULL,
  `fk_prelevement_bons` int(11) DEFAULT NULL,
  `fk_user_demande` int(11) NOT NULL,
  `fk_societe_rib` int(11) DEFAULT NULL,
  `code_banque` varchar(128) DEFAULT NULL,
  `code_guichet` varchar(6) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `cle_rib` varchar(5) DEFAULT NULL,
  `type` varchar(12) DEFAULT '',
  `ext_payment_id` varchar(255) DEFAULT NULL,
  `ext_payment_site` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_prelevement_lignes`
--

CREATE TABLE `llx_prelevement_lignes` (
  `rowid` int(11) NOT NULL,
  `fk_prelevement_bons` int(11) DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `statut` smallint(6) DEFAULT 0,
  `client_nom` varchar(255) DEFAULT NULL,
  `amount` double(24,8) DEFAULT 0.00000000,
  `code_banque` varchar(128) DEFAULT NULL,
  `code_guichet` varchar(6) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `cle_rib` varchar(5) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_prelevement_rejet`
--

CREATE TABLE `llx_prelevement_rejet` (
  `rowid` int(11) NOT NULL,
  `fk_prelevement_lignes` int(11) DEFAULT NULL,
  `date_rejet` datetime DEFAULT NULL,
  `motif` int(11) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `fk_user_creation` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `afacturer` tinyint(4) DEFAULT 0,
  `fk_facture` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_printing`
--

CREATE TABLE `llx_printing` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `printer_name` text NOT NULL,
  `printer_location` text NOT NULL,
  `printer_id` varchar(255) NOT NULL,
  `copy` int(11) NOT NULL DEFAULT 1,
  `module` varchar(16) NOT NULL,
  `driver` varchar(16) NOT NULL,
  `userid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product`
--

CREATE TABLE `llx_product` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(128) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref_ext` varchar(128) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_parent` int(11) DEFAULT 0,
  `label` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `note_public` mediumtext DEFAULT NULL,
  `note` mediumtext DEFAULT NULL,
  `customcode` varchar(32) DEFAULT NULL,
  `fk_country` int(11) DEFAULT NULL,
  `fk_state` int(11) DEFAULT NULL,
  `price` double(24,8) DEFAULT 0.00000000,
  `price_ttc` double(24,8) DEFAULT 0.00000000,
  `price_min` double(24,8) DEFAULT 0.00000000,
  `price_min_ttc` double(24,8) DEFAULT 0.00000000,
  `price_base_type` varchar(3) DEFAULT 'HT',
  `price_label` varchar(255) DEFAULT NULL,
  `cost_price` double(24,8) DEFAULT NULL,
  `default_vat_code` varchar(10) DEFAULT NULL,
  `tva_tx` double(7,4) DEFAULT NULL,
  `recuperableonly` int(11) NOT NULL DEFAULT 0,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) NOT NULL DEFAULT '0',
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) NOT NULL DEFAULT '0',
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `tosell` tinyint(4) DEFAULT 1,
  `tobuy` tinyint(4) DEFAULT 1,
  `tobatch` tinyint(4) NOT NULL DEFAULT 0,
  `sell_or_eat_by_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `batch_mask` varchar(32) DEFAULT NULL,
  `fk_product_type` int(11) DEFAULT 0,
  `duration` varchar(6) DEFAULT NULL,
  `seuil_stock_alerte` float DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `barcode` varchar(180) DEFAULT NULL,
  `fk_barcode_type` int(11) DEFAULT NULL,
  `accountancy_code_sell` varchar(32) DEFAULT NULL,
  `accountancy_code_sell_intra` varchar(32) DEFAULT NULL,
  `accountancy_code_sell_export` varchar(32) DEFAULT NULL,
  `accountancy_code_buy` varchar(32) DEFAULT NULL,
  `accountancy_code_buy_intra` varchar(32) DEFAULT NULL,
  `accountancy_code_buy_export` varchar(32) DEFAULT NULL,
  `partnumber` varchar(32) DEFAULT NULL,
  `net_measure` float DEFAULT NULL,
  `net_measure_units` tinyint(4) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `weight_units` tinyint(4) DEFAULT NULL,
  `length` float DEFAULT NULL,
  `length_units` tinyint(4) DEFAULT NULL,
  `width` float DEFAULT NULL,
  `width_units` tinyint(4) DEFAULT NULL,
  `height` float DEFAULT NULL,
  `height_units` tinyint(4) DEFAULT NULL,
  `surface` float DEFAULT NULL,
  `surface_units` tinyint(4) DEFAULT NULL,
  `volume` float DEFAULT NULL,
  `volume_units` tinyint(4) DEFAULT NULL,
  `stockable_product` int(11) NOT NULL DEFAULT 1,
  `stock` double DEFAULT NULL,
  `pmp` double(24,8) NOT NULL DEFAULT 0.00000000,
  `fifo` double(24,8) DEFAULT NULL,
  `lifo` double(24,8) DEFAULT NULL,
  `fk_default_warehouse` int(11) DEFAULT NULL,
  `fk_default_bom` int(11) DEFAULT NULL,
  `fk_default_workstation` int(11) DEFAULT NULL,
  `canvas` varchar(32) DEFAULT NULL,
  `finished` tinyint(4) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `qc_frequency` int(11) DEFAULT NULL,
  `hidden` tinyint(4) DEFAULT 0,
  `import_key` varchar(14) DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `fk_price_expression` int(11) DEFAULT NULL,
  `desiredstock` float DEFAULT 0,
  `fk_unit` int(11) DEFAULT NULL,
  `price_autogen` tinyint(4) DEFAULT 0,
  `fk_project` int(11) DEFAULT NULL,
  `mandatory_period` tinyint(4) DEFAULT 0,
  `last_main_doc` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_product`
--

INSERT INTO `llx_product` (`rowid`, `ref`, `entity`, `ref_ext`, `datec`, `tms`, `fk_parent`, `label`, `description`, `note_public`, `note`, `customcode`, `fk_country`, `fk_state`, `price`, `price_ttc`, `price_min`, `price_min_ttc`, `price_base_type`, `price_label`, `cost_price`, `default_vat_code`, `tva_tx`, `recuperableonly`, `localtax1_tx`, `localtax1_type`, `localtax2_tx`, `localtax2_type`, `fk_user_author`, `fk_user_modif`, `tosell`, `tobuy`, `tobatch`, `sell_or_eat_by_mandatory`, `batch_mask`, `fk_product_type`, `duration`, `seuil_stock_alerte`, `url`, `barcode`, `fk_barcode_type`, `accountancy_code_sell`, `accountancy_code_sell_intra`, `accountancy_code_sell_export`, `accountancy_code_buy`, `accountancy_code_buy_intra`, `accountancy_code_buy_export`, `partnumber`, `net_measure`, `net_measure_units`, `weight`, `weight_units`, `length`, `length_units`, `width`, `width_units`, `height`, `height_units`, `surface`, `surface_units`, `volume`, `volume_units`, `stockable_product`, `stock`, `pmp`, `fifo`, `lifo`, `fk_default_warehouse`, `fk_default_bom`, `fk_default_workstation`, `canvas`, `finished`, `lifetime`, `qc_frequency`, `hidden`, `import_key`, `model_pdf`, `fk_price_expression`, `desiredstock`, `fk_unit`, `price_autogen`, `fk_project`, `mandatory_period`, `last_main_doc`) VALUES
(5, 'CM5X5A3', 1, NULL, '2025-12-28 18:03:45', '2026-01-08 03:47:28', 0, 'Carpa de 5x5 - 3 mts Altura', 'Carpa con estructura Modular con lona blanca y cortinas de lona blanca con ventana', NULL, '', '', NULL, NULL, 1100.00000000, 1100.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, 5, NULL, 5, 0, 3, 0, 25, -6, 75, -9, 1, 10, 0.00000000, NULL, NULL, NULL, 0, NULL, '', 1, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(6, 'SILLA-TIFF', 1, NULL, '2025-12-28 18:20:46', '2025-12-31 03:34:02', 0, 'Silla Tifany Blanca', 'Silla de Plastico, Tifany color blanca', NULL, '', '', NULL, NULL, 30.00000000, 30.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, 100, 0.00000000, NULL, NULL, NULL, 0, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(7, 'SILLA-C-P', 1, NULL, '2025-12-28 18:22:22', '2025-12-31 03:32:09', 0, 'Silla de Cojín Plegable', 'Silla Acojinada Plegable, cromada y/o galvanizada', NULL, '', '', NULL, NULL, 20.00000000, 20.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '0', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, 500, 0.00000000, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(8, 'MESA-R', 1, NULL, '2025-12-28 18:24:15', '2025-12-31 03:32:29', 0, 'Mesa Redonda', 'Mesa redonda con orificio para sombrilla', NULL, '', '', NULL, NULL, 40.00000000, 40.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, 50, 0.00000000, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(9, 'PISTA-P', 1, NULL, '2025-12-28 18:26:14', '2025-12-28 17:33:22', 0, 'Pista personalizable', 'Pista de madera con medidas variables que se ajustan a la necesidad del cliente', NULL, '', '', NULL, NULL, 60.00000000, 60.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, 250, -2, 140, -2, NULL, -2, 35000, NULL, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, 0, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(10, 'C15X15-4A', 1, NULL, '2026-01-08 05:06:01', '2026-01-18 18:57:23', 0, 'Carpa de 15 m. de Ancho', '', NULL, '', '', NULL, NULL, 15000.00000000, 15000.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, 15, NULL, NULL, 0, NULL, 0, 225, -6, 900, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, 0, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(11, 'P-BA', 1, NULL, '2026-01-18 20:17:55', '2026-01-20 01:30:54', 0, 'Periquera', '', NULL, '', '', NULL, NULL, 120.00000000, 120.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, 0, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(12, 'SL-B', 1, NULL, '2026-01-20 02:31:39', '2026-01-20 01:31:39', 0, 'Sala Lunge Blanca', '', NULL, '', '', NULL, NULL, 900.00000000, 900.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(13, 'MR-V', 1, NULL, '2026-01-20 02:32:10', '2026-01-20 01:32:10', 0, 'Mesa Redonda Vestida', '', NULL, '', '', NULL, NULL, 180.00000000, 180.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(14, 'CM8A3H-A', 1, NULL, '2026-01-20 02:33:04', '2026-01-20 01:35:05', 0, 'Carpa de 8 m de Ancho', '', NULL, '', '', NULL, NULL, 60.00000000, 60.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, 0, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(15, 'C12A-3H', 1, NULL, '2026-01-20 02:33:51', '2026-01-20 01:33:51', 0, 'Carpa de 12 m de Ancho', '', NULL, '', '', NULL, NULL, 70.00000000, 70.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(16, 'CM10A-3H', 1, NULL, '2026-01-20 02:34:45', '2026-01-20 01:34:45', 0, 'Carpa de 10 m. de Ancho', '', NULL, '', '', NULL, NULL, 60.00000000, 60.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(17, 'C15A-HL', 1, NULL, '2026-01-20 02:36:47', '2026-01-20 01:39:22', 0, 'Carpa de 15 m. de Ancho Con Toldo de Hule Cristal', '', NULL, '', '', NULL, NULL, 90.00000000, 90.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 1, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, 0, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(18, 'PLFN-C', 1, NULL, '2026-01-20 02:41:28', '2026-01-20 01:41:28', 0, 'Plafon Ceremonial', '', NULL, '', '', NULL, NULL, 1200.00000000, 1200.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(19, 'INFL-TORO', 1, NULL, '2026-01-20 02:42:44', '2026-01-20 01:42:44', 0, 'Inflable de Toro', '', NULL, '', '', NULL, NULL, 800.00000000, 800.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 1, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(20, 'INFL-CASTILLO', 1, NULL, '2026-01-20 02:48:16', '2026-01-20 01:48:16', 0, 'Inflable de Castillo', '', NULL, '', '', NULL, NULL, 900.00000000, 900.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(21, 'TBLN', 1, NULL, '2026-01-20 02:50:39', '2026-01-20 01:50:39', 0, 'Mesa Tablón', '', NULL, '', '', NULL, NULL, 25.00000000, 25.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(22, 'MCI', 1, NULL, '2026-01-20 02:51:14', '2026-01-20 01:51:14', 0, 'Mesa Cuadrada Imperial', '', NULL, '', '', NULL, NULL, 30.00000000, 30.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 1, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL),
(23, 'SILLA-PLASTICO-N', 1, NULL, '2026-01-20 02:51:42', '2026-01-20 01:51:42', 0, 'Silla Negra de Plastico', '', NULL, '', '', NULL, NULL, 15.00000000, 15.00000000, 0.00000000, 0.00000000, 'HT', NULL, NULL, NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, 1, 1, 0, 0, 0, '', 0, '', 0, NULL, NULL, NULL, '', '', '', '', '', '', NULL, NULL, NULL, NULL, -6, NULL, -3, NULL, -3, NULL, -3, NULL, -6, NULL, -9, 1, NULL, 0.00000000, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, 0, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_association`
--

CREATE TABLE `llx_product_association` (
  `rowid` int(11) NOT NULL,
  `fk_product_pere` int(11) NOT NULL DEFAULT 0,
  `fk_product_fils` int(11) NOT NULL DEFAULT 0,
  `qty` double DEFAULT NULL,
  `incdec` int(11) DEFAULT 1,
  `rang` int(11) DEFAULT 0,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_attribute`
--

CREATE TABLE `llx_product_attribute` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(255) NOT NULL,
  `ref_ext` varchar(255) DEFAULT NULL,
  `label` varchar(255) NOT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `entity` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_attribute_value`
--

CREATE TABLE `llx_product_attribute_value` (
  `rowid` int(11) NOT NULL,
  `fk_product_attribute` int(11) NOT NULL,
  `ref` varchar(180) NOT NULL,
  `value` varchar(255) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `position` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_batch`
--

CREATE TABLE `llx_product_batch` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_product_stock` int(11) NOT NULL,
  `eatby` datetime DEFAULT NULL,
  `sellby` datetime DEFAULT NULL,
  `batch` varchar(128) NOT NULL,
  `qty` double NOT NULL DEFAULT 0,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_customer_price`
--

CREATE TABLE `llx_product_customer_price` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_product` int(11) NOT NULL,
  `fk_soc` int(11) NOT NULL,
  `ref_customer` varchar(128) DEFAULT NULL,
  `price` double(24,8) DEFAULT 0.00000000,
  `price_ttc` double(24,8) DEFAULT 0.00000000,
  `price_min` double(24,8) DEFAULT 0.00000000,
  `price_min_ttc` double(24,8) DEFAULT 0.00000000,
  `price_base_type` varchar(3) DEFAULT 'HT',
  `default_vat_code` varchar(10) DEFAULT NULL,
  `tva_tx` double(7,4) DEFAULT NULL,
  `recuperableonly` int(11) NOT NULL DEFAULT 0,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) NOT NULL DEFAULT '0',
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) NOT NULL DEFAULT '0',
  `fk_user` int(11) DEFAULT NULL,
  `price_label` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_customer_price_extrafields`
--

CREATE TABLE `llx_product_customer_price_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_customer_price_log`
--

CREATE TABLE `llx_product_customer_price_log` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `datec` datetime DEFAULT NULL,
  `fk_product` int(11) NOT NULL,
  `fk_soc` int(11) NOT NULL DEFAULT 0,
  `ref_customer` varchar(30) DEFAULT NULL,
  `price` double(24,8) DEFAULT 0.00000000,
  `price_ttc` double(24,8) DEFAULT 0.00000000,
  `price_min` double(24,8) DEFAULT 0.00000000,
  `price_min_ttc` double(24,8) DEFAULT 0.00000000,
  `price_base_type` varchar(3) DEFAULT 'HT',
  `default_vat_code` varchar(10) DEFAULT NULL,
  `tva_tx` double(7,4) DEFAULT NULL,
  `recuperableonly` int(11) NOT NULL DEFAULT 0,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) NOT NULL DEFAULT '0',
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) NOT NULL DEFAULT '0',
  `fk_user` int(11) DEFAULT NULL,
  `price_label` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_extrafields`
--

CREATE TABLE `llx_product_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_fournisseur_price`
--

CREATE TABLE `llx_product_fournisseur_price` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_product` int(11) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `ref_fourn` varchar(128) DEFAULT NULL,
  `desc_fourn` text DEFAULT NULL,
  `fk_availability` int(11) DEFAULT NULL,
  `price` double(24,8) DEFAULT 0.00000000,
  `quantity` double DEFAULT NULL,
  `remise_percent` double NOT NULL DEFAULT 0,
  `remise` double NOT NULL DEFAULT 0,
  `unitprice` double(24,8) DEFAULT 0.00000000,
  `charges` double(24,8) DEFAULT 0.00000000,
  `default_vat_code` varchar(10) DEFAULT NULL,
  `barcode` varchar(180) DEFAULT NULL,
  `fk_barcode_type` int(11) DEFAULT NULL,
  `tva_tx` double(7,4) NOT NULL,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) NOT NULL DEFAULT '0',
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) NOT NULL DEFAULT '0',
  `info_bits` int(11) NOT NULL DEFAULT 0,
  `fk_user` int(11) DEFAULT NULL,
  `fk_supplier_price_expression` int(11) DEFAULT NULL,
  `delivery_time_days` int(11) DEFAULT NULL,
  `supplier_reputation` varchar(10) DEFAULT NULL,
  `packaging` double DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_unitprice` double(24,8) DEFAULT NULL,
  `multicurrency_price` double(24,8) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `status` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_fournisseur_price_extrafields`
--

CREATE TABLE `llx_product_fournisseur_price_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_fournisseur_price_log`
--

CREATE TABLE `llx_product_fournisseur_price_log` (
  `rowid` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `fk_product_fournisseur` int(11) NOT NULL,
  `price` double(24,8) DEFAULT 0.00000000,
  `quantity` double DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_unitprice` double(24,8) DEFAULT NULL,
  `multicurrency_price` double(24,8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_lang`
--

CREATE TABLE `llx_product_lang` (
  `rowid` int(11) NOT NULL,
  `fk_product` int(11) NOT NULL DEFAULT 0,
  `lang` varchar(5) NOT NULL DEFAULT '0',
  `label` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `note` mediumtext DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_lot`
--

CREATE TABLE `llx_product_lot` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) DEFAULT 1,
  `fk_product` int(11) NOT NULL,
  `batch` varchar(128) DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `eatby` date DEFAULT NULL,
  `sellby` date DEFAULT NULL,
  `eol_date` datetime DEFAULT NULL,
  `manufacturing_date` datetime DEFAULT NULL,
  `scrapping_date` datetime DEFAULT NULL,
  `qc_frequency` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `barcode` varchar(180) DEFAULT NULL,
  `fk_barcode_type` int(11) DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_lot_extrafields`
--

CREATE TABLE `llx_product_lot_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_price`
--

CREATE TABLE `llx_product_price` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_product` int(11) NOT NULL,
  `date_price` datetime NOT NULL,
  `price_level` smallint(6) DEFAULT 1,
  `price` double(24,8) DEFAULT NULL,
  `price_ttc` double(24,8) DEFAULT NULL,
  `price_min` double(24,8) DEFAULT NULL,
  `price_min_ttc` double(24,8) DEFAULT NULL,
  `price_base_type` varchar(3) DEFAULT 'HT',
  `default_vat_code` varchar(10) DEFAULT NULL,
  `tva_tx` double(7,4) NOT NULL DEFAULT 0.0000,
  `recuperableonly` int(11) NOT NULL DEFAULT 0,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) NOT NULL DEFAULT '0',
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) NOT NULL DEFAULT '0',
  `fk_user_author` int(11) DEFAULT NULL,
  `price_label` varchar(255) DEFAULT NULL,
  `tosell` tinyint(4) DEFAULT 1,
  `price_by_qty` int(11) NOT NULL DEFAULT 0,
  `fk_price_expression` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_price` double(24,8) DEFAULT NULL,
  `multicurrency_price_ttc` double(24,8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_product_price`
--

INSERT INTO `llx_product_price` (`rowid`, `entity`, `tms`, `fk_product`, `date_price`, `price_level`, `price`, `price_ttc`, `price_min`, `price_min_ttc`, `price_base_type`, `default_vat_code`, `tva_tx`, `recuperableonly`, `localtax1_tx`, `localtax1_type`, `localtax2_tx`, `localtax2_type`, `fk_user_author`, `price_label`, `tosell`, `price_by_qty`, `fk_price_expression`, `import_key`, `fk_multicurrency`, `multicurrency_code`, `multicurrency_tx`, `multicurrency_price`, `multicurrency_price_ttc`) VALUES
(6, 1, '2025-12-28 17:03:45', 5, '2025-12-28 18:03:45', 1, 1100.00000000, 1100.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(7, 1, '2025-12-28 17:20:46', 6, '2025-12-28 18:20:46', 1, 30.00000000, 30.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(8, 1, '2025-12-28 17:22:22', 7, '2025-12-28 18:22:22', 1, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(9, 1, '2025-12-28 17:24:15', 8, '2025-12-28 18:24:15', 1, 40.00000000, 40.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(10, 1, '2025-12-28 17:26:14', 9, '2025-12-28 18:26:14', 1, 60.00000000, 60.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(11, 1, '2025-12-28 17:28:55', 7, '2025-12-28 18:28:55', 1, 20.00000000, 20.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(12, 1, '2026-01-08 04:06:01', 10, '2026-01-08 05:06:01', 1, 15000.00000000, 15000.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(13, 1, '2026-01-18 19:17:55', 11, '2026-01-18 20:17:55', 1, 120.00000000, 120.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(14, 1, '2026-01-20 01:31:39', 12, '2026-01-20 02:31:39', 1, 900.00000000, 900.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(15, 1, '2026-01-20 01:32:10', 13, '2026-01-20 02:32:10', 1, 180.00000000, 180.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(16, 1, '2026-01-20 01:33:04', 14, '2026-01-20 02:33:04', 1, 60.00000000, 60.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(17, 1, '2026-01-20 01:33:51', 15, '2026-01-20 02:33:51', 1, 70.00000000, 70.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(18, 1, '2026-01-20 01:34:45', 16, '2026-01-20 02:34:45', 1, 60.00000000, 60.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(19, 1, '2026-01-20 01:36:47', 17, '2026-01-20 02:36:47', 1, 90.00000000, 90.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(20, 1, '2026-01-20 01:41:28', 18, '2026-01-20 02:41:28', 1, 1200.00000000, 1200.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(21, 1, '2026-01-20 01:42:44', 19, '2026-01-20 02:42:44', 1, 800.00000000, 800.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(22, 1, '2026-01-20 01:48:16', 20, '2026-01-20 02:48:16', 1, 900.00000000, 900.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(23, 1, '2026-01-20 01:50:39', 21, '2026-01-20 02:50:39', 1, 25.00000000, 25.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(24, 1, '2026-01-20 01:51:14', 22, '2026-01-20 02:51:14', 1, 30.00000000, 30.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL),
(25, 1, '2026-01-20 01:51:42', 23, '2026-01-20 02:51:42', 1, 15.00000000, 15.00000000, 0.00000000, 0.00000000, 'HT', NULL, 0.0000, 0, 0.0000, '0', 0.0000, '0', 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 1.00000000, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_pricerules`
--

CREATE TABLE `llx_product_pricerules` (
  `rowid` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `fk_level` int(11) NOT NULL,
  `var_percent` double NOT NULL,
  `var_min_percent` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_price_by_qty`
--

CREATE TABLE `llx_product_price_by_qty` (
  `rowid` int(11) NOT NULL,
  `fk_product_price` int(11) NOT NULL,
  `price` double(24,8) DEFAULT 0.00000000,
  `price_base_type` varchar(3) DEFAULT 'HT',
  `quantity` double DEFAULT NULL,
  `remise_percent` double NOT NULL DEFAULT 0,
  `remise` double NOT NULL DEFAULT 0,
  `unitprice` double(24,8) DEFAULT 0.00000000,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_price` double(24,8) DEFAULT NULL,
  `multicurrency_price_ttc` double(24,8) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_price_extrafields`
--

CREATE TABLE `llx_product_price_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_stock`
--

CREATE TABLE `llx_product_stock` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_product` int(11) NOT NULL,
  `fk_entrepot` int(11) NOT NULL,
  `reel` double DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_product_stock`
--

INSERT INTO `llx_product_stock` (`rowid`, `tms`, `fk_product`, `fk_entrepot`, `reel`, `import_key`) VALUES
(6, '2025-12-31 03:32:58', 5, 3, 10, NULL),
(7, '2025-12-31 03:32:09', 7, 3, 500, NULL),
(8, '2025-12-31 03:32:29', 8, 3, 50, NULL),
(9, '2025-12-31 03:34:02', 6, 3, 100, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_thirdparty`
--

CREATE TABLE `llx_product_thirdparty` (
  `rowid` int(11) NOT NULL,
  `fk_product` int(11) NOT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_product_thirdparty_relation_type` int(11) NOT NULL,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `fk_project` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_product_warehouse_properties`
--

CREATE TABLE `llx_product_warehouse_properties` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_product` int(11) NOT NULL,
  `fk_entrepot` int(11) NOT NULL,
  `seuil_stock_alerte` float DEFAULT 0,
  `desiredstock` float DEFAULT 0,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_projet`
--

CREATE TABLE `llx_projet` (
  `rowid` int(11) NOT NULL,
  `fk_project` int(11) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dateo` date DEFAULT NULL,
  `datee` date DEFAULT NULL,
  `ref` varchar(50) DEFAULT NULL,
  `ref_ext` varchar(50) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `public` int(11) DEFAULT NULL,
  `fk_statut` int(11) NOT NULL DEFAULT 0,
  `fk_opp_status` int(11) DEFAULT NULL,
  `opp_percent` double(5,2) DEFAULT NULL,
  `fk_opp_status_end` int(11) DEFAULT NULL,
  `date_close` datetime DEFAULT NULL,
  `fk_user_close` int(11) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `email_msgid` varchar(175) DEFAULT NULL,
  `email_date` datetime DEFAULT NULL,
  `opp_amount` double(24,8) DEFAULT NULL,
  `budget_amount` double(24,8) DEFAULT NULL,
  `usage_opportunity` int(11) DEFAULT 0,
  `usage_task` int(11) DEFAULT 1,
  `usage_bill_time` int(11) DEFAULT 0,
  `usage_organize_event` int(11) DEFAULT 0,
  `date_start_event` datetime DEFAULT NULL,
  `date_end_event` datetime DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `accept_conference_suggestions` int(11) DEFAULT 0,
  `accept_booth_suggestions` int(11) DEFAULT 0,
  `max_attendees` int(11) DEFAULT 0,
  `price_registration` double(24,8) DEFAULT NULL,
  `price_booth` double(24,8) DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `ip` varchar(250) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_projet_extrafields`
--

CREATE TABLE `llx_projet_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_projet_task`
--

CREATE TABLE `llx_projet_task` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(50) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_projet` int(11) NOT NULL,
  `fk_task_parent` int(11) NOT NULL DEFAULT 0,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dateo` datetime DEFAULT NULL,
  `datee` datetime DEFAULT NULL,
  `datev` datetime DEFAULT NULL,
  `label` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `duration_effective` double DEFAULT 0,
  `planned_workload` double DEFAULT 0,
  `progress` int(11) DEFAULT 0,
  `priority` int(11) DEFAULT 0,
  `budget_amount` double(24,8) DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) NOT NULL DEFAULT 0,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `rang` int(11) DEFAULT 0,
  `model_pdf` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `billable` smallint(6) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_projet_task_extrafields`
--

CREATE TABLE `llx_projet_task_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_propal`
--

CREATE TABLE `llx_propal` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref_ext` varchar(255) DEFAULT NULL,
  `ref_client` varchar(255) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `datep` date DEFAULT NULL,
  `fin_validite` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_signature` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_signature` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) NOT NULL DEFAULT 0,
  `price` double DEFAULT 0,
  `remise_percent` double DEFAULT 0,
  `remise_absolue` double DEFAULT 0,
  `remise` double DEFAULT 0,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `localtax1` double(24,8) DEFAULT 0.00000000,
  `localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `fk_account` int(11) DEFAULT NULL,
  `fk_currency` varchar(3) DEFAULT NULL,
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `deposit_percent` varchar(63) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `online_sign_ip` varchar(48) DEFAULT NULL,
  `online_sign_name` varchar(64) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `model_pdf_pos_sign` varchar(32) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `date_livraison` date DEFAULT NULL,
  `fk_shipping_method` int(11) DEFAULT NULL,
  `fk_warehouse` int(11) DEFAULT NULL,
  `fk_availability` int(11) DEFAULT NULL,
  `fk_input_reason` int(11) DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL,
  `fk_delivery_address` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_propaldet`
--

CREATE TABLE `llx_propaldet` (
  `rowid` int(11) NOT NULL,
  `fk_propal` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `fk_remise_except` int(11) DEFAULT NULL,
  `vat_src_code` varchar(10) DEFAULT '',
  `tva_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT 0,
  `remise` double DEFAULT 0,
  `price` double DEFAULT NULL,
  `subprice` double(24,8) DEFAULT 0.00000000,
  `subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `total_localtax1` double(24,8) DEFAULT 0.00000000,
  `total_localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `product_type` int(11) DEFAULT 0,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT 0,
  `buy_price_ht` double(24,8) DEFAULT 0.00000000,
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `special_code` int(11) DEFAULT 0,
  `rang` int(11) DEFAULT 0,
  `fk_unit` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT 0.00000000,
  `multicurrency_subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_propaldet_extrafields`
--

CREATE TABLE `llx_propaldet_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_propal_extrafields`
--

CREATE TABLE `llx_propal_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_propal_merge_pdf_product`
--

CREATE TABLE `llx_propal_merge_pdf_product` (
  `rowid` int(11) NOT NULL,
  `fk_product` int(11) NOT NULL,
  `file_name` varchar(200) NOT NULL,
  `lang` varchar(5) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_mod` int(11) NOT NULL,
  `datec` datetime NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_reception`
--

CREATE TABLE `llx_reception` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_soc` int(11) NOT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `ref_ext` varchar(30) DEFAULT NULL,
  `ref_supplier` varchar(255) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `date_delivery` datetime DEFAULT NULL,
  `date_reception` datetime DEFAULT NULL,
  `fk_shipping_method` int(11) DEFAULT NULL,
  `tracking_number` varchar(50) DEFAULT NULL,
  `fk_statut` smallint(6) DEFAULT 0,
  `billed` smallint(6) DEFAULT 0,
  `height` float DEFAULT NULL,
  `width` float DEFAULT NULL,
  `size_units` int(11) DEFAULT NULL,
  `size` float DEFAULT NULL,
  `weight_units` int(11) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_receptiondet_batch`
--

CREATE TABLE `llx_receptiondet_batch` (
  `rowid` int(11) NOT NULL,
  `fk_reception` int(11) DEFAULT NULL,
  `fk_element` int(11) DEFAULT NULL,
  `fk_elementdet` int(11) DEFAULT NULL,
  `element_type` varchar(50) NOT NULL DEFAULT 'supplier_order',
  `fk_product` int(11) DEFAULT NULL,
  `qty` float DEFAULT NULL,
  `fk_entrepot` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `batch` varchar(128) DEFAULT NULL,
  `eatby` date DEFAULT NULL,
  `sellby` date DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `cost_price` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_receptiondet_batch_extrafields`
--

CREATE TABLE `llx_receptiondet_batch_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_reception_extrafields`
--

CREATE TABLE `llx_reception_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_resource`
--

CREATE TABLE `llx_resource` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref` varchar(255) DEFAULT NULL,
  `asset_number` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `fk_code_type_resource` varchar(32) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `zip` varchar(25) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `photo_filename` varchar(255) DEFAULT NULL,
  `max_users` int(11) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) NOT NULL DEFAULT 0,
  `note_public` text DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL,
  `fk_country` int(11) DEFAULT NULL,
  `fk_state` int(11) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_resource_extrafields`
--

CREATE TABLE `llx_resource_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_rights_def`
--

CREATE TABLE `llx_rights_def` (
  `id` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `libelle` varchar(255) DEFAULT NULL,
  `module` varchar(64) DEFAULT NULL,
  `module_origin` varchar(64) DEFAULT NULL,
  `module_position` int(11) NOT NULL DEFAULT 0,
  `family_position` int(11) NOT NULL DEFAULT 0,
  `perms` varchar(50) DEFAULT NULL,
  `subperms` varchar(50) DEFAULT NULL,
  `type` varchar(1) DEFAULT NULL,
  `bydefault` tinyint(4) DEFAULT 0,
  `enabled` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_rights_def`
--

INSERT INTO `llx_rights_def` (`id`, `entity`, `libelle`, `module`, `module_origin`, `module_position`, `family_position`, `perms`, `subperms`, `type`, `bydefault`, `enabled`) VALUES
(11, 1, 'Read invoices', 'facture', '', 0, 0, 'lire', '', 'a', 0, '1'),
(12, 1, 'Create and update invoices', 'facture', '', 0, 0, 'creer', '', 'a', 0, '1'),
(13, 1, 'Devalidate invoices', 'facture', '', 0, 0, 'invoice_advance', 'unvalidate', 'a', 0, '1'),
(14, 1, 'Validate invoices', 'facture', '', 0, 0, 'invoice_advance', 'validate', 'a', 0, '1'),
(15, 1, 'Send invoices by email', 'facture', '', 0, 0, 'invoice_advance', 'send', 'a', 0, '1'),
(16, 1, 'Issue payments on invoices', 'facture', '', 0, 0, 'paiement', '', 'a', 0, '1'),
(19, 1, 'Delete invoices', 'facture', '', 0, 0, 'supprimer', '', 'a', 0, '1'),
(21, 1, 'Read commercial proposals', 'propale', '', 0, 0, 'lire', '', 'r', 0, '1'),
(22, 1, 'Create and update commercial proposals', 'propale', '', 0, 0, 'creer', '', 'w', 0, '1'),
(24, 1, 'Validate commercial proposals', 'propale', '', 0, 0, 'propal_advance', 'validate', 'd', 0, '1'),
(25, 1, 'Send commercial proposals to customers', 'propale', '', 0, 0, 'propal_advance', 'send', 'd', 0, '1'),
(26, 1, 'Close commercial proposals', 'propale', '', 0, 0, 'propal_advance', 'close', 'd', 0, '1'),
(27, 1, 'Delete commercial proposals', 'propale', '', 0, 0, 'supprimer', '', 'd', 0, '1'),
(28, 1, 'Exporting commercial proposals and attributes', 'propale', '', 0, 0, 'export', '', 'r', 0, '1'),
(31, 1, 'Read products', 'produit', '', 26, 0, 'lire', '', 'r', 0, '1'),
(32, 1, 'Create/modify products', 'produit', '', 26, 0, 'creer', '', 'w', 0, '1'),
(33, 1, 'Read prices products', 'produit', '', 26, 0, 'product_advance', 'read_prices', 'w', 0, '1'),
(34, 1, 'Delete products', 'produit', '', 26, 0, 'supprimer', '', 'd', 0, '1'),
(38, 1, 'Export products', 'produit', '', 26, 0, 'export', '', 'r', 0, '1'),
(39, 1, 'Ignore minimum price', 'produit', '', 26, 0, 'ignore_price_min_advance', '', 'r', 0, '1'),
(81, 1, 'Read sales orders', 'commande', '', 0, 0, 'lire', '', 'r', 0, '1'),
(82, 1, 'Creeat/modify sales orders', 'commande', '', 0, 0, 'creer', '', 'w', 0, '1'),
(84, 1, 'Validate sales orders', 'commande', '', 0, 0, 'order_advance', 'validate', 'd', 0, '1'),
(85, 1, 'Generate the documents sales orders', 'commande', '', 0, 0, 'order_advance', 'generetedoc', 'd', 0, '1'),
(86, 1, 'Send sales orders by email', 'commande', '', 0, 0, 'order_advance', 'send', 'd', 0, '1'),
(87, 1, 'Close sale orders', 'commande', '', 0, 0, 'order_advance', 'close', 'd', 0, '1'),
(88, 1, 'Cancel sale orders', 'commande', '', 0, 0, 'order_advance', 'annuler', 'd', 0, '1'),
(89, 1, 'Delete sales orders', 'commande', '', 0, 0, 'supprimer', '', 'd', 0, '1'),
(121, 1, 'Read third parties', 'societe', '', 9, 0, 'lire', '', 'r', 0, '1'),
(122, 1, 'Create and update third parties', 'societe', '', 9, 0, 'creer', '', 'w', 0, '1'),
(125, 1, 'Delete third parties', 'societe', '', 9, 0, 'supprimer', '', 'd', 0, '1'),
(126, 1, 'Export third parties', 'societe', '', 9, 0, 'export', '', 'r', 0, '1'),
(130, 1, 'Modify thirdparty information payment', 'societe', '', 9, 0, 'thirdparty_paymentinformation_advance', 'write', 'w', 0, '1'),
(241, 1, 'Lire les categories', 'categorie', '', 0, 0, 'lire', '', 'r', 0, '1'),
(242, 1, 'Creer/modifier les categories', 'categorie', '', 0, 0, 'creer', '', 'w', 0, '1'),
(243, 1, 'Supprimer les categories', 'categorie', '', 0, 0, 'supprimer', '', 'd', 0, '1'),
(251, 1, 'Read information of other users, groups and permissions', 'user', '', 5, 0, 'user', 'lire', 'w', 0, '1'),
(252, 1, 'Read permissions of other users', 'user', '', 5, 0, 'user_advance', 'readperms', 'w', 0, '1'),
(253, 1, 'Create/modify internal and external users, groups and permissions', 'user', '', 5, 0, 'user', 'creer', 'w', 0, '1'),
(254, 1, 'Create/modify external users only', 'user', '', 5, 0, 'user_advance', 'write', 'w', 0, '1'),
(255, 1, 'Modify the password of other users', 'user', '', 5, 0, 'user', 'password', 'w', 0, '1'),
(256, 1, 'Delete or disable other users', 'user', '', 5, 0, 'user', 'supprimer', 'w', 0, '1'),
(262, 1, 'Read all third parties (and their objects) by internal users (otherwise only if commercial contact). Not effective for external users (limited to themselves).', 'societe', '', 9, 0, 'client', 'voir', 'r', 0, '1'),
(281, 1, 'Read contacts', 'societe', '', 9, 0, 'contact', 'lire', 'r', 0, '1'),
(282, 1, 'Create and update contact', 'societe', '', 9, 0, 'contact', 'creer', 'w', 0, '1'),
(283, 1, 'Delete contacts', 'societe', '', 9, 0, 'contact', 'supprimer', 'd', 0, '1'),
(286, 1, 'Export contacts', 'societe', '', 9, 0, 'contact', 'export', 'd', 0, '1'),
(341, 1, 'Read its own permissions', 'user', '', 5, 0, 'self_advance', 'readperms', 'w', 0, '1'),
(342, 1, 'Create/modify of its own user', 'user', '', 5, 0, 'self', 'creer', 'w', 0, '1'),
(343, 1, 'Modify its own password', 'user', '', 5, 0, 'self', 'password', 'w', 0, '1'),
(344, 1, 'Modify its own permissions', 'user', '', 5, 0, 'self_advance', 'writeperms', 'w', 0, '1'),
(351, 1, 'Read groups', 'user', '', 5, 0, 'group_advance', 'read', 'w', 0, '1'),
(352, 1, 'Read permissions of groups', 'user', '', 5, 0, 'group_advance', 'readperms', 'w', 0, '1'),
(353, 1, 'Create/modify groups and permissions', 'user', '', 5, 0, 'group_advance', 'write', 'w', 0, '1'),
(354, 1, 'Delete groups', 'user', '', 5, 0, 'group_advance', 'delete', 'w', 0, '1'),
(358, 1, 'Export all users', 'user', '', 5, 0, 'user', 'export', 'w', 0, '1'),
(531, 1, 'Read services', 'service', '', 0, 0, 'lire', '', 'r', 0, '1'),
(532, 1, 'Create/modify services', 'service', '', 0, 0, 'creer', '', 'w', 0, '1'),
(533, 1, 'Read prices services', 'service', '', 0, 0, 'service_advance', 'read_prices', 'w', 0, '1'),
(534, 1, 'Delete les services', 'service', '', 0, 0, 'supprimer', '', 'd', 0, '1'),
(538, 1, 'Export services', 'service', '', 0, 0, 'export', '', 'r', 0, '1'),
(1001, 1, 'Read stocks', 'stock', '', 0, 0, 'lire', '', 'r', 0, '1'),
(1002, 1, 'Create/Modify stocks', 'stock', '', 0, 0, 'creer', '', 'w', 0, '1'),
(1003, 1, 'Delete stock', 'stock', '', 0, 0, 'supprimer', '', 'd', 0, '1'),
(1004, 1, 'Read stock movements', 'stock', '', 0, 0, 'mouvement', 'lire', 'r', 0, '1'),
(1005, 1, 'Create/modify stock movements', 'stock', '', 0, 0, 'mouvement', 'creer', 'w', 0, '1'),
(1011, 1, 'inventoryReadPermission', 'stock', '', 0, 0, 'inventory_advance', 'read', 'w', 0, '1'),
(1012, 1, 'inventoryCreatePermission', 'stock', '', 0, 0, 'inventory_advance', 'write', 'w', 0, '1'),
(1013, 1, 'inventoryDeletePermission', 'stock', '', 0, 0, 'inventory_advance', 'delete', 'w', 0, '1'),
(1201, 1, 'Read exports', 'export', '', 72, 0, 'lire', '', 'r', 0, '1'),
(1202, 1, 'Creeate/modify export', 'export', '', 72, 0, 'creer', '', 'w', 0, '1'),
(1251, 1, 'Run mass imports of external data (data load)', 'import', '', 70, 0, 'run', '', 'r', 0, '1'),
(1321, 1, 'Export customer invoices, attributes and payments', 'facture', '', 0, 0, 'facture', 'export', 'r', 0, '1'),
(1322, 1, 'Re-open a fully paid invoice', 'facture', '', 0, 0, 'invoice_advance', 'reopen', 'r', 0, '1'),
(1421, 1, 'Export sales orders and attributes', 'commande', '', 0, 0, 'commande', 'export', 'r', 0, '1'),
(2401, 1, 'Read actions/tasks linked to his account', 'agenda', '', 16, 0, 'myactions', 'read', 'r', 0, '1'),
(2402, 1, 'Create/modify actions/tasks linked to his account', 'agenda', '', 16, 0, 'myactions', 'create', 'w', 0, '1'),
(2403, 1, 'Delete actions/tasks linked to his account', 'agenda', '', 16, 0, 'myactions', 'delete', 'w', 0, '1'),
(2411, 1, 'Read actions/tasks of others', 'agenda', '', 16, 0, 'allactions', 'read', 'r', 0, '1'),
(2412, 1, 'Create/modify actions/tasks of others', 'agenda', '', 16, 0, 'allactions', 'create', 'w', 0, '1'),
(2413, 1, 'Delete actions/tasks of others', 'agenda', '', 16, 0, 'allactions', 'delete', 'w', 0, '1'),
(2414, 1, 'Export actions/tasks of others', 'agenda', '', 16, 0, 'export', '', 'w', 0, '1'),
(2610, 1, 'Generate/modify users API key', 'api', '', 24, 0, 'apikey', 'generate', 'w', 0, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_salary`
--

CREATE TABLE `llx_salary` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(30) DEFAULT NULL,
  `ref_ext` varchar(255) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `fk_user` int(11) NOT NULL,
  `datep` date DEFAULT NULL,
  `datev` date DEFAULT NULL,
  `salary` double(24,8) DEFAULT NULL,
  `amount` double(24,8) NOT NULL DEFAULT 0.00000000,
  `fk_projet` int(11) DEFAULT NULL,
  `fk_typepayment` int(11) NOT NULL,
  `num_payment` varchar(50) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `datesp` date DEFAULT NULL,
  `dateep` date DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `note` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `fk_bank` int(11) DEFAULT NULL,
  `paye` smallint(6) NOT NULL DEFAULT 0,
  `fk_account` int(11) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_salary_extrafields`
--

CREATE TABLE `llx_salary_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_societe`
--

CREATE TABLE `llx_societe` (
  `rowid` int(11) NOT NULL,
  `nom` varchar(128) DEFAULT NULL,
  `name_alias` varchar(128) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref_ext` varchar(255) DEFAULT NULL,
  `statut` tinyint(4) DEFAULT 0,
  `parent` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `code_client` varchar(24) DEFAULT NULL,
  `code_fournisseur` varchar(24) DEFAULT NULL,
  `tp_payment_reference` varchar(25) DEFAULT NULL,
  `accountancy_code_customer_general` varchar(32) DEFAULT NULL,
  `code_compta` varchar(32) DEFAULT NULL,
  `accountancy_code_supplier_general` varchar(32) DEFAULT NULL,
  `code_compta_fournisseur` varchar(32) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `zip` varchar(25) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `fk_departement` int(11) DEFAULT 0,
  `fk_pays` int(11) DEFAULT 0,
  `geolat` double(24,8) DEFAULT NULL,
  `geolong` double(24,8) DEFAULT NULL,
  `geopoint` point DEFAULT NULL,
  `georesultcode` varchar(16) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `phone_mobile` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `fk_account` int(11) DEFAULT 0,
  `socialnetworks` text DEFAULT NULL,
  `fk_effectif` int(11) DEFAULT 0,
  `fk_typent` int(11) DEFAULT NULL,
  `fk_forme_juridique` int(11) DEFAULT 0,
  `fk_currency` varchar(3) DEFAULT NULL,
  `siren` varchar(128) DEFAULT NULL,
  `siret` varchar(128) DEFAULT NULL,
  `ape` varchar(128) DEFAULT NULL,
  `idprof4` varchar(128) DEFAULT NULL,
  `idprof5` varchar(128) DEFAULT NULL,
  `idprof6` varchar(128) DEFAULT NULL,
  `tva_intra` varchar(20) DEFAULT NULL,
  `capital` double(24,8) DEFAULT NULL,
  `fk_stcomm` int(11) NOT NULL DEFAULT 0,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `prefix_comm` varchar(5) DEFAULT NULL,
  `client` tinyint(4) DEFAULT 0,
  `fournisseur` tinyint(4) DEFAULT 0,
  `supplier_account` varchar(32) DEFAULT NULL,
  `fk_prospectlevel` varchar(12) DEFAULT NULL,
  `fk_incoterms` int(11) DEFAULT NULL,
  `location_incoterms` varchar(255) DEFAULT NULL,
  `customer_bad` tinyint(4) DEFAULT 0,
  `customer_rate` double DEFAULT 0,
  `supplier_rate` double DEFAULT 0,
  `remise_client` double DEFAULT 0,
  `remise_supplier` double DEFAULT 0,
  `mode_reglement` tinyint(4) DEFAULT NULL,
  `cond_reglement` tinyint(4) DEFAULT NULL,
  `deposit_percent` varchar(63) DEFAULT NULL,
  `transport_mode` tinyint(4) DEFAULT NULL,
  `mode_reglement_supplier` tinyint(4) DEFAULT NULL,
  `cond_reglement_supplier` tinyint(4) DEFAULT NULL,
  `transport_mode_supplier` tinyint(4) DEFAULT NULL,
  `fk_shipping_method` int(11) DEFAULT NULL,
  `tva_assuj` tinyint(4) DEFAULT 1,
  `vat_reverse_charge` tinyint(4) DEFAULT 0,
  `localtax1_assuj` tinyint(4) DEFAULT 0,
  `localtax1_value` double(7,4) DEFAULT NULL,
  `localtax2_assuj` tinyint(4) DEFAULT 0,
  `localtax2_value` double(7,4) DEFAULT NULL,
  `barcode` varchar(180) DEFAULT NULL,
  `fk_barcode_type` int(11) DEFAULT 0,
  `price_level` int(11) DEFAULT NULL,
  `outstanding_limit` double(24,8) DEFAULT NULL,
  `order_min_amount` double(24,8) DEFAULT NULL,
  `supplier_order_min_amount` double(24,8) DEFAULT NULL,
  `default_lang` varchar(6) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `logo_squarred` varchar(255) DEFAULT NULL,
  `canvas` varchar(32) DEFAULT NULL,
  `fk_warehouse` int(11) DEFAULT NULL,
  `webservices_url` varchar(255) DEFAULT NULL,
  `webservices_key` varchar(128) DEFAULT NULL,
  `accountancy_code_sell` varchar(32) DEFAULT NULL,
  `accountancy_code_buy` varchar(32) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `ip` varchar(250) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_societe_account`
--

CREATE TABLE `llx_societe_account` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) DEFAULT 1,
  `login` varchar(128) NOT NULL,
  `pass_encoding` varchar(24) DEFAULT NULL,
  `pass_crypted` varchar(128) DEFAULT NULL,
  `pass_temp` varchar(128) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_website` int(11) DEFAULT NULL,
  `site` varchar(128) NOT NULL,
  `site_account` varchar(128) DEFAULT NULL,
  `key_account` varchar(128) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `date_last_login` datetime DEFAULT NULL,
  `date_previous_login` datetime DEFAULT NULL,
  `date_last_reset_password` datetime DEFAULT NULL,
  `date_creation` datetime NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_creat` int(11) NOT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_societe_commerciaux`
--

CREATE TABLE `llx_societe_commerciaux` (
  `rowid` int(11) NOT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `fk_c_type_contact_code` varchar(32) NOT NULL DEFAULT 'SALESREPTHIRD',
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_societe_contacts`
--

CREATE TABLE `llx_societe_contacts` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `date_creation` datetime NOT NULL,
  `fk_soc` int(11) NOT NULL,
  `fk_c_type_contact` int(11) NOT NULL,
  `fk_socpeople` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_societe_extrafields`
--

CREATE TABLE `llx_societe_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_societe_prices`
--

CREATE TABLE `llx_societe_prices` (
  `rowid` int(11) NOT NULL,
  `fk_soc` int(11) DEFAULT 0,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `price_level` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_societe_remise`
--

CREATE TABLE `llx_societe_remise` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_soc` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `remise_client` double(7,4) NOT NULL DEFAULT 0.0000,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_societe_remise_except`
--

CREATE TABLE `llx_societe_remise_except` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_soc` int(11) NOT NULL,
  `discount_type` int(11) NOT NULL DEFAULT 0,
  `datec` datetime DEFAULT NULL,
  `amount_ht` double(24,8) NOT NULL,
  `amount_tva` double(24,8) NOT NULL DEFAULT 0.00000000,
  `amount_ttc` double(24,8) NOT NULL DEFAULT 0.00000000,
  `tva_tx` double(7,4) NOT NULL DEFAULT 0.0000,
  `vat_src_code` varchar(10) DEFAULT '',
  `fk_user` int(11) NOT NULL,
  `fk_facture_line` int(11) DEFAULT NULL,
  `fk_facture` int(11) DEFAULT NULL,
  `fk_facture_source` int(11) DEFAULT NULL,
  `fk_invoice_supplier_line` int(11) DEFAULT NULL,
  `fk_invoice_supplier` int(11) DEFAULT NULL,
  `fk_invoice_supplier_source` int(11) DEFAULT NULL,
  `description` text NOT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT NULL,
  `multicurrency_amount_ht` double(24,8) NOT NULL DEFAULT 0.00000000,
  `multicurrency_amount_tva` double(24,8) NOT NULL DEFAULT 0.00000000,
  `multicurrency_amount_ttc` double(24,8) NOT NULL DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_societe_remise_supplier`
--

CREATE TABLE `llx_societe_remise_supplier` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_soc` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `remise_supplier` double(7,4) NOT NULL DEFAULT 0.0000,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_societe_rib`
--

CREATE TABLE `llx_societe_rib` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `type` varchar(32) NOT NULL DEFAULT 'ban',
  `label` varchar(180) DEFAULT NULL,
  `fk_soc` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `bank` varchar(255) DEFAULT NULL,
  `code_banque` varchar(128) DEFAULT NULL,
  `code_guichet` varchar(6) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `cle_rib` varchar(5) DEFAULT NULL,
  `bic` varchar(20) DEFAULT NULL,
  `bic_intermediate` varchar(11) DEFAULT NULL,
  `iban_prefix` varchar(100) DEFAULT NULL,
  `domiciliation` varchar(255) DEFAULT NULL,
  `proprio` varchar(60) DEFAULT NULL,
  `owner_address` varchar(255) DEFAULT NULL,
  `default_rib` smallint(6) NOT NULL DEFAULT 0,
  `state_id` int(11) DEFAULT NULL,
  `fk_country` int(11) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `rum` varchar(32) DEFAULT NULL,
  `date_rum` date DEFAULT NULL,
  `frstrecur` varchar(16) DEFAULT 'FRST',
  `last_four` varchar(4) DEFAULT NULL,
  `card_type` varchar(255) DEFAULT NULL,
  `cvn` varchar(255) DEFAULT NULL,
  `exp_date_month` int(11) DEFAULT NULL,
  `exp_date_year` int(11) DEFAULT NULL,
  `country_code` varchar(10) DEFAULT NULL,
  `approved` int(11) DEFAULT 0,
  `email` varchar(255) DEFAULT NULL,
  `ending_date` date DEFAULT NULL,
  `max_total_amount_of_all_payments` double(24,8) DEFAULT NULL,
  `preapproval_key` varchar(255) DEFAULT NULL,
  `starting_date` date DEFAULT NULL,
  `total_amount_of_all_payments` double(24,8) DEFAULT NULL,
  `stripe_card_ref` varchar(128) DEFAULT NULL,
  `stripe_account` varchar(128) DEFAULT NULL,
  `ext_payment_site` varchar(128) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL,
  `date_signature` datetime DEFAULT NULL,
  `online_sign_ip` varchar(48) DEFAULT NULL,
  `online_sign_name` varchar(64) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `ipaddress` varchar(68) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_socpeople`
--

CREATE TABLE `llx_socpeople` (
  `rowid` int(11) NOT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_soc` int(11) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref_ext` varchar(255) DEFAULT NULL,
  `name_alias` varchar(255) DEFAULT NULL,
  `fk_parent` int(11) DEFAULT NULL,
  `civility` varchar(6) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `zip` varchar(25) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  `fk_departement` int(11) DEFAULT NULL,
  `fk_pays` int(11) DEFAULT 0,
  `geolat` double(24,8) DEFAULT NULL,
  `geolong` double(24,8) DEFAULT NULL,
  `geopoint` point DEFAULT NULL,
  `georesultcode` varchar(16) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `poste` varchar(255) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `phone_perso` varchar(30) DEFAULT NULL,
  `phone_mobile` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `socialnetworks` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `no_email` smallint(6) NOT NULL DEFAULT 0,
  `priv` smallint(6) NOT NULL DEFAULT 0,
  `fk_prospectlevel` varchar(12) DEFAULT NULL,
  `fk_stcommcontact` int(11) NOT NULL DEFAULT 0,
  `fk_user_creat` int(11) DEFAULT 0,
  `fk_user_modif` int(11) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `default_lang` varchar(6) DEFAULT NULL,
  `canvas` varchar(32) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `statut` tinyint(4) NOT NULL DEFAULT 1,
  `ip` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_socpeople_extrafields`
--

CREATE TABLE `llx_socpeople_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_stock_mouvement`
--

CREATE TABLE `llx_stock_mouvement` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datem` datetime DEFAULT NULL,
  `fk_product` int(11) NOT NULL,
  `batch` varchar(128) DEFAULT NULL,
  `eatby` date DEFAULT NULL,
  `sellby` date DEFAULT NULL,
  `fk_entrepot` int(11) NOT NULL,
  `value` double DEFAULT NULL,
  `price` double(24,8) DEFAULT 0.00000000,
  `type_mouvement` smallint(6) DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `inventorycode` varchar(128) DEFAULT NULL,
  `fk_project` int(11) DEFAULT NULL,
  `fk_origin` int(11) DEFAULT NULL,
  `origintype` varchar(64) DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `fk_projet` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_stock_mouvement`
--

INSERT INTO `llx_stock_mouvement` (`rowid`, `tms`, `datem`, `fk_product`, `batch`, `eatby`, `sellby`, `fk_entrepot`, `value`, `price`, `type_mouvement`, `fk_user_author`, `label`, `inventorycode`, `fk_project`, `fk_origin`, `origintype`, `model_pdf`, `fk_projet`) VALUES
(6, '2025-12-31 03:31:35', '2025-12-31 04:31:35', 5, NULL, NULL, NULL, 3, 500, 0.00000000, 0, 1, 'Correción de sotck del producto CM5X5A3', '20251231043053', NULL, 0, '', NULL, 0),
(7, '2025-12-31 03:32:09', '2025-12-31 04:32:09', 7, NULL, NULL, NULL, 3, 500, 0.00000000, 0, 1, 'Correción de sotck del producto SILLA-C-P', '20251231043205', NULL, 0, '', NULL, 0),
(8, '2025-12-31 03:32:29', '2025-12-31 04:32:29', 8, NULL, NULL, NULL, 3, 50, 0.00000000, 0, 1, 'Correción de sotck del producto MESA-R', '20251231043224', NULL, 0, '', NULL, 0),
(9, '2025-12-31 03:32:49', '2025-12-31 04:32:49', 5, NULL, NULL, NULL, 3, 10, 0.00000000, 0, 1, 'Correción de sotck del producto CM5X5A3', '20251231043240', NULL, 0, '', NULL, 0),
(10, '2025-12-31 03:32:58', '2025-12-31 04:32:58', 5, NULL, NULL, NULL, 3, -500, 0.00000000, 1, 1, 'Correción de sotck del producto CM5X5A3', '20251231043254', NULL, 0, '', NULL, 0),
(11, '2025-12-31 03:33:39', '2025-12-31 04:33:39', 6, NULL, NULL, NULL, 3, 100, 0.00000000, 0, 1, 'Correción de sotck del producto SILLA-TIFF', '20251231043325', NULL, 0, '', NULL, 0),
(12, '2025-12-31 03:33:50', '2025-12-31 04:33:50', 6, NULL, NULL, NULL, 3, 100, 0.00000000, 0, 1, 'Correción de sotck del producto SILLA-TIFF', '20251231043325', NULL, 0, '', NULL, 0),
(13, '2025-12-31 03:34:02', '2025-12-31 04:34:02', 6, NULL, NULL, NULL, 3, -100, 0.00000000, 1, 1, 'Correción de sotck del producto SILLA-TIFF', '20251231043357', NULL, 0, '', NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_stock_mouvement_extrafields`
--

CREATE TABLE `llx_stock_mouvement_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_subscription`
--

CREATE TABLE `llx_subscription` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `fk_adherent` int(11) DEFAULT NULL,
  `fk_type` int(11) DEFAULT NULL,
  `dateadh` datetime DEFAULT NULL,
  `datef` datetime DEFAULT NULL,
  `subscription` double(24,8) DEFAULT NULL,
  `fk_bank` int(11) DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_supplier_proposal`
--

CREATE TABLE `llx_supplier_proposal` (
  `rowid` int(11) NOT NULL,
  `ref` varchar(30) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref_ext` varchar(255) DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_projet` int(11) DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `date_valid` datetime DEFAULT NULL,
  `date_cloture` datetime DEFAULT NULL,
  `fk_user_author` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `fk_user_valid` int(11) DEFAULT NULL,
  `fk_user_cloture` int(11) DEFAULT NULL,
  `fk_statut` smallint(6) NOT NULL DEFAULT 0,
  `price` double DEFAULT 0,
  `remise_percent` double DEFAULT 0,
  `remise_absolue` double DEFAULT 0,
  `remise` double DEFAULT 0,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `localtax1` double(24,8) DEFAULT 0.00000000,
  `localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `fk_account` int(11) DEFAULT NULL,
  `fk_currency` varchar(3) DEFAULT NULL,
  `fk_cond_reglement` int(11) DEFAULT NULL,
  `fk_mode_reglement` int(11) DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `date_livraison` date DEFAULT NULL,
  `fk_shipping_method` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `extraparams` varchar(255) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_tx` double(24,8) DEFAULT 1.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_supplier_proposaldet`
--

CREATE TABLE `llx_supplier_proposaldet` (
  `rowid` int(11) NOT NULL,
  `fk_supplier_proposal` int(11) NOT NULL,
  `fk_parent_line` int(11) DEFAULT NULL,
  `fk_product` int(11) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `fk_remise_except` int(11) DEFAULT NULL,
  `vat_src_code` varchar(10) DEFAULT '',
  `tva_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_tx` double(7,4) DEFAULT 0.0000,
  `localtax1_type` varchar(10) DEFAULT NULL,
  `localtax2_tx` double(7,4) DEFAULT 0.0000,
  `localtax2_type` varchar(10) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `remise_percent` double DEFAULT 0,
  `remise` double DEFAULT 0,
  `price` double DEFAULT NULL,
  `subprice` double(24,8) DEFAULT 0.00000000,
  `subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `total_ht` double(24,8) DEFAULT 0.00000000,
  `total_tva` double(24,8) DEFAULT 0.00000000,
  `total_localtax1` double(24,8) DEFAULT 0.00000000,
  `total_localtax2` double(24,8) DEFAULT 0.00000000,
  `total_ttc` double(24,8) DEFAULT 0.00000000,
  `product_type` int(11) DEFAULT 0,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `info_bits` int(11) DEFAULT 0,
  `buy_price_ht` double(24,8) DEFAULT 0.00000000,
  `fk_product_fournisseur_price` int(11) DEFAULT NULL,
  `special_code` int(11) DEFAULT 0,
  `rang` int(11) DEFAULT 0,
  `ref_fourn` varchar(128) DEFAULT NULL,
  `fk_multicurrency` int(11) DEFAULT NULL,
  `multicurrency_code` varchar(3) DEFAULT NULL,
  `multicurrency_subprice` double(24,8) DEFAULT 0.00000000,
  `multicurrency_subprice_ttc` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ht` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_tva` double(24,8) DEFAULT 0.00000000,
  `multicurrency_total_ttc` double(24,8) DEFAULT 0.00000000,
  `fk_unit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_supplier_proposaldet_extrafields`
--

CREATE TABLE `llx_supplier_proposaldet_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_supplier_proposal_extrafields`
--

CREATE TABLE `llx_supplier_proposal_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_tva`
--

CREATE TABLE `llx_tva` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datec` datetime DEFAULT NULL,
  `datep` date DEFAULT NULL,
  `datev` date DEFAULT NULL,
  `amount` double(24,8) NOT NULL DEFAULT 0.00000000,
  `fk_typepayment` int(11) DEFAULT NULL,
  `num_payment` varchar(50) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `note` text DEFAULT NULL,
  `paye` smallint(6) NOT NULL DEFAULT 0,
  `fk_account` int(11) DEFAULT NULL,
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_user`
--

CREATE TABLE `llx_user` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref_employee` varchar(50) DEFAULT NULL,
  `ref_ext` varchar(50) DEFAULT NULL,
  `admin` smallint(6) DEFAULT 0,
  `employee` tinyint(4) DEFAULT 1,
  `fk_establishment` int(11) DEFAULT 0,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `login` varchar(50) NOT NULL,
  `pass_encoding` varchar(24) DEFAULT NULL,
  `pass` varchar(128) DEFAULT NULL,
  `pass_crypted` varchar(128) DEFAULT NULL,
  `pass_temp` varchar(128) DEFAULT NULL,
  `api_key` varchar(128) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `civility` varchar(6) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `zip` varchar(25) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `fk_state` int(11) DEFAULT 0,
  `fk_country` int(11) DEFAULT 0,
  `birth` date DEFAULT NULL,
  `birth_place` varchar(64) DEFAULT NULL,
  `job` varchar(128) DEFAULT NULL,
  `office_phone` varchar(20) DEFAULT NULL,
  `office_fax` varchar(20) DEFAULT NULL,
  `user_mobile` varchar(20) DEFAULT NULL,
  `personal_mobile` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `personal_email` varchar(255) DEFAULT NULL,
  `email_oauth2` varchar(255) DEFAULT NULL,
  `signature` longtext DEFAULT NULL,
  `socialnetworks` text DEFAULT NULL,
  `fk_soc` int(11) DEFAULT NULL,
  `fk_socpeople` int(11) DEFAULT NULL,
  `fk_member` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `fk_user_expense_validator` int(11) DEFAULT NULL,
  `fk_user_holiday_validator` int(11) DEFAULT NULL,
  `national_registration_number` varchar(50) DEFAULT NULL,
  `idpers1` varchar(128) DEFAULT NULL,
  `idpers2` varchar(128) DEFAULT NULL,
  `idpers3` varchar(128) DEFAULT NULL,
  `note_public` text DEFAULT NULL,
  `note_private` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL,
  `last_main_doc` varchar(255) DEFAULT NULL,
  `datelastlogin` datetime DEFAULT NULL,
  `datepreviouslogin` datetime DEFAULT NULL,
  `datelastpassvalidation` datetime DEFAULT NULL,
  `datestartvalidity` datetime DEFAULT NULL,
  `dateendvalidity` datetime DEFAULT NULL,
  `flagdelsessionsbefore` datetime DEFAULT NULL,
  `iplastlogin` varchar(250) DEFAULT NULL,
  `ippreviouslogin` varchar(250) DEFAULT NULL,
  `ldap_sid` varchar(255) DEFAULT NULL,
  `openid` varchar(255) DEFAULT NULL,
  `statut` tinyint(4) DEFAULT 1,
  `photo` varchar(255) DEFAULT NULL,
  `lang` varchar(6) DEFAULT NULL,
  `color` varchar(6) DEFAULT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `fk_barcode_type` int(11) DEFAULT 0,
  `accountancy_code_user_general` varchar(32) DEFAULT NULL,
  `accountancy_code` varchar(32) DEFAULT NULL,
  `nb_holiday` int(11) DEFAULT 0,
  `thm` double(24,8) DEFAULT NULL,
  `tjm` double(24,8) DEFAULT NULL,
  `salary` double(24,8) DEFAULT NULL,
  `salaryextra` double(24,8) DEFAULT NULL,
  `dateemployment` date DEFAULT NULL,
  `dateemploymentend` date DEFAULT NULL,
  `weeklyhours` double(16,8) DEFAULT NULL,
  `import_key` varchar(14) DEFAULT NULL,
  `default_range` int(11) DEFAULT NULL,
  `default_c_exp_tax_cat` int(11) DEFAULT NULL,
  `fk_warehouse` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_user`
--

INSERT INTO `llx_user` (`rowid`, `entity`, `ref_employee`, `ref_ext`, `admin`, `employee`, `fk_establishment`, `datec`, `tms`, `fk_user_creat`, `fk_user_modif`, `login`, `pass_encoding`, `pass`, `pass_crypted`, `pass_temp`, `api_key`, `gender`, `civility`, `lastname`, `firstname`, `address`, `zip`, `town`, `fk_state`, `fk_country`, `birth`, `birth_place`, `job`, `office_phone`, `office_fax`, `user_mobile`, `personal_mobile`, `email`, `personal_email`, `email_oauth2`, `signature`, `socialnetworks`, `fk_soc`, `fk_socpeople`, `fk_member`, `fk_user`, `fk_user_expense_validator`, `fk_user_holiday_validator`, `national_registration_number`, `idpers1`, `idpers2`, `idpers3`, `note_public`, `note_private`, `model_pdf`, `last_main_doc`, `datelastlogin`, `datepreviouslogin`, `datelastpassvalidation`, `datestartvalidity`, `dateendvalidity`, `flagdelsessionsbefore`, `iplastlogin`, `ippreviouslogin`, `ldap_sid`, `openid`, `statut`, `photo`, `lang`, `color`, `barcode`, `fk_barcode_type`, `accountancy_code_user_general`, `accountancy_code`, `nb_holiday`, `thm`, `tjm`, `salary`, `salaryextra`, `dateemployment`, `dateemploymentend`, `weeklyhours`, `import_key`, `default_range`, `default_c_exp_tax_cat`, `fk_warehouse`) VALUES
(1, 0, '', NULL, 1, 1, NULL, '2025-08-08 03:21:11', '2025-12-28 16:50:08', NULL, NULL, 'arturo', NULL, NULL, '$2y$10$g0/KTcFykz/AHEyulnWay.97VYU3ExHj2t3lX55hYRdd38KV5AmEG', NULL, 'dolcrypt:AES-256-CTR:10fbb3f05469219f:UhPv7w3LSscoy+5XkhDMOu40rMWJXz5sCTe195hu/ok=', NULL, '', 'SuperAdmin', '', '', '', '', NULL, NULL, NULL, NULL, '', '', '', '', '', '', '', NULL, '', '[]', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '', '', NULL, NULL, '2026-01-07 03:58:27', '2025-12-31 05:55:49', NULL, NULL, NULL, '2025-08-08 01:21:06', '::1', '::1', '', NULL, 1, NULL, NULL, '', NULL, 0, '', '', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_usergroup`
--

CREATE TABLE `llx_usergroup` (
  `rowid` int(11) NOT NULL,
  `nom` varchar(180) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `note` text DEFAULT NULL,
  `model_pdf` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_usergroup_extrafields`
--

CREATE TABLE `llx_usergroup_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_usergroup_rights`
--

CREATE TABLE `llx_usergroup_rights` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_usergroup` int(11) NOT NULL,
  `fk_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_usergroup_user`
--

CREATE TABLE `llx_usergroup_user` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_user` int(11) NOT NULL,
  `fk_usergroup` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_user_alert`
--

CREATE TABLE `llx_user_alert` (
  `rowid` int(11) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `fk_contact` int(11) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_user_clicktodial`
--

CREATE TABLE `llx_user_clicktodial` (
  `fk_user` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `login` varchar(32) DEFAULT NULL,
  `pass` varchar(64) DEFAULT NULL,
  `poste` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_user_employment`
--

CREATE TABLE `llx_user_employment` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `ref` varchar(50) DEFAULT NULL,
  `ref_ext` varchar(50) DEFAULT NULL,
  `fk_user` int(11) DEFAULT NULL,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_user_creat` int(11) DEFAULT NULL,
  `fk_user_modif` int(11) DEFAULT NULL,
  `job` varchar(128) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `salary` double(24,8) DEFAULT NULL,
  `salaryextra` double(24,8) DEFAULT NULL,
  `weeklyhours` double(16,8) DEFAULT NULL,
  `dateemployment` date DEFAULT NULL,
  `dateemploymentend` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_user_extrafields`
--

CREATE TABLE `llx_user_extrafields` (
  `rowid` int(11) NOT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_object` int(11) NOT NULL,
  `import_key` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_user_param`
--

CREATE TABLE `llx_user_param` (
  `fk_user` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `param` varchar(180) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_user_param`
--

INSERT INTO `llx_user_param` (`fk_user`, `entity`, `param`, `value`) VALUES
(1, 1, 'USER_ENABLE_PUBLIC', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_user_rib`
--

CREATE TABLE `llx_user_rib` (
  `rowid` int(11) NOT NULL,
  `fk_user` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `datec` datetime DEFAULT NULL,
  `tms` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `label` varchar(30) DEFAULT NULL,
  `bank` varchar(255) DEFAULT NULL,
  `code_banque` varchar(128) DEFAULT NULL,
  `code_guichet` varchar(6) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `cle_rib` varchar(5) DEFAULT NULL,
  `bic` varchar(11) DEFAULT NULL,
  `bic_intermediate` varchar(11) DEFAULT NULL,
  `iban_prefix` varchar(80) DEFAULT NULL,
  `domiciliation` varchar(255) DEFAULT NULL,
  `proprio` varchar(60) DEFAULT NULL,
  `owner_address` varchar(255) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `fk_country` int(11) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `default_rib` smallint(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llx_user_rights`
--

CREATE TABLE `llx_user_rights` (
  `rowid` int(11) NOT NULL,
  `entity` int(11) NOT NULL DEFAULT 1,
  `fk_user` int(11) NOT NULL,
  `fk_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `llx_user_rights`
--

INSERT INTO `llx_user_rights` (`rowid`, `entity`, `fk_user`, `fk_id`) VALUES
(289, 1, 1, 11),
(283, 1, 1, 12),
(284, 1, 1, 13),
(285, 1, 1, 14),
(286, 1, 1, 15),
(288, 1, 1, 16),
(290, 1, 1, 19),
(279, 1, 1, 21),
(273, 1, 1, 22),
(274, 1, 1, 24),
(275, 1, 1, 25),
(276, 1, 1, 26),
(278, 1, 1, 27),
(280, 1, 1, 28),
(173, 1, 1, 31),
(174, 1, 1, 32),
(175, 1, 1, 33),
(176, 1, 1, 34),
(177, 1, 1, 38),
(178, 1, 1, 39),
(268, 1, 1, 81),
(262, 1, 1, 82),
(263, 1, 1, 84),
(264, 1, 1, 85),
(265, 1, 1, 86),
(266, 1, 1, 87),
(267, 1, 1, 88),
(269, 1, 1, 89),
(187, 1, 1, 121),
(188, 1, 1, 122),
(189, 1, 1, 125),
(190, 1, 1, 126),
(191, 1, 1, 130),
(245, 1, 1, 241),
(244, 1, 1, 242),
(246, 1, 1, 243),
(192, 1, 1, 251),
(193, 1, 1, 252),
(194, 1, 1, 253),
(195, 1, 1, 254),
(196, 1, 1, 255),
(197, 1, 1, 256),
(198, 1, 1, 262),
(199, 1, 1, 281),
(200, 1, 1, 282),
(201, 1, 1, 283),
(202, 1, 1, 286),
(203, 1, 1, 341),
(204, 1, 1, 342),
(205, 1, 1, 343),
(206, 1, 1, 344),
(207, 1, 1, 351),
(208, 1, 1, 352),
(209, 1, 1, 353),
(210, 1, 1, 354),
(211, 1, 1, 358),
(240, 1, 1, 531),
(236, 1, 1, 532),
(237, 1, 1, 533),
(239, 1, 1, 534),
(241, 1, 1, 538),
(250, 1, 1, 1001),
(249, 1, 1, 1002),
(251, 1, 1, 1003),
(253, 1, 1, 1004),
(254, 1, 1, 1005),
(258, 1, 1, 1011),
(257, 1, 1, 1012),
(259, 1, 1, 1013),
(220, 1, 1, 1201),
(221, 1, 1, 1202),
(222, 1, 1, 1251),
(291, 1, 1, 1321),
(292, 1, 1, 1322),
(270, 1, 1, 1421),
(226, 1, 1, 2401),
(227, 1, 1, 2402),
(228, 1, 1, 2403),
(229, 1, 1, 2411),
(230, 1, 1, 2412),
(231, 1, 1, 2413),
(232, 1, 1, 2414),
(233, 1, 1, 2610);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `llx_accounting_account`
--
ALTER TABLE `llx_accounting_account`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_accounting_account` (`account_number`,`entity`,`fk_pcg_version`),
  ADD KEY `idx_accounting_account_fk_pcg_version` (`fk_pcg_version`),
  ADD KEY `idx_accounting_account_account_parent` (`account_parent`);

--
-- Indices de la tabla `llx_accounting_bookkeeping`
--
ALTER TABLE `llx_accounting_bookkeeping`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_accounting_bookkeeping_fk_doc` (`fk_doc`),
  ADD KEY `idx_accounting_bookkeeping_fk_docdet` (`fk_docdet`),
  ADD KEY `idx_accounting_bookkeeping_doc_date` (`doc_date`),
  ADD KEY `idx_accounting_bookkeeping_numero_compte` (`numero_compte`,`entity`),
  ADD KEY `idx_accounting_bookkeeping_code_journal` (`code_journal`,`entity`),
  ADD KEY `idx_accounting_bookkeeping_piece_num` (`piece_num`,`entity`);

--
-- Indices de la tabla `llx_accounting_bookkeeping_tmp`
--
ALTER TABLE `llx_accounting_bookkeeping_tmp`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_accounting_bookkeeping_tmp_doc_date` (`doc_date`),
  ADD KEY `idx_accounting_bookkeeping_tmp_fk_docdet` (`fk_docdet`),
  ADD KEY `idx_accounting_bookkeeping_tmp_numero_compte` (`numero_compte`),
  ADD KEY `idx_accounting_bookkeeping_tmp_code_journal` (`code_journal`);

--
-- Indices de la tabla `llx_accounting_fiscalyear`
--
ALTER TABLE `llx_accounting_fiscalyear`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_accounting_groups_account`
--
ALTER TABLE `llx_accounting_groups_account`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_accounting_journal`
--
ALTER TABLE `llx_accounting_journal`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_accounting_journal_code` (`code`,`entity`);

--
-- Indices de la tabla `llx_accounting_system`
--
ALTER TABLE `llx_accounting_system`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_accounting_system_pcg_version` (`pcg_version`);

--
-- Indices de la tabla `llx_actioncomm`
--
ALTER TABLE `llx_actioncomm`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_actioncomm_fk_soc` (`fk_soc`),
  ADD KEY `idx_actioncomm_fk_contact` (`fk_contact`),
  ADD KEY `idx_actioncomm_code` (`code`),
  ADD KEY `idx_actioncomm_fk_element` (`fk_element`),
  ADD KEY `idx_actioncomm_fk_user_action` (`fk_user_action`),
  ADD KEY `idx_actioncomm_fk_project` (`fk_project`),
  ADD KEY `idx_actioncomm_datep` (`datep`),
  ADD KEY `idx_actioncomm_datep2` (`datep2`),
  ADD KEY `idx_actioncomm_recurid` (`recurid`),
  ADD KEY `idx_actioncomm_ref_ext` (`ref_ext`),
  ADD KEY `idx_actioncomm_percent` (`percent`),
  ADD KEY `idx_actioncomm_ref` (`ref`,`entity`);

--
-- Indices de la tabla `llx_actioncomm_extrafields`
--
ALTER TABLE `llx_actioncomm_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_actioncomm_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_actioncomm_reminder`
--
ALTER TABLE `llx_actioncomm_reminder`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_actioncomm_reminder_unique` (`fk_actioncomm`,`fk_user`,`typeremind`,`offsetvalue`,`offsetunit`),
  ADD KEY `idx_actioncomm_reminder_dateremind` (`dateremind`),
  ADD KEY `idx_actioncomm_reminder_fk_user` (`fk_user`),
  ADD KEY `idx_actioncomm_reminder_status` (`status`);

--
-- Indices de la tabla `llx_actioncomm_resources`
--
ALTER TABLE `llx_actioncomm_resources`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_actioncomm_resources` (`fk_actioncomm`,`element_type`,`fk_element`),
  ADD KEY `idx_actioncomm_resources_fk_element` (`fk_element`);

--
-- Indices de la tabla `llx_adherent`
--
ALTER TABLE `llx_adherent`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_adherent_ref` (`ref`,`entity`),
  ADD UNIQUE KEY `uk_adherent_login` (`login`,`entity`),
  ADD UNIQUE KEY `uk_adherent_fk_soc` (`fk_soc`),
  ADD KEY `idx_adherent_fk_adherent_type` (`fk_adherent_type`);

--
-- Indices de la tabla `llx_adherent_extrafields`
--
ALTER TABLE `llx_adherent_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_adherent_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_adherent_type`
--
ALTER TABLE `llx_adherent_type`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_adherent_type_libelle` (`libelle`,`entity`);

--
-- Indices de la tabla `llx_adherent_type_extrafields`
--
ALTER TABLE `llx_adherent_type_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_adherent_type_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_adherent_type_lang`
--
ALTER TABLE `llx_adherent_type_lang`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_bank`
--
ALTER TABLE `llx_bank`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_bank_datev` (`datev`),
  ADD KEY `idx_bank_dateo` (`dateo`),
  ADD KEY `idx_bank_fk_account` (`fk_account`),
  ADD KEY `idx_bank_rappro` (`rappro`),
  ADD KEY `idx_bank_num_releve` (`num_releve`);

--
-- Indices de la tabla `llx_bank_account`
--
ALTER TABLE `llx_bank_account`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_bank_account_label` (`label`,`entity`),
  ADD KEY `idx_fk_accountancy_journal` (`fk_accountancy_journal`);

--
-- Indices de la tabla `llx_bank_account_extrafields`
--
ALTER TABLE `llx_bank_account_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_bank_account_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_bank_extrafields`
--
ALTER TABLE `llx_bank_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_bank_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_bank_url`
--
ALTER TABLE `llx_bank_url`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_bank_url` (`fk_bank`,`url_id`,`type`),
  ADD KEY `idx_bank_url_url_id` (`url_id`);

--
-- Indices de la tabla `llx_blockedlog`
--
ALTER TABLE `llx_blockedlog`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `signature` (`signature`),
  ADD KEY `fk_object_element` (`fk_object`,`element`),
  ADD KEY `entity` (`entity`),
  ADD KEY `fk_user` (`fk_user`),
  ADD KEY `entity_action_certified` (`entity`,`action`,`certified`),
  ADD KEY `entity_rowid` (`entity`,`rowid`);

--
-- Indices de la tabla `llx_blockedlog_authority`
--
ALTER TABLE `llx_blockedlog_authority`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `signature` (`signature`);

--
-- Indices de la tabla `llx_bookmark`
--
ALTER TABLE `llx_bookmark`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_bookmark_title` (`fk_user`,`entity`,`title`);

--
-- Indices de la tabla `llx_bordereau_cheque`
--
ALTER TABLE `llx_bordereau_cheque`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_bordereau_cheque` (`ref`,`entity`);

--
-- Indices de la tabla `llx_boxes`
--
ALTER TABLE `llx_boxes`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_boxes` (`entity`,`box_id`,`position`,`fk_user`),
  ADD KEY `idx_boxes_boxid` (`box_id`),
  ADD KEY `idx_boxes_fk_user` (`fk_user`);

--
-- Indices de la tabla `llx_boxes_def`
--
ALTER TABLE `llx_boxes_def`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_boxes_def` (`file`,`entity`,`note`);

--
-- Indices de la tabla `llx_categorie`
--
ALTER TABLE `llx_categorie`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_categorie_ref` (`entity`,`fk_parent`,`label`,`type`);

--
-- Indices de la tabla `llx_categories_extrafields`
--
ALTER TABLE `llx_categories_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_categories_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_categorie_account`
--
ALTER TABLE `llx_categorie_account`
  ADD PRIMARY KEY (`fk_categorie`,`fk_account`),
  ADD KEY `idx_categorie_account_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_account_fk_account` (`fk_account`);

--
-- Indices de la tabla `llx_categorie_actioncomm`
--
ALTER TABLE `llx_categorie_actioncomm`
  ADD PRIMARY KEY (`fk_categorie`,`fk_actioncomm`),
  ADD KEY `idx_categorie_actioncomm_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_actioncomm_fk_actioncomm` (`fk_actioncomm`);

--
-- Indices de la tabla `llx_categorie_contact`
--
ALTER TABLE `llx_categorie_contact`
  ADD PRIMARY KEY (`fk_categorie`,`fk_socpeople`),
  ADD KEY `idx_categorie_contact_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_contact_fk_socpeople` (`fk_socpeople`);

--
-- Indices de la tabla `llx_categorie_fournisseur`
--
ALTER TABLE `llx_categorie_fournisseur`
  ADD PRIMARY KEY (`fk_categorie`,`fk_soc`),
  ADD KEY `idx_categorie_fournisseur_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_fournisseur_fk_societe` (`fk_soc`);

--
-- Indices de la tabla `llx_categorie_invoice`
--
ALTER TABLE `llx_categorie_invoice`
  ADD PRIMARY KEY (`fk_categorie`,`fk_invoice`),
  ADD KEY `idx_categorie_invoice_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_invoice_fk_invoice` (`fk_invoice`);

--
-- Indices de la tabla `llx_categorie_lang`
--
ALTER TABLE `llx_categorie_lang`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_category_lang` (`fk_category`,`lang`);

--
-- Indices de la tabla `llx_categorie_member`
--
ALTER TABLE `llx_categorie_member`
  ADD PRIMARY KEY (`fk_categorie`,`fk_member`),
  ADD KEY `idx_categorie_member_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_member_fk_member` (`fk_member`);

--
-- Indices de la tabla `llx_categorie_order`
--
ALTER TABLE `llx_categorie_order`
  ADD PRIMARY KEY (`fk_categorie`,`fk_order`),
  ADD KEY `idx_categorie_order_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_order_fk_order` (`fk_order`);

--
-- Indices de la tabla `llx_categorie_product`
--
ALTER TABLE `llx_categorie_product`
  ADD PRIMARY KEY (`fk_categorie`,`fk_product`),
  ADD KEY `idx_categorie_product_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_product_fk_product` (`fk_product`);

--
-- Indices de la tabla `llx_categorie_project`
--
ALTER TABLE `llx_categorie_project`
  ADD PRIMARY KEY (`fk_categorie`,`fk_project`),
  ADD KEY `idx_categorie_project_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_project_fk_project` (`fk_project`);

--
-- Indices de la tabla `llx_categorie_societe`
--
ALTER TABLE `llx_categorie_societe`
  ADD PRIMARY KEY (`fk_categorie`,`fk_soc`),
  ADD KEY `idx_categorie_societe_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_societe_fk_societe` (`fk_soc`);

--
-- Indices de la tabla `llx_categorie_supplier_invoice`
--
ALTER TABLE `llx_categorie_supplier_invoice`
  ADD PRIMARY KEY (`fk_categorie`,`fk_supplier_invoice`),
  ADD KEY `idx_categorie_supplier_invoice_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_supplier_invoice_fk_supplier_invoice` (`fk_supplier_invoice`);

--
-- Indices de la tabla `llx_categorie_supplier_order`
--
ALTER TABLE `llx_categorie_supplier_order`
  ADD PRIMARY KEY (`fk_categorie`,`fk_supplier_order`),
  ADD KEY `idx_categorie_supplier_order_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_supplier_order_fk_supplier_order` (`fk_supplier_order`);

--
-- Indices de la tabla `llx_categorie_user`
--
ALTER TABLE `llx_categorie_user`
  ADD PRIMARY KEY (`fk_categorie`,`fk_user`),
  ADD KEY `idx_categorie_user_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_user_fk_user` (`fk_user`);

--
-- Indices de la tabla `llx_categorie_warehouse`
--
ALTER TABLE `llx_categorie_warehouse`
  ADD PRIMARY KEY (`fk_categorie`,`fk_warehouse`),
  ADD KEY `idx_categorie_warehouse_fk_categorie` (`fk_categorie`),
  ADD KEY `idx_categorie_warehouse_fk_warehouse` (`fk_warehouse`);

--
-- Indices de la tabla `llx_category_bank`
--
ALTER TABLE `llx_category_bank`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_category_bankline`
--
ALTER TABLE `llx_category_bankline`
  ADD UNIQUE KEY `uk_category_bankline_lineid` (`lineid`,`fk_categ`);

--
-- Indices de la tabla `llx_chargesociales`
--
ALTER TABLE `llx_chargesociales`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_chargesociales_fk_type` (`fk_type`),
  ADD KEY `idx_chargesociales_fk_account` (`fk_account`),
  ADD KEY `idx_chargesociales_fk_mode_reglement` (`fk_mode_reglement`),
  ADD KEY `idx_chargesociales_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_chargesociales_fk_user_modif` (`fk_user_modif`),
  ADD KEY `idx_chargesociales_fk_user_valid` (`fk_user_valid`),
  ADD KEY `idx_chargesociales_fk_projet` (`fk_projet`),
  ADD KEY `idx_chargesociales_fk_user` (`fk_user`);

--
-- Indices de la tabla `llx_commande`
--
ALTER TABLE `llx_commande`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_commande_ref` (`ref`,`entity`),
  ADD KEY `idx_commande_fk_soc` (`fk_soc`),
  ADD KEY `idx_commande_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_commande_fk_user_valid` (`fk_user_valid`),
  ADD KEY `idx_commande_fk_user_cloture` (`fk_user_cloture`),
  ADD KEY `idx_commande_fk_projet` (`fk_projet`),
  ADD KEY `idx_commande_fk_account` (`fk_account`),
  ADD KEY `idx_commande_fk_currency` (`fk_currency`);

--
-- Indices de la tabla `llx_commandedet`
--
ALTER TABLE `llx_commandedet`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_commandedet_fk_commande` (`fk_commande`),
  ADD KEY `idx_commandedet_fk_product` (`fk_product`),
  ADD KEY `fk_commandedet_fk_unit` (`fk_unit`),
  ADD KEY `fk_commandedet_fk_commandefourndet` (`fk_commandefourndet`);

--
-- Indices de la tabla `llx_commandedet_extrafields`
--
ALTER TABLE `llx_commandedet_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_commandedet_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_commande_extrafields`
--
ALTER TABLE `llx_commande_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_commande_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_commande_fournisseur`
--
ALTER TABLE `llx_commande_fournisseur`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_commande_fournisseur_ref` (`ref`,`entity`),
  ADD KEY `idx_commande_fournisseur_fk_soc` (`fk_soc`),
  ADD KEY `billed` (`billed`);

--
-- Indices de la tabla `llx_commande_fournisseurdet`
--
ALTER TABLE `llx_commande_fournisseurdet`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `fk_commande_fournisseurdet_fk_unit` (`fk_unit`),
  ADD KEY `idx_commande_fournisseurdet_fk_commande` (`fk_commande`),
  ADD KEY `idx_commande_fournisseurdet_fk_product` (`fk_product`);

--
-- Indices de la tabla `llx_commande_fournisseurdet_extrafields`
--
ALTER TABLE `llx_commande_fournisseurdet_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_commande_fournisseurdet_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_commande_fournisseur_extrafields`
--
ALTER TABLE `llx_commande_fournisseur_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_commande_fournisseur_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_commande_fournisseur_log`
--
ALTER TABLE `llx_commande_fournisseur_log`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_comment`
--
ALTER TABLE `llx_comment`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_const`
--
ALTER TABLE `llx_const`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_const` (`name`,`entity`);

--
-- Indices de la tabla `llx_contrat`
--
ALTER TABLE `llx_contrat`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_contrat_ref` (`ref`,`entity`),
  ADD KEY `idx_contrat_fk_soc` (`fk_soc`),
  ADD KEY `idx_contrat_fk_user_author` (`fk_user_author`);

--
-- Indices de la tabla `llx_contratdet`
--
ALTER TABLE `llx_contratdet`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_contratdet_fk_contrat` (`fk_contrat`),
  ADD KEY `idx_contratdet_fk_product` (`fk_product`),
  ADD KEY `idx_contratdet_date_ouverture_prevue` (`date_ouverture_prevue`),
  ADD KEY `idx_contratdet_date_ouverture` (`date_ouverture`),
  ADD KEY `idx_contratdet_date_fin_validite` (`date_fin_validite`),
  ADD KEY `idx_contratdet_statut` (`statut`),
  ADD KEY `fk_contratdet_fk_unit` (`fk_unit`);

--
-- Indices de la tabla `llx_contratdet_extrafields`
--
ALTER TABLE `llx_contratdet_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_contratdet_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_contrat_extrafields`
--
ALTER TABLE `llx_contrat_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_contrat_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_cronjob`
--
ALTER TABLE `llx_cronjob`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_cronjob` (`label`,`entity`),
  ADD KEY `idx_cronjob_status` (`status`),
  ADD KEY `idx_cronjob_datelastrun` (`datelastrun`),
  ADD KEY `idx_cronjob_datenextrun` (`datenextrun`),
  ADD KEY `idx_cronjob_datestart` (`datestart`),
  ADD KEY `idx_cronjob_dateend` (`dateend`);

--
-- Indices de la tabla `llx_c_actioncomm`
--
ALTER TABLE `llx_c_actioncomm`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_c_actioncomm` (`code`);

--
-- Indices de la tabla `llx_c_action_trigger`
--
ALTER TABLE `llx_c_action_trigger`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_action_trigger_code` (`code`),
  ADD KEY `idx_action_trigger_rang` (`rang`);

--
-- Indices de la tabla `llx_c_availability`
--
ALTER TABLE `llx_c_availability`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_availability` (`code`);

--
-- Indices de la tabla `llx_c_barcode_type`
--
ALTER TABLE `llx_c_barcode_type`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_barcode_type` (`code`,`entity`);

--
-- Indices de la tabla `llx_c_chargesociales`
--
ALTER TABLE `llx_c_chargesociales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `llx_c_civility`
--
ALTER TABLE `llx_c_civility`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_civility` (`code`);

--
-- Indices de la tabla `llx_c_country`
--
ALTER TABLE `llx_c_country`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_c_country_code` (`code`),
  ADD UNIQUE KEY `idx_c_country_label` (`label`),
  ADD UNIQUE KEY `idx_c_country_code_iso` (`code_iso`);

--
-- Indices de la tabla `llx_c_currencies`
--
ALTER TABLE `llx_c_currencies`
  ADD PRIMARY KEY (`code_iso`),
  ADD UNIQUE KEY `uk_c_currencies_code_iso` (`code_iso`);

--
-- Indices de la tabla `llx_c_departements`
--
ALTER TABLE `llx_c_departements`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_departements` (`code_departement`,`fk_region`),
  ADD KEY `idx_departements_fk_region` (`fk_region`);

--
-- Indices de la tabla `llx_c_ecotaxe`
--
ALTER TABLE `llx_c_ecotaxe`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_ecotaxe` (`code`);

--
-- Indices de la tabla `llx_c_effectif`
--
ALTER TABLE `llx_c_effectif`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_c_effectif` (`code`);

--
-- Indices de la tabla `llx_c_email_senderprofile`
--
ALTER TABLE `llx_c_email_senderprofile`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_email_senderprofile` (`entity`,`label`,`email`);

--
-- Indices de la tabla `llx_c_email_templates`
--
ALTER TABLE `llx_c_email_templates`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_email_templates` (`entity`,`label`,`lang`),
  ADD KEY `idx_type` (`type_template`);

--
-- Indices de la tabla `llx_c_field_list`
--
ALTER TABLE `llx_c_field_list`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_c_format_cards`
--
ALTER TABLE `llx_c_format_cards`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_c_forme_juridique`
--
ALTER TABLE `llx_c_forme_juridique`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_forme_juridique` (`code`);

--
-- Indices de la tabla `llx_c_holiday_types`
--
ALTER TABLE `llx_c_holiday_types`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_holiday_types` (`entity`,`code`);

--
-- Indices de la tabla `llx_c_hrm_department`
--
ALTER TABLE `llx_c_hrm_department`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_c_hrm_function`
--
ALTER TABLE `llx_c_hrm_function`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_c_hrm_public_holiday`
--
ALTER TABLE `llx_c_hrm_public_holiday`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_c_hrm_public_holiday` (`entity`,`code`),
  ADD UNIQUE KEY `uk_c_hrm_public_holiday2` (`entity`,`fk_country`,`dayrule`,`day`,`month`,`year`);

--
-- Indices de la tabla `llx_c_incoterms`
--
ALTER TABLE `llx_c_incoterms`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_incoterms` (`code`);

--
-- Indices de la tabla `llx_c_input_method`
--
ALTER TABLE `llx_c_input_method`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_input_method` (`code`);

--
-- Indices de la tabla `llx_c_input_reason`
--
ALTER TABLE `llx_c_input_reason`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_input_reason` (`code`);

--
-- Indices de la tabla `llx_c_invoice_subtype`
--
ALTER TABLE `llx_c_invoice_subtype`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_invoice_subtype` (`entity`,`code`,`fk_country`);

--
-- Indices de la tabla `llx_c_lead_status`
--
ALTER TABLE `llx_c_lead_status`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_lead_status_code` (`code`);

--
-- Indices de la tabla `llx_c_paiement`
--
ALTER TABLE `llx_c_paiement`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_c_paiement_code` (`entity`,`code`);

--
-- Indices de la tabla `llx_c_paper_format`
--
ALTER TABLE `llx_c_paper_format`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_c_payment_term`
--
ALTER TABLE `llx_c_payment_term`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_payment_term_code` (`entity`,`code`);

--
-- Indices de la tabla `llx_c_product_nature`
--
ALTER TABLE `llx_c_product_nature`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_product_nature` (`code`);

--
-- Indices de la tabla `llx_c_product_thirdparty_relation_type`
--
ALTER TABLE `llx_c_product_thirdparty_relation_type`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_c_propalst`
--
ALTER TABLE `llx_c_propalst`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_c_propalst` (`code`);

--
-- Indices de la tabla `llx_c_prospectcontactlevel`
--
ALTER TABLE `llx_c_prospectcontactlevel`
  ADD PRIMARY KEY (`code`);

--
-- Indices de la tabla `llx_c_prospectlevel`
--
ALTER TABLE `llx_c_prospectlevel`
  ADD PRIMARY KEY (`code`);

--
-- Indices de la tabla `llx_c_regions`
--
ALTER TABLE `llx_c_regions`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_code_region` (`code_region`),
  ADD KEY `idx_c_regions_fk_pays` (`fk_pays`);

--
-- Indices de la tabla `llx_c_revenuestamp`
--
ALTER TABLE `llx_c_revenuestamp`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_c_shipment_mode`
--
ALTER TABLE `llx_c_shipment_mode`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_shipment_mode` (`code`,`entity`);

--
-- Indices de la tabla `llx_c_shipment_package_type`
--
ALTER TABLE `llx_c_shipment_package_type`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_c_socialnetworks`
--
ALTER TABLE `llx_c_socialnetworks`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_c_socialnetworks_code_entity` (`entity`,`code`);

--
-- Indices de la tabla `llx_c_stcomm`
--
ALTER TABLE `llx_c_stcomm`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_c_stcomm` (`code`);

--
-- Indices de la tabla `llx_c_stcommcontact`
--
ALTER TABLE `llx_c_stcommcontact`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_c_stcommcontact` (`code`);

--
-- Indices de la tabla `llx_c_transport_mode`
--
ALTER TABLE `llx_c_transport_mode`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_transport_mode` (`code`,`entity`);

--
-- Indices de la tabla `llx_c_tva`
--
ALTER TABLE `llx_c_tva`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_tva_id` (`entity`,`fk_pays`,`code`,`taux`,`recuperableonly`),
  ADD KEY `idx_tva_fk_department_buyer` (`fk_department_buyer`);

--
-- Indices de la tabla `llx_c_typent`
--
ALTER TABLE `llx_c_typent`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_c_typent` (`code`);

--
-- Indices de la tabla `llx_c_type_contact`
--
ALTER TABLE `llx_c_type_contact`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_type_contact_id` (`element`,`source`,`code`),
  ADD KEY `idx_c_type_contact_code` (`code`);

--
-- Indices de la tabla `llx_c_type_fees`
--
ALTER TABLE `llx_c_type_fees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_c_type_fees` (`code`);

--
-- Indices de la tabla `llx_c_type_resource`
--
ALTER TABLE `llx_c_type_resource`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_type_resource_id` (`label`,`code`);

--
-- Indices de la tabla `llx_c_units`
--
ALTER TABLE `llx_c_units`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_c_units_code` (`code`);

--
-- Indices de la tabla `llx_c_ziptown`
--
ALTER TABLE `llx_c_ziptown`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_ziptown_fk_pays` (`zip`,`town`,`fk_pays`),
  ADD KEY `idx_c_ziptown_fk_county` (`fk_county`),
  ADD KEY `idx_c_ziptown_fk_pays` (`fk_pays`),
  ADD KEY `idx_c_ziptown_zip` (`zip`);

--
-- Indices de la tabla `llx_default_values`
--
ALTER TABLE `llx_default_values`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_default_values` (`type`,`entity`,`user_id`,`page`,`param`);

--
-- Indices de la tabla `llx_delivery`
--
ALTER TABLE `llx_delivery`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_delivery_uk_ref` (`ref`,`entity`),
  ADD KEY `idx_delivery_fk_soc` (`fk_soc`),
  ADD KEY `idx_delivery_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_delivery_fk_user_valid` (`fk_user_valid`);

--
-- Indices de la tabla `llx_deliverydet`
--
ALTER TABLE `llx_deliverydet`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_deliverydet_fk_delivery` (`fk_delivery`);

--
-- Indices de la tabla `llx_deliverydet_extrafields`
--
ALTER TABLE `llx_deliverydet_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_deliverydet_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_delivery_extrafields`
--
ALTER TABLE `llx_delivery_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_delivery_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_document_model`
--
ALTER TABLE `llx_document_model`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_document_model` (`nom`,`type`,`entity`);

--
-- Indices de la tabla `llx_ecm_directories`
--
ALTER TABLE `llx_ecm_directories`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_ecm_directories` (`label`,`fk_parent`,`entity`),
  ADD KEY `idx_ecm_directories_fk_user_c` (`fk_user_c`),
  ADD KEY `idx_ecm_directories_fk_user_m` (`fk_user_m`);

--
-- Indices de la tabla `llx_ecm_directories_extrafields`
--
ALTER TABLE `llx_ecm_directories_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_ecm_directories_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_ecm_files`
--
ALTER TABLE `llx_ecm_files`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_ecm_files` (`filepath`,`filename`,`entity`),
  ADD KEY `idx_ecm_files_label` (`label`);

--
-- Indices de la tabla `llx_ecm_files_extrafields`
--
ALTER TABLE `llx_ecm_files_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_ecm_files_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_element_categorie`
--
ALTER TABLE `llx_element_categorie`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_element_categorie_idx` (`fk_element`,`fk_categorie`),
  ADD KEY `idx_element_categorie_fk_categorie` (`fk_categorie`);

--
-- Indices de la tabla `llx_element_contact`
--
ALTER TABLE `llx_element_contact`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_element_contact_idx1` (`element_id`,`fk_c_type_contact`,`fk_socpeople`),
  ADD KEY `fk_element_contact_fk_c_type_contact` (`fk_c_type_contact`),
  ADD KEY `idx_element_contact_fk_socpeople` (`fk_socpeople`);

--
-- Indices de la tabla `llx_element_element`
--
ALTER TABLE `llx_element_element`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_element_element_idx1` (`fk_source`,`sourcetype`,`fk_target`,`targettype`),
  ADD KEY `idx_element_element_fk_target` (`fk_target`);

--
-- Indices de la tabla `llx_element_resources`
--
ALTER TABLE `llx_element_resources`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_element_resources_idx1` (`resource_id`,`resource_type`,`element_id`,`element_type`),
  ADD KEY `idx_element_element_element_id` (`element_id`);

--
-- Indices de la tabla `llx_element_time`
--
ALTER TABLE `llx_element_time`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_element_time_task` (`fk_element`),
  ADD KEY `idx_element_time_date` (`element_date`),
  ADD KEY `idx_element_time_datehour` (`element_datehour`);

--
-- Indices de la tabla `llx_emailcollector_emailcollector`
--
ALTER TABLE `llx_emailcollector_emailcollector`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_emailcollector_emailcollector_ref` (`ref`,`entity`),
  ADD KEY `idx_emailcollector_entity` (`entity`),
  ADD KEY `idx_emailcollector_status` (`status`);

--
-- Indices de la tabla `llx_emailcollector_emailcollectoraction`
--
ALTER TABLE `llx_emailcollector_emailcollectoraction`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_emailcollector_emailcollectoraction` (`fk_emailcollector`,`type`),
  ADD KEY `idx_emailcollector_fk_emailcollector` (`fk_emailcollector`);

--
-- Indices de la tabla `llx_emailcollector_emailcollectorfilter`
--
ALTER TABLE `llx_emailcollector_emailcollectorfilter`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_emailcollector_emailcollectorfilter` (`fk_emailcollector`,`type`,`rulevalue`),
  ADD KEY `idx_emailcollector_fk_emailcollector` (`fk_emailcollector`);

--
-- Indices de la tabla `llx_entrepot`
--
ALTER TABLE `llx_entrepot`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_entrepot_label` (`ref`,`entity`);

--
-- Indices de la tabla `llx_entrepot_extrafields`
--
ALTER TABLE `llx_entrepot_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_entrepot_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_establishment`
--
ALTER TABLE `llx_establishment`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_eventorganization_conferenceorboothattendee`
--
ALTER TABLE `llx_eventorganization_conferenceorboothattendee`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_eventorganization_conferenceorboothattendee` (`fk_project`,`email`,`fk_actioncomm`),
  ADD KEY `idx_eventorganization_conferenceorboothattendee_rowid` (`rowid`),
  ADD KEY `idx_eventorganization_conferenceorboothattendee_ref` (`ref`),
  ADD KEY `idx_eventorganization_conferenceorboothattendee_fk_soc` (`fk_soc`),
  ADD KEY `idx_eventorganization_conferenceorboothattendee_fk_actioncomm` (`fk_actioncomm`),
  ADD KEY `idx_eventorganization_conferenceorboothattendee_fk_project` (`fk_project`),
  ADD KEY `idx_eventorganization_conferenceorboothattendee_email` (`email`),
  ADD KEY `idx_eventorganization_conferenceorboothattendee_status` (`status`);

--
-- Indices de la tabla `llx_eventorganization_conferenceorboothattendee_extrafields`
--
ALTER TABLE `llx_eventorganization_conferenceorboothattendee_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_conferenceorboothattendee_fk_object` (`fk_object`);

--
-- Indices de la tabla `llx_events`
--
ALTER TABLE `llx_events`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_events_dateevent` (`dateevent`);

--
-- Indices de la tabla `llx_event_element`
--
ALTER TABLE `llx_event_element`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_expedition`
--
ALTER TABLE `llx_expedition`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_expedition_uk_ref` (`ref`,`entity`),
  ADD KEY `idx_expedition_fk_soc` (`fk_soc`),
  ADD KEY `idx_expedition_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_expedition_fk_user_valid` (`fk_user_valid`),
  ADD KEY `idx_expedition_fk_shipping_method` (`fk_shipping_method`);

--
-- Indices de la tabla `llx_expeditiondet`
--
ALTER TABLE `llx_expeditiondet`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_expeditiondet_fk_expedition` (`fk_expedition`),
  ADD KEY `idx_expeditiondet_fk_elementdet` (`fk_elementdet`);

--
-- Indices de la tabla `llx_expeditiondet_batch`
--
ALTER TABLE `llx_expeditiondet_batch`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_fk_expeditiondet` (`fk_expeditiondet`);

--
-- Indices de la tabla `llx_expeditiondet_extrafields`
--
ALTER TABLE `llx_expeditiondet_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_expeditiondet_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_expedition_extrafields`
--
ALTER TABLE `llx_expedition_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_expedition_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_expedition_package`
--
ALTER TABLE `llx_expedition_package`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_expensereport`
--
ALTER TABLE `llx_expensereport`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_expensereport_uk_ref` (`ref`,`entity`),
  ADD KEY `idx_expensereport_date_debut` (`date_debut`),
  ADD KEY `idx_expensereport_date_fin` (`date_fin`),
  ADD KEY `idx_expensereport_fk_statut` (`fk_statut`),
  ADD KEY `idx_expensereport_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_expensereport_fk_user_valid` (`fk_user_valid`),
  ADD KEY `idx_expensereport_fk_user_approve` (`fk_user_approve`),
  ADD KEY `idx_expensereport_fk_refuse` (`fk_user_refuse`);

--
-- Indices de la tabla `llx_expensereport_det`
--
ALTER TABLE `llx_expensereport_det`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_expensereport_extrafields`
--
ALTER TABLE `llx_expensereport_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_expensereport_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_export_model`
--
ALTER TABLE `llx_export_model`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_export_model` (`label`,`type`);

--
-- Indices de la tabla `llx_extrafields`
--
ALTER TABLE `llx_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_extrafields_name` (`name`,`entity`,`elementtype`);

--
-- Indices de la tabla `llx_facture`
--
ALTER TABLE `llx_facture`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_facture_ref` (`ref`,`entity`),
  ADD KEY `idx_facture_fk_soc` (`fk_soc`),
  ADD KEY `idx_facture_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_facture_fk_user_valid` (`fk_user_valid`),
  ADD KEY `idx_facture_fk_facture_source` (`fk_facture_source`),
  ADD KEY `idx_facture_fk_projet` (`fk_projet`),
  ADD KEY `idx_facture_fk_account` (`fk_account`),
  ADD KEY `idx_facture_fk_currency` (`fk_currency`),
  ADD KEY `idx_facture_fk_statut` (`fk_statut`),
  ADD KEY `idx_facture_datef` (`datef`),
  ADD KEY `idx_facture_tms` (`tms`);

--
-- Indices de la tabla `llx_facturedet`
--
ALTER TABLE `llx_facturedet`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_fk_remise_except` (`fk_remise_except`,`fk_facture`),
  ADD KEY `idx_facturedet_fk_facture` (`fk_facture`),
  ADD KEY `idx_facturedet_fk_product` (`fk_product`),
  ADD KEY `idx_facturedet_fk_code_ventilation` (`fk_code_ventilation`),
  ADD KEY `fk_facturedet_fk_unit` (`fk_unit`);

--
-- Indices de la tabla `llx_facturedet_extrafields`
--
ALTER TABLE `llx_facturedet_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_facturedet_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_facturedet_rec`
--
ALTER TABLE `llx_facturedet_rec`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `fk_facturedet_rec_fk_unit` (`fk_unit`);

--
-- Indices de la tabla `llx_facturedet_rec_extrafields`
--
ALTER TABLE `llx_facturedet_rec_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_facturedet_rec_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_facture_extrafields`
--
ALTER TABLE `llx_facture_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_facture_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_facture_fourn`
--
ALTER TABLE `llx_facture_fourn`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_facture_fourn_ref` (`ref`,`entity`),
  ADD UNIQUE KEY `uk_facture_fourn_ref_supplier` (`ref_supplier`,`fk_soc`,`entity`),
  ADD KEY `idx_facture_fourn_date_lim_reglement` (`date_lim_reglement`),
  ADD KEY `idx_facture_fourn_fk_soc` (`fk_soc`),
  ADD KEY `idx_facture_fourn_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_facture_fourn_fk_user_valid` (`fk_user_valid`),
  ADD KEY `idx_facture_fourn_fk_projet` (`fk_projet`),
  ADD KEY `idx_facture_fourn_tms` (`tms`);

--
-- Indices de la tabla `llx_facture_fourn_det`
--
ALTER TABLE `llx_facture_fourn_det`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_fk_remise_except` (`fk_remise_except`,`fk_facture_fourn`),
  ADD KEY `idx_facture_fourn_det_fk_facture` (`fk_facture_fourn`),
  ADD KEY `idx_facture_fourn_det_fk_product` (`fk_product`),
  ADD KEY `idx_facture_fourn_det_fk_code_ventilation` (`fk_code_ventilation`),
  ADD KEY `fk_facture_fourn_det_fk_unit` (`fk_unit`);

--
-- Indices de la tabla `llx_facture_fourn_det_extrafields`
--
ALTER TABLE `llx_facture_fourn_det_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_facture_fourn_det_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_facture_fourn_det_rec`
--
ALTER TABLE `llx_facture_fourn_det_rec`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `fk_facture_fourn_det_rec_fk_unit` (`fk_unit`);

--
-- Indices de la tabla `llx_facture_fourn_det_rec_extrafields`
--
ALTER TABLE `llx_facture_fourn_det_rec_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `llx_facture_fourn_det_rec_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_facture_fourn_extrafields`
--
ALTER TABLE `llx_facture_fourn_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_facture_fourn_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_facture_fourn_rec`
--
ALTER TABLE `llx_facture_fourn_rec`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_facture_fourn_rec_ref` (`titre`,`entity`),
  ADD KEY `idx_facture_fourn_rec_fk_soc` (`fk_soc`),
  ADD KEY `idx_facture_fourn_rec_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_facture_fourn_rec_fk_projet` (`fk_projet`);

--
-- Indices de la tabla `llx_facture_fourn_rec_extrafields`
--
ALTER TABLE `llx_facture_fourn_rec_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_facture_fourn_rec_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_facture_rec`
--
ALTER TABLE `llx_facture_rec`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_facture_rec_uk_titre` (`titre`,`entity`),
  ADD KEY `idx_facture_rec_fk_soc` (`fk_soc`),
  ADD KEY `idx_facture_rec_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_facture_rec_fk_projet` (`fk_projet`),
  ADD KEY `idx_facture_rec_datec` (`datec`);

--
-- Indices de la tabla `llx_facture_rec_extrafields`
--
ALTER TABLE `llx_facture_rec_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_facture_rec_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_fichinter`
--
ALTER TABLE `llx_fichinter`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_fichinter_ref` (`ref`,`entity`),
  ADD KEY `idx_fichinter_fk_soc` (`fk_soc`);

--
-- Indices de la tabla `llx_fichinterdet`
--
ALTER TABLE `llx_fichinterdet`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_fichinterdet_fk_fichinter` (`fk_fichinter`);

--
-- Indices de la tabla `llx_fichinterdet_extrafields`
--
ALTER TABLE `llx_fichinterdet_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_ficheinterdet_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_fichinterdet_rec`
--
ALTER TABLE `llx_fichinterdet_rec`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_fichinter_extrafields`
--
ALTER TABLE `llx_fichinter_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_ficheinter_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_fichinter_rec`
--
ALTER TABLE `llx_fichinter_rec`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_fichinter_rec_uk_titre` (`title`,`entity`),
  ADD KEY `idx_fichinter_rec_fk_soc` (`fk_soc`),
  ADD KEY `idx_fichinter_rec_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_fichinter_rec_fk_projet` (`fk_projet`);

--
-- Indices de la tabla `llx_holiday`
--
ALTER TABLE `llx_holiday`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_holiday_entity` (`entity`),
  ADD KEY `idx_holiday_fk_user` (`fk_user`),
  ADD KEY `idx_holiday_fk_user_create` (`fk_user_create`),
  ADD KEY `idx_holiday_date_create` (`date_create`),
  ADD KEY `idx_holiday_date_debut` (`date_debut`),
  ADD KEY `idx_holiday_date_fin` (`date_fin`),
  ADD KEY `idx_holiday_fk_validator` (`fk_validator`);

--
-- Indices de la tabla `llx_holiday_config`
--
ALTER TABLE `llx_holiday_config`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_holiday_config` (`name`);

--
-- Indices de la tabla `llx_holiday_extrafields`
--
ALTER TABLE `llx_holiday_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_holiday_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_holiday_logs`
--
ALTER TABLE `llx_holiday_logs`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_holiday_users`
--
ALTER TABLE `llx_holiday_users`
  ADD UNIQUE KEY `uk_holiday_users` (`fk_user`,`fk_type`);

--
-- Indices de la tabla `llx_import_model`
--
ALTER TABLE `llx_import_model`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_import_model` (`label`,`type`);

--
-- Indices de la tabla `llx_inventory`
--
ALTER TABLE `llx_inventory`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_inventory_ref` (`ref`,`entity`),
  ADD KEY `idx_inventory_tms` (`tms`),
  ADD KEY `idx_inventory_date_creation` (`date_creation`);

--
-- Indices de la tabla `llx_inventorydet`
--
ALTER TABLE `llx_inventorydet`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_inventorydet` (`fk_inventory`,`fk_warehouse`,`fk_product`,`batch`),
  ADD KEY `idx_inventorydet_tms` (`tms`),
  ADD KEY `idx_inventorydet_datec` (`datec`),
  ADD KEY `idx_inventorydet_fk_inventory` (`fk_inventory`);

--
-- Indices de la tabla `llx_inventory_extrafields`
--
ALTER TABLE `llx_inventory_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_inventory_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_links`
--
ALTER TABLE `llx_links`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_links` (`objectid`,`objecttype`,`label`);

--
-- Indices de la tabla `llx_localtax`
--
ALTER TABLE `llx_localtax`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_mailing_unsubscribe`
--
ALTER TABLE `llx_mailing_unsubscribe`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_mailing_unsubscribe` (`email`,`entity`,`unsubscribegroup`);

--
-- Indices de la tabla `llx_menu`
--
ALTER TABLE `llx_menu`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_menu_menuhandler_type` (`menu_handler`,`type`);

--
-- Indices de la tabla `llx_multicurrency`
--
ALTER TABLE `llx_multicurrency`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_multicurrency_rate`
--
ALTER TABLE `llx_multicurrency_rate`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_notify`
--
ALTER TABLE `llx_notify`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_notify_def`
--
ALTER TABLE `llx_notify_def`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_notify_def_object`
--
ALTER TABLE `llx_notify_def_object`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `llx_oauth_state`
--
ALTER TABLE `llx_oauth_state`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_oauth_token`
--
ALTER TABLE `llx_oauth_token`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_object_lang`
--
ALTER TABLE `llx_object_lang`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_object_lang` (`fk_object`,`type_object`,`property`,`lang`);

--
-- Indices de la tabla `llx_onlinesignature`
--
ALTER TABLE `llx_onlinesignature`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_overwrite_trans`
--
ALTER TABLE `llx_overwrite_trans`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_overwrite_trans` (`entity`,`lang`,`transkey`);

--
-- Indices de la tabla `llx_paiement`
--
ALTER TABLE `llx_paiement`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_paiementcharge`
--
ALTER TABLE `llx_paiementcharge`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_paiementcharge_fk_charge` (`fk_charge`);

--
-- Indices de la tabla `llx_paiementfourn`
--
ALTER TABLE `llx_paiementfourn`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_paiementfourn_facturefourn`
--
ALTER TABLE `llx_paiementfourn_facturefourn`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_paiementfourn_facturefourn` (`fk_paiementfourn`,`fk_facturefourn`),
  ADD KEY `idx_paiementfourn_facturefourn_fk_facture` (`fk_facturefourn`),
  ADD KEY `idx_paiementfourn_facturefourn_fk_paiement` (`fk_paiementfourn`);

--
-- Indices de la tabla `llx_paiement_facture`
--
ALTER TABLE `llx_paiement_facture`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_paiement_facture` (`fk_paiement`,`fk_facture`),
  ADD KEY `idx_paiement_facture_fk_facture` (`fk_facture`),
  ADD KEY `idx_paiement_facture_fk_paiement` (`fk_paiement`);

--
-- Indices de la tabla `llx_paymentexpensereport_expensereport`
--
ALTER TABLE `llx_paymentexpensereport_expensereport`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_payment_donation`
--
ALTER TABLE `llx_payment_donation`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_payment_expensereport`
--
ALTER TABLE `llx_payment_expensereport`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_payment_loan`
--
ALTER TABLE `llx_payment_loan`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_payment_salary`
--
ALTER TABLE `llx_payment_salary`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_payment_salary_ref` (`num_payment`),
  ADD KEY `idx_payment_salary_user` (`fk_user`,`entity`),
  ADD KEY `idx_payment_salary_datep` (`datep`),
  ADD KEY `idx_payment_salary_datesp` (`datesp`),
  ADD KEY `idx_payment_salary_dateep` (`dateep`);

--
-- Indices de la tabla `llx_payment_various`
--
ALTER TABLE `llx_payment_various`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_payment_vat`
--
ALTER TABLE `llx_payment_vat`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_pos_cash_fence`
--
ALTER TABLE `llx_pos_cash_fence`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_pos_cash_fence_extrafields`
--
ALTER TABLE `llx_pos_cash_fence_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_pos_cash_fence_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_prelevement`
--
ALTER TABLE `llx_prelevement`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_prelevement_fk_prelevement_lignes` (`fk_prelevement_lignes`);

--
-- Indices de la tabla `llx_prelevement_bons`
--
ALTER TABLE `llx_prelevement_bons`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_prelevement_bons_ref` (`ref`,`entity`);

--
-- Indices de la tabla `llx_prelevement_demande`
--
ALTER TABLE `llx_prelevement_demande`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_prelevement_demande_fk_facture` (`fk_facture`),
  ADD KEY `idx_prelevement_demande_fk_facture_fourn` (`fk_facture_fourn`),
  ADD KEY `idx_prelevement_demande_ext_payment_id` (`ext_payment_id`);

--
-- Indices de la tabla `llx_prelevement_lignes`
--
ALTER TABLE `llx_prelevement_lignes`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_prelevement_lignes_fk_prelevement_bons` (`fk_prelevement_bons`);

--
-- Indices de la tabla `llx_prelevement_rejet`
--
ALTER TABLE `llx_prelevement_rejet`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_printing`
--
ALTER TABLE `llx_printing`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_product`
--
ALTER TABLE `llx_product`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_ref` (`ref`,`entity`),
  ADD UNIQUE KEY `uk_product_barcode` (`barcode`,`fk_barcode_type`,`entity`),
  ADD KEY `idx_product_label` (`label`),
  ADD KEY `idx_product_barcode` (`barcode`),
  ADD KEY `idx_product_import_key` (`import_key`),
  ADD KEY `idx_product_seuil_stock_alerte` (`seuil_stock_alerte`),
  ADD KEY `idx_product_fk_country` (`fk_country`),
  ADD KEY `idx_product_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_product_fk_barcode_type` (`fk_barcode_type`),
  ADD KEY `idx_product_fk_project` (`fk_project`),
  ADD KEY `idx_product_entity_fk_product_type` (`entity`,`fk_product_type`),
  ADD KEY `fk_product_fk_unit` (`fk_unit`),
  ADD KEY `fk_product_finished` (`finished`);

--
-- Indices de la tabla `llx_product_association`
--
ALTER TABLE `llx_product_association`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_association` (`fk_product_pere`,`fk_product_fils`),
  ADD KEY `idx_product_association_fils` (`fk_product_fils`);

--
-- Indices de la tabla `llx_product_attribute`
--
ALTER TABLE `llx_product_attribute`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_attribute_ref` (`ref`);

--
-- Indices de la tabla `llx_product_attribute_value`
--
ALTER TABLE `llx_product_attribute_value`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_attribute_value` (`fk_product_attribute`,`ref`);

--
-- Indices de la tabla `llx_product_batch`
--
ALTER TABLE `llx_product_batch`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_batch` (`fk_product_stock`,`batch`),
  ADD KEY `idx_fk_product_stock` (`fk_product_stock`),
  ADD KEY `idx_batch` (`batch`);

--
-- Indices de la tabla `llx_product_customer_price`
--
ALTER TABLE `llx_product_customer_price`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_customer_price_fk_product_fk_soc` (`fk_product`,`fk_soc`),
  ADD KEY `idx_product_customer_price_fk_user` (`fk_user`),
  ADD KEY `idx_product_customer_price_fk_soc` (`fk_soc`);

--
-- Indices de la tabla `llx_product_customer_price_extrafields`
--
ALTER TABLE `llx_product_customer_price_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_customer_price_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_product_customer_price_log`
--
ALTER TABLE `llx_product_customer_price_log`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_product_extrafields`
--
ALTER TABLE `llx_product_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_product_fournisseur_price`
--
ALTER TABLE `llx_product_fournisseur_price`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_fournisseur_price_ref` (`ref_fourn`,`fk_soc`,`quantity`,`entity`),
  ADD UNIQUE KEY `uk_product_barcode` (`barcode`,`fk_barcode_type`,`entity`),
  ADD KEY `idx_product_fournisseur_price_fk_user` (`fk_user`),
  ADD KEY `idx_product_fourn_price_fk_product` (`fk_product`,`entity`),
  ADD KEY `idx_product_fourn_price_fk_soc` (`fk_soc`,`entity`),
  ADD KEY `idx_product_barcode` (`barcode`),
  ADD KEY `idx_product_fk_barcode_type` (`fk_barcode_type`);

--
-- Indices de la tabla `llx_product_fournisseur_price_extrafields`
--
ALTER TABLE `llx_product_fournisseur_price_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_fournisseur_price_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_product_fournisseur_price_log`
--
ALTER TABLE `llx_product_fournisseur_price_log`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_product_fournisseur_price_log_fk_product_fournisseur` (`fk_product_fournisseur`),
  ADD KEY `idx_product_fournisseur_price_log_fk_user` (`fk_user`);

--
-- Indices de la tabla `llx_product_lang`
--
ALTER TABLE `llx_product_lang`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_lang` (`fk_product`,`lang`);

--
-- Indices de la tabla `llx_product_lot`
--
ALTER TABLE `llx_product_lot`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_lot` (`fk_product`,`batch`);

--
-- Indices de la tabla `llx_product_lot_extrafields`
--
ALTER TABLE `llx_product_lot_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_lot_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_product_price`
--
ALTER TABLE `llx_product_price`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_product_price_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_product_price_fk_product` (`fk_product`);

--
-- Indices de la tabla `llx_product_pricerules`
--
ALTER TABLE `llx_product_pricerules`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `unique_level` (`level`);

--
-- Indices de la tabla `llx_product_price_by_qty`
--
ALTER TABLE `llx_product_price_by_qty`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_price_by_qty_level` (`fk_product_price`,`quantity`),
  ADD KEY `idx_product_price_by_qty_fk_product_price` (`fk_product_price`);

--
-- Indices de la tabla `llx_product_price_extrafields`
--
ALTER TABLE `llx_product_price_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_price_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_product_stock`
--
ALTER TABLE `llx_product_stock`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_product_stock` (`fk_product`,`fk_entrepot`),
  ADD KEY `idx_product_stock_fk_product` (`fk_product`),
  ADD KEY `idx_product_stock_fk_entrepot` (`fk_entrepot`);

--
-- Indices de la tabla `llx_product_thirdparty`
--
ALTER TABLE `llx_product_thirdparty`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_product_warehouse_properties`
--
ALTER TABLE `llx_product_warehouse_properties`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_projet`
--
ALTER TABLE `llx_projet`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_projet_ref` (`ref`,`entity`),
  ADD KEY `idx_projet_fk_soc` (`fk_soc`),
  ADD KEY `idx_projet_ref` (`ref`),
  ADD KEY `idx_projet_fk_statut` (`fk_statut`),
  ADD KEY `idx_projet_fk_opp_status` (`fk_opp_status`);

--
-- Indices de la tabla `llx_projet_extrafields`
--
ALTER TABLE `llx_projet_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_projet_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_projet_task`
--
ALTER TABLE `llx_projet_task`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_projet_task_ref` (`ref`,`entity`),
  ADD KEY `idx_projet_task_fk_projet` (`fk_projet`),
  ADD KEY `idx_projet_task_fk_user_creat` (`fk_user_creat`),
  ADD KEY `idx_projet_task_fk_user_valid` (`fk_user_valid`);

--
-- Indices de la tabla `llx_projet_task_extrafields`
--
ALTER TABLE `llx_projet_task_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_projet_task_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_propal`
--
ALTER TABLE `llx_propal`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_propal_ref` (`ref`,`entity`),
  ADD KEY `idx_propal_fk_soc` (`fk_soc`),
  ADD KEY `idx_propal_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_propal_fk_user_valid` (`fk_user_valid`),
  ADD KEY `idx_propal_fk_user_signature` (`fk_user_signature`),
  ADD KEY `idx_propal_fk_user_cloture` (`fk_user_cloture`),
  ADD KEY `idx_propal_fk_projet` (`fk_projet`),
  ADD KEY `idx_propal_fk_account` (`fk_account`),
  ADD KEY `idx_propal_fk_currency` (`fk_currency`),
  ADD KEY `idx_propal_fk_warehouse` (`fk_warehouse`);

--
-- Indices de la tabla `llx_propaldet`
--
ALTER TABLE `llx_propaldet`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_propaldet_fk_propal` (`fk_propal`),
  ADD KEY `idx_propaldet_fk_product` (`fk_product`),
  ADD KEY `fk_propaldet_fk_unit` (`fk_unit`);

--
-- Indices de la tabla `llx_propaldet_extrafields`
--
ALTER TABLE `llx_propaldet_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_propaldet_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_propal_extrafields`
--
ALTER TABLE `llx_propal_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_propal_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_propal_merge_pdf_product`
--
ALTER TABLE `llx_propal_merge_pdf_product`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_reception`
--
ALTER TABLE `llx_reception`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_reception_uk_ref` (`ref`,`entity`),
  ADD KEY `idx_reception_fk_soc` (`fk_soc`),
  ADD KEY `idx_reception_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_reception_fk_user_valid` (`fk_user_valid`),
  ADD KEY `idx_reception_fk_shipping_method` (`fk_shipping_method`);

--
-- Indices de la tabla `llx_receptiondet_batch`
--
ALTER TABLE `llx_receptiondet_batch`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_receptiondet_batch_fk_element` (`fk_element`),
  ADD KEY `idx_receptiondet_batch_fk_reception` (`fk_reception`),
  ADD KEY `idx_receptiondet_batch_fk_product` (`fk_product`),
  ADD KEY `idx_receptiondet_batch_fk_elementdet` (`fk_elementdet`);

--
-- Indices de la tabla `llx_receptiondet_batch_extrafields`
--
ALTER TABLE `llx_receptiondet_batch_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_receptiondet_batch_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_reception_extrafields`
--
ALTER TABLE `llx_reception_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_reception_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_resource`
--
ALTER TABLE `llx_resource`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_resource_ref` (`ref`,`entity`),
  ADD KEY `fk_code_type_resource_idx` (`fk_code_type_resource`),
  ADD KEY `idx_resource_fk_country` (`fk_country`),
  ADD KEY `idx_resource_fk_state` (`fk_state`);

--
-- Indices de la tabla `llx_resource_extrafields`
--
ALTER TABLE `llx_resource_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_resource_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_rights_def`
--
ALTER TABLE `llx_rights_def`
  ADD PRIMARY KEY (`id`,`entity`);

--
-- Indices de la tabla `llx_salary`
--
ALTER TABLE `llx_salary`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_salary_extrafields`
--
ALTER TABLE `llx_salary_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_salary_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_societe`
--
ALTER TABLE `llx_societe`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_societe_prefix_comm` (`prefix_comm`,`entity`),
  ADD UNIQUE KEY `uk_societe_code_client` (`code_client`,`entity`),
  ADD UNIQUE KEY `uk_societe_code_fournisseur` (`code_fournisseur`,`entity`),
  ADD UNIQUE KEY `uk_societe_barcode` (`barcode`,`fk_barcode_type`,`entity`),
  ADD KEY `idx_societe_nom` (`nom`),
  ADD KEY `idx_societe_user_creat` (`fk_user_creat`),
  ADD KEY `idx_societe_user_modif` (`fk_user_modif`),
  ADD KEY `idx_societe_stcomm` (`fk_stcomm`),
  ADD KEY `idx_societe_pays` (`fk_pays`),
  ADD KEY `idx_societe_account` (`fk_account`),
  ADD KEY `idx_societe_prospectlevel` (`fk_prospectlevel`),
  ADD KEY `idx_societe_typent` (`fk_typent`),
  ADD KEY `idx_societe_forme_juridique` (`fk_forme_juridique`),
  ADD KEY `idx_societe_shipping_method` (`fk_shipping_method`);

--
-- Indices de la tabla `llx_societe_account`
--
ALTER TABLE `llx_societe_account`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_societe_account_login_website` (`entity`,`login`,`site`,`fk_website`),
  ADD UNIQUE KEY `uk_societe_account_key_account_soc` (`entity`,`fk_soc`,`key_account`,`site`,`fk_website`),
  ADD KEY `idx_societe_account_rowid` (`rowid`),
  ADD KEY `idx_societe_account_login` (`login`),
  ADD KEY `idx_societe_account_status` (`status`),
  ADD KEY `idx_societe_account_fk_website` (`fk_website`),
  ADD KEY `idx_societe_account_fk_soc` (`fk_soc`);

--
-- Indices de la tabla `llx_societe_commerciaux`
--
ALTER TABLE `llx_societe_commerciaux`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_societe_commerciaux_c_type_contact` (`fk_soc`,`fk_user`,`fk_c_type_contact_code`),
  ADD KEY `fk_societe_commerciaux_fk_user` (`fk_user`);

--
-- Indices de la tabla `llx_societe_contacts`
--
ALTER TABLE `llx_societe_contacts`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `idx_societe_contacts_idx1` (`entity`,`fk_soc`,`fk_c_type_contact`,`fk_socpeople`),
  ADD KEY `fk_societe_contacts_fk_c_type_contact` (`fk_c_type_contact`),
  ADD KEY `fk_societe_contacts_fk_soc` (`fk_soc`),
  ADD KEY `fk_societe_contacts_fk_socpeople` (`fk_socpeople`);

--
-- Indices de la tabla `llx_societe_extrafields`
--
ALTER TABLE `llx_societe_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_societe_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_societe_prices`
--
ALTER TABLE `llx_societe_prices`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_societe_remise`
--
ALTER TABLE `llx_societe_remise`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_societe_remise_except`
--
ALTER TABLE `llx_societe_remise_except`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_societe_remise_except_fk_user` (`fk_user`),
  ADD KEY `idx_societe_remise_except_fk_soc` (`fk_soc`),
  ADD KEY `idx_societe_remise_except_fk_facture_line` (`fk_facture_line`),
  ADD KEY `idx_societe_remise_except_fk_facture` (`fk_facture`),
  ADD KEY `idx_societe_remise_except_fk_facture_source` (`fk_facture_source`),
  ADD KEY `idx_societe_remise_except_discount_type` (`discount_type`),
  ADD KEY `fk_soc_remise_fk_invoice_supplier_line` (`fk_invoice_supplier_line`),
  ADD KEY `fk_societe_remise_fk_invoice_supplier_source` (`fk_invoice_supplier`);

--
-- Indices de la tabla `llx_societe_remise_supplier`
--
ALTER TABLE `llx_societe_remise_supplier`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_societe_rib`
--
ALTER TABLE `llx_societe_rib`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_societe_rib` (`entity`,`label`,`fk_soc`),
  ADD KEY `llx_societe_rib_fk_societe` (`fk_soc`);

--
-- Indices de la tabla `llx_socpeople`
--
ALTER TABLE `llx_socpeople`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_socpeople_fk_soc` (`fk_soc`),
  ADD KEY `idx_socpeople_fk_user_creat` (`fk_user_creat`),
  ADD KEY `idx_socpeople_lastname` (`lastname`);

--
-- Indices de la tabla `llx_socpeople_extrafields`
--
ALTER TABLE `llx_socpeople_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_socpeople_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_stock_mouvement`
--
ALTER TABLE `llx_stock_mouvement`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_stock_mouvement_fk_product` (`fk_product`),
  ADD KEY `idx_stock_mouvement_fk_entrepot` (`fk_entrepot`);

--
-- Indices de la tabla `llx_stock_mouvement_extrafields`
--
ALTER TABLE `llx_stock_mouvement_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_stock_mouvement_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_subscription`
--
ALTER TABLE `llx_subscription`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_subscription` (`fk_adherent`,`dateadh`);

--
-- Indices de la tabla `llx_supplier_proposal`
--
ALTER TABLE `llx_supplier_proposal`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_supplier_proposal_ref` (`ref`,`entity`),
  ADD KEY `idx_supplier_proposal_fk_soc` (`fk_soc`),
  ADD KEY `idx_supplier_proposal_fk_user_author` (`fk_user_author`),
  ADD KEY `idx_supplier_proposal_fk_user_valid` (`fk_user_valid`),
  ADD KEY `idx_supplier_proposal_fk_projet` (`fk_projet`),
  ADD KEY `idx_supplier_proposal_fk_account` (`fk_account`);

--
-- Indices de la tabla `llx_supplier_proposaldet`
--
ALTER TABLE `llx_supplier_proposaldet`
  ADD PRIMARY KEY (`rowid`),
  ADD KEY `idx_supplier_proposaldet_fk_supplier_proposal` (`fk_supplier_proposal`),
  ADD KEY `idx_supplier_proposaldet_fk_product` (`fk_product`),
  ADD KEY `fk_supplier_proposaldet_fk_unit` (`fk_unit`);

--
-- Indices de la tabla `llx_supplier_proposaldet_extrafields`
--
ALTER TABLE `llx_supplier_proposaldet_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_supplier_proposaldet_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_supplier_proposal_extrafields`
--
ALTER TABLE `llx_supplier_proposal_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_supplier_proposal_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_tva`
--
ALTER TABLE `llx_tva`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_user`
--
ALTER TABLE `llx_user`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_user_login` (`login`,`entity`),
  ADD UNIQUE KEY `uk_user_fk_socpeople` (`fk_socpeople`),
  ADD UNIQUE KEY `uk_user_fk_member` (`fk_member`),
  ADD UNIQUE KEY `uk_user_api_key` (`api_key`),
  ADD KEY `idx_user_fk_societe` (`fk_soc`);

--
-- Indices de la tabla `llx_usergroup`
--
ALTER TABLE `llx_usergroup`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_usergroup_name` (`nom`,`entity`);

--
-- Indices de la tabla `llx_usergroup_extrafields`
--
ALTER TABLE `llx_usergroup_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_usergroup_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_usergroup_rights`
--
ALTER TABLE `llx_usergroup_rights`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_usergroup_rights` (`entity`,`fk_usergroup`,`fk_id`),
  ADD KEY `fk_usergroup_rights_fk_usergroup` (`fk_usergroup`);

--
-- Indices de la tabla `llx_usergroup_user`
--
ALTER TABLE `llx_usergroup_user`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_usergroup_user` (`entity`,`fk_user`,`fk_usergroup`),
  ADD KEY `fk_usergroup_user_fk_user` (`fk_user`),
  ADD KEY `fk_usergroup_user_fk_usergroup` (`fk_usergroup`);

--
-- Indices de la tabla `llx_user_alert`
--
ALTER TABLE `llx_user_alert`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_user_clicktodial`
--
ALTER TABLE `llx_user_clicktodial`
  ADD PRIMARY KEY (`fk_user`);

--
-- Indices de la tabla `llx_user_employment`
--
ALTER TABLE `llx_user_employment`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_user_employment` (`ref`,`entity`),
  ADD KEY `fk_user_employment_fk_user` (`fk_user`);

--
-- Indices de la tabla `llx_user_extrafields`
--
ALTER TABLE `llx_user_extrafields`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_user_extrafields` (`fk_object`);

--
-- Indices de la tabla `llx_user_param`
--
ALTER TABLE `llx_user_param`
  ADD UNIQUE KEY `uk_user_param` (`fk_user`,`param`,`entity`);

--
-- Indices de la tabla `llx_user_rib`
--
ALTER TABLE `llx_user_rib`
  ADD PRIMARY KEY (`rowid`);

--
-- Indices de la tabla `llx_user_rights`
--
ALTER TABLE `llx_user_rights`
  ADD PRIMARY KEY (`rowid`),
  ADD UNIQUE KEY `uk_user_rights` (`entity`,`fk_user`,`fk_id`),
  ADD KEY `fk_user_rights_fk_user_user` (`fk_user`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `llx_accounting_account`
--
ALTER TABLE `llx_accounting_account`
  MODIFY `rowid` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_accounting_bookkeeping`
--
ALTER TABLE `llx_accounting_bookkeeping`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_accounting_bookkeeping_tmp`
--
ALTER TABLE `llx_accounting_bookkeeping_tmp`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_accounting_fiscalyear`
--
ALTER TABLE `llx_accounting_fiscalyear`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_accounting_groups_account`
--
ALTER TABLE `llx_accounting_groups_account`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_accounting_journal`
--
ALTER TABLE `llx_accounting_journal`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `llx_accounting_system`
--
ALTER TABLE `llx_accounting_system`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `llx_actioncomm`
--
ALTER TABLE `llx_actioncomm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=289;

--
-- AUTO_INCREMENT de la tabla `llx_actioncomm_extrafields`
--
ALTER TABLE `llx_actioncomm_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_actioncomm_reminder`
--
ALTER TABLE `llx_actioncomm_reminder`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_actioncomm_resources`
--
ALTER TABLE `llx_actioncomm_resources`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=289;

--
-- AUTO_INCREMENT de la tabla `llx_adherent`
--
ALTER TABLE `llx_adherent`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_adherent_extrafields`
--
ALTER TABLE `llx_adherent_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_adherent_type`
--
ALTER TABLE `llx_adherent_type`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_adherent_type_extrafields`
--
ALTER TABLE `llx_adherent_type_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_adherent_type_lang`
--
ALTER TABLE `llx_adherent_type_lang`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_bank`
--
ALTER TABLE `llx_bank`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_bank_account`
--
ALTER TABLE `llx_bank_account`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_bank_account_extrafields`
--
ALTER TABLE `llx_bank_account_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_bank_extrafields`
--
ALTER TABLE `llx_bank_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_bank_url`
--
ALTER TABLE `llx_bank_url`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_blockedlog`
--
ALTER TABLE `llx_blockedlog`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_blockedlog_authority`
--
ALTER TABLE `llx_blockedlog_authority`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_bookmark`
--
ALTER TABLE `llx_bookmark`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_bordereau_cheque`
--
ALTER TABLE `llx_bordereau_cheque`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_boxes`
--
ALTER TABLE `llx_boxes`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `llx_boxes_def`
--
ALTER TABLE `llx_boxes_def`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `llx_categorie`
--
ALTER TABLE `llx_categorie`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `llx_categories_extrafields`
--
ALTER TABLE `llx_categories_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_categorie_lang`
--
ALTER TABLE `llx_categorie_lang`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_category_bank`
--
ALTER TABLE `llx_category_bank`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_chargesociales`
--
ALTER TABLE `llx_chargesociales`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_commande`
--
ALTER TABLE `llx_commande`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `llx_commandedet`
--
ALTER TABLE `llx_commandedet`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `llx_commandedet_extrafields`
--
ALTER TABLE `llx_commandedet_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_commande_extrafields`
--
ALTER TABLE `llx_commande_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_commande_fournisseur`
--
ALTER TABLE `llx_commande_fournisseur`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_commande_fournisseurdet`
--
ALTER TABLE `llx_commande_fournisseurdet`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_commande_fournisseurdet_extrafields`
--
ALTER TABLE `llx_commande_fournisseurdet_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_commande_fournisseur_extrafields`
--
ALTER TABLE `llx_commande_fournisseur_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_commande_fournisseur_log`
--
ALTER TABLE `llx_commande_fournisseur_log`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_comment`
--
ALTER TABLE `llx_comment`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_const`
--
ALTER TABLE `llx_const`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=626;

--
-- AUTO_INCREMENT de la tabla `llx_contrat`
--
ALTER TABLE `llx_contrat`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_contratdet`
--
ALTER TABLE `llx_contratdet`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_contratdet_extrafields`
--
ALTER TABLE `llx_contratdet_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_contrat_extrafields`
--
ALTER TABLE `llx_contrat_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_cronjob`
--
ALTER TABLE `llx_cronjob`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `llx_c_action_trigger`
--
ALTER TABLE `llx_c_action_trigger`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;

--
-- AUTO_INCREMENT de la tabla `llx_c_availability`
--
ALTER TABLE `llx_c_availability`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `llx_c_barcode_type`
--
ALTER TABLE `llx_c_barcode_type`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_c_chargesociales`
--
ALTER TABLE `llx_c_chargesociales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10214;

--
-- AUTO_INCREMENT de la tabla `llx_c_civility`
--
ALTER TABLE `llx_c_civility`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `llx_c_departements`
--
ALTER TABLE `llx_c_departements`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1838;

--
-- AUTO_INCREMENT de la tabla `llx_c_ecotaxe`
--
ALTER TABLE `llx_c_ecotaxe`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `llx_c_email_senderprofile`
--
ALTER TABLE `llx_c_email_senderprofile`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_c_email_templates`
--
ALTER TABLE `llx_c_email_templates`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `llx_c_field_list`
--
ALTER TABLE `llx_c_field_list`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_c_format_cards`
--
ALTER TABLE `llx_c_format_cards`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `llx_c_forme_juridique`
--
ALTER TABLE `llx_c_forme_juridique`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=329;

--
-- AUTO_INCREMENT de la tabla `llx_c_holiday_types`
--
ALTER TABLE `llx_c_holiday_types`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `llx_c_hrm_public_holiday`
--
ALTER TABLE `llx_c_hrm_public_holiday`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT de la tabla `llx_c_incoterms`
--
ALTER TABLE `llx_c_incoterms`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `llx_c_input_method`
--
ALTER TABLE `llx_c_input_method`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `llx_c_input_reason`
--
ALTER TABLE `llx_c_input_reason`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `llx_c_invoice_subtype`
--
ALTER TABLE `llx_c_invoice_subtype`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `llx_c_lead_status`
--
ALTER TABLE `llx_c_lead_status`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `llx_c_paiement`
--
ALTER TABLE `llx_c_paiement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT de la tabla `llx_c_paper_format`
--
ALTER TABLE `llx_c_paper_format`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=226;

--
-- AUTO_INCREMENT de la tabla `llx_c_payment_term`
--
ALTER TABLE `llx_c_payment_term`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `llx_c_product_nature`
--
ALTER TABLE `llx_c_product_nature`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `llx_c_product_thirdparty_relation_type`
--
ALTER TABLE `llx_c_product_thirdparty_relation_type`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_c_regions`
--
ALTER TABLE `llx_c_regions`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=311;

--
-- AUTO_INCREMENT de la tabla `llx_c_revenuestamp`
--
ALTER TABLE `llx_c_revenuestamp`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22103;

--
-- AUTO_INCREMENT de la tabla `llx_c_shipment_mode`
--
ALTER TABLE `llx_c_shipment_mode`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `llx_c_shipment_package_type`
--
ALTER TABLE `llx_c_shipment_package_type`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_c_socialnetworks`
--
ALTER TABLE `llx_c_socialnetworks`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `llx_c_transport_mode`
--
ALTER TABLE `llx_c_transport_mode`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `llx_c_tva`
--
ALTER TABLE `llx_c_tva`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22105;

--
-- AUTO_INCREMENT de la tabla `llx_c_type_contact`
--
ALTER TABLE `llx_c_type_contact`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT de la tabla `llx_c_type_fees`
--
ALTER TABLE `llx_c_type_fees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `llx_c_type_resource`
--
ALTER TABLE `llx_c_type_resource`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `llx_c_units`
--
ALTER TABLE `llx_c_units`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `llx_c_ziptown`
--
ALTER TABLE `llx_c_ziptown`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_default_values`
--
ALTER TABLE `llx_default_values`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_delivery`
--
ALTER TABLE `llx_delivery`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_deliverydet`
--
ALTER TABLE `llx_deliverydet`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_deliverydet_extrafields`
--
ALTER TABLE `llx_deliverydet_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_delivery_extrafields`
--
ALTER TABLE `llx_delivery_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_document_model`
--
ALTER TABLE `llx_document_model`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `llx_ecm_directories`
--
ALTER TABLE `llx_ecm_directories`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_ecm_directories_extrafields`
--
ALTER TABLE `llx_ecm_directories_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_ecm_files`
--
ALTER TABLE `llx_ecm_files`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `llx_ecm_files_extrafields`
--
ALTER TABLE `llx_ecm_files_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_element_categorie`
--
ALTER TABLE `llx_element_categorie`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_element_contact`
--
ALTER TABLE `llx_element_contact`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_element_element`
--
ALTER TABLE `llx_element_element`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `llx_element_resources`
--
ALTER TABLE `llx_element_resources`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_element_time`
--
ALTER TABLE `llx_element_time`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_emailcollector_emailcollector`
--
ALTER TABLE `llx_emailcollector_emailcollector`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_emailcollector_emailcollectoraction`
--
ALTER TABLE `llx_emailcollector_emailcollectoraction`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_emailcollector_emailcollectorfilter`
--
ALTER TABLE `llx_emailcollector_emailcollectorfilter`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_entrepot`
--
ALTER TABLE `llx_entrepot`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `llx_entrepot_extrafields`
--
ALTER TABLE `llx_entrepot_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_establishment`
--
ALTER TABLE `llx_establishment`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_eventorganization_conferenceorboothattendee`
--
ALTER TABLE `llx_eventorganization_conferenceorboothattendee`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_eventorganization_conferenceorboothattendee_extrafields`
--
ALTER TABLE `llx_eventorganization_conferenceorboothattendee_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_events`
--
ALTER TABLE `llx_events`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_event_element`
--
ALTER TABLE `llx_event_element`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_expedition`
--
ALTER TABLE `llx_expedition`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_expeditiondet`
--
ALTER TABLE `llx_expeditiondet`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_expeditiondet_batch`
--
ALTER TABLE `llx_expeditiondet_batch`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_expeditiondet_extrafields`
--
ALTER TABLE `llx_expeditiondet_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_expedition_extrafields`
--
ALTER TABLE `llx_expedition_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_expedition_package`
--
ALTER TABLE `llx_expedition_package`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_expensereport`
--
ALTER TABLE `llx_expensereport`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_expensereport_det`
--
ALTER TABLE `llx_expensereport_det`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_expensereport_extrafields`
--
ALTER TABLE `llx_expensereport_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_export_model`
--
ALTER TABLE `llx_export_model`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_extrafields`
--
ALTER TABLE `llx_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facture`
--
ALTER TABLE `llx_facture`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `llx_facturedet`
--
ALTER TABLE `llx_facturedet`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `llx_facturedet_extrafields`
--
ALTER TABLE `llx_facturedet_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facturedet_rec`
--
ALTER TABLE `llx_facturedet_rec`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facturedet_rec_extrafields`
--
ALTER TABLE `llx_facturedet_rec_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facture_extrafields`
--
ALTER TABLE `llx_facture_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facture_fourn`
--
ALTER TABLE `llx_facture_fourn`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facture_fourn_det`
--
ALTER TABLE `llx_facture_fourn_det`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facture_fourn_det_extrafields`
--
ALTER TABLE `llx_facture_fourn_det_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facture_fourn_det_rec`
--
ALTER TABLE `llx_facture_fourn_det_rec`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facture_fourn_det_rec_extrafields`
--
ALTER TABLE `llx_facture_fourn_det_rec_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facture_fourn_extrafields`
--
ALTER TABLE `llx_facture_fourn_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facture_fourn_rec`
--
ALTER TABLE `llx_facture_fourn_rec`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facture_fourn_rec_extrafields`
--
ALTER TABLE `llx_facture_fourn_rec_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facture_rec`
--
ALTER TABLE `llx_facture_rec`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_facture_rec_extrafields`
--
ALTER TABLE `llx_facture_rec_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_fichinter`
--
ALTER TABLE `llx_fichinter`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_fichinterdet`
--
ALTER TABLE `llx_fichinterdet`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_fichinterdet_extrafields`
--
ALTER TABLE `llx_fichinterdet_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_fichinterdet_rec`
--
ALTER TABLE `llx_fichinterdet_rec`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_fichinter_extrafields`
--
ALTER TABLE `llx_fichinter_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_fichinter_rec`
--
ALTER TABLE `llx_fichinter_rec`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_holiday`
--
ALTER TABLE `llx_holiday`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_holiday_config`
--
ALTER TABLE `llx_holiday_config`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `llx_holiday_extrafields`
--
ALTER TABLE `llx_holiday_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_holiday_logs`
--
ALTER TABLE `llx_holiday_logs`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_import_model`
--
ALTER TABLE `llx_import_model`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_inventory`
--
ALTER TABLE `llx_inventory`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_inventorydet`
--
ALTER TABLE `llx_inventorydet`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_inventory_extrafields`
--
ALTER TABLE `llx_inventory_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_links`
--
ALTER TABLE `llx_links`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_localtax`
--
ALTER TABLE `llx_localtax`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_mailing_unsubscribe`
--
ALTER TABLE `llx_mailing_unsubscribe`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_menu`
--
ALTER TABLE `llx_menu`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `llx_multicurrency`
--
ALTER TABLE `llx_multicurrency`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_multicurrency_rate`
--
ALTER TABLE `llx_multicurrency_rate`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_notify`
--
ALTER TABLE `llx_notify`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_notify_def`
--
ALTER TABLE `llx_notify_def`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_notify_def_object`
--
ALTER TABLE `llx_notify_def_object`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_oauth_state`
--
ALTER TABLE `llx_oauth_state`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_oauth_token`
--
ALTER TABLE `llx_oauth_token`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_object_lang`
--
ALTER TABLE `llx_object_lang`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_onlinesignature`
--
ALTER TABLE `llx_onlinesignature`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_overwrite_trans`
--
ALTER TABLE `llx_overwrite_trans`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_paiement`
--
ALTER TABLE `llx_paiement`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `llx_paiementcharge`
--
ALTER TABLE `llx_paiementcharge`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_paiementfourn`
--
ALTER TABLE `llx_paiementfourn`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_paiementfourn_facturefourn`
--
ALTER TABLE `llx_paiementfourn_facturefourn`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_paiement_facture`
--
ALTER TABLE `llx_paiement_facture`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `llx_paymentexpensereport_expensereport`
--
ALTER TABLE `llx_paymentexpensereport_expensereport`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_payment_donation`
--
ALTER TABLE `llx_payment_donation`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_payment_expensereport`
--
ALTER TABLE `llx_payment_expensereport`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_payment_loan`
--
ALTER TABLE `llx_payment_loan`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_payment_salary`
--
ALTER TABLE `llx_payment_salary`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_payment_various`
--
ALTER TABLE `llx_payment_various`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_payment_vat`
--
ALTER TABLE `llx_payment_vat`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_pos_cash_fence`
--
ALTER TABLE `llx_pos_cash_fence`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_pos_cash_fence_extrafields`
--
ALTER TABLE `llx_pos_cash_fence_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_prelevement`
--
ALTER TABLE `llx_prelevement`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_prelevement_bons`
--
ALTER TABLE `llx_prelevement_bons`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_prelevement_demande`
--
ALTER TABLE `llx_prelevement_demande`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_prelevement_lignes`
--
ALTER TABLE `llx_prelevement_lignes`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_prelevement_rejet`
--
ALTER TABLE `llx_prelevement_rejet`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_printing`
--
ALTER TABLE `llx_printing`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product`
--
ALTER TABLE `llx_product`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `llx_product_association`
--
ALTER TABLE `llx_product_association`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_attribute`
--
ALTER TABLE `llx_product_attribute`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_attribute_value`
--
ALTER TABLE `llx_product_attribute_value`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_batch`
--
ALTER TABLE `llx_product_batch`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_customer_price`
--
ALTER TABLE `llx_product_customer_price`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_customer_price_extrafields`
--
ALTER TABLE `llx_product_customer_price_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_customer_price_log`
--
ALTER TABLE `llx_product_customer_price_log`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_extrafields`
--
ALTER TABLE `llx_product_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_fournisseur_price`
--
ALTER TABLE `llx_product_fournisseur_price`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_fournisseur_price_extrafields`
--
ALTER TABLE `llx_product_fournisseur_price_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_fournisseur_price_log`
--
ALTER TABLE `llx_product_fournisseur_price_log`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_lang`
--
ALTER TABLE `llx_product_lang`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_lot`
--
ALTER TABLE `llx_product_lot`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_lot_extrafields`
--
ALTER TABLE `llx_product_lot_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_price`
--
ALTER TABLE `llx_product_price`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `llx_product_pricerules`
--
ALTER TABLE `llx_product_pricerules`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_price_by_qty`
--
ALTER TABLE `llx_product_price_by_qty`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_price_extrafields`
--
ALTER TABLE `llx_product_price_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_stock`
--
ALTER TABLE `llx_product_stock`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `llx_product_thirdparty`
--
ALTER TABLE `llx_product_thirdparty`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_product_warehouse_properties`
--
ALTER TABLE `llx_product_warehouse_properties`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_projet`
--
ALTER TABLE `llx_projet`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_projet_extrafields`
--
ALTER TABLE `llx_projet_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_projet_task`
--
ALTER TABLE `llx_projet_task`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_projet_task_extrafields`
--
ALTER TABLE `llx_projet_task_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_propal`
--
ALTER TABLE `llx_propal`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `llx_propaldet`
--
ALTER TABLE `llx_propaldet`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT de la tabla `llx_propaldet_extrafields`
--
ALTER TABLE `llx_propaldet_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_propal_extrafields`
--
ALTER TABLE `llx_propal_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_propal_merge_pdf_product`
--
ALTER TABLE `llx_propal_merge_pdf_product`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_reception`
--
ALTER TABLE `llx_reception`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_receptiondet_batch`
--
ALTER TABLE `llx_receptiondet_batch`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_receptiondet_batch_extrafields`
--
ALTER TABLE `llx_receptiondet_batch_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_reception_extrafields`
--
ALTER TABLE `llx_reception_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_resource`
--
ALTER TABLE `llx_resource`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_resource_extrafields`
--
ALTER TABLE `llx_resource_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_salary`
--
ALTER TABLE `llx_salary`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_salary_extrafields`
--
ALTER TABLE `llx_salary_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_societe`
--
ALTER TABLE `llx_societe`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de la tabla `llx_societe_account`
--
ALTER TABLE `llx_societe_account`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_societe_commerciaux`
--
ALTER TABLE `llx_societe_commerciaux`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `llx_societe_contacts`
--
ALTER TABLE `llx_societe_contacts`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_societe_extrafields`
--
ALTER TABLE `llx_societe_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_societe_prices`
--
ALTER TABLE `llx_societe_prices`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_societe_remise`
--
ALTER TABLE `llx_societe_remise`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_societe_remise_except`
--
ALTER TABLE `llx_societe_remise_except`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_societe_remise_supplier`
--
ALTER TABLE `llx_societe_remise_supplier`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_societe_rib`
--
ALTER TABLE `llx_societe_rib`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_socpeople`
--
ALTER TABLE `llx_socpeople`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_socpeople_extrafields`
--
ALTER TABLE `llx_socpeople_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_stock_mouvement`
--
ALTER TABLE `llx_stock_mouvement`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `llx_stock_mouvement_extrafields`
--
ALTER TABLE `llx_stock_mouvement_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_subscription`
--
ALTER TABLE `llx_subscription`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_supplier_proposal`
--
ALTER TABLE `llx_supplier_proposal`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_supplier_proposaldet`
--
ALTER TABLE `llx_supplier_proposaldet`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_supplier_proposaldet_extrafields`
--
ALTER TABLE `llx_supplier_proposaldet_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_supplier_proposal_extrafields`
--
ALTER TABLE `llx_supplier_proposal_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_tva`
--
ALTER TABLE `llx_tva`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_user`
--
ALTER TABLE `llx_user`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `llx_usergroup`
--
ALTER TABLE `llx_usergroup`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_usergroup_extrafields`
--
ALTER TABLE `llx_usergroup_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_usergroup_rights`
--
ALTER TABLE `llx_usergroup_rights`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_usergroup_user`
--
ALTER TABLE `llx_usergroup_user`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_user_alert`
--
ALTER TABLE `llx_user_alert`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_user_employment`
--
ALTER TABLE `llx_user_employment`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_user_extrafields`
--
ALTER TABLE `llx_user_extrafields`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_user_rib`
--
ALTER TABLE `llx_user_rib`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `llx_user_rights`
--
ALTER TABLE `llx_user_rights`
  MODIFY `rowid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=293;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `llx_accounting_account`
--
ALTER TABLE `llx_accounting_account`
  ADD CONSTRAINT `fk_accounting_account_fk_pcg_version` FOREIGN KEY (`fk_pcg_version`) REFERENCES `llx_accounting_system` (`pcg_version`);

--
-- Filtros para la tabla `llx_adherent`
--
ALTER TABLE `llx_adherent`
  ADD CONSTRAINT `adherent_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_adherent_adherent_type` FOREIGN KEY (`fk_adherent_type`) REFERENCES `llx_adherent_type` (`rowid`);

--
-- Filtros para la tabla `llx_bank_account`
--
ALTER TABLE `llx_bank_account`
  ADD CONSTRAINT `fk_bank_account_accountancy_journal` FOREIGN KEY (`fk_accountancy_journal`) REFERENCES `llx_accounting_journal` (`rowid`);

--
-- Filtros para la tabla `llx_boxes`
--
ALTER TABLE `llx_boxes`
  ADD CONSTRAINT `fk_boxes_box_id` FOREIGN KEY (`box_id`) REFERENCES `llx_boxes_def` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_account`
--
ALTER TABLE `llx_categorie_account`
  ADD CONSTRAINT `fk_categorie_account_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_account_fk_account` FOREIGN KEY (`fk_account`) REFERENCES `llx_bank_account` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_actioncomm`
--
ALTER TABLE `llx_categorie_actioncomm`
  ADD CONSTRAINT `fk_categorie_actioncomm_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_actioncomm_fk_actioncomm` FOREIGN KEY (`fk_actioncomm`) REFERENCES `llx_actioncomm` (`id`);

--
-- Filtros para la tabla `llx_categorie_contact`
--
ALTER TABLE `llx_categorie_contact`
  ADD CONSTRAINT `fk_categorie_contact_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_contact_fk_socpeople` FOREIGN KEY (`fk_socpeople`) REFERENCES `llx_socpeople` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_fournisseur`
--
ALTER TABLE `llx_categorie_fournisseur`
  ADD CONSTRAINT `fk_categorie_fournisseur_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_fournisseur_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_invoice`
--
ALTER TABLE `llx_categorie_invoice`
  ADD CONSTRAINT `fk_categorie_invoice_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_invoice_fk_invoice_rowid` FOREIGN KEY (`fk_invoice`) REFERENCES `llx_facture` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_lang`
--
ALTER TABLE `llx_categorie_lang`
  ADD CONSTRAINT `fk_category_lang_fk_category` FOREIGN KEY (`fk_category`) REFERENCES `llx_categorie` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_member`
--
ALTER TABLE `llx_categorie_member`
  ADD CONSTRAINT `fk_categorie_member_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_member_member_rowid` FOREIGN KEY (`fk_member`) REFERENCES `llx_adherent` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_order`
--
ALTER TABLE `llx_categorie_order`
  ADD CONSTRAINT `fk_categorie_order_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_order_fk_order_rowid` FOREIGN KEY (`fk_order`) REFERENCES `llx_commande` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_product`
--
ALTER TABLE `llx_categorie_product`
  ADD CONSTRAINT `fk_categorie_product_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_product_product_rowid` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_project`
--
ALTER TABLE `llx_categorie_project`
  ADD CONSTRAINT `fk_categorie_project_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_project_fk_project_rowid` FOREIGN KEY (`fk_project`) REFERENCES `llx_projet` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_societe`
--
ALTER TABLE `llx_categorie_societe`
  ADD CONSTRAINT `fk_categorie_societe_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_societe_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_supplier_invoice`
--
ALTER TABLE `llx_categorie_supplier_invoice`
  ADD CONSTRAINT `fk_categorie_supplier_invoice_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_supplier_invoice_fk_supplier_invoice_rowid` FOREIGN KEY (`fk_supplier_invoice`) REFERENCES `llx_facture_fourn` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_supplier_order`
--
ALTER TABLE `llx_categorie_supplier_order`
  ADD CONSTRAINT `fk_categorie_supplier_order_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_supplier_order_fk_supplier_order_rowid` FOREIGN KEY (`fk_supplier_order`) REFERENCES `llx_commande_fournisseur` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_user`
--
ALTER TABLE `llx_categorie_user`
  ADD CONSTRAINT `fk_categorie_user_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_user_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_categorie_warehouse`
--
ALTER TABLE `llx_categorie_warehouse`
  ADD CONSTRAINT `fk_categorie_warehouse_categorie_rowid` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`),
  ADD CONSTRAINT `fk_categorie_warehouse_fk_warehouse_rowid` FOREIGN KEY (`fk_warehouse`) REFERENCES `llx_entrepot` (`rowid`);

--
-- Filtros para la tabla `llx_commande`
--
ALTER TABLE `llx_commande`
  ADD CONSTRAINT `fk_commande_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  ADD CONSTRAINT `fk_commande_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_commande_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_commande_fk_user_cloture` FOREIGN KEY (`fk_user_cloture`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_commande_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_commandedet`
--
ALTER TABLE `llx_commandedet`
  ADD CONSTRAINT `fk_commandedet_fk_commande` FOREIGN KEY (`fk_commande`) REFERENCES `llx_commande` (`rowid`),
  ADD CONSTRAINT `fk_commandedet_fk_commandefourndet` FOREIGN KEY (`fk_commandefourndet`) REFERENCES `llx_commande_fournisseurdet` (`rowid`),
  ADD CONSTRAINT `fk_commandedet_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`);

--
-- Filtros para la tabla `llx_commande_fournisseur`
--
ALTER TABLE `llx_commande_fournisseur`
  ADD CONSTRAINT `fk_commande_fournisseur_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`);

--
-- Filtros para la tabla `llx_commande_fournisseurdet`
--
ALTER TABLE `llx_commande_fournisseurdet`
  ADD CONSTRAINT `fk_commande_fournisseurdet_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`);

--
-- Filtros para la tabla `llx_contrat`
--
ALTER TABLE `llx_contrat`
  ADD CONSTRAINT `fk_contrat_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_contrat_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_contratdet`
--
ALTER TABLE `llx_contratdet`
  ADD CONSTRAINT `fk_contratdet_fk_contrat` FOREIGN KEY (`fk_contrat`) REFERENCES `llx_contrat` (`rowid`),
  ADD CONSTRAINT `fk_contratdet_fk_product` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`),
  ADD CONSTRAINT `fk_contratdet_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`);

--
-- Filtros para la tabla `llx_c_departements`
--
ALTER TABLE `llx_c_departements`
  ADD CONSTRAINT `fk_departements_fk_region` FOREIGN KEY (`fk_region`) REFERENCES `llx_c_regions` (`code_region`);

--
-- Filtros para la tabla `llx_c_regions`
--
ALTER TABLE `llx_c_regions`
  ADD CONSTRAINT `fk_c_regions_fk_pays` FOREIGN KEY (`fk_pays`) REFERENCES `llx_c_country` (`rowid`);

--
-- Filtros para la tabla `llx_c_tva`
--
ALTER TABLE `llx_c_tva`
  ADD CONSTRAINT `fk_tva_fk_department_buyer` FOREIGN KEY (`fk_department_buyer`) REFERENCES `llx_c_departements` (`rowid`);

--
-- Filtros para la tabla `llx_c_ziptown`
--
ALTER TABLE `llx_c_ziptown`
  ADD CONSTRAINT `fk_c_ziptown_fk_county` FOREIGN KEY (`fk_county`) REFERENCES `llx_c_departements` (`rowid`),
  ADD CONSTRAINT `fk_c_ziptown_fk_pays` FOREIGN KEY (`fk_pays`) REFERENCES `llx_c_country` (`rowid`);

--
-- Filtros para la tabla `llx_delivery`
--
ALTER TABLE `llx_delivery`
  ADD CONSTRAINT `fk_delivery_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_delivery_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_delivery_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_deliverydet`
--
ALTER TABLE `llx_deliverydet`
  ADD CONSTRAINT `fk_deliverydet_fk_delivery` FOREIGN KEY (`fk_delivery`) REFERENCES `llx_delivery` (`rowid`);

--
-- Filtros para la tabla `llx_ecm_directories`
--
ALTER TABLE `llx_ecm_directories`
  ADD CONSTRAINT `fk_ecm_directories_fk_user_c` FOREIGN KEY (`fk_user_c`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_ecm_directories_fk_user_m` FOREIGN KEY (`fk_user_m`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_element_categorie`
--
ALTER TABLE `llx_element_categorie`
  ADD CONSTRAINT `fk_element_categorie_fk_categorie` FOREIGN KEY (`fk_categorie`) REFERENCES `llx_categorie` (`rowid`);

--
-- Filtros para la tabla `llx_element_contact`
--
ALTER TABLE `llx_element_contact`
  ADD CONSTRAINT `fk_element_contact_fk_c_type_contact` FOREIGN KEY (`fk_c_type_contact`) REFERENCES `llx_c_type_contact` (`rowid`);

--
-- Filtros para la tabla `llx_emailcollector_emailcollectoraction`
--
ALTER TABLE `llx_emailcollector_emailcollectoraction`
  ADD CONSTRAINT `fk_emailcollectoraction_fk_emailcollector` FOREIGN KEY (`fk_emailcollector`) REFERENCES `llx_emailcollector_emailcollector` (`rowid`);

--
-- Filtros para la tabla `llx_emailcollector_emailcollectorfilter`
--
ALTER TABLE `llx_emailcollector_emailcollectorfilter`
  ADD CONSTRAINT `fk_emailcollectorfilter_fk_emailcollector` FOREIGN KEY (`fk_emailcollector`) REFERENCES `llx_emailcollector_emailcollector` (`rowid`);

--
-- Filtros para la tabla `llx_expedition`
--
ALTER TABLE `llx_expedition`
  ADD CONSTRAINT `fk_expedition_fk_shipping_method` FOREIGN KEY (`fk_shipping_method`) REFERENCES `llx_c_shipment_mode` (`rowid`),
  ADD CONSTRAINT `fk_expedition_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_expedition_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_expedition_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_expeditiondet`
--
ALTER TABLE `llx_expeditiondet`
  ADD CONSTRAINT `fk_expeditiondet_fk_expedition` FOREIGN KEY (`fk_expedition`) REFERENCES `llx_expedition` (`rowid`);

--
-- Filtros para la tabla `llx_expeditiondet_batch`
--
ALTER TABLE `llx_expeditiondet_batch`
  ADD CONSTRAINT `fk_expeditiondet_batch_fk_expeditiondet` FOREIGN KEY (`fk_expeditiondet`) REFERENCES `llx_expeditiondet` (`rowid`);

--
-- Filtros para la tabla `llx_facture`
--
ALTER TABLE `llx_facture`
  ADD CONSTRAINT `fk_facture_fk_facture_source` FOREIGN KEY (`fk_facture_source`) REFERENCES `llx_facture` (`rowid`),
  ADD CONSTRAINT `fk_facture_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  ADD CONSTRAINT `fk_facture_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_facture_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_facture_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_facturedet`
--
ALTER TABLE `llx_facturedet`
  ADD CONSTRAINT `fk_facturedet_fk_facture` FOREIGN KEY (`fk_facture`) REFERENCES `llx_facture` (`rowid`),
  ADD CONSTRAINT `fk_facturedet_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`);

--
-- Filtros para la tabla `llx_facturedet_rec`
--
ALTER TABLE `llx_facturedet_rec`
  ADD CONSTRAINT `fk_facturedet_rec_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`);

--
-- Filtros para la tabla `llx_facture_fourn`
--
ALTER TABLE `llx_facture_fourn`
  ADD CONSTRAINT `fk_facture_fourn_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  ADD CONSTRAINT `fk_facture_fourn_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_facture_fourn_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_facture_fourn_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_facture_fourn_det`
--
ALTER TABLE `llx_facture_fourn_det`
  ADD CONSTRAINT `fk_facture_fourn_det_fk_facture` FOREIGN KEY (`fk_facture_fourn`) REFERENCES `llx_facture_fourn` (`rowid`),
  ADD CONSTRAINT `fk_facture_fourn_det_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`);

--
-- Filtros para la tabla `llx_facture_fourn_det_rec`
--
ALTER TABLE `llx_facture_fourn_det_rec`
  ADD CONSTRAINT `fk_facture_fourn_det_rec_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`);

--
-- Filtros para la tabla `llx_facture_fourn_rec`
--
ALTER TABLE `llx_facture_fourn_rec`
  ADD CONSTRAINT `fk_facture_fourn_rec_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  ADD CONSTRAINT `fk_facture_fourn_rec_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_facture_fourn_rec_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_facture_rec`
--
ALTER TABLE `llx_facture_rec`
  ADD CONSTRAINT `fk_facture_rec_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  ADD CONSTRAINT `fk_facture_rec_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_facture_rec_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_fichinter`
--
ALTER TABLE `llx_fichinter`
  ADD CONSTRAINT `fk_fichinter_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`);

--
-- Filtros para la tabla `llx_fichinterdet`
--
ALTER TABLE `llx_fichinterdet`
  ADD CONSTRAINT `fk_fichinterdet_fk_fichinter` FOREIGN KEY (`fk_fichinter`) REFERENCES `llx_fichinter` (`rowid`);

--
-- Filtros para la tabla `llx_fichinter_rec`
--
ALTER TABLE `llx_fichinter_rec`
  ADD CONSTRAINT `fk_fichinter_rec_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  ADD CONSTRAINT `fk_fichinter_rec_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_paiement_facture`
--
ALTER TABLE `llx_paiement_facture`
  ADD CONSTRAINT `fk_paiement_facture_fk_facture` FOREIGN KEY (`fk_facture`) REFERENCES `llx_facture` (`rowid`),
  ADD CONSTRAINT `fk_paiement_facture_fk_paiement` FOREIGN KEY (`fk_paiement`) REFERENCES `llx_paiement` (`rowid`);

--
-- Filtros para la tabla `llx_payment_salary`
--
ALTER TABLE `llx_payment_salary`
  ADD CONSTRAINT `fk_payment_salary_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_prelevement`
--
ALTER TABLE `llx_prelevement`
  ADD CONSTRAINT `fk_prelevement_fk_prelevement_lignes` FOREIGN KEY (`fk_prelevement_lignes`) REFERENCES `llx_prelevement_lignes` (`rowid`);

--
-- Filtros para la tabla `llx_prelevement_lignes`
--
ALTER TABLE `llx_prelevement_lignes`
  ADD CONSTRAINT `fk_prelevement_lignes_fk_prelevement_bons` FOREIGN KEY (`fk_prelevement_bons`) REFERENCES `llx_prelevement_bons` (`rowid`);

--
-- Filtros para la tabla `llx_product`
--
ALTER TABLE `llx_product`
  ADD CONSTRAINT `fk_product_barcode_type` FOREIGN KEY (`fk_barcode_type`) REFERENCES `llx_c_barcode_type` (`rowid`),
  ADD CONSTRAINT `fk_product_finished` FOREIGN KEY (`finished`) REFERENCES `llx_c_product_nature` (`code`),
  ADD CONSTRAINT `fk_product_fk_country` FOREIGN KEY (`fk_country`) REFERENCES `llx_c_country` (`rowid`),
  ADD CONSTRAINT `fk_product_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`);

--
-- Filtros para la tabla `llx_product_batch`
--
ALTER TABLE `llx_product_batch`
  ADD CONSTRAINT `fk_product_batch_fk_product_stock` FOREIGN KEY (`fk_product_stock`) REFERENCES `llx_product_stock` (`rowid`);

--
-- Filtros para la tabla `llx_product_customer_price`
--
ALTER TABLE `llx_product_customer_price`
  ADD CONSTRAINT `fk_product_customer_price_fk_product` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`),
  ADD CONSTRAINT `fk_product_customer_price_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_product_customer_price_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_product_fournisseur_price`
--
ALTER TABLE `llx_product_fournisseur_price`
  ADD CONSTRAINT `fk_product_fournisseur_price_barcode_type` FOREIGN KEY (`fk_barcode_type`) REFERENCES `llx_c_barcode_type` (`rowid`),
  ADD CONSTRAINT `fk_product_fournisseur_price_fk_product` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`),
  ADD CONSTRAINT `fk_product_fournisseur_price_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_product_lang`
--
ALTER TABLE `llx_product_lang`
  ADD CONSTRAINT `fk_product_lang_fk_product` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`);

--
-- Filtros para la tabla `llx_product_price`
--
ALTER TABLE `llx_product_price`
  ADD CONSTRAINT `fk_product_price_user_author` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`);

--
-- Filtros para la tabla `llx_product_price_by_qty`
--
ALTER TABLE `llx_product_price_by_qty`
  ADD CONSTRAINT `fk_product_price_by_qty_fk_product_price` FOREIGN KEY (`fk_product_price`) REFERENCES `llx_product_price` (`rowid`);

--
-- Filtros para la tabla `llx_product_stock`
--
ALTER TABLE `llx_product_stock`
  ADD CONSTRAINT `fk_entrepot_entrepot_rowid` FOREIGN KEY (`fk_entrepot`) REFERENCES `llx_entrepot` (`rowid`),
  ADD CONSTRAINT `fk_product_product_rowid` FOREIGN KEY (`fk_product`) REFERENCES `llx_product` (`rowid`);

--
-- Filtros para la tabla `llx_projet`
--
ALTER TABLE `llx_projet`
  ADD CONSTRAINT `fk_projet_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`);

--
-- Filtros para la tabla `llx_projet_task`
--
ALTER TABLE `llx_projet_task`
  ADD CONSTRAINT `fk_projet_task_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  ADD CONSTRAINT `fk_projet_task_fk_user_creat` FOREIGN KEY (`fk_user_creat`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_projet_task_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_propal`
--
ALTER TABLE `llx_propal`
  ADD CONSTRAINT `fk_propal_fk_projet` FOREIGN KEY (`fk_projet`) REFERENCES `llx_projet` (`rowid`),
  ADD CONSTRAINT `fk_propal_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_propal_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_propal_fk_user_cloture` FOREIGN KEY (`fk_user_cloture`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_propal_fk_user_signature` FOREIGN KEY (`fk_user_signature`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_propal_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_propaldet`
--
ALTER TABLE `llx_propaldet`
  ADD CONSTRAINT `fk_propaldet_fk_propal` FOREIGN KEY (`fk_propal`) REFERENCES `llx_propal` (`rowid`),
  ADD CONSTRAINT `fk_propaldet_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`);

--
-- Filtros para la tabla `llx_reception`
--
ALTER TABLE `llx_reception`
  ADD CONSTRAINT `fk_reception_fk_shipping_method` FOREIGN KEY (`fk_shipping_method`) REFERENCES `llx_c_shipment_mode` (`rowid`),
  ADD CONSTRAINT `fk_reception_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_reception_fk_user_author` FOREIGN KEY (`fk_user_author`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_reception_fk_user_valid` FOREIGN KEY (`fk_user_valid`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_receptiondet_batch`
--
ALTER TABLE `llx_receptiondet_batch`
  ADD CONSTRAINT `fk_receptiondet_batch_fk_reception` FOREIGN KEY (`fk_reception`) REFERENCES `llx_reception` (`rowid`);

--
-- Filtros para la tabla `llx_resource`
--
ALTER TABLE `llx_resource`
  ADD CONSTRAINT `fk_resource_fk_country` FOREIGN KEY (`fk_country`) REFERENCES `llx_c_country` (`rowid`);

--
-- Filtros para la tabla `llx_societe_account`
--
ALTER TABLE `llx_societe_account`
  ADD CONSTRAINT `llx_societe_account_fk_societe` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`);

--
-- Filtros para la tabla `llx_societe_commerciaux`
--
ALTER TABLE `llx_societe_commerciaux`
  ADD CONSTRAINT `fk_societe_commerciaux_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_societe_commerciaux_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_societe_contacts`
--
ALTER TABLE `llx_societe_contacts`
  ADD CONSTRAINT `fk_societe_contacts_fk_c_type_contact` FOREIGN KEY (`fk_c_type_contact`) REFERENCES `llx_c_type_contact` (`rowid`),
  ADD CONSTRAINT `fk_societe_contacts_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_societe_contacts_fk_socpeople` FOREIGN KEY (`fk_socpeople`) REFERENCES `llx_socpeople` (`rowid`);

--
-- Filtros para la tabla `llx_societe_remise_except`
--
ALTER TABLE `llx_societe_remise_except`
  ADD CONSTRAINT `fk_soc_remise_fk_facture_line` FOREIGN KEY (`fk_facture_line`) REFERENCES `llx_facturedet` (`rowid`),
  ADD CONSTRAINT `fk_soc_remise_fk_invoice_supplier_line` FOREIGN KEY (`fk_invoice_supplier_line`) REFERENCES `llx_facture_fourn_det` (`rowid`),
  ADD CONSTRAINT `fk_soc_remise_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_societe_remise_fk_facture` FOREIGN KEY (`fk_facture`) REFERENCES `llx_facture` (`rowid`),
  ADD CONSTRAINT `fk_societe_remise_fk_facture_source` FOREIGN KEY (`fk_facture_source`) REFERENCES `llx_facture` (`rowid`),
  ADD CONSTRAINT `fk_societe_remise_fk_invoice_supplier` FOREIGN KEY (`fk_invoice_supplier`) REFERENCES `llx_facture_fourn` (`rowid`),
  ADD CONSTRAINT `fk_societe_remise_fk_invoice_supplier_source` FOREIGN KEY (`fk_invoice_supplier`) REFERENCES `llx_facture_fourn` (`rowid`),
  ADD CONSTRAINT `fk_societe_remise_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_societe_rib`
--
ALTER TABLE `llx_societe_rib`
  ADD CONSTRAINT `llx_societe_rib_fk_societe` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`);

--
-- Filtros para la tabla `llx_socpeople`
--
ALTER TABLE `llx_socpeople`
  ADD CONSTRAINT `fk_socpeople_fk_soc` FOREIGN KEY (`fk_soc`) REFERENCES `llx_societe` (`rowid`),
  ADD CONSTRAINT `fk_socpeople_user_creat_user_rowid` FOREIGN KEY (`fk_user_creat`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_supplier_proposaldet`
--
ALTER TABLE `llx_supplier_proposaldet`
  ADD CONSTRAINT `fk_supplier_proposaldet_fk_supplier_proposal` FOREIGN KEY (`fk_supplier_proposal`) REFERENCES `llx_supplier_proposal` (`rowid`),
  ADD CONSTRAINT `fk_supplier_proposaldet_fk_unit` FOREIGN KEY (`fk_unit`) REFERENCES `llx_c_units` (`rowid`);

--
-- Filtros para la tabla `llx_usergroup_rights`
--
ALTER TABLE `llx_usergroup_rights`
  ADD CONSTRAINT `fk_usergroup_rights_fk_usergroup` FOREIGN KEY (`fk_usergroup`) REFERENCES `llx_usergroup` (`rowid`);

--
-- Filtros para la tabla `llx_usergroup_user`
--
ALTER TABLE `llx_usergroup_user`
  ADD CONSTRAINT `fk_usergroup_user_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`),
  ADD CONSTRAINT `fk_usergroup_user_fk_usergroup` FOREIGN KEY (`fk_usergroup`) REFERENCES `llx_usergroup` (`rowid`);

--
-- Filtros para la tabla `llx_user_employment`
--
ALTER TABLE `llx_user_employment`
  ADD CONSTRAINT `fk_user_employment_fk_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`);

--
-- Filtros para la tabla `llx_user_rights`
--
ALTER TABLE `llx_user_rights`
  ADD CONSTRAINT `fk_user_rights_fk_user_user` FOREIGN KEY (`fk_user`) REFERENCES `llx_user` (`rowid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
