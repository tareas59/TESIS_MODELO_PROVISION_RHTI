-- ===============================================================================
--
-- Author            : Carlos Daniel Martinez Ortiz
-- Create date       : 2017-04-15
-- Stored Procedure  : 1
-- Description       : Carga de las siguientes tablas de recursos humanos de TI
--                     1) Candidatos
--                     2) Educacion_academica_cand
--                     3) Experiencia_laboral_cand
--                     4) Empleos_cand
--                     5) Idiomas_cand
--                     6) Puestos_TI_cand
--                     7) Conocimientos_cand
--                     8) Preferencias_cand
--
-- ================================================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SE UTILIZARÁ LA BASE DE DATOS tesisrh

USE tesisrh
GO


CREATE PROCEDURE [dbo].[SP_CARGA_TABLAS_1_RH_TI] 

USE tesisrh
GO

-- DECLARACIÓN DE VARIABLES
DECLARE
-- Variables para la tabla: Candidatos
	@T1_Id_candidato       char(10),
	@T1_Timestamp          datetime,
	@T1_Nombre             char(50),
	@T1_Sexo               char(10),
	@T1_Edad               int,
	@T1_Estado_civil       char(10),

-- Variables para la tabla: Educacion_academica_cand
	@T2_Id_candidato       char(10),
    @T2_Id_nivel           int, 
	@T2_Id_situacion       int, 
	@T2_Anio_sit           int, 
	@T2_Institucion        char(100), 
	@T2_Carrera            char(100), 
	@T2_Relacion_ti        char(1),

-- Variables para la tabla: Experiencia_laboral_cand
    @T3_Id_candidato       char(10),
    @T3_Exper_laboral      int,
    @T3_Total_empleos      int,
    @T3_Antig_max_empleo   int,
    @T3_Antig_min_empleo   int,
    @T3_Tiempo_max_inac    int,

-- Variables para la tabla: Empleos_cand
    @T4_Id_candidato       char(10),
	@T4_Id_tipo_empleo     int,
    @T4_Antiguedad         int,
	@T4_Anio_ini           int,   
	@T4_Anio_fin           int, 
	@T4_Sector             char(3), 
	@T4_Nombre_empresa     char(100), 
	@T4_Puesto             char(50), 
	@T4_Antig_ult_puesto   int, 
	@T4_Sueldo             decimal(15,2),

-- Variables para la tabla: Idiomas_cand
    @T5_Id_candidato       char(10), 
	@T5_Id_Idioma          char(3), 
	@T5_Id_valor_Idioma    int,

-- Variables para la tabla: Preferencias_cand
    @T6_Id_candidato       char(10), 
	@T6_Id_preferencia     int, 
	@T6_Id_estado_pref     int, 
	@T6_valor_estado_pref  int,

-- Variables de paso
	@P_situacion_acad      char(50),
	@P_posicion            int,


-- Variables para la tabla: Encuesta_General
	@E_Id_candidato            char(10),
	@E_Timestamp               datetime,
	@E_Nombre                  char(50),
	@E_Sexo                    char(10),
	@E_Edad                    int,
	@E_Estado_civil            char(10),

    @E_Preg_estudios_ems       char(2),
    @E_Eb_grado_max            char(50),
    @E_Eb_situacion            char(50),
    @E_Eb_anio_situacion       int,
    @E_Ems_situacion           char(50),
    @E_Ems_anio_situacion      int,
    @E_Ems_institucion         char(100),
    @E_Ems_especialidad        char(100),
    @E_Ems_pertenece_TI        char(2),
    @E_Preg_estudios_es        char(2),
    @E_Es_situacion            char(50),
    @E_Es_anio_situacion       int,
    @E_Es_institucion          char(100),
    @E_Es_carrera              char(100),
    @E_Es_pertenece_TI         char(2),
    @E_Preg_estudios_maestria  char(2),
    @E_Maest_situacion         char(50),
    @E_Maest_anio_situacion    int,
    @E_Maest_institucion       char(100),          
    @E_Maest_carrera           char(100), 
    @E_Maest_pertenece_TI      char(2),
    @E_Preg_estudios_doctorado char(2),
    @E_Doc_situacion           char(50),
    @E_Doc_anio_situacion      int,
    @E_Doc_institucion         char(100),
    @E_Doc_carrera             char(100),
    @E_Doc_pertenece_TI        char(2),

    @E_Preg_exp_laboral_TI     char(2),
    @E_Anios_experiencia       int,
    @E_Num_empleos_TI          int,
    @E_Max_antig_empleo_TI     int,
    @E_Min_antig_empleo_TI     int,
    @E_Max_tiempo_inactividad  char(50),

    @E_Preg_empl_relac_TI      char(2),
    @E_Tact_antig              int,
    @E_Tact_sector             char(10),
    @E_Tact_empresa            char(100),
    @E_Tact_puesto             char(50),
    @E_Tact_antig_puesto       int,
    @E_Tact_sueldo             char(50),
    @E_Tult_antig              int,
    @E_Tult_anio_salida        int,
    @E_Tult_sector             char(10),
    @E_Tult_empresa            char(100),
    @E_Tult_puesto             char(50),
    @E_Tult_antig_puesto       int,
	@E_Tult_sueldo             char(50),

    @E_Factores_dl             char(500),

	@E_Factores_at_calidad     int,  
    @E_Factores_at_sueldo      int,
    @E_Factores_at_estabilidad int,
    @E_Factores_at_crecimiento int,
    @E_Factores_at_reconoc     int,

	@E_Idiomas_ingles          char(20), 
    @E_Idiomas_frances         char(20),
    @E_Idiomas_aleman          char(20),
    @E_Idiomas_japones         char(20),
    @E_Idiomas_mandarin        char(20)



-- DECLARACIÓN del cursor Encuesta_general_cursor para leer la tabla Encuesta_General
DECLARE Encuesta_general_cursor CURSOR FOR  
SELECT Id_candidato,
       Timestamp,
       Nombre,
       Sexo,
       Edad,
       Estado_civil,

       Preg_estudios_ems,
       Eb_grado_max,
       Eb_situacion,
       Eb_anio_situacion,
       Ems_situacion,
       Ems_anio_situacion,
       Ems_institucion,
       Ems_especialidad,
       Ems_pertenece_TI,
       Preg_estudios_es,
       Es_situacion,
       Es_anio_situacion,
       Es_institucion,
       Es_carrera,
       Es_pertenece_TI,
       Preg_estudios_maestria,
       Maest_situacion,
       Maest_anio_situacion,
       Maest_institucion,
       Maest_carrera,
       Maest_pertenece_TI,	   
	   Preg_estudios_doctorado,
       Doc_situacion,
       Doc_anio_situacion,
       Doc_institucion,
       Doc_carrera,
       Doc_pertenece_TI,

       Preg_exp_laboral_TI,
       Anios_experiencia,
       Num_empleos_TI,
       Max_antig_empleo_TI,
       Min_antig_empleo_TI,
       Max_tiempo_inactividad,

       Preg_empl_relac_TI,
       Tact_antig,
       Tact_sector,
       Tact_empresa,
       Tact_puesto,
       Tact_antig_puesto,
       Tact_sueldo,
       Tult_antig,
       Tult_anio_salida,
       Tult_sector,
       Tult_empresa,
       Tult_puesto,
       Tult_antig_puesto,
       Tult_sueldo,

	   Factores_dl,

	   Factores_at_calidad,  
       Factores_at_sueldo,
       Factores_at_estabilidad,
       Factores_at_crecimiento,
       Factores_at_reconoc,

       Idiomas_ingles, 
       Idiomas_frances,
       Idiomas_aleman,
       Idiomas_japones,
       Idiomas_mandarin

FROM [dbo].[Encuesta_General]
ORDER BY [Id_candidato];

-- APRETURA DEL CURSOR Encuesta_general_cursor
OPEN Encuesta_general_cursor

-- LECTURA DEL CURSOR Encuesta_general_cursor (PRIMER REGISTRO)
FETCH NEXT FROM Encuesta_general_cursor
  INTO 	@E_Id_candidato,	
        @E_Timestamp,
    	@E_Nombre,
	    @E_Sexo,
	    @E_Edad,
	    @E_Estado_civil,

        @E_Preg_estudios_ems,
        @E_Eb_grado_max,
        @E_Eb_situacion,
        @E_Eb_anio_situacion,
        @E_Ems_situacion,
        @E_Ems_anio_situacion,
        @E_Ems_institucion,
        @E_Ems_especialidad,
        @E_Ems_pertenece_TI,
        @E_Preg_estudios_es,
        @E_Es_situacion,
        @E_Es_anio_situacion,
        @E_Es_institucion,
        @E_Es_carrera,
        @E_Es_pertenece_TI,
        @E_Preg_estudios_maestria,
        @E_Maest_situacion,
        @E_Maest_anio_situacion,
        @E_Maest_institucion,
        @E_Maest_carrera,
        @E_Maest_pertenece_TI, 
        @E_Preg_estudios_doctorado,
        @E_Doc_situacion,
        @E_Doc_anio_situacion,
        @E_Doc_institucion,
        @E_Doc_carrera,
        @E_Doc_pertenece_TI,
	    
		@E_Preg_exp_laboral_TI,
        @E_Anios_experiencia,
        @E_Num_empleos_TI,
        @E_Max_antig_empleo_TI,
        @E_Min_antig_empleo_TI,
        @E_Max_tiempo_inactividad,

        @E_Preg_empl_relac_TI,
        @E_Tact_antig,
        @E_Tact_sector,
        @E_Tact_empresa,
        @E_Tact_puesto,
        @E_Tact_antig_puesto,
        @E_Tact_sueldo,
        @E_Tult_antig,
        @E_Tult_anio_salida,
        @E_Tult_sector,
        @E_Tult_empresa,
        @E_Tult_puesto,
        @E_Tult_antig_puesto,
        @E_Tult_sueldo,

		@E_Factores_dl,

        @E_Factores_at_calidad,  
        @E_Factores_at_sueldo,
        @E_Factores_at_estabilidad,
        @E_Factores_at_crecimiento,
        @E_Factores_at_reconoc,

        @E_Idiomas_ingles, 
        @E_Idiomas_frances,
        @E_Idiomas_aleman,
        @E_Idiomas_japones,
        @E_Idiomas_mandarin
 

-- CICLO PARA LEER LA TABLA: Encuesta_General
WHILE @@FETCH_STATUS = 0  
BEGIN  
   -- Mensaje de salida
   PRINT 'CANDIDATO: ' + @E_Id_candidato + ' ' +  @E_Nombre  

-- ========>>> LLENADO DE LA TABLA: Candidatos <<<<   

-- Se pasan valores de la tabla: Encuesta_General a tabla: Candidatos
SET @T1_Id_candidato = @E_Id_candidato
SET @T1_Nombre       = @E_Nombre
SET	@T1_Edad         = @E_Edad
SET	@T1_Timestamp    = @E_Timestamp

-- Se transforman las valores de los siguientes campos
   IF @E_Sexo = 'Masculino'
      SET @T1_Sexo = 'M';
   ELSE
      SET @T1_Sexo = 'F';

   IF @E_Estado_civil = 'Soltero(a)'
      SET @T1_Estado_civil = 'S';
   ELSE
     IF @E_Estado_civil = 'Casado(a)'
        SET @T1_Estado_civil = 'C';
     ELSE
        SET @T1_Estado_civil = 'O';


   -- INSERTA EN TABLA: Candidatos
   INSERT INTO [dbo].[Candidatos]
         (Id_candidato, 
		  Nombre, 
		  Sexo, 
		  Edad, 
		  Estado_civil,
		  Fecha_encuesta
		  )
		  Values
		 (@T1_Id_candidato,	
    	  @T1_Nombre,
	      @T1_Sexo,
	      @T1_Edad,
	      @T1_Estado_civil,
		  @T1_Timestamp
		  )

-- ========>>> LLENADO DE LA TABLA: Educacion_academica_cand <<<<   

-- Se pasan valores de la tabla: Encuesta_General a tabla: Educacion_academica_cand

SET	@T2_Id_candidato  = @E_Id_candidato


--=== EDUCACION BASICA O EDUCACION MEDIA SUPERIOR

-- Se transforman las valores de los siguientes campos
   IF @E_Preg_estudios_ems = 'Si'
     BEGIN
      SET @T2_Id_nivel      = 3
	  SET @T2_Anio_sit      = @E_Ems_anio_situacion
	  SET @T2_Institucion   = @E_Ems_institucion
	  SET @T2_Carrera       = @E_Ems_especialidad    
      SET @T2_Relacion_ti   = substring(@E_Ems_pertenece_TI,1,1)	  
      SET @P_situacion_acad = @E_Ems_situacion
	END
   ELSE
      IF @E_Eb_grado_max = 'Primaria'
        BEGIN
         SET @T2_Id_nivel      = 1
         SET @T2_Anio_sit      = @E_Eb_anio_situacion
		 SET @T2_Institucion   = ' '
		 SET @T2_Carrera       = ' '
    	 SET @T2_Relacion_ti   = 'N'
    	 SET @P_situacion_acad = @E_Eb_situacion;
		 IF @E_Eb_situacion = 'Concluido'
		    SET @P_situacion_acad	= 'Concluido (sin título)';  
        END
      ELSE
        BEGIN
         SET @T2_Id_nivel      = 2
         SET @T2_Anio_sit      = @E_Eb_anio_situacion
		 SET @T2_Institucion   = ' '
		 SET @T2_Carrera       = ' '
    	 SET @T2_Relacion_ti   = 'N'	  
    	 SET @P_situacion_acad = @E_Eb_situacion;
		 IF @E_Eb_situacion = 'Concluido'
		    SET @P_situacion_acad	= 'Concluido (sin título)';  
        END

      -- Se obtiene el Id del nivel de educación
      SET @T2_Id_situacion =
       ( SELECT Id_situacion FROM [dbo].[Codigos_situacion_acad]
          WHERE Descrip_situacion =  @P_situacion_acad); 

   -- Mensaje de salida
   PRINT '@P_situacion_acad : ' + @P_situacion_acad 
   PRINT '@T2_Id_situacion: ' + cast (@T2_Id_situacion as varchar(5))
   PRINT '@T2_Institucion: ' + @T2_Institucion


   -- INSERTA EN TABLA: Educacion_academica_cand (Educación basica o Educación media superior)

   INSERT INTO [dbo].[Educacion_academica_cand]
         (Id_candidato, 
		  Id_nivel, 
		  Id_situacion, 
		  Anio_sit, 
		  Institucion, 
		  Carrera, 
		  Relacion_ti
		  )
		  Values
         (@T2_Id_candidato, 
		  @T2_Id_nivel, 
		  @T2_Id_situacion,
		  @T2_Anio_sit, 
		  @T2_Institucion, 
		  @T2_Carrera,
		  @T2_Relacion_ti
		  )

--=== EDUCACION SUPERIOR

-- Se transforman las valores de los siguientes campos
   IF @E_Preg_estudios_es = 'Si'
    BEGIN
      SET @T2_Id_nivel      = 4
	  SET @T2_Anio_sit      = @E_Es_anio_situacion
	  SET @T2_Institucion   = @E_Es_institucion
	  SET @T2_Carrera       = @E_Es_carrera    
      SET @T2_Relacion_ti   = substring(@E_Es_pertenece_TI,1,1)	  
      SET @P_situacion_acad = @E_Es_situacion

    -- Se obtiene el Id del nivel de educación
      SET @T2_Id_situacion =
       ( SELECT Id_situacion FROM [dbo].[Codigos_situacion_acad]
          WHERE Descrip_situacion =  @P_situacion_acad); 

   -- Mensaje de salida
   PRINT '@P_situacion_acad : ' + @P_situacion_acad 
   PRINT '@T2_Id_situacion: ' + cast (@T2_Id_situacion as varchar(5))
   PRINT '@T2_Institucion: ' + @T2_Institucion


   -- INSERTA EN TABLA: Educacion_academica_cand (Educación superior)

   INSERT INTO [dbo].[Educacion_academica_cand]
         (Id_candidato, 
		  Id_nivel, 
		  Id_situacion, 
		  Anio_sit, 
		  Institucion, 
		  Carrera, 
		  Relacion_ti
		  )
		  Values
         (@T2_Id_candidato, 
		  @T2_Id_nivel, 
		  @T2_Id_situacion,
		  @T2_Anio_sit, 
		  @T2_Institucion, 
		  @T2_Carrera,
		  @T2_Relacion_ti
		  )

    END

--=== EDUCACION MAESTRÍA

-- Se transforman las valores de los siguientes campos
   IF @E_Preg_estudios_maestria = 'Si'
    BEGIN
      SET @T2_Id_nivel      = 5
	  SET @T2_Anio_sit      = @E_Maest_anio_situacion
	  SET @T2_Institucion   = @E_Maest_institucion
	  SET @T2_Carrera       = @E_Maest_carrera    
      SET @T2_Relacion_ti   = substring(@E_Maest_pertenece_TI,1,1)	  
      SET @P_situacion_acad = @E_Maest_situacion

    -- Se obtiene el Id del nivel de educación
      SET @T2_Id_situacion =
       ( SELECT Id_situacion FROM [dbo].[Codigos_situacion_acad]
          WHERE Descrip_situacion =  @P_situacion_acad); 

   -- Mensaje de salida
   PRINT '@P_situacion_acad : ' + @P_situacion_acad 
   PRINT '@T2_Id_situacion: ' + cast (@T2_Id_situacion as varchar(5))
   PRINT '@T2_Institucion: ' + @T2_Institucion


   -- INSERTA EN TABLA: Educacion_academica_cand (Educación Maestría)

   INSERT INTO [dbo].[Educacion_academica_cand]
         (Id_candidato, 
		  Id_nivel, 
		  Id_situacion, 
		  Anio_sit, 
		  Institucion, 
		  Carrera, 
		  Relacion_ti
		  )
		  Values
         (@T2_Id_candidato, 
		  @T2_Id_nivel, 
		  @T2_Id_situacion,
		  @T2_Anio_sit, 
		  @T2_Institucion, 
		  @T2_Carrera,
		  @T2_Relacion_ti
		  )

    END

--=== EDUCACION DOCTORADO

-- Se transforman las valores de los siguientes campos
   IF @E_Preg_estudios_doctorado = 'Si'
    BEGIN
      SET @T2_Id_nivel      = 6
	  SET @T2_Anio_sit      = @E_Doc_anio_situacion
	  SET @T2_Institucion   = @E_Doc_institucion
	  SET @T2_Carrera       = @E_Doc_carrera    
      SET @T2_Relacion_ti   = substring(@E_Doc_pertenece_TI,1,1)	  
      SET @P_situacion_acad = @E_Doc_situacion

    -- Se obtiene el Id del nivel de educación
      SET @T2_Id_situacion =
       ( SELECT Id_situacion FROM [dbo].[Codigos_situacion_acad]
          WHERE Descrip_situacion =  @P_situacion_acad); 

   -- Mensaje de salida
   PRINT '@P_situacion_acad : ' + @P_situacion_acad 
   PRINT '@T2_Id_situacion: ' + cast (@T2_Id_situacion as varchar(5))
   PRINT '@T2_Institucion: ' + @T2_Institucion


   -- INSERTA EN TABLA: Educacion_academica_cand (Educación Doctorado)

   INSERT INTO [dbo].[Educacion_academica_cand]
         (Id_candidato, 
		  Id_nivel, 
		  Id_situacion, 
		  Anio_sit, 
		  Institucion, 
		  Carrera, 
		  Relacion_ti
		  )
		  Values
         (@T2_Id_candidato, 
		  @T2_Id_nivel, 
		  @T2_Id_situacion,
		  @T2_Anio_sit, 
		  @T2_Institucion, 
		  @T2_Carrera,
		  @T2_Relacion_ti
		  )

    END



-- ========>>> LLENADO DE LA TABLA: Experiencia_laboral_cand <<<<   

-- Se pasan valores de la tabla: Encuesta_General a tabla: Experiencia_laboral_cand

SET @T3_Id_candidato      = @E_Id_candidato
SET @T3_Exper_laboral     = @E_Anios_experiencia
SET @T3_Total_empleos     = @E_Num_empleos_TI
SET @T3_Antig_max_empleo  = @E_Max_antig_empleo_TI
SET @T3_Antig_min_empleo  = @E_Min_antig_empleo_TI


-- Se transforman las valores de los siguientes campos
--NOTACD_1 : Cambiar en formulario (Quitar el acento en la palabra Sí)
   IF @E_Preg_exp_laboral_TI = 'Sí'
     BEGIN
	   
	   SET @T3_Tiempo_max_inac =
	     (CASE @E_Max_tiempo_inactividad
		    WHEN 'Menos de 1 mes' THEN 0
		    WHEN '1 mes'          THEN 1
		    WHEN '2 meses'        THEN 2
		    WHEN '3 meses'        THEN 3
		    WHEN '4 meses'        THEN 4
		    WHEN '5 meses'        THEN 5
		    WHEN '6 meses'        THEN 6
		    WHEN '7 meses'        THEN 7
		    WHEN '8 meses'        THEN 8
		    WHEN '9 meses'        THEN 9
		    WHEN '10 meses'       THEN 10
		    WHEN '11 meses'       THEN 11
		    WHEN '1 año'          THEN 12
		    WHEN 'Más de 1 año'   THEN 13
			ELSE 99
	      END
	      )

   -- Mensaje de salida
     PRINT '@E_Max_tiempo_inactividad : ' + @E_Max_tiempo_inactividad 
     PRINT '@T3_Tiempo_max_inac      : ' + cast (@T3_Tiempo_max_inac as varchar(5)) 

   -- INSERTA EN TABLA: Experiencia_laboral_cand

     INSERT INTO [dbo].[Experiencia_laboral_cand]
         (Id_candidato, 
		  Exper_laboral, 
		  Total_empleos, 
		  Antig_max_empleo, 
		  Antig_min_empleo, 
		  Tiempo_max_inac

		  )
		  Values
         (@T3_Id_candidato, 
		  @T3_Exper_laboral, 
		  @T3_Total_empleos,
		  @T3_Antig_max_empleo, 
		  @T3_Antig_min_empleo, 
		  @T3_Tiempo_max_inac
		  )

     END


 -- ========>>> LLENADO DE LA TABLA: Empleos_cand <<<<   

   IF @E_Preg_empl_relac_TI = 'Si' OR 
      @E_Preg_empl_relac_TI = 'No'
	 
	 BEGIN

-- Se pasan valores de la tabla: Encuesta_General a tabla: Empleos_cand   
       SET @T4_Id_candidato       = @E_Id_candidato  

-- Se transforman las valores de los siguientes campos
--NOTACD_1 : Cambiar en formulario (Quitar el acento en la palabra Sí)
      IF @E_Preg_empl_relac_TI = 'Si'
         BEGIN
            SET @T4_Id_tipo_empleo     = 1
            SET @T4_Antiguedad         = @E_Tact_antig
            SET @T4_Anio_ini           = (YEAR(@E_Timestamp) - @E_Tact_antig  )
            SET @T4_Anio_fin           = (YEAR(@E_Timestamp)) 
            SET @T4_Nombre_empresa     = @E_Tact_empresa
            SET @T4_Puesto             = @E_Tact_puesto
            SET @T4_Antig_ult_puesto   = @E_Tact_antig_puesto

            SET @T4_Sector   = 
		  (CASE @E_Tact_sector   
		    WHEN 'Público'          THEN   'PUB'
		    WHEN 'Privado'          THEN   'PRI'
            ELSE                           'OTR'
	       END
	      )

       	    SET @T4_Sueldo =
	      (CASE @E_Tact_sueldo
		    WHEN 'Prefiero no especificar'          THEN     00.00
		    WHEN 'Menos de 5,000 pesos'             THEN   5000.00
		    WHEN 'Entre 5,001 y 10,000 mil pesos'   THEN  10000.00
		    WHEN 'Entre 10,001 y 15,000 mil pesos'  THEN  15000.00
		    WHEN 'Entre 15,001 y 20,000 mil pesos'  THEN  20000.00
		    WHEN 'Entre 20,001 y 25,000 mil pesos'  THEN  25000.00
		    WHEN 'Entre 25,001 y 30,000 mil pesos'  THEN  30000.00
		    WHEN 'Entre 30,001 y 35,000 mil pesos'  THEN  35000.00
		    WHEN 'Entre 35,001 y 40,000 mil pesos'  THEN  40000.00
		    WHEN 'Entre 40,001 y 45,000 mil pesos'  THEN  45000.00
		    WHEN 'Entre 45,001 y 50,000 mil pesos'  THEN  50000.00
		    WHEN 'Entre 50,001 y 55,000 mil pesos'  THEN  55000.00
		    WHEN 'Entre 55,001 y 60,000 mil pesos'  THEN  60000.00
		    WHEN 'Entre 60,001 y 65,000 mil pesos'  THEN  65000.00
		    WHEN 'Entre 65,001 y 70,000 mil pesos'  THEN  70000.00
		    WHEN 'Entre 70,001 y 75,000 mil pesos'  THEN  75000.00
		    WHEN 'Entre 75,001 y 80,000 mil pesos'  THEN  80000.00
		    WHEN 'Entre 80,001 y 85,000 mil pesos'  THEN  85000.00
		    WHEN 'Entre 85,001 y 90,000 mil pesos'  THEN  90000.00
		    WHEN 'Entre 90,001 y 95,000 mil pesos'  THEN  95000.00
		    WHEN 'Entre 95,001 y 100,000 mil pesos' THEN 100000.00
		    WHEN 'Más de 100,000 mil pesos'         THEN 100001.00
			ELSE 999999.00
	      END
	      )

		 END

	  ELSE
         BEGIN
            SET @T4_Id_tipo_empleo     = 2
            SET @T4_Antiguedad         = @E_Tult_antig
            SET @T4_Anio_ini           = @E_Tult_anio_salida - @E_Tult_antig  
            SET @T4_Anio_fin           = @E_Tult_anio_salida
            SET @T4_Nombre_empresa     = @E_Tult_empresa
            SET @T4_Puesto             = @E_Tult_puesto
            SET @T4_Antig_ult_puesto   = @E_Tult_antig_puesto

            SET @T4_Sector   = 
		  (CASE @E_Tult_sector   
		    WHEN 'Público'          THEN   'PUB'
		    WHEN 'Privado'          THEN   'PRI'
            ELSE                           'OTR'
	       END
	      )

       	    SET @T4_Sueldo =
	      (CASE @E_Tult_sueldo
		    WHEN 'Prefiero no especificar'          THEN     00.00
		    WHEN 'Menos de 5,000 pesos'             THEN   5000.00
		    WHEN 'Entre 5,001 y 10,000 mil pesos'   THEN  10000.00
		    WHEN 'Entre 10,001 y 15,000 mil pesos'  THEN  15000.00
		    WHEN 'Entre 15,001 y 20,000 mil pesos'  THEN  20000.00
		    WHEN 'Entre 20,001 y 25,000 mil pesos'  THEN  25000.00
		    WHEN 'Entre 25,001 y 30,000 mil pesos'  THEN  30000.00
		    WHEN 'Entre 30,001 y 35,000 mil pesos'  THEN  35000.00
		    WHEN 'Entre 35,001 y 40,000 mil pesos'  THEN  40000.00
		    WHEN 'Entre 40,001 y 45,000 mil pesos'  THEN  45000.00
		    WHEN 'Entre 45,001 y 50,000 mil pesos'  THEN  50000.00
		    WHEN 'Entre 50,001 y 55,000 mil pesos'  THEN  55000.00
		    WHEN 'Entre 55,001 y 60,000 mil pesos'  THEN  60000.00
		    WHEN 'Entre 60,001 y 65,000 mil pesos'  THEN  65000.00
		    WHEN 'Entre 65,001 y 70,000 mil pesos'  THEN  70000.00
		    WHEN 'Entre 70,001 y 75,000 mil pesos'  THEN  75000.00
		    WHEN 'Entre 75,001 y 80,000 mil pesos'  THEN  80000.00
		    WHEN 'Entre 80,001 y 85,000 mil pesos'  THEN  85000.00
		    WHEN 'Entre 85,001 y 90,000 mil pesos'  THEN  90000.00
		    WHEN 'Entre 90,001 y 95,000 mil pesos'  THEN  95000.00
		    WHEN 'Entre 95,001 y 100,000 mil pesos' THEN 100000.00
		    WHEN 'Más de 100,000 mil pesos'         THEN 100001.00
			ELSE 999999.00
	      END
	      )

		 END


   -- Mensaje de salida
      PRINT '@E_Tact_sueldo : ' + @E_Tact_sueldo 
      PRINT '@E_Tult_sueldo : ' + @E_Tult_sueldo 
--      PRINT '@T4_Sueldo      : ' + cast (@T4_Sueldo as decimal(15,2)) 
 
   -- INSERTA EN TABLA: Experiencia_laboral_cand
    
      INSERT INTO [dbo].[Empleos_cand]
          (Id_candidato, 
		   Id_tipo_empleo, 
		   Antiguedad, 
		   Anio_ini, 
		   Anio_fin, 
		   Sector, 
		   Nombre_empresa, 
		   Puesto, 
		   Antig_ult_puesto, 
		   Sueldo   
		  )
		  Values
         (@T4_Id_candidato, 
		  @T4_Id_tipo_empleo, 
		  @T4_Antiguedad,
		  @T4_Anio_ini, 
		  @T4_Anio_fin, 
		  @T4_Sector,
		  @T4_Nombre_empresa,
		  @T4_Puesto,
		  @T4_Antig_ult_puesto,
		  @T4_Sueldo
		  )

     END


-- ========>>> LLENADO DE LA TABLA: Idiomas_cand <<<<   

--== IDIOMA: INGLÉS
   IF (SELECT ISNULL(@E_Idiomas_ingles,'No lo conozco')) <> 'No lo conozco'
    
	 BEGIN

-- Se pasan valores de la tabla: Encuesta_General a tabla: Empleos_cand   
       SET @T5_Id_candidato       = @E_Id_candidato  
	   SET @T5_Id_Idioma          = 'ING'

-- Se transforman las valores de los siguientes campos
	   SET @T5_Id_valor_Idioma     = 
       (CASE @E_Idiomas_ingles
		    WHEN 'No lo conozco'      THEN  0
		    WHEN 'Bajo'               THEN  1
		    WHEN 'Medio'              THEN  2
		    WHEN 'Alto'               THEN  3
		    WHEN 'Con certificación'  THEN  4
			ELSE 9
	     END
		)

   -- Mensaje de salida
      PRINT '@T5_Id_Idioma : ' + @T5_Id_Idioma 
      PRINT '@T5_Id_valor_Idioma   : ' + cast (@T5_Id_valor_Idioma as varchar(5)) 
 
   -- INSERTA EN TABLA: Idiomas_cand

      INSERT INTO [dbo].[Idiomas_cand]
          (Id_candidato, 
		   Id_Idioma, 
		   Id_valor_Idioma 
		  )
		  Values
         (@T5_Id_candidato, 
		  @T5_Id_Idioma, 
		  @T5_Id_valor_Idioma
		  )
     END

--== IDIOMA: FRANCÉS
   IF (SELECT ISNULL(@E_Idiomas_frances,'No lo conozco')) <> 'No lo conozco'
 
	 BEGIN

-- Se pasan valores de la tabla: Encuesta_General a tabla: Empleos_cand   
       SET @T5_Id_candidato       = @E_Id_candidato  
	   SET @T5_Id_Idioma          = 'FRA'

-- Se transforman las valores de los siguientes campos
	   SET @T5_Id_valor_Idioma     = 
       (CASE @E_Idiomas_frances
		    WHEN 'No lo conozco'      THEN  0
		    WHEN 'Bajo'               THEN  1
		    WHEN 'Medio'              THEN  2
		    WHEN 'Alto'               THEN  3
		    WHEN 'Con certificación'  THEN  4
			ELSE 9
	     END
		)

   -- Mensaje de salida
      PRINT '@T5_Id_Idioma : ' + @T5_Id_Idioma 
      PRINT '@T5_Id_valor_Idioma   : ' + cast (@T5_Id_valor_Idioma as varchar(5)) 
 
   -- INSERTA EN TABLA: Idiomas_cand
    
      INSERT INTO [dbo].[Idiomas_cand]
          (Id_candidato, 
		   Id_Idioma, 
		   Id_valor_Idioma 
		  )
		  Values
         (@T5_Id_candidato, 
		  @T5_Id_Idioma, 
		  @T5_Id_valor_Idioma
		  )
    END

--== IDIOMA: ALEMAN
   IF (SELECT ISNULL(@E_Idiomas_aleman,'No lo conozco')) <> 'No lo conozco'
 
	 BEGIN

-- Se pasan valores de la tabla: Encuesta_General a tabla: Empleos_cand   
       SET @T5_Id_candidato       = @E_Id_candidato  
	   SET @T5_Id_Idioma          = 'ALE'

-- Se transforman las valores de los siguientes campos
	   SET @T5_Id_valor_Idioma     = 
       (CASE @E_Idiomas_aleman
		    WHEN 'No lo conozco'      THEN  0
		    WHEN 'Bajo'               THEN  1
		    WHEN 'Medio'              THEN  2
		    WHEN 'Alto'               THEN  3
		    WHEN 'Con certificación'  THEN  4
			ELSE 9
	     END
		)

   -- Mensaje de salida
      PRINT '@T5_Id_Idioma : ' + @T5_Id_Idioma 
      PRINT '@T5_Id_valor_Idioma   : ' + cast (@T5_Id_valor_Idioma as varchar(5)) 
 
   -- INSERTA EN TABLA: Idiomas_cand
    
      INSERT INTO [dbo].[Idiomas_cand]
          (Id_candidato, 
		   Id_Idioma, 
		   Id_valor_Idioma 
		  )
		  Values
         (@T5_Id_candidato, 
		  @T5_Id_Idioma, 
		  @T5_Id_valor_Idioma
		  )

     END

--== IDIOMA: JAPONES
   IF (SELECT ISNULL(@E_Idiomas_japones,'No lo conozco')) <> 'No lo conozco'
	 
	 BEGIN

-- Se pasan valores de la tabla: Encuesta_General a tabla: Empleos_cand   
       SET @T5_Id_candidato       = @E_Id_candidato  
	   SET @T5_Id_Idioma          = 'JAP'

-- Se transforman las valores de los siguientes campos
	   SET @T5_Id_valor_Idioma     = 
       (CASE @E_Idiomas_japones
		    WHEN 'No lo conozco'      THEN  0
		    WHEN 'Bajo'               THEN  1
		    WHEN 'Medio'              THEN  2
		    WHEN 'Alto'               THEN  3
		    WHEN 'Con certificación'  THEN  4
			ELSE 9
	     END
		)

   -- Mensaje de salida
      PRINT '@T5_Id_Idioma : ' + @T5_Id_Idioma 
      PRINT '@T5_Id_valor_Idioma   : ' + cast (@T5_Id_valor_Idioma as varchar(5)) 
 
   -- INSERTA EN TABLA: Idiomas_cand
       
      INSERT INTO [dbo].[Idiomas_cand]
          (Id_candidato, 
		   Id_Idioma, 
		   Id_valor_Idioma 
		  )
		  Values
         (@T5_Id_candidato, 
		  @T5_Id_Idioma, 
		  @T5_Id_valor_Idioma
		  )
     END


--== IDIOMA: MANDARÍN
   IF (SELECT ISNULL(@E_Idiomas_mandarin,'No lo conozco')) <> 'No lo conozco'
 
	 BEGIN

-- Se pasan valores de la tabla: Encuesta_General a tabla: Empleos_cand   
       SET @T5_Id_candidato       = @E_Id_candidato  
	   SET @T5_Id_Idioma          = 'MAN'

-- Se transforman las valores de los siguientes campos
	   SET @T5_Id_valor_Idioma     = 
       (CASE @E_Idiomas_mandarin
		    WHEN 'No lo conozco'      THEN  0
		    WHEN 'Bajo'               THEN  1
		    WHEN 'Medio'              THEN  2
		    WHEN 'Alto'               THEN  3
		    WHEN 'Con certificación'  THEN  4
			ELSE 9
	     END
		)

   -- Mensaje de salida
      PRINT '@T5_Id_Idioma : ' + @T5_Id_Idioma 
      PRINT '@T5_Id_valor_Idioma   : ' + cast (@T5_Id_valor_Idioma as varchar(5)) 
 
   -- INSERTA EN TABLA: Idiomas_cand
    
      INSERT INTO [dbo].[Idiomas_cand]
          (Id_candidato, 
		   Id_Idioma, 
		   Id_valor_Idioma 
		  )
		  Values
         (@T5_Id_candidato, 
		  @T5_Id_Idioma, 
		  @T5_Id_valor_Idioma
		  )

     END



 -- ========>>> LLENADO DE LA TABLA: Preferencias_cand (Preferencia 1)<<<<   

IF @E_Preg_exp_laboral_TI = 'Sí'

  BEGIN

   -- Se declaran variables 
   DECLARE @posIni          int,
           @posFin          int,
           @longNueva       int,
	       @preferenX       char(100),
           @P_preferencias  char(500),
	       @P_numPref       int

   -- Se establecen valores inciales de la tabla: Preferencias_cand
   SET @T6_Id_candidato     = @E_Id_candidato
   SET @T6_Id_preferencia   = 1
   SET @P_numPref           = 1
   SET @P_preferencias      = @E_Factores_dl


-- Se pasan valores de la tabla: Encuesta_General a tabla: Empleos_cand   
   
   PRINT '@E_Id_candidato: ' + @E_Id_candidato
   PRINT '@P_preferencias: ' + @P_preferencias

	  
	  SET @posIni = 1

      WHILE LEN(@P_preferencias) > 0

      BEGIN
         SET @posFin = (SELECT CHARINDEX(',', @P_preferencias,@posIni)) - 1
         PRINT '@posFin: ' + cast (@posFin as varchar(5))
         PRINT 'LEN(@P_preferencias): ' + cast ( (LEN(@P_preferencias)) as varchar(5))

		 IF @posFin <= 0
		   BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @preferenX = (SELECT LTRIM( (SELECT SUBSTRING (@P_preferencias,@posIni,LEN(@P_preferencias)) )	))
              PRINT '-----------INSERT 2-----------: ' + @preferenX
              SET @P_preferencias = ''	

			  -- Se pasan valores de la tabla: Encuesta_General a tabla: Preferencias_cand
              SET @T6_valor_estado_pref  = @P_numPref

             -- Se obtiene el Id del estado de la preferencia
              SET @T6_Id_estado_pref =
              ( SELECT Id_estado_pref FROM [dbo].[Codigos_estados_pref]
                    WHERE Descrip_estado like '%' + @preferenX +'%')
               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T6_Id_estado_pref is null
                SET @T6_Id_estado_pref = 99
                
              PRINT '@preferenX        : ' + cast (@preferenX as varchar(100))
              PRINT '@T6_Id_estado_pref: ' + cast (@T6_Id_estado_pref as varchar(5))
           
		      -- INSERTA EN TABLA: Preferencias_cand
    
              INSERT INTO [dbo].[Preferencias_cand]
               (Id_candidato, 
	   	 	    Id_preferencia, 
			    Id_estado_pref, 
			    valor_estado_pref
		       )
		       Values
               (@T6_Id_candidato,
			    @T6_Id_preferencia,
                @T6_Id_estado_pref,
                @T6_valor_estado_pref
		       )
 

           END
		 ELSE
		   BEGIN
              -- Se eliminan con LTRIM el espacio que hay después de la coma
              SET @preferenX = (SELECT LTRIM ((SELECT SUBSTRING (@P_preferencias,@posIni,@posFin) )))

              PRINT '-----------INSERT 1-----------: ' + @preferenX
			  -- Se pasan valores de la tabla: Encuesta_General a tabla: Preferencias_cand
              SET @T6_valor_estado_pref  = @P_numPref
			  
             -- Se obtiene el Id del estado de la preferencia
              SET @T6_Id_estado_pref =
              ( SELECT Id_estado_pref FROM [dbo].[Codigos_estados_pref]
                    WHERE Descrip_estado like '%' + @preferenX +'%')
               -- En caso de que no encuentre el valor del Id del estado de la preferencia se mueve 99
               IF @T6_Id_estado_pref is null
			    BEGIN				  
                  SET @T6_Id_estado_pref = 99
                END

              PRINT '@preferenX        : ' + cast (@preferenX as varchar(100))
              PRINT '@T6_Id_estado_pref: ' + cast (@T6_Id_estado_pref as varchar(5))
           
              
		      -- INSERTA EN TABLA: Preferencias_cand
    
              INSERT INTO [dbo].[Preferencias_cand]
               (Id_candidato, 
	   	 	    Id_preferencia, 
			    Id_estado_pref, 
			    valor_estado_pref
		       )
		       Values
               (@T6_Id_candidato,
			    @T6_Id_preferencia,
                @T6_Id_estado_pref,
                @T6_valor_estado_pref
		       )


			  SET @longNueva =LEN(@P_preferencias) - (@posFin + 1)
      		  SET @P_preferencias = (SELECT SUBSTRING (@P_preferencias,@posFin + 2,@longNueva) )

              PRINT '@posFin: ' + cast (@posFin as varchar(5))
              PRINT '@longNueva: ' + cast (@longNueva as varchar(5))
              PRINT '@P_preferencias: ' + cast (@P_preferencias as varchar(100))
              PRINT '@P_preferencias: ' + cast ((LEN(@P_preferencias)) as varchar(100))

           END

		   SET @P_numPref        = @P_numPref + 1

      END  
 END


-- ========>>> LLENADO DE LA TABLA: Preferencias_cand (Preferencia 2)<<<<   

--== PREFERENCIA 2_: CALIDAD DE VIDA
   IF @E_Factores_at_calidad IS NOT NULL 
	 
	 BEGIN

        -- Se pasan valores de la tabla: Encuesta_General a tabla: Preferencias_cand
            SET @T6_Id_candidato       = @E_Id_candidato
            SET @T6_Id_preferencia     = 2
            SET @T6_Id_estado_pref     = 1
            SET @T6_valor_estado_pref  = @E_Factores_at_calidad

		-- INSERTA EN TABLA: Preferencias_cand
    
          INSERT INTO [dbo].[Preferencias_cand]
             (Id_candidato, 
   	   	      Id_preferencia, 
			  Id_estado_pref, 
			  valor_estado_pref
             )
	         Values
             (@T6_Id_candidato,
		      @T6_Id_preferencia,
              @T6_Id_estado_pref,
              @T6_valor_estado_pref
		     )

     END

--== PREFERENCIA 2_: SUELDO
   IF @E_Factores_at_sueldo IS NOT NULL 
	 
	 BEGIN

        -- Se pasan valores de la tabla: Encuesta_General a tabla: Preferencias_cand
            SET @T6_Id_candidato       = @E_Id_candidato
            SET @T6_Id_preferencia     = 2
            SET @T6_Id_estado_pref     = 2
            SET @T6_valor_estado_pref  = @E_Factores_at_sueldo

		-- INSERTA EN TABLA: Preferencias_cand
    
          INSERT INTO [dbo].[Preferencias_cand]
             (Id_candidato, 
   	   	      Id_preferencia, 
			  Id_estado_pref, 
			  valor_estado_pref
             )
	         Values
             (@T6_Id_candidato,
		      @T6_Id_preferencia,
              @T6_Id_estado_pref,
              @T6_valor_estado_pref
		     )

     END

--== PREFERENCIA 2_: ESTABILIDAD LABORAL
   IF @E_Factores_at_estabilidad IS NOT NULL 
	 
	 BEGIN

        -- Se pasan valores de la tabla: Encuesta_General a tabla: Preferencias_cand
            SET @T6_Id_candidato       = @E_Id_candidato
            SET @T6_Id_preferencia     = 2
            SET @T6_Id_estado_pref     = 3
            SET @T6_valor_estado_pref  = @E_Factores_at_estabilidad

		-- INSERTA EN TABLA: Preferencias_cand
    
          INSERT INTO [dbo].[Preferencias_cand]
             (Id_candidato, 
   	   	      Id_preferencia, 
			  Id_estado_pref, 
			  valor_estado_pref
             )
	         Values
             (@T6_Id_candidato,
		      @T6_Id_preferencia,
              @T6_Id_estado_pref,
              @T6_valor_estado_pref
		     )

     END


--== PREFERENCIA 2_: CRECIMIENTO LABORAL
   IF @E_Factores_at_crecimiento IS NOT NULL 
	 
	 BEGIN

        -- Se pasan valores de la tabla: Encuesta_General a tabla: Preferencias_cand
            SET @T6_Id_candidato       = @E_Id_candidato
            SET @T6_Id_preferencia     = 2
            SET @T6_Id_estado_pref     = 4
            SET @T6_valor_estado_pref  = @E_Factores_at_crecimiento

		-- INSERTA EN TABLA: Preferencias_cand
    
          INSERT INTO [dbo].[Preferencias_cand]
             (Id_candidato, 
   	   	      Id_preferencia, 
			  Id_estado_pref, 
			  valor_estado_pref
             )
	         Values
             (@T6_Id_candidato,
		      @T6_Id_preferencia,
              @T6_Id_estado_pref,
              @T6_valor_estado_pref
		     )

     END


--== PREFERENCIA 2_: RECONOCIMIENTO LABORAL
   IF @E_Factores_at_reconoc IS NOT NULL 
	 
	 BEGIN

        -- Se pasan valores de la tabla: Encuesta_General a tabla: Preferencias_cand
            SET @T6_Id_candidato       = @E_Id_candidato
            SET @T6_Id_preferencia     = 2
            SET @T6_Id_estado_pref     = 5
            SET @T6_valor_estado_pref  = @E_Factores_at_reconoc

		-- INSERTA EN TABLA: Preferencias_cand
    
          INSERT INTO [dbo].[Preferencias_cand]
             (Id_candidato, 
   	   	      Id_preferencia, 
			  Id_estado_pref, 
			  valor_estado_pref
             )
	         Values
             (@T6_Id_candidato,
		      @T6_Id_preferencia,
              @T6_Id_estado_pref,
              @T6_valor_estado_pref
		     )

     END


   -- LECTURA DEL CURSOR Encuesta_general_cursor (SIGUIENTE REGISTRO)
  FETCH NEXT FROM Encuesta_general_cursor
  INTO 	@E_Id_candidato,	
        @E_Timestamp,
    	@E_Nombre,
	    @E_Sexo,
	    @E_Edad,
	    @E_Estado_civil,

        @E_Preg_estudios_ems,
        @E_Eb_grado_max,
        @E_Eb_situacion,
        @E_Eb_anio_situacion,
        @E_Ems_situacion,
        @E_Ems_anio_situacion,
        @E_Ems_institucion,
        @E_Ems_especialidad,
        @E_Ems_pertenece_TI,
        @E_Preg_estudios_es,
        @E_Es_situacion,
        @E_Es_anio_situacion,
        @E_Es_institucion,
        @E_Es_carrera,
        @E_Es_pertenece_TI,
        @E_Preg_estudios_maestria,
        @E_Maest_situacion,
        @E_Maest_anio_situacion,
        @E_Maest_institucion,
        @E_Maest_carrera,
        @E_Maest_pertenece_TI, 
        @E_Preg_estudios_doctorado,
        @E_Doc_situacion,
        @E_Doc_anio_situacion,
        @E_Doc_institucion,
        @E_Doc_carrera,
        @E_Doc_pertenece_TI,

		@E_Preg_exp_laboral_TI,
        @E_Anios_experiencia,
        @E_Num_empleos_TI,
        @E_Max_antig_empleo_TI,
        @E_Min_antig_empleo_TI,
        @E_Max_tiempo_inactividad,

        @E_Preg_empl_relac_TI,
        @E_Tact_antig,
        @E_Tact_sector,
        @E_Tact_empresa,
        @E_Tact_puesto,
        @E_Tact_antig_puesto,
        @E_Tact_sueldo,
        @E_Tult_antig,
        @E_Tult_anio_salida,
        @E_Tult_sector,
        @E_Tult_empresa,
        @E_Tult_puesto,
        @E_Tult_antig_puesto,
        @E_Tult_sueldo,

		@E_Factores_dl,

        @E_Factores_at_calidad,  
        @E_Factores_at_sueldo,
        @E_Factores_at_estabilidad,
        @E_Factores_at_crecimiento,
        @E_Factores_at_reconoc,

        @E_Idiomas_ingles, 
        @E_Idiomas_frances,
        @E_Idiomas_aleman,
        @E_Idiomas_japones,
        @E_Idiomas_mandarin

END  

-- CIERRA CURSOR 
CLOSE Encuesta_general_cursor;  
DEALLOCATE Encuesta_general_cursor;  
GO  




