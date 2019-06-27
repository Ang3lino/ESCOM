
drop database if exists costcook;
create database costcook; 
use costcook;

source costcook.sql;

-- 1 Mostrar el nombre de los deptos que tienens la sucursal SALTILLo
select nombre from sucursal where nombre like "Saltillo%";

select d.nombre 
	from departamento d, sucdepartamento sd, sucursal s 
	where s.nombre like "Saltillo%"
		and d.idDepto = sd.idDepto
		and s.idSuc = sd.idSuc 
	order by 1;

-- 2 Mostrar el nombre completo de los socis que estan registrados en la sucursal 
-- interlomas

select s.nombre, s.apPaterno, s.apMaterno 
	from socio s, sociomembresia sm, sucursal suc
	where suc.nombre like "interlomas%"
		and s.idSocio = sm.idSocio 
		and sm.idSuc = suc.idSuc ;


-- 3 El nombre de los producto sque pertenecen a la categoria asadores

select * from categoria order by 2;

select p.nombre 
	from producto p, subcategoria s, categoria c, departamento d 
	where c.nombre like "asadores%"
		and p.idSubCat = s.idSubCat
		and c.idCat = s.idCat 
		and d.idDepto = c.idDepto; 

-- 4 Que categoria pertenecen los productos que tienen los siguientes 
-- identificadores 103200 y 944, incluir nombre y marca 

select p.nombre, p.marca, c.nombre 
	from producto p, subcategoria x, categoria c 
	where p.idSubCat = x.idSubCat 
		and x.idCat = c.idCat 
		and p.idProducto in (944, 104200); 

-- 5
select * from servicio ;

select sucursal.nombre 
	from sucursal, sucservicio, servicio 
	where servicio.nombre like "Servicio Deli%" 
		and sucursal.idSuc = sucservicio.idSuc 
		and sucservicio.idServicio = servicio.idServicio;


-- 6 
select s.nombre, e.nombre 
	from sociomembresia x, sucursal s, estado e 
	where x.idSuc = s.idSuc 
		and s.idEdo = e.idEdo 
		and x.fechaAlta = "2016-07-11";

-- 7 
select s.nombre, t.tel 
	from sucursal s, estado e, telsuc t 
	where e.idEdo = s.idEdo 
		and s.idSuc = t.idSuc 
		and e.nombre like "Nuev% Le_n%";

-- 8 
select count(*) 
	from socio s, sociomembresia sm, sucursal suc 
	where s.idSocio = sm.idSocio 
		and sm.idSuc = suc.idSuc ;
		and suc.nombre in ("CUERNA%", "XALAP%", "MEXICAL%");

-- 8 
select count(*) 
	from socio s, sociomembresia sm, sucursal suc 
	where s.idSocio = sm.idSocio 
		and sm.idSuc = suc.idSuc
		and (suc.nombre like "CUERNA%"
			or suc.nombre like "XALAP%"
			or suc.nombre like"MEXICAL%");

-- 9 
select suc.nombre, sm.fechaAlta 
	from sucursal suc, sociomembresia sm, socio s 
	where s.genero like "F" 
		and s.idSocio = sm.idSocio 
		and sm.idSuc = suc.idSuc ;

-- 10 
select p.nombre 
	from producto p, subcategoria x 
	where p.idSubCat = x.idSubCat 
		and x.nombre like "Sillas%";

-- Vistas 
-- 1
create view v1 as 
	select s.nombre, s.apPaterno, s.apMaterno, sm.fechaAlta, t.nombre as membresia 
	from socio s, sociomembresia sm, tipomembresia t 
	where s.apPaterno like "Cervantes%"
		and s.idSocio = sm.idSocio 
		and sm.idTipoMem = t.idTipoMem ;

-- 2 
create view v2 as 
	select s.nombre, su.nombre as sucursal 
	from socio s, sociomembresia x, tipomembresia t, sucursal su 
	where s.idSocio = x.idSocio
		and x.idTipoMem = t.idTipoMem
		and x.idSuc = su.idSuc 
		and t.nombre like "Dorad%";

-- 3 
create view v3 as 
	select p.nombre, p.precioUnitario 
	from producto p, subcategoria x, categoria y, departamento d
	where p.idSubCat = x.idSubCat 
		AND x.idCat = y.idCat
		and y.idDepto = d.idDepto 
		and d.nombre like "Vinos y Licores%";

-- 4 
create view v4 as 
	select s.nombre, e.nombre as estado 
	from sucursal s, estado e 
	where s.idEdo = e.idEdo ;

-- 5 
create view v5 as 
	select s.nombre, t.nombre as tipo 
		from socio s, sociomembresia x, tipomembresia t 
		where s.idSocio = x.idSocio 
			and x.idTipoMem = t.idTipoMem 
			and x.fechaAlta like  "2017-09%";


-- 6 
create view v6 as 
	select p.nombre, d.nombre as departamento 
	from departamento d, categoria c, subcategoria s, producto p 
	where p.marca like "Disney%"
		and d.idDepto = c.idDepto 
		and c.idCat = s.idCat 
		and s.idSubCat = p.idSubCat ;

-- 1 
select * from v1;
-- 2
select * from v2;
-- 3 
select * from v3;
-- 4
select * from v4;
-- 5
select * from v5;
-- 6
select * from v6;
