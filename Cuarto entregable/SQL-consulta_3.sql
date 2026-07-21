DROP TABLE IF EXISTS DB_202613_j_rodriguezv23.Dashboard2_BasePagos;

CREATE TABLE DB_202613_j_rodriguezv23.Dashboard2_BasePagos AS

/* Registros de copago */
SELECT
    h.IdProveedor_DWH,
    COALESCE(
        CAST(p.IdProveedor_T AS CHAR),
        CAST(h.IdProveedor_DWH AS CHAR)
    ) AS Codigo_Proveedor,

    h.IdPlan AS Codigo_Plan,
    h.IdFechaEmision,
    f.Fecha AS Fecha_Emision,
    f.Annio AS Anio_Emision,

    h.IdAreaDeServicio_DWH,
    a.IdAreaDeServicio_T AS Codigo_Area_Servicio,
    a.Nombre AS Nombre_Area_Servicio,

    h.IdTipoBeneficio_DWH,
    t.IdTipoBeneficio_T AS Codigo_Tipo_Beneficio,
    t.Nombre AS Tipo_Beneficio,

    h.IdCondicionesDePagoCopago_DWH AS IdCondicionPago_DWH,
    cp.Descripcion AS Condicion_Pago,

    'Copago' AS Tipo_Pago,
    CAST(h.ValorCopago AS DECIMAL(12,2)) AS Valor_Pago

FROM RaSaTransaccional_Tablero.HechoPlanesTiposBeneficio_10000 h

LEFT JOIN RaSaTransaccional_Tablero.Proveedor p
    ON h.IdProveedor_DWH = p.IdProveedor_DWH

LEFT JOIN RaSaTransaccional_Tablero.Fecha f
    ON h.IdFechaEmision = f.IdFecha

LEFT JOIN RaSaTransaccional_Tablero.AreasDeServicio a
    ON h.IdAreaDeServicio_DWH = a.IdAreaDeServicio_DWH

LEFT JOIN RaSaTransaccional_Tablero.TiposBeneficio t
    ON h.IdTipoBeneficio_DWH = t.IdTipoBeneficio_DWH

LEFT JOIN RaSaTransaccional_Tablero.CondicionesDePago cp
    ON h.IdCondicionesDePagoCopago_DWH = cp.IdCondicionesDePago_DWH

WHERE h.ValorCopago IS NOT NULL
  AND h.ValorCopago > 0

UNION ALL

/* Registros de coseguro */
SELECT
    h.IdProveedor_DWH,
    COALESCE(
        CAST(p.IdProveedor_T AS CHAR),
        CAST(h.IdProveedor_DWH AS CHAR)
    ) AS Codigo_Proveedor,

    h.IdPlan AS Codigo_Plan,
    h.IdFechaEmision,
    f.Fecha AS Fecha_Emision,
    f.Annio AS Anio_Emision,

    h.IdAreaDeServicio_DWH,
    a.IdAreaDeServicio_T AS Codigo_Area_Servicio,
    a.Nombre AS Nombre_Area_Servicio,

    h.IdTipoBeneficio_DWH,
    t.IdTipoBeneficio_T AS Codigo_Tipo_Beneficio,
    t.Nombre AS Tipo_Beneficio,

    h.IdCondicionesDePagoCoseguro_DWH AS IdCondicionPago_DWH,
    cc.Descripcion AS Condicion_Pago,

    'Coseguro' AS Tipo_Pago,
    CAST(TRIM(h.ValorCoseguro) AS DECIMAL(12,2)) AS Valor_Pago

FROM RaSaTransaccional_Tablero.HechoPlanesTiposBeneficio_10000 h

LEFT JOIN RaSaTransaccional_Tablero.Proveedor p
    ON h.IdProveedor_DWH = p.IdProveedor_DWH

LEFT JOIN RaSaTransaccional_Tablero.Fecha f
    ON h.IdFechaEmision = f.IdFecha

LEFT JOIN RaSaTransaccional_Tablero.AreasDeServicio a
    ON h.IdAreaDeServicio_DWH = a.IdAreaDeServicio_DWH

LEFT JOIN RaSaTransaccional_Tablero.TiposBeneficio t
    ON h.IdTipoBeneficio_DWH = t.IdTipoBeneficio_DWH

LEFT JOIN RaSaTransaccional_Tablero.CondicionesDePago cc
    ON h.IdCondicionesDePagoCoseguro_DWH = cc.IdCondicionesDePago_DWH

WHERE TRIM(COALESCE(h.ValorCoseguro, ''))
      REGEXP '^[0-9]+([.][0-9]+)?$'
  AND CAST(TRIM(h.ValorCoseguro) AS DECIMAL(12,2)) > 0;
  
############################################################

DROP TABLE IF EXISTS DB_202613_j_rodriguezv23.Dashboard2_Referencias;

CREATE TABLE DB_202613_j_rodriguezv23.Dashboard2_Referencias AS
SELECT
    Anio_Emision,
    IdAreaDeServicio_DWH,
    IdTipoBeneficio_DWH,
    Tipo_Pago,
    IdCondicionPago_DWH,

    MIN(Valor_Pago) AS Valor_Referencia,
    MAX(Valor_Pago) AS Valor_Maximo_Grupo,
    COUNT(*) AS Ofertas_Comparables,
    COUNT(DISTINCT IdProveedor_DWH) AS Proveedores_Comparables

FROM DB_202613_j_rodriguezv23.Dashboard2_BasePagos

GROUP BY
    Anio_Emision,
    IdAreaDeServicio_DWH,
    IdTipoBeneficio_DWH,
    Tipo_Pago,
    IdCondicionPago_DWH

HAVING COUNT(DISTINCT IdProveedor_DWH) >= 2;

###############################################################

DROP TABLE IF EXISTS DB_202613_j_rodriguezv23.Dashboard2_OfertaProveedores;

CREATE TABLE DB_202613_j_rodriguezv23.Dashboard2_OfertaProveedores AS
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
   AND b.IdAreaDeServicio_DWH = r.IdAreaDeServicio_DWH
   AND b.IdTipoBeneficio_DWH = r.IdTipoBeneficio_DWH
   AND b.Tipo_Pago = r.Tipo_Pago
   AND b.IdCondicionPago_DWH = r.IdCondicionPago_DWH

LEFT JOIN RaSaTransaccional_Tablero.AsociacionAreaServicioGeografia ag
    ON b.IdAreaDeServicio_DWH = ag.IdAreaDeServicio_DWH

LEFT JOIN RaSaTransaccional_Tablero.Geografia g
    ON ag.IdGeografia_DWH = g.IdGeografia_DWH;
    
################################################################

SELECT
    Tipo_Pago,
    COUNT(*) AS Registros,
    COUNT(DISTINCT Codigo_Proveedor) AS Proveedores,
    COUNT(DISTINCT Caso_ID) AS Casos,
    SUM(Resultado = 'Alerta') AS Alertas,
    ROUND(AVG(Diferencia_Porcentual), 2) AS DiferenciaPromedio,
    MAX(Diferencia_Porcentual) AS DiferenciaMaxima
FROM DB_202613_j_rodriguezv23.Dashboard2_OfertaProveedores
GROUP BY Tipo_Pago;

SELECT
    Codigo_Proveedor,
    Codigo_Plan,
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
