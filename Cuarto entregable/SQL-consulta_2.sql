USE RaSaTransaccional_Tablero;

-- Perfilamiento de los valores de copago
SELECT
    COUNT(*) AS TotalRegistros,
    SUM(ValorCopago IS NULL) AS CopagosNulos,
    SUM(ValorCopago = 0) AS CopagosEnCero,
    MIN(ValorCopago) AS CopagoMinimo,
    MAX(ValorCopago) AS CopagoMaximo,
    COUNT(DISTINCT ValorCopago) AS ValoresCopagoDistintos
FROM HechoPlanesTiposBeneficio_10000;

-- Revisar el formato del coseguro, almacenado como texto
SELECT
    COALESCE(NULLIF(TRIM(ValorCoseguro), ''), '[VACÍO]') AS ValorCoseguro,
    COUNT(*) AS CantidadRegistros
FROM HechoPlanesTiposBeneficio_10000
GROUP BY COALESCE(NULLIF(TRIM(ValorCoseguro), ''), '[VACÍO]')
ORDER BY CantidadRegistros DESC
LIMIT 30;

-- Revisar una muestra de los campos principales
SELECT
    IdProveedor_DWH,
    IdFechaEmision,
    IdPlan,
    IdAreaDeServicio_DWH,
    IdTipoBeneficio_DWH,
    IdCondicionesDePagoCopago_DWH,
    IdCondicionesDePagoCoseguro_DWH,
    ValorCopago,
    ValorCoseguro
FROM HechoPlanesTiposBeneficio_10000
LIMIT 20;

-- Conocer el alcance de la muestra
SELECT
    COUNT(DISTINCT IdProveedor_DWH) AS Proveedores,
    COUNT(DISTINCT IdPlan) AS Planes,
    COUNT(DISTINCT IdAreaDeServicio_DWH) AS AreasServicio,
    COUNT(DISTINCT IdTipoBeneficio_DWH) AS TiposBeneficio,
    COUNT(DISTINCT IdFechaEmision) AS FechasEmision
FROM HechoPlanesTiposBeneficio_10000;