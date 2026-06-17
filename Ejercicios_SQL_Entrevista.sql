/*Mostrar todos los clientes junto con la cantidad de pedidos que ha realizado cada uno.

Requisitos
Deben aparecer todos los clientes.
Si un cliente no tiene pedidos, también debe aparecer.
La cantidad de pedidos para esos clientes debe mostrarse como 0.
Mostrar:
ClienteID
Nombre
TotalPedidos
*/

select
	Rtrim(cli.ClienteID)+' - '+ RTRIM(cli.Nombre) Cliente,
	count(ped.PedidoID) TotalPedidos
from Clientes cli
LEFT JOIN Pedidos Ped on cli.ClienteID = ped.ClienteID
Group by cli.ClienteID, cli.Nombre
;

/*Mostrar los productos que nunca han sido vendidos.

Requisitos

Mostrar:

ProductoID
NombreProducto
Precio
*/
SELECT
	prod.ProductoID,
	prod.nombreProducto,
	prod.precio
FROM
	productos prod
LEFT JOIN DetallePedido dped
	on prod.ProductoID = dped.ProductoID
WHERE
	dped.PedidoID is NULL
;

/*Mostrar el pedido más caro.

Requisitos

Debes mostrar:

PedidoID
TotalPedido*/
select
	top 1
	dped.PedidoID,
	SUM(prod.Precio * dped.Cantidad) TotalPedido
FROM
	DetallePedido dped
JOIN Productos prod
	on prod.ProductoID = dped.ProductoID
GROUP BY
	dped.PedidoID
ORDER BY TotalPedido desc	
;

/*Mostrar el cliente que realizó más pedidos.

Requisitos

Mostrar:

ClienteID
Nombre
TotalPedidos*/
SELECT top 1
	cli.ClienteID,
	cli.Nombre,
	COUNT(ped.PedidoID) TotalPedidos
FROM
	Clientes cli
JOIN Pedidos ped
	ON cli.ClienteID = ped.ClienteID
GROUP BY
	cli.ClienteID, cli.Nombre
ORDER BY
	TotalPedidos DESC
;

--Mostrar los clientes que han gastado más de $10,000.
SELECT
	RTRIM(cli.ClienteID)+' - '+RTRIM(cli.Nombre) Cliente,
	SUM(prod.Precio * dped.Cantidad) total
FROM 
	Clientes cli
JOIN Pedidos ped 
	ON ped.ClienteID = cli.ClienteID
JOIN DetallePedido dped
	ON ped.PedidoID = dped.PedidoID
JOIN Productos prod
	ON dped.ProductoID = prod.ProductoID
GROUP BY
	cli.ClienteID, cli.Nombre
HAVING
	SUM(prod.Precio * dped.Cantidad) > 10000
;

--Mostrar el producto más vendido.
SELECT TOP 1
	RTRIM(prod.ProductoID)+' - '+RTRIM(prod.NombreProducto) Producto,
	SUM(dped.Cantidad) CantidadVendida
FROM
	Productos prod
JOIN DetallePedido dped
	ON prod.ProductoID = dped.ProductoID
GROUP BY
	prod.ProductoID, prod.NombreProducto
ORDER BY 
	CantidadVendida DESC
;

--Mostrar el segundo producto más vendido.
SELECT --TOP 1
	RTRIM(prod.ProductoID)+' - '+RTRIM(prod.NombreProducto) Producto,
	SUM(dped.Cantidad) CantidadVendida
FROM
	Productos prod
JOIN DetallePedido dped
	ON prod.ProductoID = dped.ProductoID
GROUP BY
	prod.ProductoID, prod.NombreProducto
ORDER BY 
	CantidadVendida DESC
OFFSET 1 ROWS
FETCH NEXT 1 ROWS ONLY
;

--Mostrar los pedidos cuyo total sea mayor al promedio de todos los pedidos.
SELECT
    dped.PedidoID,
    SUM(prod.Precio * dped.Cantidad) AS TotalPedido
FROM DetallePedido dped
JOIN Productos prod
    ON dped.ProductoID = prod.ProductoID
GROUP BY
    dped.PedidoID
HAVING
    SUM(prod.Precio * dped.Cantidad) >
    (
        SELECT
            AVG(TotalPedido)
        FROM
        (
            SELECT
                dped2.PedidoID,
                SUM(prod2.Precio * dped2.Cantidad) AS TotalPedido
            FROM DetallePedido dped2
            JOIN Productos prod2
                ON dped2.ProductoID = prod2.ProductoID
            GROUP BY dped2.PedidoID
        ) Ventas
    );