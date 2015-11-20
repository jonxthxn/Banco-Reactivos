create database BDREACTIVOS;
use BDREACTIVOS;

create table tbl_ad_persona(
pe_cedula varchar(10),
pe_nombre varchar(50),
pe_apellido varchar(50),
pe_fechanacimiento date,
constraint pkpersona primary key(pe_cedula)
);
create table tbl_ad_rol(
ro_codigo int,
ro_nombre varchar(50),
ro_descripcion varchar(50),
constraint pkrol primary key(ro_codigo)
);
create table tbl_ad_menu(
me_codigo int,
me_item varchar(50),
me_descripcion varchar(50),
constraint pkmenu primary key (me_codigo)
);
create table tbl_ad_rolMenu(
ro_codigo int,
me_codigo int,
constraint pkrolMenu primary key(ro_codigo,me_codigo),
constraint fkroMenu_rol foreign key (ro_codigo) references tbl_ad_rol(ro_codigo),
constraint fkroMenu_menu foreign key (me_codigo) references tbl_ad_menu(me_codigo)
);
create table tbl_ad_rolPersona(
pe_cedula varchar(10),
ro_codigo int,
constraint pkrolpersona primary key(pe_cedula,ro_codigo),
constraint fkropers_persona foreign key (pe_cedula) references tbl_ad_persona(pe_cedula),
constraint fkropers_rol foreign key (ro_codigo) references tbl_ad_rol(ro_codigo)
);
create table tbl_ac_area(
ar_codigo int,
ar_nombre varchar(50),
pe_cedula varchar(10),
constraint pkarea primary key(ar_codigo),
constraint fkare_persona foreign key(pe_cedula) references tbl_ad_persona(pe_cedula)
);
create table tbl_ac_materia(
ma_codigo varchar(50),
ma_nombre varchar(50),
ma_numreactivo int,
ar_codigo int,
constraint pkmateria primary key(ma_codigo),
constraint fkmat_area foreign key(ar_codigo) references tbl_ac_area(ar_codigo)
);
create table tbl_do_reactivo(
rec_idreactivo int,
rec_tema varchar(50),
rec_tipo varchar(50),
rec_planteamiento varchar(50),
rec_dificultad varchar(50),
rec_respuesta varchar(50),
rec_observacion varchar(50),
rec_estado varchar(50),
pe_cedula varchar(10),
ma_codigo varchar(50),
constraint pkreactivo primary key (rec_idreactivo),
constraint fkrea_persona foreign key(pe_cedula) references tbl_ad_persona(pe_cedula),
constraint fkrea_materia foreign key(ma_codigo) references tbl_ac_materia(ma_codigo)
);
create table tbl_do_respuesta(
rep_idrespuesta int,
rep_opcion_respuesta varchar(50),
rep_argumento varchar(50),
rec_idreactivo int,
rep_correcta boolean,
constraint pkrespuesta primary key(rep_idrespuesta),
constraint fkres_reactivo foreign key (rec_idreactivo) references tbl_do_reactivo(rec_idreactivo)
);
create table tbl_ac_periodo(
pd_codigo int,
pd_descripcion varchar(50),
ex_codigo int,
constraint pkperiodo primary key (pd_codigo)
);
create table tbl_ja_reporte(
re_idreporte int,
re_estado varchar(50),
re_observacion varchar(50),
re_fecha_creacion date,
pd_codigo int,
constraint pkreporte primary key(re_idreporte),
constraint fkrep_periodo foreign key(pd_codigo) references tbl_ac_periodo(pd_codigo)
);
create table tbl_ac_distributivo(
di_codigo int,
ma_codigo varchar(50),
pe_cedula varchar(10),
pd_codigo int,
constraint pkdistribuitivo primary key (di_codigo),
constraint fkdis_materia foreign key (ma_codigo) references tbl_ac_materia(ma_codigo),
constraint fkdis_persona foreign key(pe_cedula) references tbl_ad_persona(pe_cedula),
constraint fkdis_periodo foreign key(pd_codigo) references tbl_ac_periodo(pd_codigo)
);
create table tbl_ac_examen(
ex_codigo int,
pd_codigo int,
ex_descripcion varchar(50),
constraint pkexamen primary key(ex_codigo),
constraint fkexa_periodo foreign key(pd_codigo) references tbl_ac_periodo(pd_codigo)
);
create table tbl_dtexamen(
dtex_codigo int,
ex_codigo int, 
rec_idreactivo int,
constraint pkdtexamen primary key(dtex_codigo),
constraint fkdtexa_examen foreign key(ex_codigo) references tbl_ac_examen(ex_codigo),
constraint fkdtexa_reactivo foreign key(rec_idreactivo) references tbl_do_reactivo(rec_idreactivo)
);