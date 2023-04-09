create database gestao default character set utf8 collate utf8_general_ci;

--tabela usuarios
create table if not exists usuario(
    id_usuario int not null auto_increment,
    nome varchar(30) not null,
    senha varchar(10) not null,
    -- administrador aceita somente 0 ou 1 e default é 0
    administrador enum('0','1') not null default '0',
    primary key(id_usuario)
    )default charset=utf8;

    -- inserir dados na tabela usuario
    insert into usuario(nome,senha,administrador) values('Fulano','123','1');
    insert into usuario(nome,senha) values('Ciclano','124');

    -- alterar tabela usuario
    alter table usuario add ativo enum('0','1') not null default '1' after administrador;


--tabela servicos com relacionamento com categoria_servico
create table if not exists servicos(
    id_servico int not null auto_increment,
    nome_servico varchar(30) not null unique,
    categoria_servico int not null,
    foreign key(categoria_servico) references categoria_servico(id_categoria_servico),
    primary key(id_servico)
);



--tabela categoria servicos
create table if not exists categoria_servico(
    id_categoria_servico int not null auto_increment,
    nome_categoria_servico varchar(30) not null unique,
    primary key(id_categoria_servico)
);

--select na tabela servicos com inner join na tabela categoria_servico
select s.nome_servico, cs.nome_categoria_servico from servicos s inner join categoria_servico cs on s.categoria_servico = cs.id_categoria_servico;


create table if not exists empresas(
    id_empresa int not null auto_increment,
    data_cadastro date not null,
    nome_empresa varchar(30) not null,
    proprietario varchar(30) default '',
    estado char(2) not null,
    primary key(id_empresa)
);

--insert na tabela empresas
insert into empresas(data_cadastro,nome_empresa,proprietario,estado) values('2019-01-01','Empresa 1','Fulano','SP');
insert into empresas(data_cadastro,nome_empresa,estado) values('2019-01-01','Empresa 2','Fulano 2','SP');


--tabela serviços contratados
create table if not exists servicos_contratados(
    id_servico_contratado int not null auto_increment,
    id_empresa int not null,
    id_servico int not null,
    foreign key(id_empresa) references empresas(id_empresa),
    foreign key(id_servico) references servicos(id_servico),
    primary key(id_servico_contratado)
);

--insert na tabela servicos_contratados
insert into servicos_contratados(id_empresa,id_servico) values(1,1);

--select na tabela servicos_contratados com inner join na tabela empresas e servicos
select sc.id_servico_contratado, e.nome_empresa, s.nome_servico from servicos_contratados sc inner join empresas e on sc.id_empresa = e.id_empresa inner join servicos s on sc.id_servico = s.id_servico;