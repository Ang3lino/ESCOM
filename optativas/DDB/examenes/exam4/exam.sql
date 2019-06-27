
-- mysql -u root -p --disable-auto-rehash --auto-vertical-output
-- mysql -u root -p --auto-vertical-output


-- load database

drop database if exists elektra;
create database elektra;
use elektra;
source elektra.sql ;

-- alta insertar 

-- join all 
select * from cliente cl 
  join pago p            on cl.idcliente     = p.idcliente
  join credito cr        on cr.idcredito     = p.idcredito 
  join tienda t          on t.idtienda       = p.idtienda 
  join tiendaproducto tp on tp.idtienda      = t.idtienda
  join producto pr       on tp.idproducto    = pr.idproducto
  join subcategoria s    on s.idsubcategoria = pr.idsubcategoria     
  join categoria c       on c.idcategoria    = s.idcategoria
;

-- procedure
drop procedure if exists p;
delimiter $
create procedure p ([ [in|out] arg1 type, ..., [in|out] argn type ])
begin
end $
delimiter ;

-- parte 1 ----------------------------------------------------------
create database parte1;
use parte1;

create table destino (
  otrosdatos varchar(30),
  codigo int not null primary key, 
  nombre varchar(45));

create table origen(
  codigo int not null primary key,
  otrosdatos varchar(30),
  nombre varchar(45));


create table viajero(
  rfc varchar(10) primary key,
  nombre varchar(45),
  direccion varchar(45));

create table telefono(
  rfc varchar(10),
  tel varchar(15));

alter table telefono add foreign key(rfc) references viajero(rfc) on delete cascade on update cascade;

create table viaje(
  codigo int not null primary key,
  numeroplazas int,
  fecha date,
  otrosdatos varchar(30),
  o_cod int not null,
  d_cod int not null);

alter table viaje add foreign key(d_cod) references destino(codigo) on delete cascade on update cascade;
alter table viaje add foreign key(o_cod) references origen(codigo) on delete cascade on update cascade;

-- parte a 
use elektra;

-- 6
drop procedure if exists p6;
delimiter $
create procedure p6 (
  in p_idcliente int, 
  in p_nombre varchar(45),
  in p_apPaterno varchar(45),
  in p_apMaterno varchar(45),
  in p_sexo varchar(3),
  in p_email varchar(50),
  in p_salario double
)
begin
  insert into cliente
    values (
      p_idcliente , 
      p_nombre ,
      p_apPaterno ,
      p_apMaterno ,
      p_sexo ,
      p_email ,
      p_salario 
    );
end $
delimiter ;

-- dar de alta a un cliente
call p6(161, "Miguel", "Lopez", "Hernandez", 
  "M", "miguel777@gmail.com", 10000);

-- 7 
drop procedure if exists p7;
delimiter $
create procedure p7 (in p_idcliente int, in p_salario double )
begin
  update cliente set salario = p_salario where idcliente = p_idcliente;
end $
delimiter ;

-- actualizar el salario de un cliente
select * from cliente where idcliente = 161;
call p7(161, 11000);
select * from cliente where idcliente = 161;

-- 8 
drop procedure if exists p8;
delimiter $
create procedure p8 (in p_idcliente int)
begin
  declare curr_salario double default (
      select salario from cliente where idcliente = p_idcliente);
  declare dx double default (curr_salario + curr_salario * 0.3);
  update cliente set salario = dx
    where idcliente = p_idcliente;
end $
delimiter ;

-- incrementar el salario de un cliente en un 30%
select * from cliente where idcliente = 161;
call p8(161);
select * from cliente where idcliente = 161;

-- 9 
drop procedure if exists p9;
delimiter $
create procedure p9 (in p_fecha date)
begin
  select cl.nombre, pr.nombre, pr.precioUnitario from cliente cl 
    join pago p            on cl.idcliente     = p.idcliente
    join producto pr on pr.idproducto = p.idproducto 
  where p.fechaPago = p_fecha; 
end $
delimiter ;

-- mostrar datos con base en fecha
call p9("2010-03-09");

-- 10 
drop procedure if exists p10;
delimiter $
create procedure p10 (in p_idcategoria int)
begin
  select pr.nombre, pr.marca from producto pr       
      join subcategoria s    on s.idsubcategoria = pr.idsubcategoria     
      join categoria c       on c.idcategoria    = s.idcategoria
    where c.idcategoria = p_idcategoria
  ;
end $
delimiter ;

-- mostrar nombre y marca con base en categoria
call p10(16);

-- 11 
drop procedure if exists p11;
delimiter $
create procedure p11 (in p_marca varchar(45))
begin
  select pr.nombre, pr.descripcion, s.nombre 
    from producto pr 
    join subcategoria s on pr.idsubcategoria = s.idsubcategoria
  where pr.marca = p_marca
  ; 
end $
delimiter ;

-- proyectar con base en marca
call p11("HB");

-- parte b) 

-- 12
select nombre, cp from tienda
where estado like ("%Chiapas%");

-- 13.
select c.monto from  credito c
  join pago p on p.idcredito = c.idcredito
  join tienda t on t.idtienda = p.idtienda
  where t.nombre like "Presta Prenda Jesus Maria 2";

update credito c
  join pago p on p.idcredito = c.idcredito
  join tienda t on t.idtienda = p.idtienda
  set c.monto = c.monto + 0.3 * c.monto 
  where t.nombre like "Presta Prenda Jesus Maria 2";

select c.monto from  credito c
  join pago p on p.idcredito = c.idcredito
  join tienda t on t.idtienda = p.idtienda
  where t.nombre like "Presta Prenda Jesus Maria 2";

-- 14.
select * from producto
where marca like ("SIN MARCA");

-- 15.
select count(*) from tienda 
where estado like ("%Colima%");

-- 16.
select c.nombre, c.appaterno, c.apmaterno, t.nombre, p.fechapago
  from cliente c, pago p, tienda t
  where c.idcliente=p.idcliente
    and p.idtienda=t.idtienda
    and estado like ("%Colima%");

-- 17.
alter table pago add pago double;
update pago set pago=1000;

-- vistas
-- 18.
create view v18 as
  select c.nombre, c.appaterno, c.apmaterno, cr.monto 
  from cliente c, pago p, credito cr, tienda t
  where c.idcliente = p.idcliente
  and p.idcredito = cr.idcredito
  and p.idtienda = t.idtienda
  and t.nombre = "EKT TECATE";

-- 19.
create view v19 as
select * from producto 
where preciounitario between 4500 and 5500;

-- 20.
create view v20 as
  select c.idcliente, c.nombre, c.appaterno, c.apmaterno, c.sexo, c.email, c.salario
    from cliente c, pago p
    where c.idcliente = p.idcliente
    and p.fechapago = "2010-03-10"
    order by 1;

select * from v18;
select * from v19;
select * from v20;