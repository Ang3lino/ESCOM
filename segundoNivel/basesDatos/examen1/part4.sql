
create database if not exists part4;
use part4;
source home.sql;

-- 16
insert into asociado(idAsociado, homedepot_idhd, nombre) 
values 
    ("a1000", (select idHd from homedepot where nombre like "Tecnologic%"), 'LOPEZ LOPEZ LUIS'), 
    ("a1001", (select idHd from homedepot where nombre like "Tlatilc%"), "PEREZ PEREZ PANCHO");

update asociado 
    set homedepot_idhd = (
        select idhd from homedepot 
        where nombre like "Interlomas%"
    ) where nombre like "%DAVID RAZA%";
