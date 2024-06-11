CREATE DATABASE IF NOT EXISTS BaseDeDatosYGestionsAlmacen;
USE BaseDeDatosYGestionsAlmacen;

CREATE TABLE almacen(
nro MEDIUMINT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
responsable VARCHAR (50) NOT NULL);

CREATE TABLE articulo (
cod_art mediumint primary key,
descripcion text not null,
precio mediumint not null);

create table material (
cod_mat int primary key,
descripcion text not null);

create table ciudad(
cod_ciu smallint primary key,
nombre varchar(50) not null);

create table proveedor(
cod_prov smallint primary key,
nombre varchar(50) not null,
domicilio text not null, 
cod_ciu smallint,
fecha_alta date,
foreign key (cod_ciu) references ciudad(cod_ciu));



create table contiene(
nro mediumint,
cod_art mediumint,
CONSTRAINT contiene_pk PRIMARY KEY (nro, cod_art),
foreign key (nro) references almacen(nro),
foreign key (cod_art) references articulo(cod_art)
);

create table compuesto_por(
cod_art mediumint,
cod_mat int,
constraint compuesto_por_pk primary key (cod_art, cod_mat),
foreign key (cod_art) references articulo(cod_art),
foreign key (cod_mat) references material(cod_mat)
);

create table provisto_por(
cod_mat int,
cod_prov smallint,
constraint provisto_por_pk primary key (cod_mat, cod_prov),
foreign key (cod_mat) references material(cod_mat),
foreign key (cod_prov) references proveedor(cod_prov));

insert into almacen
(nro, nombre, responsable)
VALUES (1, "Coto", "Alfredo"), (2,"Dia","Roberto");

insert into contiene
(nro, cod_art)
VALUES (1,7);

insert into articulo
(cod_art, descripcion, precio)
VALUES (1, 'Almidon', 1000), (2, 'Azufre', 800), (3, 'Azucar', 1000), (4, 'Detergente', 1500);

insert into articulo
(cod_art, descripcion, precio)
values (6, 'Detergente Premium', 15000);

insert into articulo
(cod_art, descripcion, precio)
values (7, 'A', 15000);

select * from almacen;
select * from articulo;

insert into ciudad
(cod_ciu, nombre)
values (1, 'Buenos Aires'), (2, 'Santa fe');

insert into ciudad
(cod_ciu, nombre)
values (3, 'La Plata');

insert into proveedor
(cod_prov, nombre, domicilio, cod_ciu, fecha_alta)
values (1, 'Emilio', 'Tucuman 520', 1, '2000-10-12'), (2, 'Julio', 'Alberdi 420', 2, '2010-10-12');

insert into proveedor
(cod_prov, nombre, domicilio, cod_ciu, fecha_alta)
values (3, 'Sergio', 'Av. 9 de Julio 520', 1, '2001-10-12');

insert into proveedor
(cod_prov, nombre, domicilio, cod_ciu, fecha_alta)
values (4, 'Manuel', 'Suipacha 720', 1, '2001-10-12');

insert into proveedor
(cod_prov, nombre, domicilio, cod_ciu, fecha_alta)
values (5, 'Manuelita', '14 y 20', 3, '2001-10-12');

select * from proveedor;

insert into material
(cod_mat, descripcion)
values (1, 'Agua'), (2, 'Tierra'), (3, 'Plastico'), (4, 'Metal');

insert into provisto_por
(cod_mat, descripcion)
values (1, 'Agua'), (2, 'Tierra'), (3, 'Plastico'), (4, 'Metal');


select * from material;

/*EJERCICIO 1:
Listar los números de artículos cuyo precio se encuentre entre $100 y $1000 y su
descripción comience con la letra A.
*/

select cod_art,descripcion from articulo
where precio between 100 and 1000
and descripcion like 'a%';

/*EJERCICIO 2:
 Listar todos los datos de todos los proveedores.
*/

select * from proveedor;

/*EJERCICIO 3:
Listar la descripción de los materiales de código 1, 3, 6, 9 y 18.
*/

select cod_mat,descripcion from material
where cod_mat in (1,3,6,9,18);

/*EJERCICIO 4:
Listar código y nombre de proveedores de la calle Suipacha, que hayan sido dados
de alta en el año 2001.
*/

select cod_prov, nombre
FROM proveedor
where fecha_alta between '2001-01-01' and '2001-12-31' and domicilio like '%Suipacha%';

/*
5. Listar nombre de todos los proveedores y de su ciudad.
*/

select PROV.nombre, ciu.nombre
from proveedor PROV join ciudad CIU
where PROV.cod_ciu = CIU.cod_ciu;

/*
6. Listar los nombres de los proveedores de la ciudad de La Plata.
*/

select PROV.nombre, CIU.nombre
from proveedor prov join ciudad ciu
where prov.cod_ciu = ciu.cod_ciu and ciu.nombre like "%La Plata%";

/*
7. Listar los números de almacenes que almacenan el artículo de descripción A.
*/

SELECT ALM.nro
FROM almacen ALM 
JOIN contiene CON ON ALM.nro = CON.nro
JOIN articulo ART ON CON.cod_art = ART.cod_art
WHERE ART.descripcion = 'A';


/*
8. Listar los materiales (código y descripción) provistos por proveedores de la ciudad
de Rosario.
*/

select ma.cod_mat, ma.descripcion, prove.nombre, ciu.nombre
from material ma
join provisto_por pp on ma.cod_mat = pp.cod_mat
join proveedor prove on pp.cod_prov = prove.cod_prov
join ciudad ciu on prove.cod_ciu = ciu.cod_ciu
where ciu.nombre like "Rosario";

/*
9. Listar los nombres de los proveedores que proveen materiales para artículos
ubicados en almacenes que Martín Gómez tiene a su cargo.
*/

select  prove.nombre
from proveedor prove
join provisto_por pp on pp.cod_prov = prove.cod_prov
join material mat on mat.cod_mat = pp.cod_mat
join compuesto_por cp on cp.cod_mat = mat.cod_mat
join articulo art on art.cod_art = cp.cod_art
join contiene conti on conti.cod_art = art.cod_art
join almacen alm on alm.nro = conti.nro
where alm.responsable like 'Martin Gomez';

select  prove.nombre, prove.cod_prov
from proveedor prove
where exists (
select 1
from provisto_por pp
join material mat on pp.cod_mat = mat.cod_mat
where prove.cod_prov = pp.cod_prov);

		


/*
10. Mover los artículos almacenados en el almacén de número 10 al de número 20
*/

/*
11. Eliminar a los proveedores que contengan la palabra ABC en su nombre
*/

/*
12. Indicar la cantidad de proveedores que comienzan con la letra F.
*/

select count(prov.nombre)
from proveedor prov
where nombre like 'f%';


/*
13. Listar el promedio de precios de los artículos por cada almacén (nombre)
*/

select avg(art.precio), alm.nombre
from articulo art
join contiene cont on cont.cod_art = art.cod_art
join almacen alm on alm.nro = cont.nro
group by alm.nombre;

SELECT alm.nombre as 'almacen',
 AVG(art.precio) as 'precio promedio'
 FROM almacen alm JOIN contiene c ON alm.nro = c.nro
 JOIN Articulo art ON art.cod_art = c.cod_art
GROUP BY alm.nro, alm.nombre;


/*
14. Listar la descripción de artículos compuestos por al menos 2 materiales.


*/
SELECT a.descripcion
 FROM articulo a 
 JOIN compuesto_por c ON a.cod_art = c.cod_art
GROUP BY a.descripcion
 HAVING COUNT(*) >= 2;
 
 /*listar la cantidad de materiales que tiene un articulo*/
SELECT a.descripcion, count(c.cod_mat) as cantidad_materiales
 FROM articulo a 
 JOIN compuesto_por c ON a.cod_art = c.cod_art
 join material mat on mat.cod_mat = c.cod_mat
 group by a.descripcion;



/*
15. Listar cantidad de materiales que provee cada proveedor (código, nombre y
domicilio)
16. Cuál es el precio máximo de los artículos que proveen los proveedores de la ciudad
de Zárate.
17. Listar los nombres de aquellos proveedores que no proveen ningún material.
18. Listar los códigos de los materiales que provea el proveedor 10 y no los provea el
proveedor 15.
19. Listar número y nombre de almacenes que contienen los artículos de descripción A
y los de descripción B (ambos).
20. Listar la descripción de artículos compuestos por todos los materiales.
21. Hallar los códigos y nombres de los proveedores que proveen al menos un material
que se usa en algún artículo cuyo precio es mayor a $100.
22. Listar la descripción de los artículos de mayor precio.
23. Listar los nombres de proveedores de Capital Federal que sean únicos
proveedores de algún material.
24. Listar los nombres de almacenes que almacenan la mayor cantidad de artículos.
25. Listar la ciudades donde existan proveedores que proveen todos los materiales.
26. Listar los números de almacenes que tienen todos los artículos que incluyen el
material con código 123.

*/