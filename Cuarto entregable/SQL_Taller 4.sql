# Se indica qué base de datos se va a utilizar
USE DB_202613_cj_hernandezg12;

#Copia de tablas a mi base de datos
CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.AreasDeServicio_RaSA LIKE RaSaTransaccional_Tablero.AreasDeServicio;
INSERT INTO DB_202613_cj_hernandezg12.AreasDeServicio_RaSA SELECT * FROM RaSaTransaccional_Tablero.AreasDeServicio;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.AsociacionAreaServicioGeografia_RaSA LIKE RaSaTransaccional_Tablero.AsociacionAreaServicioGeografia;
INSERT INTO DB_202613_cj_hernandezg12.AsociacionAreaServicioGeografia_RaSA SELECT * FROM RaSaTransaccional_Tablero.AsociacionAreaServicioGeografia;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.CondicionesDePago_RaSA LIKE RaSaTransaccional_Tablero.CondicionesDePago;
INSERT INTO DB_202613_cj_hernandezg12.CondicionesDePago_RaSA SELECT * FROM RaSaTransaccional_Tablero.CondicionesDePago;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.Fecha_RaSA LIKE RaSaTransaccional_Tablero.Fecha;
INSERT INTO DB_202613_cj_hernandezg12.Fecha_RaSA SELECT * FROM RaSaTransaccional_Tablero.Fecha;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.Geografia_RaSA LIKE RaSaTransaccional_Tablero.Geografia;
INSERT INTO DB_202613_cj_hernandezg12.Geografia_RaSA SELECT * FROM RaSaTransaccional_Tablero.Geografia;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.HechoHistCondicionesTiposBeneficio_RaSA LIKE RaSaTransaccional_Tablero.HechoHistCondicionesTiposBeneficio;
INSERT INTO DB_202613_cj_hernandezg12.HechoHistCondicionesTiposBeneficio_RaSA SELECT * FROM RaSaTransaccional_Tablero.HechoHistCondicionesTiposBeneficio;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.HechoHistCondicionesTiposBeneficio_v_RaSA LIKE RaSaTransaccional_Tablero.HechoHistCondicionesTiposBeneficio_v;
INSERT INTO DB_202613_cj_hernandezg12.HechoHistCondicionesTiposBeneficio_v_RaSA SELECT * FROM RaSaTransaccional_Tablero.HechoHistCondicionesTiposBeneficio_v;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_RaSA LIKE RaSaTransaccional_Tablero.HechoPlanesTiposBeneficio;
INSERT INTO DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_RaSA SELECT * FROM RaSaTransaccional_Tablero.HechoPlanesTiposBeneficio;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_1000_RaSA LIKE RaSaTransaccional_Tablero.HechoPlanesTiposBeneficio_1000;
INSERT INTO DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_1000_RaSA SELECT * FROM RaSaTransaccional_Tablero.HechoPlanesTiposBeneficio_1000;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_10000_RaSA LIKE RaSaTransaccional_Tablero.HechoPlanesTiposBeneficio_10000;
INSERT INTO DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_10000_RaSA SELECT * FROM RaSaTransaccional_Tablero.HechoPlanesTiposBeneficio_10000;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_5000_RaSA LIKE RaSaTransaccional_Tablero.HechoPlanesTiposBeneficio_5000;
INSERT INTO DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_5000_RaSA SELECT * FROM RaSaTransaccional_Tablero.HechoPlanesTiposBeneficio_5000;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.MiniCondicionesTipoBeneficio_RaSA LIKE RaSaTransaccional_Tablero.MiniCondicionesTipoBeneficio;
INSERT INTO DB_202613_cj_hernandezg12.MiniCondicionesTipoBeneficio_RaSA SELECT * FROM RaSaTransaccional_Tablero.MiniCondicionesTipoBeneficio;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.MiniCondicionesTipoBeneficio_v_RaSA LIKE RaSaTransaccional_Tablero.MiniCondicionesTipoBeneficio_v;
INSERT INTO DB_202613_cj_hernandezg12.MiniCondicionesTipoBeneficio_v_RaSA SELECT * FROM RaSaTransaccional_Tablero.MiniCondicionesTipoBeneficio_v;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.NivelesDeServicio_RaSA LIKE RaSaTransaccional_Tablero.NivelesDeServicio;
INSERT INTO DB_202613_cj_hernandezg12.NivelesDeServicio_RaSA SELECT * FROM RaSaTransaccional_Tablero.NivelesDeServicio;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.Proveedor_RaSA LIKE RaSaTransaccional_Tablero.Proveedor;
INSERT INTO DB_202613_cj_hernandezg12.Proveedor_RaSA SELECT * FROM RaSaTransaccional_Tablero.Proveedor;

CREATE TABLE IF NOT EXISTS DB_202613_cj_hernandezg12.TiposBeneficio_RaSA LIKE RaSaTransaccional_Tablero.TiposBeneficio;
INSERT INTO DB_202613_cj_hernandezg12.TiposBeneficio_RaSA SELECT * FROM RaSaTransaccional_Tablero.TiposBeneficio;


#Creacion de tabla para DataStudio (sin nomnbres organizados)
DROP TABLE IF EXISTS DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_Looker;
CREATE TABLE DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_Looker AS  
SELECT 
    -- 1. Hechos y Dimensiones Degeneradas del núcleo  
    h.ValorCoseguro AS "Valor Coseguro",  
    h.ValorCopago AS "Valor Copago",  
    h.CantidadLimite AS "Cantidad Limite", 
   
    -- 2. Proveedor  
    p.IdProveedor_T AS "Codigo Proveedor", 
   
    -- 3. Fecha de Emision  
    f.Fecha AS FechaEmision,  
    f.Annio AS AnnioEmision,  
    f.Mes AS MesEmision,  
    f.Dia AS DiaEmision, 
   
    -- 4. Areas de Servicio  
    a.IdAreaDeServicio_DWH AS AreaServicio_DWH_ID,
    a.IdAreaDeServicio_T AS AreaServicio_Codigo,
    a.Nombre AS AreaServicio_Nombre,  
    a.AnnioCreacion AS AreaServicio_AnnioCreacion, 
   
    -- 5. Geografia (A través de la tabla de asociacion)  
    g.IdGeografia_T AS Geografia_Codigo,  
    g.Estado AS Geografia_Estado,  
    g.Condado AS Geografia_Condado,  
    g.AreaAct AS Geografia_AreaAct,  
    g.DensidadAct AS Geografia_DensidadAct,  
    g.PoblacionAct AS Geografia_PoblacionAct, 
   
    -- 6. Niveles de Servicio  
    n.IdNivelDeServicio_T AS NivelServicio_Codigo,  
    n.Descripcion AS NivelServicio_Descripcion, 
   
    -- 7. Tipos de Beneficio  
    t.IdTipoBeneficio_T AS TipoBeneficio_Codigo,  
    t.Nombre AS TipoBeneficio_Nombre, 
   
    -- 8. Mini Condiciones Tipo Beneficio  
    m.EstaCubiertaPorSeguro,  
    m.EsEHB,  
    m.TieneLimiteCuantitativo,  
    m.ExcluidoDelDesembolsoMaximoDentroDeLaRed,  
    m.ExcluidoDelDesembolsoMaximoFueraDeLaRed,  
    m.UnidadDelLimite, 
   
    -- 9. Condicion de Pago - Coseguro (Rol 1)  
    cc.IdCondicionesDePago_T AS CondicionCoseguro_Codigo,  
    cc.Descripcion AS CondicionCoseguro_Descripcion,  
    cc.Tipo AS CondicionCoseguro_Tipo, 
   
    -- 10. Condicion de Pago - Copago (Rol 2)  
    cp.IdCondicionesDePago_T AS CondicionCopago_Codigo,
    cp.Descripcion AS CondicionCopago_Descripcion,  
    cp.Tipo AS CondicionCopago_Tipo, 
    
    -- 11 Condiciones Tipo Beneficio
    
    -- Campos de la tabla historica de condiciones de beneficios
    IF(ctb.IdFechaInicio = 0 OR ctb.IdFechaInicio IS NULL, NULL, STR_TO_DATE(ctb.IdFechaInicio, '%Y%m%d')) AS FechaInicio,
    IF(ctb.IdFechaFin = 0 OR ctb.IdFechaFin IS NULL, NULL, STR_TO_DATE(ctb.IdFechaFin, '%Y%m%d')) AS FechaFin,
	ctb.Cambio AS Cambio
   
FROM DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_RaSA h 
   
-- Relacion con Proveedor  
LEFT JOIN DB_202613_cj_hernandezg12.Proveedor_RaSA p 
    ON h.IdProveedor_DWH = p.IdProveedor_DWH 
   
-- Relacion con Fecha de Emision  
LEFT JOIN DB_202613_cj_hernandezg12.Fecha_RaSA f 
    ON h.IdFechaEmision = f.IdFecha 
   
-- Relacion con Areas de Servicio  
LEFT JOIN DB_202613_cj_hernandezg12.AreasDeServicio_RaSA a 
    ON h.IdAreaDeServicio_DWH = a.IdAreaDeServicio_DWH 
   
-- Relacion con Geografia (pasando por la tabla puente/asociacion)  
LEFT JOIN DB_202613_cj_hernandezg12.AsociacionAreaServicioGeografia_RaSA asoc 
    ON a.IdAreaDeServicio_DWH = asoc.IdAreaDeServicio_DWH  
LEFT JOIN DB_202613_cj_hernandezg12.Geografia_RaSA g 
    ON asoc.IdGeografia_DWH = g.IdGeografia_DWH 
   
-- Relacion con Niveles de Servicio  
LEFT JOIN DB_202613_cj_hernandezg12.NivelesDeServicio_RaSA n 
    ON h.IdNivelDeServicio_DWH = n.IdNivelDeServicio_DWH 
   
-- Relacion con Tipos de Beneficio  
LEFT JOIN DB_202613_cj_hernandezg12.TiposBeneficio_RaSA t 
    ON h.IdTipoBeneficio_DWH = t.IdTipoBeneficio_DWH 
   
-- Relacion con Mini Condiciones Tipo Beneficio  
LEFT JOIN DB_202613_cj_hernandezg12.MiniCondicionesTipoBeneficio_RaSA m 
    ON h.IdCondicionesTipoBeneficios_DWH = m.IdCondicionesTipoBeneficios_DWH 
   
-- Relacion con Condicion de Pago interpretada como COSEGURO  
LEFT JOIN DB_202613_cj_hernandezg12.CondicionesDePago_RaSA cc 
    ON h.IdCondicionesDePagoCoseguro_DWH = cc.IdCondicionesDePago_DWH 
   
-- Relacion con Condicion de Pago interpretada como COPAGO  
LEFT JOIN DB_202613_cj_hernandezg12.CondicionesDePago_RaSA cp 
    ON h.IdCondicionesDePagoCopago_DWH = cp.IdCondicionesDePago_DWH
    
LEFT JOIN DB_202613_cj_hernandezg12.HechoHistCondicionesTiposBeneficio_RaSA ctb
	ON ctb.IdCondicionesTipoBeneficios_DWH = m.IdCondicionesTipoBeneficios_DWH
	AND ctb.IdTipoBeneficio_DWH = t.IdTipoBeneficio_DWH;
    
SELECT * FROM HechoPlanesTiposBeneficio_Looker;


#Creacion de tabla para DataStudio / Looker
DROP TABLE IF EXISTS DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_Looker;
CREATE TABLE DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_Looker AS  
SELECT 
    -- 1. Hechos y Dimensiones Degeneradas del núcleo  
    h.ValorCoseguro AS Valor_Coseguro,  
    h.ValorCopago AS Valor_Copago,  
    h.CantidadLimite AS Cantidad_Limite, 
   
    -- 2. Proveedor  
    p.IdProveedor_T AS Codigo_Proveedor, 
   
    -- 3. Fecha de Emision  
    f.Fecha AS Fecha_Emision,  
    f.Annio AS Año_Emision,  
    f.Mes AS Mes_Emision,  
    f.Dia AS Dia_Emision, 
   
    -- 4. Areas de Servicio  
    a.IdAreaDeServicio_DWH AS Area_Servicio_DWH_ID,
    a.IdAreaDeServicio_T AS Codigo_Area_Servicio,
    a.Nombre AS Nombre_Area_Servicio,  
    a.AnnioCreacion AS Año_Creacion_Area_Servicio, 
   
    -- 5. Geografia  
    g.IdGeografia_T AS Codigo_Geografia,  
    g.Estado AS Estado,  
    g.Condado AS Condado,  
    g.AreaAct AS Area_Activa,  
    g.DensidadAct AS Densidad_Activa,  
    g.PoblacionAct AS Poblacion_Activa, 
   
    -- 6. Niveles de Servicio  
    n.IdNivelDeServicio_T AS Codigo_Nivel_Servicio,  
    n.Descripcion AS Descripcion_Nivel_Servicio, 
   
    -- 7. Tipos de Beneficio  
    t.IdTipoBeneficio_T AS Codigo_Tipo_Beneficio,  
    t.Nombre AS Tipo_Beneficio, 
   
    -- 8. Mini Condiciones Tipo Beneficio  
    m.IdCondicionesTipoBeneficios_DWH AS Codigo_Condiciones_TipoB,
    m.EstaCubiertaPorSeguro AS Esta_Cubierto_Por_Seguro,  
    m.EsEHB AS Es_EHB,  
    m.TieneLimiteCuantitativo AS Tiene_Limite_Cuantitativo,  
    m.ExcluidoDelDesembolsoMaximoDentroDeLaRed AS Excluido_Desembolso_Maximo_Dentro_Red,  
    m.ExcluidoDelDesembolsoMaximoFueraDeLaRed AS Excluido_Desembolso_Maximo_Fuera_Red,  
    m.UnidadDelLimite AS Unidad_del_Limite, 
   
    -- 9. Condicion de Pago - Coseguro (Rol 1)  
    cc.IdCondicionesDePago_T AS Codigo_Condicion_Coseguro,  
    cc.Descripcion AS Descripcion_Condicion_Coseguro,  
    cc.Tipo AS Tipo_Condicion_Coseguro, 
   
    -- 10. Condicion de Pago - Copago (Rol 2)  
    cp.IdCondicionesDePago_T AS Codigo_Condicion_Copago,
    cp.Descripcion AS Descripcion_Condicion_Copago,  
    cp.Tipo AS Tipo_Condicion_Copago, 
    
    -- 11. Historico de Condiciones de Beneficios
    IF(ctb.IdFechaInicio = 0 OR ctb.IdFechaInicio IS NULL, NULL, STR_TO_DATE(ctb.IdFechaInicio, '%Y%m%d')) AS Fecha_Inicio_Condicion,
    IF(ctb.IdFechaFin = 0 OR ctb.IdFechaFin IS NULL, NULL, STR_TO_DATE(ctb.IdFechaFin, '%Y%m%d')) AS Fecha_Fin_Condicion,
    ctb.Cambio AS Cambio_Historico
   
FROM DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_RaSA h 
   
-- Relacion con Proveedor  
LEFT JOIN DB_202613_cj_hernandezg12.Proveedor_RaSA p 
    ON h.IdProveedor_DWH = p.IdProveedor_DWH 
   
-- Relacion con Fecha de Emision  
LEFT JOIN DB_202613_cj_hernandezg12.Fecha_RaSA f 
    ON h.IdFechaEmision = f.IdFecha 
   
-- Relacion con Areas de Servicio  
LEFT JOIN DB_202613_cj_hernandezg12.AreasDeServicio_RaSA a 
    ON h.IdAreaDeServicio_DWH = a.IdAreaDeServicio_DWH 
   
-- Relacion con Geografia (pasando por la tabla puente/asociacion)  
LEFT JOIN DB_202613_cj_hernandezg12.AsociacionAreaServicioGeografia_RaSA asoc 
    ON a.IdAreaDeServicio_DWH = asoc.IdAreaDeServicio_DWH  
LEFT JOIN DB_202613_cj_hernandezg12.Geografia_RaSA g 
    ON asoc.IdGeografia_DWH = g.IdGeografia_DWH 
   
-- Relacion con Niveles de Servicio  
LEFT JOIN DB_202613_cj_hernandezg12.NivelesDeServicio_RaSA n 
    ON h.IdNivelDeServicio_DWH = n.IdNivelDeServicio_DWH 
   
-- Relacion con Tipos de Beneficio  
LEFT JOIN DB_202613_cj_hernandezg12.TiposBeneficio_RaSA t 
    ON h.IdTipoBeneficio_DWH = t.IdTipoBeneficio_DWH 
   
-- Relacion con Mini Condiciones Tipo Beneficio  
LEFT JOIN DB_202613_cj_hernandezg12.MiniCondicionesTipoBeneficio_RaSA m 
    ON h.IdCondicionesTipoBeneficios_DWH = m.IdCondicionesTipoBeneficios_DWH 
   
-- Relacion con Condicion de Pago interpretada como COSEGURO  
LEFT JOIN DB_202613_cj_hernandezg12.CondicionesDePago_RaSA cc 
    ON h.IdCondicionesDePagoCoseguro_DWH = cc.IdCondicionesDePago_DWH 
   
-- Relacion con Condicion de Pago interpretada como COPAGO  
LEFT JOIN DB_202613_cj_hernandezg12.CondicionesDePago_RaSA cp 
    ON h.IdCondicionesDePagoCopago_DWH = cp.IdCondicionesDePago_DWH
    
-- Relacion Historica de Condiciones de Beneficios  
LEFT JOIN DB_202613_cj_hernandezg12.HechoHistCondicionesTiposBeneficio_RaSA ctb
    ON ctb.IdCondicionesTipoBeneficios_DWH = m.IdCondicionesTipoBeneficios_DWH
    AND ctb.IdTipoBeneficio_DWH = t.IdTipoBeneficio_DWH;

SELECT * FROM HechoPlanesTiposBeneficio_Looker;


#Creacion de tabla con 10000 registros para DataStudio
DROP TABLE IF EXISTS HechoPlanesTiposBeneficio_Looker_Muestra;
CREATE TABLE DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_Looker_Muestra AS  
SELECT 
    -- 1. Hechos y Dimensiones Degeneradas del núcleo  
    h.ValorCoseguro AS Valor_Coseguro,  
    h.ValorCopago AS Valor_Copago,  
    h.CantidadLimite AS Cantidad_Limite, 
   
    -- 2. Proveedor  
    p.IdProveedor_T AS Codigo_Proveedor, 
   
    -- 3. Fecha de Emision  
    f.Fecha AS Fecha_Emision,  
    f.Annio AS Año_Emision,  
    f.Mes AS Mes_Emision,  
    f.Dia AS Dia_Emision, 
   
    -- 4. Areas de Servicio  
    a.IdAreaDeServicio_DWH AS Area_Servicio_DWH_ID,
    a.IdAreaDeServicio_T AS Codigo_Area_Servicio,
    a.Nombre AS Nombre_Area_Servicio,  
    a.AnnioCreacion AS Año_Creacion_Area_Servicio, 
   
    -- 5. Geografia  
    g.IdGeografia_T AS Codigo_Geografia,  
    g.Estado AS Estado,  
    g.Condado AS Condado,  
    g.AreaAct AS Area_Activa,  
    g.DensidadAct AS Densidad_Activa,  
    g.PoblacionAct AS Poblacion_Activa, 
   
    -- 6. Niveles de Servicio  
    n.IdNivelDeServicio_T AS Codigo_Nivel_Servicio,  
    n.Descripcion AS Descripcion_Nivel_Servicio, 
   
    -- 7. Tipos de Beneficio  
    t.IdTipoBeneficio_T AS Codigo_Tipo_Beneficio,  
    t.Nombre AS Tipo_Beneficio, 
   
    -- 8. Mini Condiciones Tipo Beneficio 
    m.IdCondicionesTipoBeneficios_DWH AS Codigo_Condiciones_TipoB,
    m.EstaCubiertaPorSeguro AS Esta_Cubierto_Por_Seguro,  
    m.EsEHB AS Es_EHB,  
    m.TieneLimiteCuantitativo AS Tiene_Limite_Cuantitativo,  
    m.ExcluidoDelDesembolsoMaximoDentroDeLaRed AS Excluido_Desembolso_Maximo_Dentro_Red,  
    m.ExcluidoDelDesembolsoMaximoFueraDeLaRed AS Excluido_Desembolso_Maximo_Fuera_Red,  
    m.UnidadDelLimite AS Unidad_del_Limite, 
   
    -- 9. Condicion de Pago - Coseguro (Rol 1)  
    cc.IdCondicionesDePago_T AS Codigo_Condicion_Coseguro,  
    cc.Descripcion AS Descripcion_Condicion_Coseguro,  
    cc.Tipo AS Tipo_Condicion_Coseguro, 
   
    -- 10. Condicion de Pago - Copago (Rol 2)  
    cp.IdCondicionesDePago_T AS Codigo_Condicion_Copago,
    cp.Descripcion AS Descripcion_Condicion_Copago,  
    cp.Tipo AS Tipo_Condicion_Copago, 
    
    -- 11. Historico de Condiciones de Beneficios
    IF(ctb.IdFechaInicio = 0 OR ctb.IdFechaInicio IS NULL, NULL, STR_TO_DATE(ctb.IdFechaInicio, '%Y%m%d')) AS Fecha_Inicio_Condicion,
    IF(ctb.IdFechaFin = 0 OR ctb.IdFechaFin IS NULL, NULL, STR_TO_DATE(ctb.IdFechaFin, '%Y%m%d')) AS Fecha_Fin_Condicion,
    ctb.Cambio AS Cambio_Historico
   
FROM DB_202613_cj_hernandezg12.HechoPlanesTiposBeneficio_RaSA h 
   
-- Relacion con Proveedor  
LEFT JOIN DB_202613_cj_hernandezg12.Proveedor_RaSA p 
    ON h.IdProveedor_DWH = p.IdProveedor_DWH 
   
-- Relacion con Fecha de Emision  
LEFT JOIN DB_202613_cj_hernandezg12.Fecha_RaSA f 
    ON h.IdFechaEmision = f.IdFecha 
   
-- Relacion con Areas de Servicio  
LEFT JOIN DB_202613_cj_hernandezg12.AreasDeServicio_RaSA a 
    ON h.IdAreaDeServicio_DWH = a.IdAreaDeServicio_DWH 
   
-- Relacion con Geografia (pasando por la tabla puente/asociacion)  
LEFT JOIN DB_202613_cj_hernandezg12.AsociacionAreaServicioGeografia_RaSA asoc 
    ON a.IdAreaDeServicio_DWH = asoc.IdAreaDeServicio_DWH  
LEFT JOIN DB_202613_cj_hernandezg12.Geografia_RaSA g 
    ON asoc.IdGeografia_DWH = g.IdGeografia_DWH 
   
-- Relacion con Niveles de Servicio  
LEFT JOIN DB_202613_cj_hernandezg12.NivelesDeServicio_RaSA n 
    ON h.IdNivelDeServicio_DWH = n.IdNivelDeServicio_DWH 
   
-- Relacion con Tipos de Beneficio  
LEFT JOIN DB_202613_cj_hernandezg12.TiposBeneficio_RaSA t 
    ON h.IdTipoBeneficio_DWH = t.IdTipoBeneficio_DWH 
   
-- Relacion con Mini Condiciones Tipo Beneficio  
LEFT JOIN DB_202613_cj_hernandezg12.MiniCondicionesTipoBeneficio_RaSA m 
    ON h.IdCondicionesTipoBeneficios_DWH = m.IdCondicionesTipoBeneficios_DWH 
   
-- Relacion con Condicion de Pago interpretada como COSEGURO  
LEFT JOIN DB_202613_cj_hernandezg12.CondicionesDePago_RaSA cc 
    ON h.IdCondicionesDePagoCoseguro_DWH = cc.IdCondicionesDePago_DWH 
   
-- Relacion con Condicion de Pago interpretada como COPAGO  
LEFT JOIN DB_202613_cj_hernandezg12.CondicionesDePago_RaSA cp 
    ON h.IdCondicionesDePagoCopago_DWH = cp.IdCondicionesDePago_DWH
    
-- Relacion Historica de Condiciones de Beneficios  
LEFT JOIN DB_202613_cj_hernandezg12.HechoHistCondicionesTiposBeneficio_RaSA ctb
    ON ctb.IdCondicionesTipoBeneficios_DWH = m.IdCondicionesTipoBeneficios_DWH
    AND ctb.IdTipoBeneficio_DWH = t.IdTipoBeneficio_DWH
LIMIT 10000;

SELECT * FROM HechoPlanesTiposBeneficio_Looker_Muestra;
