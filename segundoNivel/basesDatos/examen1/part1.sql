create database if not exists part1;
use part1;

create table patrocinador (
    idPatrocinador int not null primary key, 
    nombre varchar(98)
);

create table autor(
    idAutor int not null primary key, 
    nombre varchar(99), 
    fechaNacimiento varchar(99), 
    numero varchar(99), 
    cp int,
    calle varchar(99)
);

create table libro (
    idLibro int not null primary key, 
    prologo varchar(99), 
    titulo varchar(99),
	foreign key (idLibro) references autor (idAutor) 
		on delete cascade on update cascade
);

create table libroEditorial(
    idLibroEditorial int not null primary key,
    editorial varchar(99),
    foreign key(idLibroEditorial) references libro(idLibro) 
);

create table libroAutor (
    idLibro int not null , 
    idAutor int not null , 
    primary key (idlibro, idAutor),
    fechaPublicacion varchar(99),
	foreign key (idLibro) references libro (idLibro) 
		on delete cascade on update cascade,
	foreign key (idAutor) references autor (idAutor) 
		on delete cascade on update cascade
);