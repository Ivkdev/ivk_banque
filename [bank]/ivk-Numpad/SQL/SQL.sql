USE `es_extended`;

CREATE TABLE IF NOT EXISTS `saving_accounts` (
  `id` varchar(40) CHARACTER SET utf8mb4 DEFAULT NULL,
  `money` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `users` ADD COLUMN `pin` varchar(50) NOT NULL DEFAULT '';

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('bankcard', 'Bank Card', 1)
;