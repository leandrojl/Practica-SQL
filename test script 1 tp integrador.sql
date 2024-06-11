UPDATE ciudad SET nombre = "Rosario" WHERE cod_ciu = 2;

UPDATE articulo SET descripcion = "Botella de Agua" WHERE cod_art = 1;
UPDATE articulo SET descripcion = "Bicicleta" WHERE cod_art = 2;
UPDATE articulo SET descripcion = "Ladrillo" WHERE cod_art = 3;
UPDATE articulo SET descripcion = "Planta" WHERE cod_art = 4;

delete from material
where cod_mat in (1,2,3,4,6,9,18)