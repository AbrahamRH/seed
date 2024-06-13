Prompt creando tablas

conn admin_almacen/admin_almacen@pdb_almacen

prompt Tabla: almacen

CREATE TABLE ALMACEN
(
	almacen_id           CHAR(18) NOT NULL ,
	tipo_almacen         VARCHAR2(30) NOT NULL  CONSTRAINT  ck_tipo_almacen CHECK (tipo_almacen IN ('bodega', 'silo', 'patio')),
	capacidad_almacen    NUMBER NOT NULL ,
	centro_acopio_id     INTEGER NOT NULL ,
	empleado_id          INTEGER NOT NULL 
) tablespace almacen_tbs;

prompt indice: almacen_id

CREATE UNIQUE INDEX XPKALMACEN ON ALMACEN
(almacen_id   ASC) tablespace almacen_idx_tbs;



ALTER TABLE ALMACEN
	ADD CONSTRAINT  XPKALMACEN PRIMARY KEY (almacen_id);

prompt tabla:almacen_viaje_compra

CREATE TABLE ALMACEN_VIAJE_COMPRA
(
	almacen_id           INTEGER NOT NULL ,
	cantidad_almacenada  NUMBER(7,2) NOT NULL ,
	empleado_id          INTEGER NOT NULL ,
	viaje_id_RID         INTEGER NOT NULL ,
	almacen_viaje_compra_id CHAR(18) NOT NULL 
) tablespace almacen_tbs;

prompt indice: almace_tipo_producto

CREATE UNIQUE INDEX XPKALMACEN_TIPO_PRODUCTO ON ALMACEN_VIAJE_COMPRA
(almacen_viaje_compra_id   ASC) tablespace almacen_idx_tbs;


ALTER TABLE ALMACEN_VIAJE_COMPRA
	ADD CONSTRAINT  XPKALMACEN_TIPO_PRODUCTO PRIMARY KEY (almacen_viaje_compra_id);

prompt tabla: almacen_viaje_venta

CREATE TABLE ALMACEN_VIAJE_VENTA
(
	almacen_id           CHAR(18) NOT NULL ,
	viaje_id_RID         INTEGER NOT NULL ,
	cantidad_extraida_grano CHAR(18) NOT NULL 
) tablespace almacen_tbs;

prompt indice: almacen_viaje_venta_id

CREATE UNIQUE INDEX XPKALMACEN_VIAJE_VENTA ON ALMACEN_VIAJE_VENTA
(almacen_id   ASC,viaje_id_RID   ASC) tablespace almacen_idx_tbs;



ALTER TABLE ALMACEN_VIAJE_VENTA
	ADD CONSTRAINT  XPKALMACEN_VIAJE_VENTA PRIMARY KEY (almacen_id,viaje_id_RID);


conn admin_ventas/admin_ventas@pdb_ventas
prompt tabla: boleta

CREATE TABLE BOLETA
(
	folio                CHAR(18) NOT NULL ,
	fecha_compra         DATE NOT NULL ,
	cantidad_total       NUMBER(7,2) NOT NULL ,
	importe_total        NUMBER(8,2) NOT NULL ,
	productor_id         INTEGER NOT NULL ,
	viaje_id_RID         INTEGER NOT NULL 
)tablespace ventas_tbs;

prompt indice: boleta_id

CREATE UNIQUE INDEX XPKBOLETA ON BOLETA
(folio   ASC,productor_id   ASC) tablespace ventas_idx_tbs;



ALTER TABLE BOLETA
	ADD CONSTRAINT  XPKBOLETA PRIMARY KEY (folio,productor_id);

conn admin_viajes/admin_viajes@pdb_viajes
prompt tabla: camion

CREATE TABLE CAMION
(
	camion_id            INTEGER NOT NULL ,
	capacidad            NUMBER(7,2) NOT NULL ,
	tipo_camion          VARCHAR2(10) NOT NULL  CONSTRAINT  ck_TipoCamion CHECK (tipo_camion IN ('TORTON', 'PLATAFORMA', 'CERRADO')),
	foto                 BLOB NULL ,
	placas               VARCHAR2(15) NOT NULL 
) tablespace viajes_big_tbs;

prompt indice: camion_id

CREATE UNIQUE INDEX XPKCAMION ON CAMION
(camion_id   ASC) tablespace viajes_idx_tbs;



ALTER TABLE CAMION
	ADD CONSTRAINT  XPKCAMION PRIMARY KEY (camion_id);

prompt unique: placas

CREATE UNIQUE INDEX AK1CAMION ON CAMION
(placas   ASC) tablespace ventas_idx_tbs;


ALTER TABLE CAMION
ADD CONSTRAINT  AK1CAMION UNIQUE (placas);


conn admin_ventas/admin_ventas@pdb_ventas

prompt tabla: cliente

CREATE TABLE CLIENTE
(
	nombre_cliente       VARCHAR2(200) NOT NULL ,
	rfc_cliente          CHAR(18) NOT NULL ,
	email                VARCHAR2(50) NOT NULL ,
	cliente_id           INTEGER NOT NULL 
) tablespace ventas_multiple_tbs;

prompt indice: cliente_id

CREATE UNIQUE INDEX XPKCLIENTES ON CLIENTE
(cliente_id   ASC) tablespace ventas_idx_tbs;



ALTER TABLE CLIENTE
	ADD CONSTRAINT  XPKCLIENTES PRIMARY KEY (cliente_id);

prompt tabla: CUENTA_CLABE

CREATE TABLE CUENTA_CLABE
(
	productor_id         INTEGER NOT NULL ,
	clabe                INTEGER NOT NULL 
) tablespace ventas_tbs;



CREATE UNIQUE INDEX XPKCUENTA_CLABE ON CUENTA_CLABE
(productor_id   ASC,clabe   ASC) tablespace ventas_idx_tbs;



ALTER TABLE CUENTA_CLABE
	ADD CONSTRAINT  XPKCUENTA_CLABE PRIMARY KEY (productor_id,clabe);

conn admin_almacen/admin_almacen@pdb_almacen
prompt tabla: empleado

CREATE TABLE EMPLEADO
(
	empleado_id          INTEGER NOT NULL ,
	jefe                 INTEGER NULL ,
	rfc                  CHAR(18) NOT NULL ,
	nombre_empleado      VARCHAR2(30) NOT NULL ,
	apellido_pat_empleado VARCHAR2(30) NOT NULL ,
	apellido_mat_empleado VARCHAR2(30) NULL ,
	rol                  VARCHAR2(25) NOT NULL ,
	sueldo               NUMBER(8,2) NOT NULL 
) tablespace almacen_big_tbs;

prompt indice: empleado_id

CREATE UNIQUE INDEX XPKEMPLEADO ON EMPLEADO
(empleado_id   ASC) tablespace almacen_idx_tbs;



ALTER TABLE EMPLEADO
	ADD CONSTRAINT  XPKEMPLEADO PRIMARY KEY (empleado_id);

prompt indice: rfc

CREATE UNIQUE INDEX AK1EMPLEADO ON EMPLEADO
(rfc   ASC) tablespace almacen_idx_tbs;



ALTER TABLE EMPLEADO
ADD CONSTRAINT  AK1EMPLEADO UNIQUE (rfc);

conn admin_viajes/admin_viajes@pdb_viajes
prompt tabla: estatus_viaje

CREATE TABLE ESTATUS_VIAJE
(
	estatus_id           INTEGER NOT NULL ,
	estatus_viaje        VARCHAR2(25) NOT NULL  CONSTRAINT  ck_estatus_viaje CHECK (estatus_viaje IN ('CARGANDO', 'EN CURSO', 'EN CENTRO ACOPIO', 'DESCARGANDO', 'EN DESTINO CLIENTE', 'EN PAUSA')),
	descripcion          VARCHAR2(200) NOT NULL 
) tablespace viajes_tbs;

prompt indice: estatus_id

CREATE UNIQUE INDEX XPKESTATUS_VIAJE ON ESTATUS_VIAJE
(estatus_id   ASC);



ALTER TABLE ESTATUS_VIAJE
	ADD CONSTRAINT  XPKESTATUS_VIAJE PRIMARY KEY (estatus_id);

conn admin_ventas/admin_ventas@pdb_ventas
prompt tabla: factua

CREATE TABLE FACTURA
(
	factura_id           INTEGER NOT NULL ,
	domicilio_factura    VARCHAR2(1000) NOT NULL ,
	precio_venta_kg      NUMBER(8,2) NOT NULL ,
	total                NUMBER(8,2) NOT NULL ,
	iva                  as (total*0.16),
	viaje_id_RID         INTEGER NOT NULL ,
	cliente_id           INTEGER NOT NULL 
) tablespace ventas_multiple_tbs;

prompt indice: factura_id

CREATE UNIQUE INDEX XPKFACTURA ON FACTURA
(factura_id   ASC) tablespace ventas_idx_tbs;



ALTER TABLE FACTURA
	ADD CONSTRAINT  XPKFACTURA PRIMARY KEY (factura_id);

conn admin_viajes/admin_viajes@pdb_viajes
prompt tabla: hist_precio

CREATE TABLE HIST_PRECIO_VENTA_PRODUCTO
(
	tipo_producto_id     INTEGER NOT NULL ,
	precio_id            INTEGER NOT NULL ,
	fecha_inicio_precio  DATE NOT NULL ,
	fecha_fin_precio     DATE NOT NULL ,
	precio               NUMBER(8,2) NOT NULL 
) tablespace viajes_big_tbs;

prompt indice: precio_id

CREATE UNIQUE INDEX XPKHISTORICO_PRECIO ON HIST_PRECIO_VENTA_PRODUCTO
(precio_id   ASC) tablespace viajes_idx_tbs;



ALTER TABLE HIST_PRECIO_VENTA_PRODUCTO
	ADD CONSTRAINT  XPKHISTORICO_PRECIO PRIMARY KEY (precio_id);

prompt tabla: HISTORICO_ESTATUS_VIAJE

CREATE TABLE HISTORICO_ESTATUS_VIAJE
(
	viaje_id             INTEGER NOT NULL ,
	estatus_id           INTEGER NOT NULL ,
	fecha_estatus_viaje  DATE NOT NULL 
) tablespace viajes_big_tbs;

prompt indice: viaje_status_hist_id

CREATE UNIQUE INDEX XPKHISTORICO_ESTATUS_VIAJE ON HISTORICO_ESTATUS_VIAJE
(viaje_id   ASC,estatus_id   ASC) tablespace viajes_idx_tbs;



ALTER TABLE HISTORICO_ESTATUS_VIAJE
	ADD CONSTRAINT  XPKHISTORICO_ESTATUS_VIAJE PRIMARY KEY (viaje_id,estatus_id);

prompt tabla: lugar

CREATE TABLE LUGAR
(
	lugar_id             INTEGER NOT NULL ,
	nombre_lugar         VARCHAR2(30) NOT NULL ,
	descripcion_lugar    VARCHAR2(200) NOT NULL ,
	direccion_lugar      VARCHAR2(1000) NOT NULL ,
	latitud_lugar        NUMBER(10,5) NOT NULL ,
	longitud_lugar       NUMBER(10,5) NOT NULL 
) tablespace viajes_big_tbs;

prompt indice: lugar_id

CREATE UNIQUE INDEX XPKLUGAR ON LUGAR
(lugar_id   ASC) tablespace viajes_idx_tbs;



ALTER TABLE LUGAR
	ADD CONSTRAINT  XPKLUGAR PRIMARY KEY (lugar_id);

prompt tabla: monitoreo

CREATE TABLE MONITOREO
(
	monitoreo_id         INTEGER NOT NULL ,
	fecha_hora           DATE NOT NULL ,
	longitud             NUMBER(10,5) NOT NULL ,
	latitud              NUMBER(10,5) NOT NULL ,
	viaje_id             INTEGER NOT NULL 
) tablespace viajes_big_tbs;

prompt indice: monitoreo_id

CREATE UNIQUE INDEX XPKMONITOREO ON MONITOREO
(monitoreo_id   ASC) tablespace viajes_idx_tbs;



ALTER TABLE MONITOREO
	ADD CONSTRAINT  XPKMONITOREO PRIMARY KEY (monitoreo_id);

conn admin_ventas/admin_ventas@pdb_ventas
prompt tabla: productor

CREATE TABLE PRODUCTOR
(
	productor_id         INTEGER NOT NULL ,
	rfc                  CHAR(18) NOT NULL ,
	direccion            VARCHAR2(50 BYTE) NOT NULL ,
	nombre_productor     VARCHAR2(30) NOT NULL ,
	apellido_pat_productor VARCHAR2(30) NOT NULL ,
	apellido_mat_productor VARCHAR2(30) NULL 
) tablespace ventas_multiple_tbs;

prompt indice: productor_id

CREATE UNIQUE INDEX XPKPRODUCTOR ON PRODUCTOR
(productor_id   ASC) tablespace ventas_idx_tbs;



ALTER TABLE PRODUCTOR
	ADD CONSTRAINT  XPKPRODUCTOR PRIMARY KEY (productor_id);

prompt indice: productor rfc

CREATE UNIQUE INDEX AK1PRODUCTOR ON PRODUCTOR
(rfc   ASC) tablespace ventas_idx_tbs;



ALTER TABLE PRODUCTOR
ADD CONSTRAINT  AK1PRODUCTOR UNIQUE (rfc);

conn admin_viajes/admin_viajes@pdb_viajes

CREATE TABLE TIPO_PRODUCTO
(
	tipo_producto_id     INTEGER NOT NULL ,
	precio_actual        NUMBER(8,2) NOT NULL ,
	tipo_producto        VARCHAR2(6) NOT NULL  CONSTRAINT  ckTipo_producto CHECK (tipo_producto IN ('MAIZ', 'SORGO', 'FRIJOL', 'SOYA'))
) tablespace viajes_tbs;

prompt indice: tipo_producto

CREATE UNIQUE INDEX XPKTIPO_PRODUCTO ON TIPO_PRODUCTO
(tipo_producto_id   ASC) tablespace viajes_idx_tbs;



ALTER TABLE TIPO_PRODUCTO
	ADD CONSTRAINT  XPKTIPO_PRODUCTO PRIMARY KEY (tipo_producto_id);

prompt tabla: viaje

CREATE TABLE VIAJE
(
	viaje_id             INTEGER NOT NULL ,
	fecha_salida         DATE NOT NULL ,
	fecha_llegada        DATE NOT NULL ,
	fecha_estatus        DATE NOT NULL ,
	peso_tara            NUMBER(7,2) NOT NULL ,
	peso_neto            NUMBER(7,2) NOT NULL ,
	peso_bruto           as (peso_tara+peso_neto),
	tipo_viaje           CHAR NOT NULL ,
	tipo_producto_id     INTEGER NOT NULL ,
	estatus_id           INTEGER NOT NULL ,
	camion_id            INTEGER NOT NULL ,
	empleado_chofer_id_RID INTEGER NOT NULL 
) tablespace viajes_big_tbs;



CREATE UNIQUE INDEX XPKVIAJE ON VIAJE
(viaje_id   ASC);



ALTER TABLE VIAJE
	ADD CONSTRAINT  XPKVIAJE PRIMARY KEY (viaje_id);

prompt tabla: viaje_compra

CREATE TABLE VIAJE_COMPRA
(
	viaje_id_RID         INTEGER NOT NULL ,
	lugar_origen_id      INTEGER NOT NULL ,
	centro_acopio_destino_id INTEGER NOT NULL 
) tablespace viajes_big_tbs;

prompt indice: viaje_compra_id

CREATE UNIQUE INDEX XPKVIAJE_COMPRA ON VIAJE_COMPRA
(viaje_id_RID   ASC) tablespace viajes_idx_tbs;



ALTER TABLE VIAJE_COMPRA
	ADD CONSTRAINT  XPKVIAJE_COMPRA PRIMARY KEY (viaje_id_RID);

prompt tabla: viaje_venta

CREATE TABLE VIAJE_VENTA
(
	viaje_id_RID         INTEGER NOT NULL ,
	lugar_destino_id     INTEGER NOT NULL ,
	centro_acopio_origen_id INTEGER NOT NULL 
) tablespace viajes_big_tbs;

prompt indice: viaje_venta_id

CREATE UNIQUE INDEX XPKVIAJE_VENTA ON VIAJE_VENTA
(viaje_id_RID   ASC) tablespace viajes_idx_tbs;

conn admin_almacen/admin_almacen@pdb_almacen


ALTER TABLE ALMACEN
	ADD (CONSTRAINT R_33 FOREIGN KEY (empleado_id) REFERENCES EMPLEADO (empleado_id));



ALTER TABLE ALMACEN_VIAJE_COMPRA
	ADD (CONSTRAINT R_18 FOREIGN KEY (almacen_id) REFERENCES ALMACEN (almacen_id));



ALTER TABLE ALMACEN_VIAJE_COMPRA
	ADD (CONSTRAINT R_49 FOREIGN KEY (empleado_id) REFERENCES EMPLEADO (empleado_id));


ALTER TABLE ALMACEN_VIAJE_VENTA
	ADD (CONSTRAINT R_40 FOREIGN KEY (almacen_id) REFERENCES ALMACEN (almacen_id));

ALTER TABLE EMPLEADO
	ADD (CONSTRAINT jefe FOREIGN KEY (jefe) REFERENCES EMPLEADO (empleado_id) ON DELETE SET NULL);

conn admin_ventas/admin_ventas@pdb_ventas

ALTER TABLE BOLETA
	ADD (CONSTRAINT R_11 FOREIGN KEY (productor_id) REFERENCES PRODUCTOR (productor_id));


ALTER TABLE CUENTA_CLABE
	ADD (CONSTRAINT R_9 FOREIGN KEY (productor_id) REFERENCES PRODUCTOR (productor_id));



ALTER TABLE FACTURA
	ADD (CONSTRAINT R_47 FOREIGN KEY (cliente_id) REFERENCES CLIENTE (cliente_id));



conn admin_viajes/admin_viajes@pdb_viajes

ALTER TABLE HIST_PRECIO_VENTA_PRODUCTO
	ADD (CONSTRAINT R_2 FOREIGN KEY (tipo_producto_id) REFERENCES TIPO_PRODUCTO (tipo_producto_id));



ALTER TABLE HISTORICO_ESTATUS_VIAJE
	ADD (CONSTRAINT R_6 FOREIGN KEY (viaje_id) REFERENCES VIAJE (viaje_id));



ALTER TABLE HISTORICO_ESTATUS_VIAJE
	ADD (CONSTRAINT R_8 FOREIGN KEY (estatus_id) REFERENCES ESTATUS_VIAJE (estatus_id));



ALTER TABLE MONITOREO
	ADD (CONSTRAINT R_46 FOREIGN KEY (viaje_id) REFERENCES VIAJE (viaje_id));



ALTER TABLE VIAJE
	ADD (CONSTRAINT R_3 FOREIGN KEY (tipo_producto_id) REFERENCES TIPO_PRODUCTO (tipo_producto_id));



ALTER TABLE VIAJE
	ADD (CONSTRAINT R_4 FOREIGN KEY (estatus_id) REFERENCES ESTATUS_VIAJE (estatus_id));



ALTER TABLE VIAJE
	ADD (CONSTRAINT R_13 FOREIGN KEY (camion_id) REFERENCES CAMION (camion_id));



ALTER TABLE VIAJE_COMPRA
	ADD (CONSTRAINT R_30 FOREIGN KEY (lugar_origen_id) REFERENCES LUGAR (lugar_id));



ALTER TABLE VIAJE_VENTA
	ADD (CONSTRAINT R_38 FOREIGN KEY (lugar_destino_id) REFERENCES LUGAR (lugar_id));

