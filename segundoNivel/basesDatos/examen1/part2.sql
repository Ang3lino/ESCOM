
create database if not exists part2;
use part2;

--source home.sql;

-- 6

select s.nombre, s.tel, h.nombre 
    from socio s, hdsocio hd, homedepot h 
    where s.idSocio = hd.socio_idsocio 
        and hd.homedepot_idhd = h.idhd 
        and s.nombre like "%JUAN%";

select a.nombre, h.estado
    from asociado a, homedepot h 
    where a.homedepot_idhd = h.idhd 
        and (a.nombre like "%AKETZALI CASTRO%"
        or a.nombre like "%THELMA P_REZ%");

select d.nombre, h.nombre 
    from depto d, hddepto hd, homedepot h 
    where h.idhd = hd.homedepot_idhd    
     and hd.depto_iddepto = d.iddepto;




-- 11
select count(*) from homedepot where estado like "Sinalo%";

-- 12
alter table asociado 
    add column(salario int not null);


-- Part 3

-- 14 

create view v2 as 
select s.nombre, s.credito, t.nombre as tarjeta 
from socio s, homedepot h, hdsocio hd, tarjeta t 
where t.socio_idsocio = s.idsocio 
and hd.socio_idsocio = s.idsocio 
and hd.homedepot_idhd = h.idhd 
and h.nombre like "%Interlomas%"
order by 1;

select * from v2;

