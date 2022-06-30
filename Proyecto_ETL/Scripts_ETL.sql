SELECT 
		num_ticket
		, categoria
		, tipo
		, detalle
		, ubicacion
		,

		CASE estado
			WHEN 'Terminado' THEN 'Cerrado'
			ELSE estado
		END as estado,
	
		CONVERT(date, TRIM(fecha_creacion), 103) as 'fecha_creacion',
		CONVERT(date, TRIM(COALESCE(fecha_termino, fecha_cierre)), 103) as 'fecha_real_fin',
		
		CASE CHARINDEX(' - ', ubicacion)
		WHEN 0 THEN NULL
		ELSE CHARINDEX(' - ', ubicacion) + 3
		END as inicio,
		len(ubicacion) as fin

	INTO STAGING.dbo.ETL_BaseTickets
	FROM STAGING.dbo.BaseTickets;

    	SELECT	A.num_ticket,
			
			CASE A.inicio
				WHEN NULL THEN NULL
				ELSE TRIM(SUBSTRING(A.ubicacion, A.inicio, A.fin))
			END as 'AgenciaID',
			
			CASE C.CategoriaID
				WHEN NULL THEN 10
				ELSE C.CategoriaID
			END as 'CategoriaID',
			
			CASE T.TipoID
				WHEN NULL THEN 100
				ELSE T.TipoID
			END as 'TipoID',

			CASE D.DetalleID
				WHEN NULL THEN 100
				ELSE D.DetalleID
			END as 'DetalleID',

			A.estado,
			A.fecha_creacion,
			A.fecha_real_fin
	INTO STAGING.dbo.ETL_BaseTickets2
	FROM STAGING.dbo.ETL_BaseTickets A
	LEFT JOIN STAGING.dbo.Categoria C
	ON A.categoria = C.Categoria
	LEFT JOIN STAGING.dbo.Tipo T
	ON A.tipo = T.Tipo
	LEFT JOIN STAGING.dbo.Detalle D
	ON A.detalle = D.Detalle;

    
	SELECT	num_ticket,

	CONVERT(date, TRIM(fecha_programada), 103) as 'fecha_programada',

	TRIM(service_desk) as 'service_desk',

	CASE LEFT(UPPER(TRIM(tipo_ticket)), 4)
		WHEN 'DIFE' THEN 'FLAT'
		WHEN 'VARI' THEN 'VARIABLE'
		ELSE UPPER(TRIM(tipo_ticket))
	END as 'tipo_ticket',

	TRIM(proveedor) as 'proveedor',

	CAST(
	CASE costo
		WHEN 'SIN COSTO' then NULL
		ELSE costo
	END 
	as smallmoney)
	as 'costo'

	INTO STAGING.dbo.ETL_atenciones1
	FROM STAGING.dbo.BaseAtenciones;


    	INSERT INTO STAGING.dbo.Atenciones
	SELECT	A.num_ticket,
			T.AgenciaID,
			T.CategoriaID,
			T.TipoID,
			T.DetalleID,
			T.fecha_creacion, 
			A.fecha_programada,
			T.fecha_real_fin,
			T.estado,
			A.service_desk,
			A.tipo_ticket,
			A.proveedor,
			A.costo
	FROM STAGING.dbo.ETL_atenciones1 as A
	INNER JOIN STAGING.dbo.ETL_BaseTickets2 as T
	ON A.num_ticket = T.num_ticket;