create table ALUNOS(
CPF_aluno text NOT NULL unique,
nome_aluno varchar(50) NOT NULL unique,
endereço_aluno text NOT NULL,
email_aluno text NOT NULL unique,
status_inadinplemcia varchar(50) NOT NULL,
telefone_1 text NOT NULL unique,
telefone_2 text unique,
primary key(CPF_aluno),
);

create table EDITORA(
COD_editora int NOT NULL unique,
nome_editora varchar(50) NOT NULL,
primary key COD_editora
);
create table AUTOR(
cod_autor int NOT NULL unique,
nome_autor varchar(50) NOT NULL unique,
cod_editora int NOT NULL unique,
primary key cod_autor
foreign key(cod_editora) references EDITORA(COD_editora)
);

create table LIVROS(
codigo_livro int NOT NULL unique,
nome_livro varchar(50) NOT NULL unique,
ano_fabricacao_livro date,
genero_livro varchar(50) NOT NULL,
paginas_livro int NOT NULL,
edicao_livro int NOT NULL,
COD_editora int NOT NULL unique,
COD_autor int NOT NULL unique,
foreign key(COD_editora) references EDITORA(COD_editora),
foreign key(COD_autor) references AUTOR(COD_autor),
primary key(codigo_livro),
);
create table EMPRESTIMOS(
cod_emprestimo varchar(10) NOT NULL unique,
cpf_aluno varchar(50) NOT NULL unique,
cod_livro varchar (50) NOT NULL unique,
tempo int NOT NULL,
primary key(cod_emprestimo),
foreign key(aluno) references ALUNO(cpf_aluno),
foreign key(livro) references LIVRO(cod_livro),
);
create table fucionarios(
CPF_funcionario int NOT NULL unique,
nome_funcionario varchar(50) NOT NULL unique,
endereco_fucionario text NOT NULL,
email_funcionario NOT NULL text,
telefone_1 text NOT NULL unique,
telefone_2 text unique,
primary key CPF_funcionario,
);
insert into ALUNOS(CPF_aluno,nome_aluno,endereço_aluno,telefone_1,email_aluno)
values('956.562.577-28','Jorge Miguel','rua alameda dos santos silva','988455678','jorge53458@gmail.com'),
	  ('856.577.565-77','Fernanda Silva','Avenida Jorge Amado','988324672','fernanda87@outlook.com'),
	  ('775.208.857-08','Roberto Costa','Imbuí','988752245','roberto.c@hotmail.com'),
      ('554,675.890-75','Valdir Miranda','Pituaçu','988524720','valdr@outlook.com'),
      ('447.568.78-36','David Rios','Boca do rio','988527750','david189@gmail.com'),
insert into LIVROS(codigo_livro, nome_livro, anofabricacao_livro, genero_livro, paginas_livro, edicao_livro, autor_livro)
values ('001','REDES COMPUTADORES', '2010', 'INFORMATICA','607', '6ª'), 
       ('002','BANCO DE DADOS', '2008', 'INFORMATICA','542', '3ª'), 
       ('003','SISTEMAS OPERACIONAIS', '2002', 'INFORMATICA','780', '2ª'), 
       ('004','O UNIVERSO DA PROGRAMAÇÃO', '2015', 'INFORMATICA','543', '1ª'), 
       ('005','JAVASCRIPT', '2015', 'INFORMATICA','685', '1ª');
insert into funcionarios(CPF_funcionarios,nome_funcionarios, 
values ('001.002.003-12', 'Joao', 'Rua ameixa num 1 Bairro verde','joao@biblioteca.com','71 3621-1234'),
       ('001.002.047-02', 'Maria', 'Rua Jambo num 42 Bairro verde', 'maria@biblioteca.com', '71 3621-3246'),
       ('002.123.213-23', 'Martins', 'Rua acerolas num 69 Bairro azul', 'martins@biblioteca.com','71 3621-5280'),
       ('002.123.213-23','Trix', 'Rua margaridas num 13 Bairro cinza', 'trix@biblioteca.com', '71 3621-7235'),
       ('002.123.213-23', 'Sandro', 'Rua lobos num 12 Bairro cinza', 'sandro@biblioteca.com', '71 3621-5259');

insert into EDITORA(COD_editora,nome_editora)
values(001,'Auta Books'),
	  (002,'Editora arqueiro'),
      (003,'Panda Books'),
      (004,'FTD'),
      (005,'UBUS');
insert into AUTOR(cod_autor,nome_autor,cod_editora)
values (222,'KUROSE',001),
	   (333,'MATHEUS',002),
       (444,'TANENBAUM',003),
       (555,'WILLIAM OLIVEIRA',004),
       (666,'NICHOLAS C. ZAKAS',005);
GRANT ALL PRIVILEGES ON funcionarios TO joão;
GRANT ALL PRIVILEGES ON funcionarios TO Maria;
GRANT SELECT,  INSERT ON funcionarios TO Martins;
GRANT SELECT,  INSERT ON funcionarios TO Prins;
GRANT SELECT,  INSERT ON funcionarios TO Sandro;

select CPF_aluno
from ALUNO;

select nome_aluno
from ALUNO;

select endereco_aluno
from ALUNO;

select email_aluno
from ALUNO;

select t1.nome_aluno,t2.cod_emprestimo
from ALUNO t1,EMPRESTIMO t2
where t1.CPF_aluno=t2.cpf_aluno;

select nome_livro,cod_emprestimo
from LIVROS,EMPRESTIMOS
where genero_livro=INFORMATICA;

select t1.nome_AUTOR
from AUTOR t1, EDITORA t2
where t1.cod_editora=t2.COD_editora AND t2.nome="FTD";


select nome_livro, 
from LIVROS
where  genero_livro = INFORMATICA  AND anofabricação_livro >2005;
-- SELECIONA NA TABELA LIVROS, O NOME DOS LIVROS DE INFORMATICA FABRICADO DEPOIS DE 2005
select nome_livro, codigo_livro 
from LIVROS
where  edicao_livro = 6  AND COD_autor =222 ;
-- SELECIONA NA TABELA LIVROS, O NOME E O CODIGO DOS LIVROS DA SEXTA EDIÇÃO ESCRITO POR O AUTOR DE CÓDIGO 222
select  nome_livro, COD_livro
from LIVROS
where  paginas_livro > 550  AND anofabricação_livro >2015;
-- SELECIONA NA TABELA LIVROS, O NOME E O CÓDIGO DO AUTOR DO LIVRO COM O NUMERO DE PAGINAS MAIOR QUE 500 E FABRICADO DEPOIS DE 2015.

create view info_livro as select nome_livro,codigo_livro from LIVROS;
-- view criada devido a necessidade constante de realizar a consulta das informações de livros presentes na biblioteca realizada não só por funcionarios mas também por alunos
create view info_aluno as select CPF_aluno,nome_aluno from ALUNOS;
-- view criada devido a necessidade diaria dos funcionarios da biblioteca em adquirir informações pertinentes aos alunos que realizaram um emprestimo

create trigger ConfirmarEmprestimo
	check before update on cod_emprestimo on EMPRESTIMO
	for each row
	begin
	if status_inadimplencia="Aluno inadimplente" then
    set cod_emprestimo=0;
    else if status_inadimplencia="Aluno não é inadimplente" then
    set cod_emprestimo=cod_emprestimo+1
    endif;
end;
-- Trigger utilizado para confirmar o emprestimo do livro para os alunos, levando em consideração se o mesmo é inadimplente para com a biblioteca, em caso positivo o livro não é emprestado, e em caso negativo o livro é emprestado e este fato é registrado no banco.

create trigger Inadimplencia 
	check after update on status_inadimplencia on ALUNOS
    for each row
    begin
    if tempo>30 then
    set status_inadimplencia="Aluno inadiplente";
    else if tempo <=30 then
    set status_inadimplente="Aluno não é inadimplente";
    endif;
end;
-- Trigger utilizado para indicar e atualizar o status de inadimplência do aluno, no caso em que se passa um periodo de 30 dias e o livro não é devolvido é registrado no banco que o aluno é inadimplente, já no caso onde o periodo de emprestimo se encontra baixo dos 30 dias é registrado no banco que o aluno não é inadimplente.