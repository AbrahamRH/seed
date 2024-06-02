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
) ;



CREATE UNIQUE INDEX XPKALMACEN ON ALMACEN
(almacen_id   ASC);



ALTER TABLE ALMACEN
	ADD CONSTRAINT  XPKALMACEN PRIMARY KEY (almacen_id);



CREATE TABLE ALMACEN_VIAJE_COMPRA
(
	almacen_id           INTEGER NOT NULL ,
	cantidad_almacenada  NUMBER(7,2) NOT NULL ,
	empleado_id          INTEGER NOT NULL ,
	viaje_id_RID         INTEGER NOT NULL ,
	almacen_viaje_compra_id CHAR(18) NOT NULL 
);



CREATE UNIQUE INDEX XPKALMACEN_TIPO_PRODUCTO ON ALMACEN_VIAJE_COMPRA
(almacen_viaje_compra_id   ASC);



ALTER TABLE ALMACEN_VIAJE_COMPRA
	ADD CONSTRAINT  XPKALMACEN_TIPO_PRODUCTO PRIMARY KEY (almacen_viaje_compra_id);



CREATE TABLE ALMACEN_VIAJE_VENTA
(
	almacen_id           CHAR(18) NOT NULL ,
	viaje_id_RID         INTEGER NOT NULL ,
	cantidad_extraida_grano CHAR(18) NOT NULL 
);



CREATE UNIQUE INDEX XPKALMACEN_VIAJE_VENTA ON ALMACEN_VIAJE_VENTA
(almacen_id   ASC,viaje_id_RID   ASC);



ALTER TABLE ALMACEN_VIAJE_VENTA
	ADD CONSTRAINT  XPKALMACEN_VIAJE_VENTA PRIMARY KEY (almacen_id,viaje_id_RID);



CREATE TABLE BOLETA
(
	folio                CHAR(18) NOT NULL ,
	fecha_compra         DATE NOT NULL ,
	cantidad_total       NUMBER(7,2) NOT NULL ,
	importe_total        NUMBER(8,2) NOT NULL ,
	productor_id         INTEGER NOT NULL ,
	viaje_id_RID         INTEGER NOT NULL 
);



CREATE UNIQUE INDEX XPKBOLETA ON BOLETA
(folio   ASC,productor_id   ASC);



ALTER TABLE BOLETA
	ADD CONSTRAINT  XPKBOLETA PRIMARY KEY (folio,productor_id);



CREATE TABLE CAMION
(
	camion_id            INTEGER NOT NULL ,
	capacidad            NUMBER(7,2,) NOT NULL ,
	tipo_camion          VARCHAR2(10) NOT NULL  CONSTRAINT  ck_TipoCamion CHECK (tipo_camion IN ('TORTON', 'PLATAFORMA', 'CERRADO')),
	foto                 BLOB NOT NULL ,
	placas               VARCHAR2(15) NOT NULL 
);



CREATE UNIQUE INDEX XPKCAMION ON CAMION
(camion_id   ASC);



ALTER TABLE CAMION
	ADD CONSTRAINT  XPKCAMION PRIMARY KEY (camion_id);



CREATE UNIQUE INDEX AK1CAMION ON CAMION
(placas   ASC);



ALTER TABLE CAMION
ADD CONSTRAINT  AK1CAMION UNIQUE (placas);



CREATE TABLE CENTRO_ACOPIO
(
	centro_acopio_id     INTEGER NOT NULL ,
	nombre_centro        VARCHAR2(30) NOT NULL ,
	direccion_centro     VARCHAR2(1000) NOT NULL ,
	latitud_centro       NUMBER(9,6) NOT NULL ,
	longitud_centro      NUMBER(9,6) NOT NULL ,
	empleado_id          INTEGER NOT NULL 
);



CREATE UNIQUE INDEX XPKCENTRO_ACOPIO ON CENTRO_ACOPIO
(centro_acopio_id   ASC);



ALTER TABLE CENTRO_ACOPIO
	ADD CONSTRAINT  XPKCENTRO_ACOPIO PRIMARY KEY (centro_acopio_id);



CREATE TABLE CLIENTE
(
	nombre_cliente       VARCHAR2(200) NOT NULL ,
	rfc_cliente          CHAR(18) NOT NULL ,
	email                VARCHAR2(50) NOT NULL ,
	cliente_id           INTEGER NOT NULL 
);



CREATE UNIQUE INDEX XPKCLIENTES ON CLIENTE
(cliente_id   ASC);



ALTER TABLE CLIENTE
	ADD CONSTRAINT  XPKCLIENTES PRIMARY KEY (cliente_id);



CREATE TABLE CUENTA_CLABE
(
	productor_id         INTEGER NOT NULL ,
	clabe                INTEGER NOT NULL 
);



CREATE UNIQUE INDEX XPKCUENTA_CLABE ON CUENTA_CLABE
(productor_id   ASC,clabe   ASC);



ALTER TABLE CUENTA_CLABE
	ADD CONSTRAINT  XPKCUENTA_CLABE PRIMARY KEY (productor_id,clabe);



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
);



CREATE UNIQUE INDEX XPKEMPLEADO ON EMPLEADO
(empleado_id   ASC);



ALTER TABLE EMPLEADO
	ADD CONSTRAINT  XPKEMPLEADO PRIMARY KEY (empleado_id);



CREATE UNIQUE INDEX AK1EMPLEADO ON EMPLEADO
(rfc   ASC);



ALTER TABLE EMPLEADO
ADD CONSTRAINT  AK1EMPLEADO UNIQUE (rfc);



CREATE TABLE ESTATUS_VIAJE
(
	estatus_id           INTEGER NOT NULL ,
	estatus_viaje        VARCHAR2(25) NOT NULL  CONSTRAINT  ck_estatus_viaje CHECK (estatus_viaje IN ('CARGANDO', 'EN CURSO', 'EN CENTRO ACOPIO', 'DESCARGANDO', 'EN DESTINO CLIENTE', 'EN PAUSA')),
	descripcion          VARCHAR2(200) NOT NULL 
);



CREATE UNIQUE INDEX XPKESTATUS_VIAJE ON ESTATUS_VIAJE
(estatus_id   ASC);



ALTER TABLE ESTATUS_VIAJE
	ADD CONSTRAINT  XPKESTATUS_VIAJE PRIMARY KEY (estatus_id);



CREATE TABLE FACTURA
(
	factura_id           INTEGER NOT NULL ,
	domicilio_factura    VARCHAR2(1000) NOT NULL ,
	precio_venta_kg      NUMBER(8,2) NOT NULL ,
	total                NUMBER(8,2) NOT NULL ,
	iva                  NUMBER(2) NOT NULL  CONSTRAINT  ck_iva CHECK (total*0.16),
	viaje_id_RID         INTEGER NOT NULL ,
	cliente_id           INTEGER NOT NULL 
);



CREATE UNIQUE INDEX XPKFACTURA ON FACTURA
(factura_id   ASC);



ALTER TABLE FACTURA
	ADD CONSTRAINT  XPKFACTURA PRIMARY KEY (factura_id);



CREATE TABLE HIST_PRECIO_VENTA_PRODUCTO
(
	tipo_producto_id     INTEGER NOT NULL ,
	precio_id            INTEGER NOT NULL ,
	fecha_inicio_precio  DATE NOT NULL ,
	fecha_fin_precio     DATE NOT NULL ,
	precio               NUMBER(8,2) NOT NULL 
);



CREATE UNIQUE INDEX XPKHISTORICO_PRECIO ON HIST_PRECIO_VENTA_PRODUCTO
(precio_id   ASC);



ALTER TABLE HIST_PRECIO_VENTA_PRODUCTO
	ADD CONSTRAINT  XPKHISTORICO_PRECIO PRIMARY KEY (precio_id);



CREATE TABLE HISTORICO_ESTATUS_VIAJE
(
	viaje_id             INTEGER NOT NULL ,
	estatus_id           INTEGER NOT NULL ,
	fecha_estatus_viaje  DATE NOT NULL 
);



CREATE UNIQUE INDEX XPKHISTORICO_ESTATUS_VIAJE ON HISTORICO_ESTATUS_VIAJE
(viaje_id   ASC,estatus_id   ASC);



ALTER TABLE HISTORICO_ESTATUS_VIAJE
	ADD CONSTRAINT  XPKHISTORICO_ESTATUS_VIAJE PRIMARY KEY (viaje_id,estatus_id);



CREATE TABLE LUGAR
(
	lugar_id             INTEGER NOT NULL ,
	nombre_lugar         VARCHAR2(30) NOT NULL ,
	descripcion_lugar    VARCHAR2(200) NOT NULL ,
	direccion_lugar      VARCHAR2(1000) NOT NULL ,
	latitud_lugar        NUMBER(9,6) NOT NULL ,
	longitud_lugar       NUMBER(9,6) NOT NULL 
);



CREATE UNIQUE INDEX XPKLUGAR ON LUGAR
(lugar_id   ASC);



ALTER TABLE LUGAR
	ADD CONSTRAINT  XPKLUGAR PRIMARY KEY (lugar_id);



CREATE TABLE MONITOREO
(
	monitoreo_id         INTEGER NOT NULL ,
	fecha_hora           DATE NOT NULL  CONSTRAINT  ck_fechaHora CHECK (sysdate),
	longitud             NUMBER(9,6,) NOT NULL ,
	latitud              NUMBER(9,6) NOT NULL ,
	viaje_id             INTEGER NOT NULL 
);



CREATE UNIQUE INDEX XPKMONITOREO ON MONITOREO
(monitoreo_id   ASC);



ALTER TABLE MONITOREO
	ADD CONSTRAINT  XPKMONITOREO PRIMARY KEY (monitoreo_id);



CREATE TABLE PRODUCTOR
(
	productor_id         INTEGER NOT NULL ,
	rfc                  CHAR(18) NOT NULL ,
	direccion            VARCHAR2(50 BYTE) NOT NULL ,
	nombre_productor     VARCHAR2(30) NOT NULL ,
	apellido_pat_productor VARCHAR2(30) NOT NULL ,
	apellido_mat_productor VARCHAR2(30) NULL 
);



CREATE UNIQUE INDEX XPKPRODUCTOR ON PRODUCTOR
(productor_id   ASC);



ALTER TABLE PRODUCTOR
	ADD CONSTRAINT  XPKPRODUCTOR PRIMARY KEY (productor_id);



CREATE UNIQUE INDEX AK1PRODUCTOR ON PRODUCTOR
(rfc   ASC);



ALTER TABLE PRODUCTOR
ADD CONSTRAINT  AK1PRODUCTOR UNIQUE (rfc);



CREATE TABLE TIPO_PRODUCTO
(
	tipo_producto_id     INTEGER NOT NULL ,
	precio_actual        NUMBER(8,2) NOT NULL ,
	tipo_producto        VARCHAR2(2) NOT NULL  CONSTRAINT  ckTipo_producto CHECK (tipo_producto IN ('MAIZ', 'SORGO', 'FRIJOL', 'SOYA'))
);



CREATE UNIQUE INDEX XPKTIPO_PRODUCTO ON TIPO_PRODUCTO
(tipo_producto_id   ASC);



ALTER TABLE TIPO_PRODUCTO
	ADD CONSTRAINT  XPKTIPO_PRODUCTO PRIMARY KEY (tipo_producto_id);



CREATE TABLE VIAJE
(
	viaje_id             INTEGER NOT NULL ,
	fecha_salida         DATE NOT NULL ,
	fecha_llegada        DATE NOT NULL ,
	fecha_estatus        DATE NOT NULL ,
	peso_bruto           NUMBER(7,2) NOT NULL  CONSTRAINT  ck_peso_bruto CHECK (peso_tara+peso_neto),
	peso_tara            NUMBER(7,2) NOT NULL ,
	peso_neto            NUMBER(7,2) NOT NULL ,
	tipo_viaje           CHAR NOT NULL ,
	tipo_producto_id     INTEGER NOT NULL ,
	estatus_id           INTEGER NOT NULL ,
	camion_id            INTEGER NOT NULL ,
	empleado_chofer_id_RID INTEGER NOT NULL 
);



CREATE UNIQUE INDEX XPKVIAJE ON VIAJE
(viaje_id   ASC);



ALTER TABLE VIAJE
	ADD CONSTRAINT  XPKVIAJE PRIMARY KEY (viaje_id);



CREATE TABLE VIAJE_COMPRA
(
	viaje_id_RID         INTEGER NOT NULL ,
	lugar_origen_id      INTEGER NOT NULL ,
	centro_acopio_destino_id INTEGER NOT NULL 
);



CREATE UNIQUE INDEX XPKVIAJE_COMPRA ON VIAJE_COMPRA
(viaje_id_RID   ASC);



ALTER TABLE VIAJE_COMPRA
	ADD CONSTRAINT  XPKVIAJE_COMPRA PRIMARY KEY (viaje_id_RID);



CREATE TABLE VIAJE_VENTA
(
	viaje_id_RID         INTEGER NOT NULL ,
	lugar_destino_id     INTEGER NOT NULL ,
	centro_acopio_origen_id INTEGER NOT NULL 
);



CREATE UNIQUE INDEX XPKVIAJE_VENTA ON VIAJE_VENTA
(viaje_id_RID   ASC);



ALTER TABLE VIAJE_VENTA
	ADD CONSTRAINT  XPKVIAJE_VENTA PRIMARY KEY (viaje_id_RID);



ALTER TABLE ALMACEN
	ADD (CONSTRAINT R_22 FOREIGN KEY (centro_acopio_id) REFERENCES CENTRO_ACOPIO (centro_acopio_id));



ALTER TABLE ALMACEN
	ADD (CONSTRAINT R_33 FOREIGN KEY (empleado_id) REFERENCES EMPLEADO (empleado_id));



ALTER TABLE ALMACEN_VIAJE_COMPRA
	ADD (CONSTRAINT R_18 FOREIGN KEY (almacen_id) REFERENCES ALMACEN (almacen_id));



ALTER TABLE ALMACEN_VIAJE_COMPRA
	ADD (CONSTRAINT R_49 FOREIGN KEY (empleado_id) REFERENCES EMPLEADO (empleado_id));



ALTER TABLE ALMACEN_VIAJE_COMPRA
	ADD (CONSTRAINT R_52 FOREIGN KEY (viaje_id_RID) REFERENCES VIAJE_COMPRA (viaje_id_RID));



ALTER TABLE ALMACEN_VIAJE_VENTA
	ADD (CONSTRAINT R_40 FOREIGN KEY (almacen_id) REFERENCES ALMACEN (almacen_id));



ALTER TABLE ALMACEN_VIAJE_VENTA
	ADD (CONSTRAINT R_42 FOREIGN KEY (viaje_id_RID) REFERENCES VIAJE_VENTA (viaje_id_RID));



ALTER TABLE BOLETA
	ADD (CONSTRAINT R_11 FOREIGN KEY (productor_id) REFERENCES PRODUCTOR (productor_id));



ALTER TABLE BOLETA
	ADD (CONSTRAINT R_50 FOREIGN KEY (viaje_id_RID) REFERENCES VIAJE (viaje_id));



ALTER TABLE CENTRO_ACOPIO
	ADD (CONSTRAINT R_29 FOREIGN KEY (empleado_id) REFERENCES EMPLEADO (empleado_id));



ALTER TABLE CUENTA_CLABE
	ADD (CONSTRAINT R_9 FOREIGN KEY (productor_id) REFERENCES PRODUCTOR (productor_id));



ALTER TABLE EMPLEADO
	ADD (CONSTRAINT jefe FOREIGN KEY (jefe) REFERENCES EMPLEADO (empleado_id) ON DELETE SET NULL);



ALTER TABLE FACTURA
	ADD (CONSTRAINT R_44 FOREIGN KEY (viaje_id_RID) REFERENCES VIAJE_VENTA (viaje_id_RID));



ALTER TABLE FACTURA
	ADD (CONSTRAINT R_47 FOREIGN KEY (cliente_id) REFERENCES CLIENTE (cliente_id));



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



ALTER TABLE VIAJE
	ADD (CONSTRAINT R_34 FOREIGN KEY (empleado_chofer_id_RID) REFERENCES EMPLEADO (empleado_id));



ALTER TABLE VIAJE_COMPRA
	ADD (FOREIGN KEY (viaje_id_RID) REFERENCES VIAJE(viaje_id) ON DELETE CASCADE);



ALTER TABLE VIAJE_COMPRA
	ADD (CONSTRAINT R_30 FOREIGN KEY (lugar_origen_id) REFERENCES LUGAR (lugar_id));



ALTER TABLE VIAJE_COMPRA
	ADD (CONSTRAINT R_32 FOREIGN KEY (centro_acopio_destino_id) REFERENCES CENTRO_ACOPIO (centro_acopio_id));



ALTER TABLE VIAJE_VENTA
	ADD (FOREIGN KEY (viaje_id_RID) REFERENCES VIAJE(viaje_id) ON DELETE CASCADE);



ALTER TABLE VIAJE_VENTA
	ADD (CONSTRAINT R_37 FOREIGN KEY (lugar_destino_id) REFERENCES LUGAR (lugar_id));



ALTER TABLE VIAJE_VENTA
	ADD (CONSTRAINT R_39 FOREIGN KEY (centro_acopio_origen_id) REFERENCES CENTRO_ACOPIO (centro_acopio_id));

