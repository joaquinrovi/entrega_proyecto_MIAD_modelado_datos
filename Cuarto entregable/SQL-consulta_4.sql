## Recalcular las referencias

DROP TABLE IF EXISTS 
    DB_202613_j_rodriguezv23.Dashboard2_Referencias;

CREATE TABLE 
    DB_202613_j_rodriguezv23.Dashboard2_Referencias AS
SELECT
    Anio_Emision,
    IdTipoBeneficio_DWH,
    Tipo_Pago,

    MIN(Valor_Pago) AS Valor_Referencia,
    MAX(Valor_Pago) AS Valor_Maximo_Grupo,
    COUNT(*) AS Ofertas_Comparables,
    COUNT(DISTINCT IdProveedor_DWH) AS Proveedores_Comparables

FROM DB_202613_j_rodriguezv23.Dashboard2_BasePagos

GROUP BY
    Anio_Emision,
    IdTipoBeneficio_DWH,
    Tipo_Pago

HAVING COUNT(DISTINCT IdProveedor_DWH) >= 2;

## Comprobación

SELECT
    Tipo_Pago,
    COUNT(*) AS GruposComparables,
    SUM(Ofertas_Comparables) AS Ofertas,
    MAX(Proveedores_Comparables) AS MaximoProveedoresGrupo
FROM DB_202613_j_rodriguezv23.Dashboard2_Referencias
GROUP BY Tipo_Pago;

## Reconstrucción de tabla final

DROP TABLE IF EXISTS
    DB_202613_j_rodriguezv23.Dashboard2_OfertaProveedores;

CREATE TABLE
    DB_202613_j_rodriguezv23.Dashboard2_OfertaProveedores AS
SELECT DISTINCT
    CONCAT_WS(
        '-',
        b.IdFechaEmision,
        b.IdAreaDeServicio_DWH,
        b.IdTipoBeneficio_DWH,
        b.Tipo_Pago,
        COALESCE(b.IdCondicionPago_DWH, 0),
        b.IdProveedor_DWH,
        b.Codigo_Plan
    ) AS Caso_ID,

    b.Fecha_Emision,
    b.Anio_Emision,

    b.IdProveedor_DWH,
    b.Codigo_Proveedor,
    b.Codigo_Plan,

    b.IdAreaDeServicio_DWH,
    b.Codigo_Area_Servicio,
    b.Nombre_Area_Servicio,

    g.Estado,

    b.IdTipoBeneficio_DWH,
    b.Codigo_Tipo_Beneficio,
    b.Tipo_Beneficio,

    b.IdCondicionPago_DWH,
    b.Condicion_Pago,
    b.Tipo_Pago,

    b.Valor_Pago,
    r.Valor_Referencia,
    r.Proveedores_Comparables,
    r.Ofertas_Comparables,

    ROUND(
        (
            (b.Valor_Pago - r.Valor_Referencia)
            / r.Valor_Referencia
        ) * 100,
        2
    ) AS Diferencia_Porcentual,

    CASE
        WHEN (
            (b.Valor_Pago - r.Valor_Referencia)
            / r.Valor_Referencia
        ) * 100 > 20
        THEN 'Alerta'
        ELSE 'Sin alerta'
    END AS Resultado

FROM DB_202613_j_rodriguezv23.Dashboard2_BasePagos b

INNER JOIN DB_202613_j_rodriguezv23.Dashboard2_Referencias r
    ON b.Anio_Emision = r.Anio_Emision
   AND b.IdTipoBeneficio_DWH = r.IdTipoBeneficio_DWH
   AND b.Tipo_Pago = r.Tipo_Pago

LEFT JOIN RaSaTransaccional_Tablero.AsociacionAreaServicioGeografia ag
    ON b.IdAreaDeServicio_DWH = ag.IdAreaDeServicio_DWH

LEFT JOIN RaSaTransaccional_Tablero.Geografia g
    ON ag.IdGeografia_DWH = g.IdGeografia_DWH;
    
## Validación final

SELECT
    Tipo_Pago,
    COUNT(*) AS Registros,
    COUNT(DISTINCT Codigo_Proveedor) AS Proveedores,
    COUNT(DISTINCT Caso_ID) AS Casos,
    SUM(Resultado = 'Alerta') AS Alertas,
    ROUND(
        AVG(
            CASE
                WHEN Resultado = 'Alerta'
                THEN Diferencia_Porcentual
            END
        ),
        2
    ) AS DiferenciaPromedioAlertas,
    MAX(Diferencia_Porcentual) AS DiferenciaMaxima
FROM DB_202613_j_rodriguezv23.Dashboard2_OfertaProveedores
GROUP BY Tipo_Pago;

SELECT
    Codigo_Proveedor,
    Codigo_Plan,
    Anio_Emision,
    Tipo_Beneficio,
    Tipo_Pago,
    Valor_Pago,
    Valor_Referencia,
    Diferencia_Porcentual,
    Estado,
    Resultado
FROM DB_202613_j_rodriguezv23.Dashboard2_OfertaProveedores
WHERE Resultado = 'Alerta'
ORDER BY Diferencia_Porcentual DESC
LIMIT 20;