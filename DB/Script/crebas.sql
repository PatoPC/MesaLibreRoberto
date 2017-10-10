/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2005                    */
/* Created on:     09/10/2017 17:58:11                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('IMAGENESLOCAL') and o.name = 'FK_IMAGENES_REFERENCE_LOCAL')
alter table IMAGENESLOCAL
   drop constraint FK_IMAGENES_REFERENCE_LOCAL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('LOCAL') and o.name = 'FK_LOCAL_REFERENCE_RESTAURA')
alter table LOCAL
   drop constraint FK_LOCAL_REFERENCE_RESTAURA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RESTAURANTE') and o.name = 'FK_RESTAURA_REFERENCE_TIPOREST')
alter table RESTAURANTE
   drop constraint FK_RESTAURA_REFERENCE_TIPOREST
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TIPOCOMIDA') and o.name = 'FK_TIPOCOMI_REFERENCE_LOCAL')
alter table TIPOCOMIDA
   drop constraint FK_TIPOCOMI_REFERENCE_LOCAL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('IMAGENESLOCAL')
            and   type = 'U')
   drop table IMAGENESLOCAL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LOCAL')
            and   type = 'U')
   drop table LOCAL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RESTAURANTE')
            and   type = 'U')
   drop table RESTAURANTE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TIPOCOMIDA')
            and   type = 'U')
   drop table TIPOCOMIDA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TIPORESTAURANTE')
            and   type = 'U')
   drop table TIPORESTAURANTE
go

/*==============================================================*/
/* Table: IMAGENESLOCAL                                         */
/*==============================================================*/
create table IMAGENESLOCAL (
   IDIMAGENLOCAL        int                  not null,
   IDLOCAL              int                  null,
   IMAGENLOCAL          image                not null,
   constraint PK_IMAGENESLOCAL primary key (IDIMAGENLOCAL)
)
go

/*==============================================================*/
/* Table: LOCAL                                                 */
/*==============================================================*/
create table LOCAL (
   IDLOCAL              int                  not null,
   IDRESTAURANTE        int                  null,
   NOMBRELOCAL          varchar(60)          not null,
   TIPOLOCAL            varchar(8)           not null,
   TELEFONOLOCAL        varchar(15)          not null,
   DIRECCIONLOCAL       varchar(70)          not null,
   NOMBREREPRESENTANTE  varchar(40)          not null,
   TELEFONOREPRESENTANTE varchar(15)          not null,
   TELEFONOADICIONAAL   varchar(15)          null,
   constraint PK_LOCAL primary key (IDLOCAL)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Dado que solo se tendrá dos tipos se manejará desde el codigo para crear una tabla por dos valores',
   'user', @CurrentUser, 'table', 'LOCAL', 'column', 'TIPOLOCAL'
go

/*==============================================================*/
/* Table: RESTAURANTE                                           */
/*==============================================================*/
create table RESTAURANTE (
   IDRESTAURANTE        int                  not null,
   IDTIPORESTAURANTE    int                  null,
   RAZONSOCIAL          varchar(60)          not null,
   NOMBRECOMERCIAL      varchar(60)          not null,
   RUC                  varchar(15)          not null,
   TELEFNORESTAURANTE   varchar(15)          not null,
   DIRECCIONRESTAURANTE varchar(70)          not null,
   NOMBREREPRESENTANTE  varchar(40)          not null,
   TELEFONOREPRESENTANTE varchar(15)          not null,
   TELEFONOADICIONAL    varchar(15)          null,
   constraint PK_RESTAURANTE primary key (IDRESTAURANTE)
)
go

/*==============================================================*/
/* Table: TIPOCOMIDA                                            */
/*==============================================================*/
create table TIPOCOMIDA (
   IDTIPOCOMIDA         int                  not null,
   IDLOCAL              int                  null,
   NOMBRETIPOCOMIDA     varchar(15)          not null,
   constraint PK_TIPOCOMIDA primary key (IDTIPOCOMIDA)
)
go

/*==============================================================*/
/* Table: TIPORESTAURANTE                                       */
/*==============================================================*/
create table TIPORESTAURANTE (
   IDTIPORESTAURANTE    int                  not null,
   NOMBRETIPORESTAURANTE varchar(8)           null,
   constraint PK_TIPORESTAURANTE primary key (IDTIPORESTAURANTE)
)
go

alter table IMAGENESLOCAL
   add constraint FK_IMAGENES_REFERENCE_LOCAL foreign key (IDLOCAL)
      references LOCAL (IDLOCAL)
go

alter table LOCAL
   add constraint FK_LOCAL_REFERENCE_RESTAURA foreign key (IDRESTAURANTE)
      references RESTAURANTE (IDRESTAURANTE)
go

alter table RESTAURANTE
   add constraint FK_RESTAURA_REFERENCE_TIPOREST foreign key (IDTIPORESTAURANTE)
      references TIPORESTAURANTE (IDTIPORESTAURANTE)
go

alter table TIPOCOMIDA
   add constraint FK_TIPOCOMI_REFERENCE_LOCAL foreign key (IDLOCAL)
      references LOCAL (IDLOCAL)
go

