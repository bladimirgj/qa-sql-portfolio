--Mostrar cuántos pedidos tiene cada cliente.

select
	count(ped.PedidoID) TotalPedidos,
	RTRIM(cli.clienteId) + ' - '  + RTRIM(cli.Nombre) Cliente
from clientes cli
Join pedidos ped 
	on cli.ClienteID = ped.ClienteID
Group by cli.clienteID, cli.Nombre
;

--Obtener el total vendido por pedido.
select
	dped.PedidoID,
	SUM(prod.Precio * dped.Cantidad) TotalPedido
from 
	DetallePedido dped
JOIN Productos prod on dped.ProductoID = prod.ProductoID
Group By dped.PedidoID

--Mostrar el producto más caro.
select top 1
	NombreProducto,
	precio
from
	Productos
order by Precio desc;

--Mostrar el producto más barato.
select top 1
	NombreProducto,
	precio
from Productos
order by precio asc;

--Mostrar el total de productos vendidos por producto.
SELECT
    prod.NombreProducto,
    SUM(dped.Cantidad) CantidadVendida
FROM Productos prod
JOIN DetallePedido dped
    ON prod.ProductoID = dped.ProductoID
GROUP BY prod.NombreProducto;

--Mostrar los clientes que tienen más de un pedido.
select
	Rtrim(cli.ClienteID)+ ' - ' + Rtrim(cli.nombre) Cliente,
	Count(Ped.PedidoID)
	
from Clientes cli 
JOIN Pedidos ped ON cli.ClienteID = ped.ClienteID
Group by
	cli.ClienteID, cli.Nombre
having count(ped.pedidoID) > 1
;

--Calcular el promedio de venta por pedido.
SELECT
    AVG(TotalPedido) PromedioVentas
FROM (
    SELECT
        ped.PedidoID,
        SUM(prod.Precio * dped.Cantidad) AS TotalPedido
    FROM pedidos ped
    INNER JOIN detallepedido dped
        ON ped.PedidoID = dped.PedidoID
    INNER JOIN productos prod
        ON dped.ProductoID = prod.ProductoID
    GROUP BY ped.PedidoID
) Ventas;
	
--Mostrar el cliente que más dinero ha gastado.
/*
clientes
pedidos
detallepedido
productos
*/
select --TOP 1
    RTRIM(cli.ClienteID) + ' - ' + RTRIM(cli.Nombre) Cliente,
    SUM(prod.Precio * dped.Cantidad) TotalGastado
from Clientes cli
JOIN Pedidos ped ON cli.ClienteID = ped.ClienteID
JOIN DetallePedido dped ON ped.PedidoID = dped.PedidoID
JOIN Productos prod ON dped.ProductoID = prod.ProductoID
Group by
    cli.ClienteID,
    cli.Nombre
order by TotalGastado desc;

-- Mostrar los clientes que nunca han realizado pedidos
select 
    RTRIM(cli.ClienteID) + ' - ' + RTRIM(cli.Nombre) Cliente
from Clientes cli
LEFT JOIN Pedidos ped ON cli.ClienteID = ped.ClienteID
where 
    ped.ClienteID IS NULL
;

