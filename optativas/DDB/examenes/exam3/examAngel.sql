
-- TYPE: A

-- LOAD DATABASE ----------------------------------------------------

-- CREATE DATABASE IF NOT EXISTS escuela;
-- USE escuela ;
-- SOURCE escuela.sql ;


-- SHOW CREATE PROCEDURE nameProcedure
SHOW PROCEDURE STATUS ;


-- JOIN ALL 
SELECT * 
FROM evaluacion e 
  JOIN alumnoevaluacion ae ON ae.evaluaciones_idEvaluacion = e.idEvaluacion 
  JOIN alumno a            ON a.boleta = ae.alumno_boleta 
  JOIN login l             ON l.idLogin = a.Login_idLogin 
  JOIN profesor p          ON p.Login_idLogin = l.idLogin 
  JOIN profesorgrupo pg    ON pg.profesor_idProfesor = p.idProfesor 
  JOIN materia m           ON m.idMateria = pg.materia_idMateria 
  JOIN grupo g             ON g.idGrupo = pg.grupos_idGrupo 
  JOIN alumnogrupo ag      ON ag.grupos_idGrupo = g.idGrupo
;

-- x
-- DROP VIEW IF EXISTS vx;
-- CREATE VIEW vx AS 
--   SELECT  
--   ;

-- views
-- 1
DROP VIEW IF EXISTS v1;
CREATE VIEW v1 AS 
  SELECT p.Nombre, p.ApPaterno, p.ApMaterno, g.Nombre AS grupo
  FROM profesor p 
  JOIN profesorgrupo pg          ON p.idProfesor = pg.profesor_idProfesor
  JOIN grupo g             ON g.idGrupo = pg.grupos_idGrupo ;

-- 2
DROP VIEW IF EXISTS v2;
CREATE VIEW v2 AS 
  SELECT p.Nombre, p.ApPaterno, p.ApMaterno, m.Nombre AS materia
  FROM profesor p 
  JOIN profesorgrupo pg          ON p.idProfesor = pg.profesor_idProfesor
  JOIN materia m ON m.idMateria = pg.materia_idMateria ;

-- 3
DROP VIEW IF EXISTS v3;
CREATE VIEW v3 AS 
  SELECT ae.Calificacion, count(*) as calif_count
  FROM alumnoevaluacion ae 
    JOIN alumno a ON a.boleta = ae.alumno_boleta 
  GROUP BY ae.Calificacion;

-- 4
CREATE VIEW v4 AS 
SELECT * FROM login l
  INNER JOIN profesor p          ON p.Login_idLogin = l.idLogin 
  ;

-- 5
DROP VIEW IF EXISTS v5;
CREATE VIEW v5 AS 
  SELECT p.Nombre, p.ApPaterno, p.ApMaterno, g.Nombre AS grupo, p.Especialidad
  FROM profesor p 
  JOIN profesorgrupo pg          ON p.idProfesor = pg.profesor_idProfesor
  JOIN grupo g             ON g.idGrupo = pg.grupos_idGrupo 
  WHERE g.Nombre LIKE "GRUPO115";

SELECT * FROM v1;
SELECT * FROM v2;
SELECT * FROM v3;
SELECT * FROM v4;
SELECT * FROM v5;

-- PROCEDURES 
DROP PROCEDURE IF EXISTS c1;
DELIMITER &
CREATE PROCEDURE c1(
    IN gr VARCHAR(32)
) BEGIN 
    select m.nombre as materia, p.nombre
    from  grupo g, profesorgrupo pg, profesor p, materia m
    where g.idgrupo=pg.grupos_idgrupo
      and pg.materia_idmateria=m.idmateria
      and pg.profesor_idprofesor=p.idprofesor
      and g.nombre like concat(gr,"%");
    END &
DELIMITER ;

CALL c1("GRUPO111");

-- PROCEDURES 
DROP PROCEDURE IF EXISTS c2;
DELIMITER &
CREATE PROCEDURE c2(
    IN ap VARCHAR(32)
) BEGIN 
    select a.nombre,a.appaterno, a.apmaterno, g.nombre as grupo
    from alumno a, alumnogrupo ag, grupo g 
    where a.boleta=ag.alumno_boleta
    and ag.grupos_idgrupo=g.idgrupo
    and (a.appaterno like concat(ap,"%") or a.apmaterno like concat(ap,"%") );
    END &
DELIMITER ;

DROP PROCEDURE IF EXISTS c3;
DELIMITER &
CREATE PROCEDURE c3(
    IN mat VARCHAR(32)
) BEGIN 
    select m.nombre as materia, p.nombre 
    from profesor p, profesorgrupo pg, materia m
    where p.idprofesor=pg.profesor_idprofesor
    and pg.materia_idmateria=m.idmateria
    and m.nombre like concat(mat,"%");
   END &
DELIMITER ;

DROP PROCEDURE IF EXISTS c4;
DELIMITER &
CREATE PROCEDURE c4(
    IN correo VARCHAR(50), IN b INT
) BEGIN 
   select boleta,nombre,email from alumno
   where boleta=b;

   update alumno
   set email=correo
   where boleta=b;

   select boleta,nombre,email from alumno
   where boleta=b;
   END &
DELIMITER ;

DROP PROCEDURE IF EXISTS c5;
DELIMITER &
CREATE PROCEDURE c5(
    IN id INT, IN cupo1 INT
) BEGIN 
  select idgrupo, cupo 
  from grupo
  where idgrupo=id;

  update grupo 
  set cupo=cupo1
  where idgrupo=id;

  select idgrupo, cupo 
  from grupo
  where idgrupo=id;
   END &
DELIMITER ;

DROP PROCEDURE IF EXISTS c6;
DELIMITER &
CREATE PROCEDURE c6(
  IN b INT
) BEGIN 
  select a.nombre, a.appaterno, a.apmaterno, ae.calificacion, e.titulo
  from alumno a, alumnoevaluacion ae, evaluacion e 
  where a.boleta=ae.alumno_boleta
  and ae.evaluaciones_idevaluacion=e.idevaluacion 
  and a.boleta like concat(b,"%");
  END &
DELIMITER ;


CALL c1("GRUPO111");
CALL c2("Mesa");
CALL c3("Ingles");
CALL c4("2013631010", "fdjskal@gmail.com");
CALL c5(800, 32);
CALL c6("2013639824");

SHOW CREATE PROCEDURE c6;

-- Escritura 

DROP PROCEDURE IF EXISTS c14;
DELIMITER &
CREATE PROCEDURE c14(
) BEGIN 
  SELECT count(*) as mcount
  FROM  alumno a
  JOIN alumnoevaluacion ae ON a.boleta = ae.alumno_boleta
  WHERE ae.Calificacion = 8;
  END &
DELIMITER ;

DROP PROCEDURE IF EXISTS c15;
DELIMITER &
CREATE PROCEDURE c15(
) BEGIN 
  SELECT a.Nombre, a.ApPaterno, a.ApMaterno
  FROM  alumno a
  JOIN alumnoevaluacion ae ON a.boleta = ae.alumno_boleta
  WHERE ae.Calificacion = 8;
  END &
DELIMITER ;


DROP PROCEDURE IF EXISTS c16;
DELIMITER &
CREATE PROCEDURE c16(
) BEGIN 
  SELECT * FROM alumno;
  DELETE FROM alumno 
  WHERE ApPaterno LIKE "Mota"
    OR ApMaterno LIKE "Mota";
  SELECT * FROM alumno;
  END &
DELIMITER ;

DROP PROCEDURE IF EXISTS c12;
DELIMITER &
CREATE PROCEDURE c12(
  IN p_ap VARCHAR(50)
) BEGIN 
  DECLARE s VARCHAR(50) DEFAULT(CONCAT("%", p_ap, "%") );
  SELECT count(*) 
  FROM alumno 
  WHERE ApMaterno LIKE s
    OR ApMaterno LIKE s ;
  END &
DELIMITER ;

CALL c12("Perez"); 
CALL c14; 
CALL c15;
CALL c16;

DROP PROCEDURE IF EXISTS px;
DELIMITER &
CREATE PROCEDURE px(
    IN n INT
) BEGIN 
    END &
DELIMITER ;

-- 729
