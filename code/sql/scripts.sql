CREATE TABLE lugar(
	lu_codigo		SERIAL,
	lu_nombre		VARCHAR(50)	NOT NULL,
	lu_tipo			VARCHAR(20)	NOT NULL,
	fk_lugar		INTEGER,
	
	CONSTRAINT pk_lu_codigo PRIMARY KEY (lu_codigo),
    CONSTRAINT fk_lugar FOREIGN KEY (fk_lugar) REFERENCES lugar (lu_codigo),
	CONSTRAINT ch_lu_tipo CHECK(lu_tipo IN ('ESTADO', 'MUNICIPIO', 'PARROQUIA', 'DIRECCION'))
);

CREATE TABLE tienda(
	ti_codigo		SERIAL,
	ti_nombre		VARCHAR(20)	NOT NULL,
	fk_lugar		INTEGER NOT NULL,
	CONSTRAINT pk_ti_codigo PRIMARY KEY (ti_codigo),
	CONSTRAINT fk_lugar FOREIGN KEY (fk_lugar) REFERENCES lugar (lu_codigo)
);

CREATE TABLE cliente(
	cl_id				SERIAL,	 
	cl_correo			VARCHAR(50)  NOT NULL 	UNIQUE,
	cl_contrasena		VARCHAR(20)	 NOT NULL,
	cl_afiliacion		NUMERIC(10)	 NOT NULL,
	cl_rif				VARCHAR(20),
	cl_tipo				VARCHAR(20)	 NOT NULL,
	fk_tienda			INTEGER      NOT NULL,

	/*NATURAL*/

	cl_cedula			NUMERIC(10),
	cl_p_nombre			VARCHAR(20),
	cl_s_nombre			VARCHAR(20), 
	cl_p_apellido		VARCHAR(20), 
	cl_s_apellido		VARCHAR(20), 
	fk_lugar			INTEGER,
	
	/*JURIDICO*/

    cl_razon_social     VARCHAR(50),  
	cl_pagina_web       VARCHAR(50),
	cl_den_comercial    VARCHAR(50),
    cl_capital          NUMERIC(10),
	fk_lugar_fiscal		INTEGER,
	fk_lugar_fisica		INTEGER,
	  
	
	CONSTRAINT pk_cliente PRIMARY KEY (cl_id),
	CONSTRAINT ch_cl_tipo CHECK(cl_tipo IN ('NATURAL', 'JURIDICO')),
	CONSTRAINT fk_tienda FOREIGN KEY (fk_tienda) REFERENCES tienda(ti_codigo),
	
	CONSTRAINT fk_lugar FOREIGN KEY (fk_lugar) REFERENCES lugar(lu_codigo),

	CONSTRAINT fk_lugar_fiscal FOREIGN KEY (fk_lugar_fiscal) REFERENCES lugar(lu_codigo),
	CONSTRAINT fk_lugar_fisica FOREIGN KEY (fk_lugar_fisica) REFERENCES lugar(lu_codigo)
	
);





CREATE TABLE compra(
	co_id            	SERIAL,
		
	CONSTRAINT pk_co_id PRIMARY KEY (co_id)
);



CREATE TABLE tipo_pago(
	tp_codigo            	SERIAL,
	tp_descripcion			VARCHAR(50),
		
	CONSTRAINT pk_tp_codigo PRIMARY KEY (tp_codigo)
);



CREATE TABLE metodo_pago(
	mc_documento          	VARCHAR(25),
	fk_cliente				INTEGER,
	
	fk_tipo_pago			INTEGER,	
	

	CONSTRAINT pk_metodo_pago PRIMARY KEY (mc_documento,fk_cliente,fk_tipo_pago),


	CONSTRAINT fk_cliente FOREIGN KEY (fk_cliente) REFERENCES cliente (cl_id),	
	CONSTRAINT fk_tipo_pago FOREIGN KEY (fk_tipo_pago) REFERENCES tipo_pago (tp_codigo)
);

CREATE TABLE moneda(
	mo_codigo        SERIAL,
	mo_descripcion	 VARCHAR(50) NOT NULL,
	
	CONSTRAINT pk_mo_codigo PRIMARY KEY (mo_codigo)
);

CREATE TABLE cotizacion(
	ct_fecha        TIMESTAMP,
	ct_valor		NUMERIC(10) NOT NULL,
	ct_expira       TIMESTAMP,

	fk_moneda		INTEGER NOT NULL,	
	
	CONSTRAINT pk_ct_fecha PRIMARY KEY (ct_fecha),
	CONSTRAINT fk_moneda FOREIGN KEY (fk_moneda) REFERENCES moneda (mo_codigo)
);

CREATE TABLE metodo_pago_compra(
	mp_documento            VARCHAR(25),
	mp_monto				NUMERIC(10) NOT NULL,
	mp_cantidad				NUMERIC(10) NOT NULL,
	
	fk_moneda 				INTEGER NOT NULL,
	fk_compra				INTEGER,
	fk_tipo_pago			INTEGER,	
	
	
	CONSTRAINT pk_pago_compra PRIMARY KEY (fk_compra,fk_tipo_pago,mp_documento),
	

	CONSTRAINT fk_moneda FOREIGN KEY (fk_moneda) REFERENCES moneda (mo_codigo),
	CONSTRAINT fk_compra FOREIGN KEY (fk_compra) REFERENCES compra (co_id),
	CONSTRAINT fk_tipo_pago FOREIGN KEY (fk_tipo_pago) REFERENCES tipo_pago (tp_codigo)
);


/* EMPLEADOS */


CREATE TABLE rol(

	ro_codigo		   SERIAL,
	ro_nombre		   VARCHAR(20) NOT NULL,

	CONSTRAINT pk_ro_codigo PRIMARY KEY (ro_codigo)
);





CREATE TABLE empleado(
	em_codigo 			SERIAL,
	em_cedula			NUMERIC(10) 	NOT NULL 	UNIQUE,
    em_correo			VARCHAR(50)     NOT NULL 	UNIQUE,
	em_contrasena		VARCHAR(20)	    NOT NULL,
	em_p_nombre			VARCHAR(20) 	NOT NULL,
	em_s_nombre			VARCHAR(20),
	em_p_apellido		VARCHAR(20) 	NOT NULL,
	em_s_apellido		VARCHAR(20),
	em_sueldo			NUMERIC(10) 	NOT NULL,
	em_fecha_nac		DATE			NOT NULL,


	fk_rol				INTEGER			NOT NULL,
    fk_tienda			INTEGER		    NOT NULL,
    fk_empleado_sup     INTEGER,
    

	CONSTRAINT pk_empleado PRIMARY KEY (em_codigo),
	CONSTRAINT fk_rol FOREIGN KEY (fk_rol) REFERENCES rol(ro_codigo),
    CONSTRAINT fk_tienda FOREIGN KEY (fk_tienda) REFERENCES tienda(ti_codigo),	
	CONSTRAINT fk_empleado_sup FOREIGN KEY (fk_empleado_sup) REFERENCES empleado (em_cedula)
);




CREATE TABLE horario(
	ho_codigo        SERIAL,
	ho_descripcion	 VARCHAR(50) 	NOT NULL,
	ho_dia			 VARCHAR(20)	NOT NULL,
	ho_hora_entrada	 TIME			NOT NULL,
	ho_hora_salida   TIME			NOT NULL, 
	
	CONSTRAINT pk_horario PRIMARY KEY (ho_codigo),
	CONSTRAINT ch_ho_dia CHECK (ho_dia IN ('LUNES', 'MARTES', 'MIERCOLES','JUEVES', 'VIERNES', 'SABADO','DOMINGO'))
);

CREATE TABLE horario_empleado(

	fk_horario				INTEGER,
	fk_empleado				INTEGER,	

	CONSTRAINT pk_horario_empleado PRIMARY KEY (fk_horario,fk_empleado),

	CONSTRAINT fk_horario FOREIGN KEY (fk_horario) REFERENCES horario (ho_codigo),	
	CONSTRAINT fk_empleado FOREIGN KEY (fk_empleado) REFERENCES empleado (em_codigo)
);




CREATE TABLE beneficio(
	be_codigo        SERIAL,
	be_nombre		 VARCHAR(50) 	NOT NULL,
		
	CONSTRAINT pk_beneficio PRIMARY KEY (be_codigo)
);

CREATE TABLE beneficio_empleado(

	fk_beneficio			INTEGER,
	fk_empleado				INTEGER,	

	CONSTRAINT pk_beneficio_empleado PRIMARY KEY (fk_beneficio,fk_empleado),

	CONSTRAINT fk_beneficio FOREIGN KEY (fk_beneficio) REFERENCES beneficio (be_codigo),	
	CONSTRAINT fk_empleado FOREIGN KEY (fk_empleado) REFERENCES empleado (em_codigo)
);




CREATE TABLE control_entrada(
	
	coen_entrada		TIMESTAMP,
	coen_salida		 	TIMESTAMP,
	fk_empleado         INTEGER,

	CONSTRAINT pk_control_entrada PRIMARY KEY (fk_empleado,coen_entrada),
	CONSTRAINT fk_empleado FOREIGN KEY (fk_empleado) REFERENCES empleado (em_codigo)

);



CREATE TABLE vacaciones(

	va_fecha_ini	TIMESTAMP	NOT NULL,
	va_fecha_fin	TIMESTAMP	NOT NULL,
	va_estatus		VARCHAR(20)	NOT NULL,				

	fk_empleado		INTEGER,


	CONSTRAINT pk_vacaciones PRIMARY KEY (va_fecha_ini,fk_empleado), 


	CONSTRAINT fk_empleado FOREIGN KEY (fk_empleado) REFERENCES empleado (em_cedula),
	CONSTRAINT ch_va_estatus CHECK (va_estatus IN ('PENDIENTE', 'EN PROCESO', 'FINALIZADO'))

);













CREATE TABLE proveedor(
	po_id				SERIAL,
	po_rif				NUMERIC(10)		NOT NULL	UNIQUE,
	po_den_comercial	VARCHAR(50)		NOT NULL,
	po_razon_social		VARCHAR(50)		NOT NULL,
	po_pagina_web		VARCHAR(50),
	po_correo			VARCHAR(50)		NOT NULL,
	po_correo_alt		VARCHAR(50),
	
	fk_lugar_fisica		INTEGER  		NOT NULL,
	fk_lugar_fiscal		INTEGER  		NOT NULL,
	
    CONSTRAINT pk_po_id PRIMARY KEY (po_id),
	CONSTRAINT fk_lugar_fisica FOREIGN KEY (fk_lugar_fisica) REFERENCES lugar (lu_codigo),
	CONSTRAINT fk_lugar_fiscal FOREIGN KEY (fk_lugar_fiscal) REFERENCES lugar (lu_codigo)
);

CREATE TABLE persona_contacto(
	peco_cedula		SERIAL,
	peco_p_nombre	VARCHAR(20)	NOT NULL,
	peco_p_apellido	VARCHAR(20)	NOT NULL,
	peco_s_nombre	VARCHAR(20)	,
	peco_s_apellido	VARCHAR(20)	,
	fk_cliente		INTEGER,
	fk_proveedor	INTEGER,

	CONSTRAINT pk_peco_cedula PRIMARY KEY (peco_cedula),
	CONSTRAINT fk_cliente FOREIGN KEY (fk_cliente) REFERENCES cliente (cl_id),
	CONSTRAINT fk_proveedor FOREIGN KEY (fk_proveedor) REFERENCES proveedor(po_id)
);


CREATE TABLE telefono(
	te_codigo			SERIAL,
	te_tipo				VARCHAR(20)	NOT NULL,
	te_numero			NUMERIC(10)	NOT NULL,
	fk_cliente			INTEGER,
	fk_empleado			INTEGER,
	fk_proveedor		INTEGER,
	fk_persona_contacto	INTEGER,


	CONSTRAINT pk_te_codigo PRIMARY KEY (te_codigo),
	CONSTRAINT ch_te_tipo CHECK (te_tipo IN ('CELULAR', 'OFICINA', 'CASA')),

	CONSTRAINT fk_cliente FOREIGN KEY (fk_cliente) REFERENCES cliente (cl_id),
	CONSTRAINT fk_empleado FOREIGN KEY (fk_empleado) REFERENCES empleado(em_cedula),
	CONSTRAINT fk_proveedor FOREIGN KEY (fk_proveedor) REFERENCES proveedor(po_id),
	CONSTRAINT fk_persona_contacto FOREIGN KEY (fk_persona_contacto) REFERENCES persona_contacto(peco_cedula)
);