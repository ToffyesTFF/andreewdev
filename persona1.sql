CREATE TABLE ESTADO_CIVIL (
id_estado_civil   NUMBER(38),
nombre            VARCHAR2(30),
estado            NUMBER(1),
sigla             VARCHAR2(5),

CONSTRAINT pk_estado_civil
PRIMARY KEY (id_estado_civil)
);

CREATE TABLE TIPO_DOCUMENTO (
id_tipo_documento NUMBER(38),
nombre            VARCHAR2(50),
estado            NUMBER(1),
sigla             VARCHAR2(10),

CONSTRAINT pk_tipo_documento
PRIMARY KEY (id_tipo_documento)
);

CREATE TABLE GENERO (
id_genero         NUMBER(38),
nombre            VARCHAR2(50),
estado            NUMBER(1),
sigla             VARCHAR2(10),
CONSTRAINT pk_genero
PRIMARY KEY (id_genero)
);

CREATE TABLE PERSONA (
id_persona           NUMBER(38),
id_estado_civil      NUMBER(38),
id_tipo_documento    NUMBER(38),
id_genero            NUMBER(38),
nombres              VARCHAR2(200) NOT NULL,
apellidos            VARCHAR2(200) NOT NULL,
fecha_nacimiento     DATE,
numero_documento     NUMBER(15)    NOT NULL UNIQUE,
celular              VARCHAR2(15),
correo               VARCHAR2(200) UNIQUE,
direccion            VARCHAR2(250),
estado               NUMBER(1)     DEFAULT 1,
id_usuario_registra  NUMBER(38),
id_usuario_actualiza NUMBER(38),
fecha_registra       DATE,
fecha_actualiza      DATE,
CONSTRAINT pk_persona
PRIMARY KEY (id_persona),

CONSTRAINT fk_estado_civil_persona
FOREIGN KEY (id_estado_civil) REFERENCES ESTADO_CIVIL (id_estado_civil),

CONSTRAINT fk_tipo_documento_persona
FOREIGN KEY (id_tipo_documento) REFERENCES TIPO_DOCUMENTO (id_tipo_documento),

CONSTRAINT fk_genero_persona
FOREIGN KEY (id_genero) REFERENCES GENERO (id_genero),

CONSTRAINT ck_correo
CHECK (correo LIKE '%@%.%')
);

CREATE SEQUENCE persona_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;


CREATE OR REPLACE TRIGGER persona_bir
BEFORE INSERT ON PERSONA
FOR EACH ROW
BEGIN
IF :NEW.id_persona IS NULL THEN
SELECT persona_seq.NEXTVAL
INTO :NEW.id_persona
FROM dual;
END IF;
END;
/



-----------------INSERTANDO DATOS Y COLUMNAS
--Insertando dato en genero
--ANDRER CONTRERAS
INSERT INTO genero (id_genero, nombre, estado, sigla) VALUES (1, 'Masculino', '1', 'M');
INSERT INTO genero (id_genero, nombre, estado, sigla) VALUES (2, 'Femenino',  '1', 'F');
INSERT INTO genero (id_genero, nombre, estado, sigla) VALUES (3, 'Otro',      '1', 'O');


--Insertando dato en estado_civil
--ANDRER CONTRERAS
INSERT INTO estado_civil (id_estado_civil, nombre, estado, sigla) VALUES (1, 'Soltero',   '1', 'S');
INSERT INTO estado_civil (id_estado_civil, nombre, estado, sigla) VALUES (2, 'Casado',    '1', 'C');
INSERT INTO estado_civil (id_estado_civil, nombre, estado, sigla) VALUES (3, 'Divorciado','1', 'D');
INSERT INTO estado_civil (id_estado_civil, nombre, estado, sigla) VALUES (4, 'Viudo',     '1', 'V');

--Insertando dato en tipo_documento
--ANDRER CONTRERAS
INSERT INTO tipo_documento (id_tipo_documento, nombre, sigla, estado) VALUES (1, 'Documento Nacional de Identidad',       'DNI', '1');
INSERT INTO tipo_documento (id_tipo_documento, nombre, sigla, estado) VALUES (2, 'Carnet de Extranjeria',        'CE',  '1');
INSERT INTO tipo_documento (id_tipo_documento, nombre, sigla, estado) VALUES (3, 'Pasaporte', 'PAS', '1');


-- 1
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (1, 'JUAN', 'PÉREZ RAMOS', TO_DATE('1990-02-15','YYYY-MM-DD'), 1, 1, 1, 74561234, '987654321', 'juan.perez@mail.com', '1', 'Av. Lima 123', 101, NULL, SYSDATE-30, NULL);

-- 2
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (2, 'ANA', 'GÓMEZ LÓPEZ', TO_DATE('1995-11-03','YYYY-MM-DD'), 2, 2, 1, 81234567, '987111222', 'ana.gomez@mail.com', '1', 'Jr. Los Olivos 456', 102, 105, SYSDATE-25, SYSDATE-5);

-- 3
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (3, 'CARLOS', 'RUIZ MORALES', TO_DATE('1988-07-20','YYYY-MM-DD'), 1, 2, 2, 99887766, '944333444', 'carlos.ruiz@corp.com', '1', 'Calle 7 Mz A Lt 8', 101, NULL, SYSDATE-40, NULL);

-- 4
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (4, 'LUCÍA', 'CASTRO VARGAS', TO_DATE('2000-01-10','YYYY-MM-DD'), 2, 1, 1, 66554433, NULL, 'lucia.castro@mail.com', '1', 'Av. Principal 999', 103, 106, SYSDATE-12, SYSDATE-2);

-- 5
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (5, 'PEDRO', 'SALAZAR DÍAZ', TO_DATE('1975-05-05','YYYY-MM-DD'), 1, 2, 3, 12345001, '955666777', 'pedro.salazar@demo.com', '0', 'Psj. Central 12', 101, 101, SYSDATE-300, SYSDATE-200);

-- 6
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (6, 'MARÍA', 'ROJAS QUISPE', TO_DATE('1992-09-18','YYYY-MM-DD'), 2, 1, 1, 12345002, '900111222', 'maria.rojas@mail.com', '1', 'Urb. Jardines B-21', 104, NULL, SYSDATE-15, NULL);

-- 7
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (7, 'DANIEL', 'FLORES MENDOZA', TO_DATE('1985-03-30','YYYY-MM-DD'), 1, 3, 2, 12345003, NULL, 'daniel.flores@mail.com', '1', 'Av. Arequipa 1500', 101, 104, SYSDATE-120, SYSDATE-1);

-- 8
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (8, 'SOFÍA', 'SÁNCHEZ RIVERA', TO_DATE('1998-12-12','YYYY-MM-DD'), 2, 1, 1, 12345004, '933222111', 'sofia.sanchez@mail.com', '1', 'Jr. Colmena 321', 102, NULL, SYSDATE-7, NULL);

-- 9
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (9, 'MARIO', 'CAMPOS TORRES', TO_DATE('1991-06-21','YYYY-MM-DD'), 1, 2, 1, 12345005, '988777666', NULL, '1', 'Av. Grau 456', 103, NULL, SYSDATE-60, NULL);

-- 10
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (10, 'ELENA', 'HERRERA ARIAS', TO_DATE('1983-08-09','YYYY-MM-DD'), 2, 2, 3, 12345006, '922333444', 'elena.herrera@corp.com', '0', 'Mz J Lote 3', 104, 104, SYSDATE-500, SYSDATE-300);

-- 11
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (11, 'JORGE', 'VALDEZ IBARRA', TO_DATE('1997-04-14','YYYY-MM-DD'), 1, 1, 1, 12345007, '955888999', 'jorge.valdez@mail.com', '1', 'Av. Universitaria 760', 101, NULL, SYSDATE-10, NULL);

-- 12
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (12, 'KARLA', 'MEJÍA CÁCERES', TO_DATE('1993-10-25','YYYY-MM-DD'), 2, 3, 2, 12345008, NULL, 'karla.mejia@mail.com', '1', 'Calle Lima 12', 105, 106, SYSDATE-200, SYSDATE-20);

-- 13
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (13, 'RAÚL', 'NAVARRO POMA', TO_DATE('1989-02-02','YYYY-MM-DD'), 1, 1, 1, 12345009, '911222333', 'raul.navarro@mail.com', '1', 'Urb. Sol de Oro C-5', 101, 101, SYSDATE-5, SYSDATE-3);

-- 14
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (14, 'NATALIA', 'DURÁN VELÁSQUEZ', TO_DATE('1996-07-07','YYYY-MM-DD'), 2, 1, 1, 12345010, '900555444', 'natalia.duran@mail.com', '1', 'Av. Brasil 999', 102, NULL, SYSDATE-90, NULL);

-- 15
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (15, 'IVÁN', 'PALACIOS QUIROZ', TO_DATE('1980-11-11','YYYY-MM-DD'), 1, 4, 3, 12345011, '988000111', 'ivan.palacios@empresa.pe', '0', 'Calle 3 #120', 104, 105, SYSDATE-800, SYSDATE-600);

-- 16
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (16, 'PAOLA', 'ORTEGA SOTO', TO_DATE('2001-03-19','YYYY-MM-DD'), 2, 1, 2, 12345012, '977333222', 'paola.ortega@mail.com', '1', 'Jr. Puno 456', 103, NULL, SYSDATE-2, NULL);

-- 17
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (17, 'GABRIEL', 'VEGA ROSALES', TO_DATE('1994-01-28','YYYY-MM-DD'), 1, 2, 1, 12345013, NULL, 'gabriel.vega@mail.com', '1', 'Callejón 8 s/n', 101, NULL, SYSDATE-45, NULL);

-- 18
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (18, 'DIANA', 'ALVARADO LOAYZA', TO_DATE('1987-05-16','YYYY-MM-DD'), 2, 2, 1, 12345014, '966111000', 'diana.alvarado@mail.com', '1', 'Av. Los Incas 444', 105, 105, SYSDATE-365, SYSDATE-100);

-- 19
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (19, 'OSCAR', 'MARTÍNEZ LUNA', TO_DATE('1999-09-09','YYYY-MM-DD'), 1, 1, 2, 12345015, '955444333', 'oscar.martinez@mail.com', '1', 'Psj. Primavera 7', 102, NULL, SYSDATE-18, NULL);

-- 20
INSERT INTO persona (id_persona, nombres, apellidos, fecha_nacimiento, id_genero, id_estado_civil, id_tipo_documento, numero_documento, celular, correo, estado, direccion, id_usuario_registra, id_usuario_actualiza, fecha_registra, fecha_actualiza)
VALUES (20, 'FLOR', 'PAREDES HUAMÁN', TO_DATE('1986-06-30','YYYY-MM-DD'), 2, 3, 1, 12345016, '922888777', 'flor.paredes@mail.com', '0', 'Av. Central 1200', 104, 106, SYSDATE-700, SYSDATE-500);

COMMIT;

--------FUNCIONES

SELECT p.NOMBRES , p.APELLIDOS FROM PERSONA p;

--INITCAP -> La primera letra de cada palabra en mayuscula
--UPPER -> Palabras en mayusculas
--UPPER -> Palabras en minusculas
--ANDREE CONTRERAS
SELECT INITCAP(p.NOMBRES) , UPPER(p.NOMBRES), LOWER(p.APELLIDOS) FROM PERSONA p;

--SUBTR -> Corta cadenas string. EL Primer numero indica el numero desde q contara, 
--el segundo cuantas letras mostrara a partir de ese num
--ANDREE CONTRERAS
SELECT SUBSTR(NOMBRES,2,3) FROM PERSONA;

--LENGTH -> Cuenta la cantidad de caracteres
--ANDREE CONTRERAS
SELECT correo, LENGTH(correo) AS cantidad_caracteres FROM PERSONA;

--CONCAT -> Concatenar cadenas
--ANDREE CONTRERAS
SELECT NOMBRES ||' '|| APELLIDOS AS nombres_apellidos FROM PERSONA;
SELECT CONCAT(NOMBRES, CONCAT(' ', APELLIDOS)) AS nombres_apellidos2 FROM PERSONA;

--FUNCIONES ARITMETICAS
--ANDREE CONTRERAS
SELECT (2+2), (2-3), (2*2), (8/2) FROM DUAL;

--EDAD --> EXTRACT mes y año actuales
--ANDREE CONTRERAS
SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM FECHA_NACIMIENTO) FROM PERSONA;
SELECT EXTRACT(MONTH FROM SYSDATE) FROM DUAL;
SELECT EXTRACT(DAY FROM SYSDATE) FROM DUAL;

--TO_CHAR-> convertir fechas a string con diferente formato
--ANDREE CONTRERAS
SELECT TO_CHAR(FECHA_NACIMIENTO, 'DD-MM-YYYY') FROM PERSONA;
SELECT TO_DATE('15-02-1990', 'DD-MM-YYYY') AS FECHA_CONVERTIDA FROM DUAL;

--COUNT -> Contar la cantidad de inserts o datos
--ANDREE CONTRERAS
SELECT count(*) FROM PERSONA ;

--HAVING -> extrae datos bajo una condicion
--ANDREE CONTRERAS
SELECT NOMBRES,
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM FECHA_NACIMIENTO) AS EDAD FROM PERSONA
GROUP BY NOMBRES, FECHA_NACIMIENTO
HAVING EXTRACT(YEAR FROM SYSDATE) -
EXTRACT(YEAR FROM FECHA_NACIMIENTO ) > 29;

--NVL() REEMPLAZAR VALORES NULOS
--ANDREE CONTRERAS
SELECT NVL(p.CELULAR, 'celular no registrado'), NVL(p.CORREO, 'correo no registrado') FROM PERSONA p;

--ORDENAR alfabeticamente ASC;DESC
--ANDREE CONTRERAS
SELECT NOMBRES, APELLIDOS, CORREO, CELULAR FROM persona ORDER BY NOMBRES ASC;

--GROUP BY y la subconsulta para TIPO_DOCUMENTO
--ANDREE CONTRERAS
SELECT COUNT(*) AS CANTIDAD,
(
	SELECT td.NOMBRE
	FROM TIPO_DOCUMENTO td
	WHERE td.ID_TIPO_DOCUMENTO = p.ID_TIPO_DOCUMENTO
) AS TIPO_DE_DOCUMENTO
FROM PERSONA p
GROUP BY p.ID_TIPO_DOCUMENTO
;
