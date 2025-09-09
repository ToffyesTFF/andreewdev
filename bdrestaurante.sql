-- 1) CREACIÓN DE TABLAS

CREATE TABLE ESTADO_CIVIL (
  id_estado_civil   NUMBER(5) PRIMARY KEY,
  nombre            VARCHAR2(50) NOT NULL,
  sigla             VARCHAR2(5),
  estado            NUMBER(1) DEFAULT 1
);

CREATE TABLE TIPO_DOCUMENTO (
  id_tipo_documento NUMBER(5) PRIMARY KEY,
  nombre            VARCHAR2(50) NOT NULL,
  sigla             VARCHAR2(5),
  estado            NUMBER(1) DEFAULT 1
);

CREATE TABLE GENERO (
  id_genero         NUMBER(5) PRIMARY KEY,
  nombre            VARCHAR2(50) NOT NULL,
  sigla             VARCHAR2(5),
  estado            NUMBER(1) DEFAULT 1
);

CREATE TABLE CATEGORIA (
  id_categoria      NUMBER(5) PRIMARY KEY,
  nombre            VARCHAR2(100) NOT NULL,
  estado            NUMBER(1) DEFAULT 1
);

CREATE TABLE ESTADO_MESA (
  id_estado_mesa    NUMBER(5) PRIMARY KEY,
  nombre            VARCHAR2(50) NOT NULL,
  estado            NUMBER(1) DEFAULT 1
);

CREATE TABLE METODO_PAGO (
  id_metodo_pago    NUMBER(5) PRIMARY KEY,
  nombre            VARCHAR2(50) NOT NULL,
  estado            NUMBER(1) DEFAULT 1
);

CREATE TABLE CARGO_EMPLEADO (
  id_cargo_empleado NUMBER(5) PRIMARY KEY,
  nombre            VARCHAR2(50) NOT NULL,
  estado            NUMBER(1) DEFAULT 1
);

CREATE TABLE TIPO_CLIENTE (
  id_tipo_cliente   NUMBER(5) PRIMARY KEY,
  nombre            VARCHAR2(50) NOT NULL,
  estado            NUMBER(1) DEFAULT 1
);

CREATE TABLE PERSONA (
  id_persona        NUMBER(10) PRIMARY KEY,
  id_estado_civil   NUMBER(5),
  id_genero         NUMBER(5),
  id_tipo_documento NUMBER(5),
  nombres           VARCHAR2(100) NOT NULL,
  apellidos         VARCHAR2(100) NOT NULL,
  celular           VARCHAR2(15),
  correo            VARCHAR2(100) UNIQUE
                     CHECK (correo LIKE '%@%.%'),
  direccion         VARCHAR2(250),
  fecha_nacimiento  DATE,
  numero_documento  NUMBER(15) UNIQUE NOT NULL,
  id_usuario_actualiza NUMBER(5),
  id_usuario_registra NUMBER(5),
  fecha_actualiza   DATE,
  fecha_registra    DATE,
  estado            NUMBER(1) DEFAULT 1,
  FOREIGN KEY (id_estado_civil)   REFERENCES ESTADO_CIVIL(id_estado_civil),
  FOREIGN KEY (id_genero)         REFERENCES GENERO(id_genero),
  FOREIGN KEY (id_tipo_documento) REFERENCES TIPO_DOCUMENTO(id_tipo_documento)
);

CREATE TABLE CLIENTE (
  id_cliente        NUMBER(10) PRIMARY KEY,
  id_persona        NUMBER(10),
  id_tipo_cliente   NUMBER(5),
  estado            NUMBER(1) DEFAULT 1,
  FOREIGN KEY (id_persona)      REFERENCES PERSONA(id_persona),
  FOREIGN KEY (id_tipo_cliente) REFERENCES TIPO_CLIENTE(id_tipo_cliente)
);

CREATE TABLE HORARIO (
  id_horario        NUMBER(5) PRIMARY KEY,
  hora_inicio       VARCHAR2(10) NOT NULL,
  hora_fin          VARCHAR2(10) NOT NULL,
  dias_semana       VARCHAR2(300),
  id_usuario_actualiza NUMBER(5),
  id_usuario_registra  NUMBER(5),
  fecha_actualiza   DATE,
  fecha_registra    DATE,
  estado            NUMBER(1) DEFAULT 1
);

CREATE TABLE EMPLEADO (
  id_empleado       NUMBER(10) PRIMARY KEY,
  id_cargo_empleado NUMBER(5),
  id_horario        NUMBER(5),
  id_persona        NUMBER(10),
  fecha_contrato    DATE,
  FOREIGN KEY (id_cargo_empleado) REFERENCES CARGO_EMPLEADO(id_cargo_empleado),
  FOREIGN KEY (id_horario)        REFERENCES HORARIO(id_horario),
  FOREIGN KEY (id_persona)        REFERENCES PERSONA(id_persona)
);

CREATE TABLE MESA (
  id_mesa           NUMBER(10) PRIMARY KEY,
  nombre            VARCHAR2(50),
  id_estado_mesa    NUMBER(5),
  capacidad         NUMBER(4),
  estado            NUMBER(1) DEFAULT 1,
  FOREIGN KEY (id_estado_mesa)   REFERENCES ESTADO_MESA(id_estado_mesa)
);

CREATE TABLE RESERVA (
  id_reserva        NUMBER(10) PRIMARY KEY,
  id_cliente        NUMBER(10),
  cantidad_personas NUMBER(5),
  estado_reserva    VARCHAR2(20),
  fecha_hora        DATE,
  FOREIGN KEY (id_cliente)       REFERENCES CLIENTE(id_cliente)
);

CREATE TABLE PROMOCION (
  id_promocion      NUMBER(10) PRIMARY KEY,
  nombre            VARCHAR2(100) NOT NULL,
  fecha_inicio      DATE,
  fecha_fin         DATE,
  descripcion       VARCHAR2(350),
  id_usuario_registra NUMBER(5),
  id_usuario_actualiza NUMBER(5),
  fecha_registro    DATE,
  fecha_actualiza   DATE,
  estado            NUMBER(1) DEFAULT 1
);

CREATE TABLE PRODUCTO (
  id_producto       NUMBER(10) PRIMARY KEY,
  id_categoria      NUMBER(5),
  nombre_producto   VARCHAR2(100) NOT NULL,
  descripcion       VARCHAR2(350) NOT NULL,
  precio            NUMBER(10,2),
  tiempo_preparacion VARCHAR2(20),
  fecha_actualiza   DATE,
  fecha_registro    DATE,
  id_usuario_actualiza NUMBER(5),
  id_usuario_registra  NUMBER(5),
  estado            NUMBER(1) DEFAULT 1,
  FOREIGN KEY (id_categoria)      REFERENCES CATEGORIA(id_categoria)
);

CREATE TABLE PEDIDO (
  id_pedido         NUMBER(10) PRIMARY KEY,
  id_cliente        NUMBER(10),
  id_empleado       NUMBER(10),
  id_mesa           NUMBER(10),
  id_metodo_pago    NUMBER(5),
  id_reserva        NUMBER(10),
  estado_pedido     VARCHAR2(20),
  total             NUMBER(10,2),
  fecha_hora        TIMESTAMP,
  fecha_registra    DATE,
  fecha_actualiza   DATE,
  id_usuario_registrado NUMBER(5),
  id_usuario_actualizado NUMBER(5),
  estado            NUMBER(1) DEFAULT 1,
  FOREIGN KEY (id_cliente)       REFERENCES CLIENTE(id_cliente),
  FOREIGN KEY (id_empleado)      REFERENCES EMPLEADO(id_empleado),
  FOREIGN KEY (id_mesa)          REFERENCES MESA(id_mesa),
  FOREIGN KEY (id_metodo_pago)   REFERENCES METODO_PAGO(id_metodo_pago),
  FOREIGN KEY (id_reserva)       REFERENCES RESERVA(id_reserva)
);

CREATE TABLE DETALLE_PEDIDO (
  id_detalle_pedido NUMBER(10) PRIMARY KEY,
  id_pedido         NUMBER(10),
  id_producto       NUMBER(10),
  cantidad          NUMBER(5),
  nota_especial     VARCHAR2(250),
  subtotal          NUMBER(10,2),
  estado            NUMBER(1) DEFAULT 1,
  FOREIGN KEY (id_pedido)        REFERENCES PEDIDO(id_pedido),
  FOREIGN KEY (id_producto)      REFERENCES PRODUCTO(id_producto)
);

CREATE TABLE PROMOCION_PRODUCTO (
  id_promocion      NUMBER(10),
  id_producto       NUMBER(10),
  PRIMARY KEY (id_promocion, id_producto),
  FOREIGN KEY (id_promocion)     REFERENCES PROMOCION(id_promocion),
  FOREIGN KEY (id_producto)      REFERENCES PRODUCTO(id_producto)
);


-- 2) CREACIÓN DE SECUENCIAS (después de las tablas)

CREATE SEQUENCE seq_persona   START WITH 11 INCREMENT BY 1;
CREATE SEQUENCE seq_cliente   START WITH 1  INCREMENT BY 1;
CREATE SEQUENCE seq_horario   START WITH 11 INCREMENT BY 1;
CREATE SEQUENCE seq_empleado  START WITH 1  INCREMENT BY 1;
CREATE SEQUENCE seq_mesa      START WITH 1  INCREMENT BY 1;
CREATE SEQUENCE seq_reserva   START WITH 1  INCREMENT BY 1;
CREATE SEQUENCE seq_promocion START WITH 1  INCREMENT BY 1;
CREATE SEQUENCE seq_producto  START WITH 1  INCREMENT BY 1;
CREATE SEQUENCE seq_pedido    START WITH 1  INCREMENT BY 1;


-- 3) DATOS DE CATÁLOGOS

INSERT INTO ESTADO_CIVIL VALUES (1,'Soltero','S',1);
INSERT INTO ESTADO_CIVIL VALUES (2,'Casado','C',1);
INSERT INTO ESTADO_CIVIL VALUES (3,'Divorciado','D',1);

INSERT INTO TIPO_DOCUMENTO VALUES (1,'DNI','DNI',1);
INSERT INTO TIPO_DOCUMENTO VALUES (2,'Carnet Extranjería','CE',1);
INSERT INTO TIPO_DOCUMENTO VALUES (3,'Pasaporte','P',1);

INSERT INTO GENERO VALUES (1,'Masculino','M',1);
INSERT INTO GENERO VALUES (2,'Femenino','F',1);
INSERT INTO GENERO VALUES (3,'Otro','O',1);

INSERT INTO CATEGORIA VALUES (1,'BEBIDAS',1);
INSERT INTO CATEGORIA VALUES (2,'COMIDA',1);
INSERT INTO CATEGORIA VALUES (3,'POSTRE',1);

INSERT INTO ESTADO_MESA VALUES (1,'DISPONIBLE',1);
INSERT INTO ESTADO_MESA VALUES (2,'OCUPADO',1);

INSERT INTO METODO_PAGO VALUES (1,'Efectivo',1);
INSERT INTO METODO_PAGO VALUES (2,'Tarjeta Crédito',1);
INSERT INTO METODO_PAGO VALUES (3,'Tarjeta Débito',1);

INSERT INTO CARGO_EMPLEADO VALUES (1,'MOSO',1);
INSERT INTO CARGO_EMPLEADO VALUES (2,'GERENTE',1);
INSERT INTO CARGO_EMPLEADO VALUES (3,'ADMINISTRADOR',1);

INSERT INTO TIPO_CLIENTE VALUES (1,'Nuevo',1);
INSERT INTO TIPO_CLIENTE VALUES (2,'Leal',1);
INSERT INTO TIPO_CLIENTE VALUES (3,'Casual',1);


-- 4) DATOS PRINCIPALES

-- 4.1 PERSONAS (10 registros predeterminados)
INSERT INTO PERSONA (
  id_persona,id_estado_civil,id_genero,id_tipo_documento,
  nombres,apellidos,celular,correo,direccion,
  fecha_nacimiento,numero_documento,
  id_usuario_actualiza,id_usuario_registra,fecha_actualiza,fecha_registra,estado
) VALUES (
  1,1,1,1,'Pedro','Pérez','999111222','pedro.perez@example.com','Calle A 123',
  TO_DATE('1980-01-15','YYYY-MM-DD'),12345678,1,1,SYSDATE,SYSDATE,1
);
INSERT INTO PERSONA VALUES (
  2,2,2,1,'María','Gómez','999222333','maria.gomez@example.com','Av. B 456',
  TO_DATE('1990-03-22','YYYY-MM-DD'),23456789,1,1,SYSDATE,SYSDATE,1
);
INSERT INTO PERSONA VALUES (
  3,1,1,1,'Luis','Sánchez','999333444','luis.sanchez@example.com','Jr. C 789',
  TO_DATE('1985-07-05','YYYY-MM-DD'),34567890,1,1,SYSDATE,SYSDATE,1
);
INSERT INTO PERSONA VALUES (
  4,3,2,2,'Ana','Torres','999444555','ana.torres@example.com','Pasaje D 101',
  TO_DATE('1978-11-30','YYYY-MM-DD'),45678901,1,1,SYSDATE,SYSDATE,1
);
INSERT INTO PERSONA VALUES (
  5,2,2,1,'Jorge','Flores','999555666','jorge.flores@example.com','Calle E 202',
  TO_DATE('1992-06-17','YYYY-MM-DD'),56789012,1,1,SYSDATE,SYSDATE,1
);
INSERT INTO PERSONA VALUES (
  6,1,2,3,'Elena','Rodríguez','999666777','elena.rodriguez@example.com','Av. F 303',
  TO_DATE('1983-12-08','YYYY-MM-DD'),67890123,1,1,SYSDATE,SYSDATE,1
);
INSERT INTO PERSONA VALUES (
  7,3,1,1,'Martín','Quiñones','999777888','martin.quinones@example.com','Jr. G 404',
  TO_DATE('1975-09-21','YYYY-MM-DD'),78901234,1,1,SYSDATE,SYSDATE,1
);
INSERT INTO PERSONA VALUES (
  8,2,2,2,'Carla','Mendoza','999888999','carla.mendoza@example.com','Pasaje H 505',
  TO_DATE('1988-02-11','YYYY-MM-DD'),89012345,1,1,SYSDATE,SYSDATE,1
);
INSERT INTO PERSONA VALUES (
  9,1,1,1,'Alberto','Díaz','999999000','alberto.diaz@example.com','Calle I 606',
  TO_DATE('1995-04-02','YYYY-MM-DD'),90123456,1,1,SYSDATE,SYSDATE,1
);
INSERT INTO PERSONA VALUES (
 10,3,2,3,'Patricia','Ortega','999000111','patricia.ortega@example.com','Av. J 707',
  TO_DATE('1991-08-29','YYYY-MM-DD'),12345098,1,1,SYSDATE,SYSDATE,1
);

-- 4.2 CLIENTES (uno por persona)
BEGIN
  FOR i IN 1..10 LOOP
    INSERT INTO CLIENTE(id_cliente,id_persona,id_tipo_cliente)
    VALUES(seq_cliente.NEXTVAL, i, MOD(i,3)+1);
  END LOOP;
END;
/

-- 4.3 HORARIOS (10 franjas)
INSERT INTO HORARIO VALUES(1,'08:00','10:00','L,M,X,J,V',1,1,SYSDATE,SYSDATE,1);
INSERT INTO HORARIO VALUES(2,'10:00','12:00','L,M,X,J,V',1,1,SYSDATE,SYSDATE,1);
INSERT INTO HORARIO VALUES(3,'12:00','14:00','L,M,X,J,V',1,1,SYSDATE,SYSDATE,1);
INSERT INTO HORARIO VALUES(4,'14:00','16:00','L,M,X,J,V',1,1,SYSDATE,SYSDATE,1);
INSERT INTO HORARIO VALUES(5,'16:00','18:00','L,M,X,J,V',1,1,SYSDATE,SYSDATE,1);
INSERT INTO HORARIO VALUES(6,'18:00','20:00','L,M,X,J,V',1,1,SYSDATE,SYSDATE,1);
INSERT INTO HORARIO VALUES(7,'20:00','22:00','L,M,X,J,V',1,1,SYSDATE,SYSDATE,1);
INSERT INTO HORARIO VALUES(8,'22:00','00:00','L,M,X,J,V',1,1,SYSDATE,SYSDATE,1);
INSERT INTO HORARIO VALUES(9,'07:00','09:00','S,D',  1,1,SYSDATE,SYSDATE,1);
INSERT INTO HORARIO VALUES(10,'09:00','11:00','S,D', 1,1,SYSDATE,SYSDATE,1);

-- 4.4 EMPLEADOS (10)
BEGIN
  FOR i IN 1..10 LOOP
    INSERT INTO EMPLEADO(
      id_empleado,id_cargo_empleado,id_horario,id_persona,fecha_contrato
    ) VALUES (
      seq_empleado.NEXTVAL,
      MOD(i,3)+1,
      MOD(i,10)+1,
      i,
      ADD_MONTHS(SYSDATE,-12+i)
    );
  END LOOP;
END;
/

-- 4.5 MESAS (10)
BEGIN
  FOR i IN 1..10 LOOP
    INSERT INTO MESA(
      id_mesa,nombre,id_estado_mesa,capacidad
    ) VALUES (
      seq_mesa.NEXTVAL,
      'Mesa '||i,
      CASE WHEN MOD(i,2)=0 THEN 2 ELSE 1 END,
      CASE WHEN MOD(i,4)=0 THEN 2 ELSE 4 END
    );
  END LOOP;
END;
/

-- 1) REPORTE DE PEDIDOS
CREATE OR REPLACE VIEW vw_reporte_pedidos AS
SELECT
  per.nombres || ' ' || per.apellidos AS nombre_completo_cliente,
  pe.fecha_hora                           AS fecha_pedido,
  pe.estado_pedido,
  pe.total,
  dp.cantidad,
  pr.nombre_producto,
  dp.subtotal,
  mp.nombre                              AS nombre_metodo_pago,
  ca.nombre                              AS nombre_categoria
FROM PEDIDO pe
JOIN CLIENTE cl   ON pe.id_cliente     = cl.id_cliente
JOIN PERSONA per  ON cl.id_persona     = per.id_persona
JOIN DETALLE_PEDIDO dp ON pe.id_pedido = dp.id_pedido
JOIN PRODUCTO pr  ON dp.id_producto    = pr.id_producto
JOIN METODO_PAGO mp ON pe.id_metodo_pago = mp.id_metodo_pago
JOIN CATEGORIA ca ON pr.id_categoria   = ca.id_categoria
WHERE pe.estado = 1;


-- 2) REPORTE DE RESERVAS
CREATE OR REPLACE VIEW vw_reporte_reservas AS
SELECT
  per.nombres || ' ' || per.apellidos      AS nombre_completo_cliente,
  NVL(per.celular, 'SIN CELULAR')          AS celular_cliente,
  per.direccion,
  tc.nombre                                AS tipo_cliente,
  re.fecha_hora                            AS fecha_reserva,
  re.estado_reserva,
  re.cantidad_personas                     AS cantidad_persona,
  me.nombre                                AS nombre_mesa,
  em.nombre                                AS estado_mesa
FROM RESERVA re
JOIN CLIENTE cl     ON re.id_cliente      = cl.id_cliente
JOIN PERSONA per    ON cl.id_persona      = per.id_persona
JOIN TIPO_CLIENTE tc ON cl.id_tipo_cliente = tc.id_tipo_cliente
JOIN RESERVA_MESA rm ON re.id_reserva      = rm.id_reserva
JOIN MESA me        ON rm.id_mesa          = me.id_mesa
JOIN ESTADO_MESA em ON me.id_estado_mesa   = em.id_estado_mesa
WHERE re.estado_reserva IS NOT NULL;


-- 3) REPORTE DE EMPLEADOS
CREATE OR REPLACE VIEW vw_reporte_empleados AS
SELECT
  per.nombres                               AS nombre,
  per.apellidos                             AS apellidos,
  NVL(per.celular, 'SIN CELULAR')           AS celular,
  per.correo,
  EXTRACT(YEAR FROM SYSDATE) 
   - EXTRACT(YEAR FROM per.fecha_nacimiento) AS edad,
  g.nombre                                  AS nombre_genero,
  ec.nombre                                 AS nombre_estado_civil,
  e.fecha_contrato,
  ce.nombre                                 AS cargo,
  h.hora_inicio,
  h.hora_fin
FROM EMPLEADO e
JOIN PERSONA per        ON e.id_persona        = per.id_persona
JOIN GENERO g           ON per.id_genero       = g.id_genero
JOIN ESTADO_CIVIL ec    ON per.id_estado_civil = ec.id_estado_civil
JOIN CARGO_EMPLEADO ce  ON e.id_cargo_empleado = ce.id_cargo_empleado
JOIN HORARIO h          ON e.id_horario        = h.id_horario
WHERE e.estado = 1;


-- 4) REPORTE DE CLIENTES
CREATE OR REPLACE VIEW vw_reporte_clientes AS
SELECT
  per.nombres                               AS nombre,
  per.apellidos                             AS apellidos,
  NVL(per.celular, 'SIN CELULAR')           AS celular,
  per.correo,
  EXTRACT(YEAR FROM SYSDATE) 
   - EXTRACT(YEAR FROM per.fecha_nacimiento) AS edad,
  per.direccion,
  g.nombre                                  AS nombre_genero,
  ec.nombre                                 AS nombre_estado_civil,
  td.nombre                                 AS nombre_tipo_documento,
  cl.estado                                 AS estado_cliente,
  tc.nombre                                 AS tipo_cliente
FROM CLIENTE cl
JOIN PERSONA per        ON cl.id_persona       = per.id_persona
JOIN GENERO g           ON per.id_genero       = g.id_genero
JOIN ESTADO_CIVIL ec    ON per.id_estado_civil = ec.id_estado_civil
JOIN TIPO_DOCUMENTO td  ON per.id_tipo_documento = td.id_tipo_documento
JOIN TIPO_CLIENTE tc    ON cl.id_tipo_cliente  = tc.id_tipo_cliente
WHERE cl.estado = 1;

