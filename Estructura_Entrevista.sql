/*CREATE TABLE Cliente (
    id_cliente VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100),
    telefono VARCHAR(20),
    ciudad VARCHAR(50)
);

CREATE TABLE Venta (
    id_venta VARCHAR(10) PRIMARY KEY,
    id_cliente VARCHAR(10) NOT NULL,
    fecha_venta DATE NOT NULL,
    total DECIMAL(10,2),
    impuesto DECIMAL(10,2),
    descuento DECIMAL(10,2),
    total_final DECIMAL(10,2),

    CONSTRAINT FK_Venta_Cliente
        FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
);

CREATE TABLE Categoria (
    id_categoria INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(250),
    activo BIT NOT NULL
);

CREATE TABLE Producto (
    id_producto VARCHAR(10) PRIMARY KEY,
    id_categoria INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(250),
    precio_venta DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    activo BIT NOT NULL,

    CONSTRAINT FK_Producto_Categoria
        FOREIGN KEY (id_categoria)
        REFERENCES Categoria(id_categoria)
);

CREATE TABLE Detalle_Venta (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_venta VARCHAR(10) NOT NULL,
    id_producto VARCHAR(10) NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    descuento DECIMAL(10,2),
    subtotal DECIMAL(10,2),

    CONSTRAINT FK_DetalleVenta_Venta
        FOREIGN KEY (id_venta)
        REFERENCES Venta(id_venta),

    CONSTRAINT FK_DetalleVenta_Producto
        FOREIGN KEY (id_producto)
        REFERENCES Producto(id_producto)
);

CREATE TABLE Pago (
    id_pago VARCHAR(10) PRIMARY KEY,
    id_venta VARCHAR(10) NOT NULL,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(30) NOT NULL,
    estado VARCHAR(20) NOT NULL,

    CONSTRAINT FK_Pago_Venta
        FOREIGN KEY (id_venta)
        REFERENCES Venta(id_venta)
);

INSERT INTO Categoria VALUES
(1,'Computadoras','Equipos de cómputo',1),
(2,'Periféricos','Accesorios para computadora',1),
(3,'Almacenamiento','Dispositivos de almacenamiento',1),
(4,'Impresión','Equipos de impresión',1);

INSERT INTO Cliente VALUES
('C001','Juan Pérez','juan@gmail.com','5511111111','CDMX'),
('C002','Ana López','ana@gmail.com','5522222222','Guadalajara'),
('C003','Carlos Ruiz','carlos@gmail.com','5533333333','Monterrey'),
('C004','Laura Torres','laura@gmail.com','5544444444','Guadalajara'),
('C005','Miguel Díaz','miguel@gmail.com','5555555555','CDMX'),
('C006','Andrea Soto','andrea@gmail.com','5566666666','Puebla'),
('C007','Roberto Vega','roberto@gmail.com','5577777777','Toluca'),
('C008','Fernanda Cruz','fernanda@gmail.com','5588888888','Querétaro');

INSERT INTO Producto VALUES
('P001',1,'Laptop HP','Laptop HP 15"',15000,8,1),
('P002',2,'Mouse Logitech','Mouse inalámbrico',350,25,1),
('P003',2,'Teclado Mecánico','RGB',1200,4,1),
('P004',1,'Monitor Samsung','24 pulgadas',4500,15,1),
('P005',4,'Impresora Epson','Multifuncional',3800,7,1),
('P006',3,'Disco SSD 1TB','SSD Kingston',2200,30,1),
('P007',3,'Memoria USB 64GB','USB 3.0',250,10,1),
('P008',2,'Webcam Logitech','HD',900,0,0),
('P009',2,'Audífonos Gamer','Headset',1500,6,1),
('P010',3,'Disco Externo 2TB','USB-C',3200,5,1);

INSERT INTO Venta VALUES
('V001','C001','2026-06-01',16000,2560,200,18360),
('V002','C002','2026-06-02',4500,720,0,5220),
('V003','C003','2026-06-03',6000,960,100,6860),
('V004','C001','2026-06-05',18000,2880,300,20580),
('V005','C004','2026-05-20',2200,352,0,2552),
('V006','C005','2026-06-10',5200,832,150,5882),
('V007','C006','2026-06-12',3500,560,0,4060),
('V008','C007','2026-06-14',15400,2464,500,17364),
('V009','C008','2026-06-15',4200,672,100,4772),
('V010','C001','2026-06-16',7000,1120,0,8120);

INSERT INTO Detalle_Venta
(id_venta,id_producto,cantidad,precio_unitario,descuento,subtotal)
VALUES

('V001','P001',1,15000,200,14800),
('V001','P002',2,350,0,700),

('V002','P004',1,4500,0,4500),

('V003','P005',1,3800,100,3700),
('V003','P007',8,250,0,2000),

('V004','P001',1,15000,300,14700),
('V004','P006',1,2200,0,2200),
('V004','P002',2,350,0,700),

('V005','P006',1,2200,0,2200),

('V006','P005',1,3800,150,3650),
('V006','P002',4,350,0,1400),

('V007','P009',2,1500,0,3000),
('V007','P007',2,250,0,500),

('V008','P001',1,15000,500,14500),
('V008','P007',4,250,0,1000),

('V009','P010',1,3200,100,3100),
('V009','P002',3,350,0,1050),

('V010','P003',2,1200,0,2400),
('V010','P009',2,1500,0,3000);

INSERT INTO Pago VALUES
('PG001','V001','2026-06-01',18360,'Efectivo','Pagado'),
('PG002','V002','2026-06-02',5220,'Tarjeta','Pagado'),
('PG003','V003','2026-06-03',6860,'Efectivo','Pagado'),
('PG004','V004','2026-06-05',20580,'Transferencia','Pagado'),
('PG005','V005','2026-05-20',2552,'Tarjeta','Pagado'),
('PG006','V006','2026-06-10',5882,'Efectivo','Pagado'),
('PG007','V007','2026-06-12',4060,'Tarjeta','Pagado'),
('PG008','V008','2026-06-14',17364,'Transferencia','Pagado'),
('PG009','V009','2026-06-15',4772,'Efectivo','Pagado'),
('PG010','V010','2026-06-16',8120,'Tarjeta','Pagado');
*/

--1. Mostrar todos los productos activos.
select 
    RTRIM(id_producto)+' - '+RTRIM(Nombre) Producto,
    precio_venta
From 
    Producto
WHERE
    activo = 1
Order by
    id_producto desc
;

--2. Mostrar los productos con stock menor o igual a 10.
SELECT
    RTRIM(id_producto)+ ' - ' + RTRIM(Nombre) Producto,
    stock,
    'RECARGAR' Accion
FROM
    Producto
Where 
    stock <= 10
;

--3. Obtener los productos de la categoría "Periféricos".
SELECT
    RTRIM(prod.id_producto)+ ' - ' + RTRIM(prod.Nombre) Producto,
    cat.Descripcion,
    cat.nombre
FROM
    Producto prod
JOIN Categoria cat 
    ON cat.id_categoria = prod.id_categoria
WHERE
    cat.nombre = 'Periféricos'
;

select * from cliente
select * from venta
--4. Mostrar todas las ventas realizadas por Juan Pérez.
SELECT
    ven.id_venta,
    ven.fecha_venta,
    cli.nombre
FROM
    Venta ven
JOIN Cliente cli
    ON ven.id_cliente = cli.id_cliente
WHERE
    cli.nombre = 'Juan Pérez'
;

--5. Obtener el total de ventas por cliente.
SELECT
    RTRIM(cli.id_Cliente)+ ' - ' + RTRIM(cli.nombre) Cliente,
    SUM(dven.cantidad * dven.precio_unitario) TotalVenta
FROM
    Cliente cli
JOIN Venta ven
    ON ven.id_cliente = cli.id_cliente
JOIN Detalle_Venta dven
    ON ven.id_venta = dven.id_venta
GROUP BY
    cli.id_cliente, cli.nombre
;

--6. Mostrar los 3 productos más vendidos
SELECT Top 3
    RTRIM(prod.id_producto)+ ' - ' + RTRIM(prod.nombre) Producto,
    COUNT(dven.cantidad) TotalVendido
FROM
    Producto prod
JOIN Detalle_Venta dven
    ON dven.id_producto = prod.id_producto
GROUP BY
    prod.id_producto, prod.nombre
Order by 
    TotalVendido DESC
;

--7 Obtener el cliente que más compras ha realizado.
SELECT top 1
    RTRIM(cli.id_Cliente) + ' - ' +RTRIM(cli.nombre) Cliente,
    COUNT(ven.id_venta) totalVentas
FROM 
    Cliente cli
JOIN Venta ven
    ON cli.id_cliente = ven.id_cliente
GROUP BY
    cli.id_cliente, cli.nombre
ORDER BY
    totalVentas DESC
;

--8 Mostrar las ventas pagadas en efectivo durante el mes actual.
SELECT
    ven.id_venta,
    ven.fecha_venta,
    pag.metodo_pago
FROM
    Venta ven
JOIN Pago pag
    ON ven.id_venta = pag.id_venta
WHERE
    pag.metodo_pago = 'Efectivo'
    AND MONTH(ven.fecha_venta) = MONTH(GETDATE())
    AND YEAR(ven.fecha_venta) = YEAR(GETDATE());
;

--9 Obtener el producto que generó más ingresos.
SELECT top 1
    RTRIM(prod.id_producto)+ ' - ' + RTRIM(prod.nombre) Producto,
    SUM(dven.cantidad * dven.precio_unitario) Precio
FROM 
    Producto prod
JOIN Detalle_Venta dven 
    ON dven.id_producto = prod.id_producto
GROUP BY
    prod.id_producto, prod.nombre
Order by
    Precio DESC
;

--10. Mostrar los productos que nunca han sido vendidos.
SELECT
    RTRIM(prod.id_producto)+ ' - '+RTRIM(prod.nombre) Producto,
    dven.Cantidad
FROM Producto prod
LEFT JOIN Detalle_Venta dven
    ON prod.id_producto = dven.id_producto
WHERE
    dven.cantidad is null
;
 

    