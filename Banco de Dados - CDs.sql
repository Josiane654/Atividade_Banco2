create database db_cds;
use db_cds;

create table tb_artista(
	pk_id_cod_art int auto_increment primary key,
    nome_art varchar (100) not null unique
);

create table tb_gravadora(
	pk_id_cod_grav int auto_increment primary key,
    nome_grav varchar (50) not null unique
);

create table tb_categoria(
	pk_id_cod_cat int auto_increment primary key,
    nome_cat varchar (50) not null unique
);

create table tb_estado(
	pk_sigla_est char (2) not null primary key,
    nome_est char (50) not null unique
);

create table tb_cidade(
	pk_id_cod_cid int auto_increment primary key,
    nome_cid varchar (100) not null,
    sigla_est char (2) not null,
    foreign key (sigla_est) references tb_estado (pk_sigla_est)
);

create table tb_cliente(
	pk_id_cod_cli int auto_increment primary key,
    cod_cid int not null,
    nome_cli varchar (100) not null,
    end_cli varchar (200) not null,
    renda_cli decimal (10,2) not null check(renda_cli >=0) default '0',
    sexo_cli enum('f', 'm') not null default 'f',
    foreign key (cod_cid) references tb_cidade (pk_id_cod_cid)
);

create table tb_conjuge(
	pk_id_cod_cli int auto_increment primary key,
    nome_conj varchar (100) not null,
    renda_conj decimal (10,2) not null check(renda_conj >=0) default '0',
    sexo_conj enum('f', 'm') not null default 'm',
    foreign key (pk_id_cod_cli) references tb_cliente (pk_id_cod_cli)
);

create table tb_funcionario(
	pk_id_cod_func int auto_increment primary key,
    nome_func varchar (100) not null,
    end_func varchar (200) not null,
    sal_func decimal (10,2) not null check(sal_func >=0) default '0',
    sexo_func enum('f', 'm') not null default 'm'
);

create table tb_dependente(
	pk_id_cod_dep int auto_increment primary key,
    fk_cod_func int not null,
    nome_dep varchar (100) not null,
    sexo_dep enum('f', 'm') not null default 'm',
	foreign key (fk_cod_func) references tb_funcionario (pk_id_cod_func)
);

create table tb_titulo(
	pk_id_cod_tit int auto_increment primary key,
    fk_cod_cat int not null,
    fk_cod_grav int not null,
    nome_cd varchar (100) not null unique,
	val_cd decimal (10,2) not null check(val_cd >0),
    qtd_estq int not null check(qtd_estq >=0),
	foreign key (fk_cod_cat) references tb_categoria (pk_id_cod_cat),
    foreign key (fk_cod_grav) references tb_gravadora (pk_id_cod_grav)
);

create table tb_pedido(
	pk_num_ped int auto_increment primary key,
    fk_cod_cli int not null,
    fk_cod_func int not null,
    data_ped datetime not null,
	val_ped decimal (10,2) not null check(val_ped >=0) default '0',
	foreign key (fk_cod_cli) references tb_cliente (pk_id_cod_cli),
    foreign key (fk_cod_func) references tb_funcionario (pk_id_cod_func)
);

create table tb_titulo_pedido(
	pk_num_ped int not null,
    pk_cod_tit int not null,
    qtd_cd int not null check(qtd_cd >=1),
	val_cd decimal (10,2) not null check(val_cd >0),
	foreign key (pk_num_ped) references tb_pedido (pk_num_ped),
    foreign key (pk_cod_tit) references tb_titulo (pk_id_cod_tit),
    primary key (pk_num_ped, pk_cod_tit)
);

create table tb_titulo_artista(
	pk_num_art int not null,
    pk_cod_tit int not null,
	foreign key (pk_num_art) references tb_artista (pk_id_cod_art),
    foreign key (pk_cod_tit) references tb_titulo (pk_id_cod_tit),
    primary key (pk_num_art, pk_cod_tit)
    );