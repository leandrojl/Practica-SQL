USE BaseDeDatosYGestionsAlmacen;

select * from proveedor;
select * from almacen;
select * from articulo;
select * from ciudad;
select * from material;
select * from contiene;
select * from compuesto_por;
select * from provisto_por;

insert into contiene
(nro, cod_art)
values (2,5),(2,6);

insert into contiene
(nro, cod_art)
values (1,5),(1,6);

insert into articulo
(cod_art, descripcion, precio)
values (5,"A",12000), (6,"B",15000);

insert into ciudad
(cod_ciu, nombre)
values (3,"Zarate");

insert into provisto_por
(cod_mat, cod_prov)
values (1,10),(2,10),(3,10),(1,15),(2,15),(4,15);

insert into proveedor
(cod_prov, nombre, domicilio, cod_ciu, fecha_alta)
values (15, 'Quito', 'Quiencu 910',1,'2011-12-31');

insert into proveedor
(cod_prov, nombre, domicilio, cod_ciu, fecha_alta)
values (10, 'Diego', 'Dignidad 90',3,'2011-12-31');

insert into proveedor
(cod_prov, nombre, domicilio, cod_ciu, fecha_alta)
values (8, 'Zaracho', 'Zarasa 90',3,'2011-12-31');

insert into proveedor
(cod_prov, nombre, domicilio, cod_ciu, fecha_alta)
values (5, 'Tulio', 'Berutti 545',1,'2011-12-31');

insert into proveedor
(cod_prov, nombre, domicilio, cod_ciu, fecha_alta)
values (6, 'Franco', 'Alberti 545',1,'2011-12-12');


insert into proveedor
(cod_prov, nombre, domicilio, cod_ciu, fecha_alta)
values (7, 'Fito', 'Alberti 548',1,'2011-12-12');


insert into contiene
(nro, cod_art)
values (3,1),(3,2),(3,3),(3,4);

insert into contiene
(nro, cod_art)
values (2,1),(2,2),(2,3);

insert into contiene
(nro, cod_art)
values (2,4);


insert into provisto_por
(cod_prov, cod_mat)
values (2,1),(2,2),(2,3),(2,4);

insert into provisto_por
(cod_prov, cod_mat)
values (2,1),(2,2),(2,3),(2,4);

insert into compuesto_por
(cod_art, cod_mat)
values (1,2),(1,3),(2,3),(2,4),(3,1),(3,2),(4,1),(4,2);

insert into almacen
(nro, nombre, responsable)
values (3, "El super de Martin Gomez", "Martin Gomez");

delete from ciudad
where cod_ciu = 2;