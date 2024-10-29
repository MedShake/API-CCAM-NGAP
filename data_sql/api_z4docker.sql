
GRANT ALL PRIVILEGES ON NGAP.* TO 'user'@'%';
GRANT ALL PRIVILEGES ON config.* TO 'user'@'%';

USE config;

INSERT INTO `apiKeys` (`clef`, `user`, `start`, `end`) VALUES
('1234', 'default', NULL, NULL);

