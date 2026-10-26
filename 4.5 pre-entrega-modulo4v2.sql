--pre-entrega-modulo4.sql

-- ---------------------------------------------------------------------
-- 1. ESTRUCTURA
-- ---------------------------------------------------------------------
 
CREATE TABLE categorias (
    id_categoria  SERIAL PRIMARY KEY,
    nombre        VARCHAR(50) NOT NULL UNIQUE
);
 
CREATE TABLE productos (
    id_producto   SERIAL PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL,
    id_categoria  INT NOT NULL REFERENCES categorias(id_categoria),
    precio        NUMERIC(10,2) NOT NULL CHECK (precio > 0)
);
 
CREATE TABLE clientes (
    id_cliente     SERIAL PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    email          VARCHAR(100),          -- puede ser NULL (dato incompleto)
    telefono       VARCHAR(20),           -- puede ser NULL
    ciudad         VARCHAR(50),           -- puede ser NULL
    fecha_registro DATE NOT NULL DEFAULT CURRENT_DATE
);
 
CREATE TABLE ventas (
    id_venta        SERIAL PRIMARY KEY,
    id_cliente      INT NOT NULL REFERENCES clientes(id_cliente),
    id_producto     INT NOT NULL REFERENCES productos(id_producto),
    cantidad        INT NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(10,2) NOT NULL,  -- precio al momento de la venta
    fecha_venta     DATE NOT NULL
);
 
 
-- ---------------------------------------------------------------------
-- 2. DATOS
-- ---------------------------------------------------------------------
 
INSERT INTO categorias (nombre) VALUES
('Electrónica'),   -- 1: pocas unidades, pero ingreso muy alto
('Indumentaria'),  -- 2: muchas unidades, ingreso medio
('Hogar'),         -- 3: ingreso medio
('Librería'),      -- 4: muchas unidades, ingreso bajo
('Deportes');      -- 5: casi sin ventas
 
INSERT INTO productos (nombre, id_categoria, precio) VALUES
('Notebook 14"',         1, 850000.00),  -- 1
('Auriculares Bluetooth',1,  45000.00),  -- 2
('Mouse inalámbrico',    1,  18000.00),  -- 3
('Remera algodón',       2,  15000.00),  -- 4
('Jean clásico',         2,  42000.00),  -- 5
('Campera rompeviento',  2,  68000.00),  -- 6
('Juego de sábanas',     3,  38000.00),  -- 7
('Cafetera de filtro',   3,  55000.00),  -- 8
('Set de ollas',         3,  95000.00),  -- 9
('Cuaderno universitario',4,  4500.00),  -- 10
('Pack de lapiceras',    4,   3200.00),  -- 11
('Agenda 2026',          4,  12000.00),  -- 12
('Pelota de fútbol',     5,  28000.00),  -- 13
('Mat de yoga',          5,  22000.00);  -- 14
 
INSERT INTO clientes (nombre, email, telefono, ciudad, fecha_registro) VALUES
('Lucía Fernández',  'lucia.fernandez@mail.com', '11-4523-8890', 'Buenos Aires', '2025-01-15'),  -- 1
('Martín Gómez',     'martin.gomez@mail.com',    '351-422-1188', 'Córdoba',      '2025-02-03'),  -- 2
('Sofía Rodríguez',  'sofia.rodriguez@mail.com', NULL,           'Rosario',      '2025-03-10'),  -- 3
('Juan Pérez',       NULL,                       '11-3344-5566', 'Buenos Aires', '2025-03-22'),  -- 4
('Valentina López',  'vale.lopez@mail.com',      '261-455-7788', 'Mendoza',      '2025-04-05'),  -- 5
('Diego Martínez',   'diego.martinez@mail.com',  NULL,           NULL,           '2025-05-18'),  -- 6
('Camila Sánchez',   'camila.sanchez@mail.com',  '11-6677-1122', 'La Plata',     '2025-06-30'),  -- 7
('Tomás Díaz',       NULL,                       NULL,           'Córdoba',      '2025-08-12'),  -- 8
-- Clientes registrados que NUNCA compraron (para la consulta del punto 5)
('Agustina Romero',  'agus.romero@mail.com',     NULL,           'Salta',        '2025-09-01'),  -- 9
('Nicolás Álvarez',  NULL,                       '11-2299-4455', NULL,           '2025-10-20'),  -- 10
('Florencia Torres', 'flor.torres@mail.com',     '341-488-3300', 'Rosario',      '2026-02-14'),  -- 11
('Bruno Acosta',     NULL,                       NULL,           NULL,           '2026-05-08');  -- 12
 
INSERT INTO ventas (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES
-- Lucía: compra Remeras varias veces (producto favorito claro)
(1,  4, 3,  15000.00, '2025-11-05'),
(1,  4, 2,  15000.00, '2026-01-18'),
(1,  4, 4,  15000.00, '2026-04-22'),
(1,  1, 1, 850000.00, '2026-03-10'),
(1, 10, 5,   4500.00, '2026-07-02'),
-- Martín: fan de la electrónica, compra Auriculares repetidas veces
(2,  2, 1,  45000.00, '2025-12-01'),
(2,  2, 2,  45000.00, '2026-02-15'),
(2,  2, 1,  45000.00, '2026-06-30'),
(2,  3, 2,  18000.00, '2026-06-30'),
(2,  1, 1, 850000.00, '2026-08-14'),
-- Sofía: compra artículos de librería
(3, 10, 10,  4500.00, '2026-02-25'),
(3, 10, 8,   4500.00, '2026-03-12'),
(3, 11, 6,   3200.00, '2026-03-12'),
(3, 12, 2,  12000.00, '2026-09-03'),
-- Juan: hogar
(4,  8, 1,  55000.00, '2025-10-11'),
(4,  7, 2,  38000.00, '2026-01-09'),
(4,  7, 1,  38000.00, '2026-05-27'),
(4,  9, 1,  95000.00, '2026-05-27'),
-- Valentina: indumentaria
(5,  5, 2,  42000.00, '2026-03-03'),
(5,  5, 1,  42000.00, '2026-06-19'),
(5,  6, 1,  68000.00, '2026-07-25'),
(5,  4, 3,  15000.00, '2026-07-25'),
(5,  5, 1,  42000.00, '2026-10-02'),
-- Diego: una notebook y accesorios
(6,  1, 1, 850000.00, '2026-04-04'),
(6,  3, 1,  18000.00, '2026-04-04'),
(6,  3, 1,  18000.00, '2026-08-21'),
-- Camila: mezcla de categorías
(7, 13, 1,  28000.00, '2026-05-14'),
(7,  9, 1,  95000.00, '2026-06-01'),
(7,  8, 1,  55000.00, '2026-09-17'),
(7,  8, 1,  55000.00, '2026-10-12'),
-- Tomás: compra lapiceras seguido
(8, 11, 4,   3200.00, '2026-01-20'),
(8, 11, 5,   3200.00, '2026-04-11'),
(8, 11, 3,   3200.00, '2026-08-30'),
(8, 14, 1,  22000.00, '2026-09-30');

-- =====================================================================
-- pre-entrega-modulo4.sql
-- Pre-entrega Módulo 4 - Consultas de análisis de ventas
-- Motor: PostgreSQL
-- Tablas utilizadas: categorias, productos, clientes, ventas
-- =====================================================================


-- =====================================================================
-- CONSULTA 1: RENTABILIDAD POR CATEGORÍA
-- ---------------------------------------------------------------------
-- Problema de negocio:
--   La empresa necesita saber qué categorías generan la mayor parte
--   de sus ingresos para decidir dónde invertir en stock, publicidad
--   y espacio de exhibición. También sirve para detectar categorías
--   que venden mucho en unidades pero aportan poco dinero (por ejemplo,
--   productos baratos de alta rotación).
--
-- Umbral definido en $400.000 porque es el ingreso mínimo que
-- consideramos necesario para que una categoría justifique su costo
-- de mantenimiento (stock inmovilizado, espacio y promoción). Las
-- categorías por debajo de ese valor quedan fuera del reporte y
-- deberían revisarse por separado (¿promocionarlas o discontinuarlas?).
--
-- Cómo lo resuelve:
--   - Une ventas -> productos -> categorias para saber a qué categoría
--     pertenece cada venta.
--   - Agrupa por categoría y suma unidades e ingresos.
--   - El ingreso se calcula con el precio_unitario guardado en la venta
--     (precio real cobrado), no con el precio actual del producto.
--   - HAVING filtra sobre el total ya agrupado (no se puede con WHERE).
-- =====================================================================

SELECT
    c.nombre                              AS categoria,
    SUM(v.cantidad)                       AS unidades_vendidas,
    SUM(v.cantidad * v.precio_unitario)   AS ingreso_total
FROM ventas v
INNER JOIN productos  p ON v.id_producto  = p.id_producto
INNER JOIN categorias c ON p.id_categoria = c.id_categoria
GROUP BY c.nombre
HAVING SUM(v.cantidad * v.precio_unitario) > 400000
ORDER BY ingreso_total DESC;


-- =====================================================================
-- CONSULTA 2: CLIENTES SIN COMPRAS
-- ---------------------------------------------------------------------
-- Problema de negocio:
--   Hay clientes que se registraron pero nunca concretaron una compra.
--   Identificarlos permite al área de marketing armar una campaña de
--   reactivación (por ejemplo, un cupón de primera compra). Para eso
--   se necesitan sus datos de contacto, y como algunos están
--   incompletos, se reemplazan los vacíos por un texto claro para que
--   el equipo sepa qué canal de contacto tiene disponible.
--
-- Cómo lo resuelve:
--   - LEFT JOIN trae a TODOS los clientes, tengan o no ventas.
--   - Los clientes sin ventas quedan con las columnas de "ventas" en
--     NULL, y el WHERE ... IS NULL se queda solo con ellos.
--   - COALESCE reemplaza los datos de contacto faltantes (NULL) por un
--     texto descriptivo.
-- =====================================================================

SELECT
    c.nombre                                       AS cliente,
    COALESCE(c.email,    'Sin email')              AS email,
    COALESCE(c.telefono, 'Sin teléfono')           AS telefono,
    COALESCE(c.ciudad,   'Ciudad no informada')    AS ciudad
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL
ORDER BY c.nombre;


-- =====================================================================
-- CONSULTA 3: TOP DE COMPRAS POR CLIENTE
-- ---------------------------------------------------------------------
-- Problema de negocio:
--   Identificar el producto favorito de cada cliente (el que compró
--   más veces) y cuándo lo compró por última vez. Sirve para:
--     - Ofrecer promociones personalizadas sobre lo que ya le interesa.
--     - Detectar clientes que hace tiempo no vuelven, antes de perderlos.
--     - Asegurar stock de los productos que más clientes eligen.
--   Se cuentan las VECES que compró (no las unidades) porque lo que
--   interesa es el hábito: volver varias veces por lo mismo indica
--   preferencia, mientras que una compra grande puede ser puntual.
--
-- Cómo lo resuelve:
--   - Une clientes, ventas y productos para tener los nombres.
--   - Agrupa por cliente y producto: COUNT(*) cuenta cuántas veces lo
--     compró y MAX(fecha_venta) da la fecha de la última compra.
--   - La subconsulta del HAVING calcula, para cada cliente, la mayor
--     cantidad de veces que compró un mismo producto. El HAVING deja
--     solo el producto que alcanza ese número: su favorito.
--   - Si hay empate, se muestran ambos productos.
-- =====================================================================

SELECT
    c.nombre           AS cliente,
    p.nombre           AS producto,
    COUNT(*)           AS veces_comprado,
    MAX(v.fecha_venta) AS ultima_compra
FROM clientes c
INNER JOIN ventas    v ON c.id_cliente  = v.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
GROUP BY c.id_cliente, c.nombre, p.nombre
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM ventas v2
    WHERE v2.id_cliente = c.id_cliente
    GROUP BY v2.id_producto
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY c.nombre;

--
