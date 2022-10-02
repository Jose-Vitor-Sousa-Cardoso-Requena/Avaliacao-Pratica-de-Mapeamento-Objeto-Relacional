CREATE DATABASE 'jose3info';

CREATE TABLE 'campeonato' (
  'id_campeonato' int NOT NULL AUTO_INCREMENT,
  'id_creator' int DEFAULT NULL,
  'id_nome' varchar(150) NOT NULL,
  PRIMARY KEY ('id_campeonato'),
  KEY 'id_creator' ('id_creator'),
  CONSTRAINT 'campeonato_ibfk_1' FOREIGN KEY ('id_creator') REFERENCES 'user' ('id_user')
);

CREATE TABLE 'conta_valorant' (
  'id_conta' int NOT NULL AUTO_INCREMENT,
  'id_user' int DEFAULT NULL,
  'nome' varchar(150) NOT NULL,
  'tag' varchar(150) NOT NULL,
  PRIMARY KEY ('id_conta'),
  KEY 'id_user' ('id_user'),
  CONSTRAINT 'conta_valorant_ibfk_1' FOREIGN KEY ('id_user') REFERENCES 'user' ('id_user')
);

CREATE TABLE 'info_user' (
  'id_user' int NOT NULL,
  'nome' varchar(150) NOT NULL,
  'idade' int NOT NULL,
  'email' varchar(150) NOT NULL,
  'bio' varchar(200) DEFAULT NULL,
  PRIMARY KEY ('id_user'),
  CONSTRAINT 'info_user_ibfk_1' FOREIGN KEY ('id_user') REFERENCES 'user' ('id_user')
);

CREATE TABLE 'membro_time' (
  'id_user' int NOT NULL,
  'id_time' int NOT NULL,
  PRIMARY KEY ('id_user','id_time'),
  KEY 'id_time' ('id_time'),
  CONSTRAINT 'membro_time_ibfk_1' FOREIGN KEY ('id_user') REFERENCES 'user' ('id_user'),
  CONSTRAINT 'membro_time_ibfk_2' FOREIGN KEY ('id_time') REFERENCES 'time' ('id_time')
);

CREATE TABLE 'mensagem' (
  'id_mensagem' int NOT NULL AUTO_INCREMENT,
  'id_mandou' int DEFAULT NULL,
  'id_recebe' int DEFAULT NULL,
  'mensagem' varchar(200) NOT NULL,
  PRIMARY KEY ('id_mensagem'),
  KEY 'id_mandou' ('id_mandou'),
  KEY 'id_recebe' ('id_recebe'),
  CONSTRAINT 'mensagem_ibfk_1' FOREIGN KEY ('id_mandou') REFERENCES 'user' ('id_user'),
  CONSTRAINT 'mensagem_ibfk_2' FOREIGN KEY ('id_recebe') REFERENCES 'user' ('id_user')
);

CREATE TABLE 'mensagem_time' (
  'id_mensagem' int NOT NULL AUTO_INCREMENT,
  'id_mandou' int DEFAULT NULL,
  'id_time' int DEFAULT NULL,
  'mensagem' varchar(200) NOT NULL,
  PRIMARY KEY ('id_mensagem'),
  KEY 'id_mandou' ('id_mandou'),
  KEY 'id_time' ('id_time'),
  CONSTRAINT 'mensagem_time_ibfk_1' FOREIGN KEY ('id_mandou') REFERENCES 'user' ('id_user'),
  CONSTRAINT 'mensagem_time_ibfk_2' FOREIGN KEY ('id_time') REFERENCES 'time' ('id_time')
);

CREATE TABLE 'role_jogadas' (
  'id_conta' int NOT NULL,
  'id_role' int NOT NULL,
  PRIMARY KEY ('id_conta','id_role'),
  KEY 'id_role' ('id_role'),
  CONSTRAINT 'role_jogadas_ibfk_1' FOREIGN KEY ('id_conta') REFERENCES 'conta_valorant' ('id_conta'),
  CONSTRAINT 'role_jogadas_ibfk_2' FOREIGN KEY ('id_role') REFERENCES 'role_valorant' ('id_role')
);

CREATE TABLE 'role_valorant' (
  'id_role' int NOT NULL AUTO_INCREMENT,
  'nome' varchar(150) NOT NULL,
  PRIMARY KEY ('id_role')
);

CREATE TABLE 'segue' (
  'id_user' int NOT NULL,
  'id_friend' int NOT NULL,
  PRIMARY KEY ('id_user','id_friend'),
  KEY 'id_friend' ('id_friend'),
  CONSTRAINT 'segue_ibfk_1' FOREIGN KEY ('id_user') REFERENCES 'user' ('id_user'),
  CONSTRAINT 'segue_ibfk_2' FOREIGN KEY ('id_friend') REFERENCES 'user' ('id_user')
);

CREATE TABLE 'time' (
  'id_time' int NOT NULL AUTO_INCREMENT,
  'id_criador' int DEFAULT NULL,
  'nome' varchar(150) NOT NULL,
  PRIMARY KEY ('id_time'),
  KEY 'id_criador' ('id_criador'),
  CONSTRAINT 'time_ibfk_1' FOREIGN KEY ('id_criador') REFERENCES 'user' ('id_user')
);

CREATE TABLE 'time_campeonato' (
  'id_campeonato' int NOT NULL,
  'id_time' int NOT NULL,
  PRIMARY KEY ('id_campeonato','id_time'),
  KEY 'id_time' ('id_time'),
  CONSTRAINT 'time_campeonato_ibfk_1' FOREIGN KEY ('id_campeonato') REFERENCES 'campeonato' ('id_campeonato'),
  CONSTRAINT 'time_campeonato_ibfk_2' FOREIGN KEY ('id_time') REFERENCES 'time' ('id_time')
);

CREATE TABLE 'user' (
  'id_user' int NOT NULL AUTO_INCREMENT,
  'login' varchar(150) NOT NULL,
  'senha' varchar(150) NOT NULL,
  PRIMARY KEY ('id_user')
);
