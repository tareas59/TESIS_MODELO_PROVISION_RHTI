/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tesis_rhti;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author CD
 */
public class PerfilesCandidatosAlta 

{
 
 public  boolean altaPerfilCandidatoDet(String idCandidato, int id_perfil_idoneo, String idPuesto)
 {
    boolean agregado = false;

     
     Conexion c = new Conexion();
     Connection con = c.getConexion();
     String sql_1 = "SELECT * FROM Perfiles_idoneos_detalle WHERE Id_perfil_idoneo = "+ id_perfil_idoneo ;
     String sql_2 = "INSERT INTO Perfiles_candidatos_detalle (Id_candidato, Id_perfil_idoneo, Id_tipo_carac_perfil, Id_carac_perfil, Ind_carac, Tipo_valor, Valor_num, Valor_text, Valor_binario_perfil) VALUES (?,?,?,?,?,?,?,?,?)";
          
     //Ciclo 1: Carga de las "CARACTERÍSTICAS" del perfil de TI
     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);

                 
         while(rs.next())
         {        
           // INSERT TABLA: Perfiles_candidatos_detalle
           try (PreparedStatement pst = con.prepareStatement(sql_2)) 
           {                       
              pst.setString(1,idCandidato);
              pst.setInt(2, id_perfil_idoneo);
              pst.setString(3, rs.getString(2));
              pst.setString(4, String.valueOf(rs.getInt(3))); //Id_carac_perfil
              pst.setString(5, rs.getString(4));
              pst.setString(6, rs.getString(5));
             
              pst.setInt(7, 0);
              pst.setString(8,"");                                  
              pst.setInt(9, 0);
                            
              // Obtenemos el valor binario para todas las caracterìsticas del perfil que sean del tipo CONOCIMIENTO (CON)
              // ya que todas ellas se miden en años de experiencia
              if (rs.getString(2).equals("CON"))
              { 
                int aniosExperiencia = obtieneAniosConoc(idCandidato, idPuesto, rs.getInt(3));

                // Actualiza los anios de experiencia
                pst.setInt(7, aniosExperiencia);

                System.out.println("aniosExperiencia:" + String.valueOf(aniosExperiencia));
                System.out.println("Rango ini:" + String.valueOf(rs.getInt(6)));
                System.out.println("Rango fin:" + String.valueOf(rs.getInt(7)));
                        
                if( aniosExperiencia < rs.getInt(6)  || aniosExperiencia > rs.getInt(7))
//                if( aniosExperiencia < rs.getInt(6))
                {
                  pst.setInt(9, 0); 
                }
                else
                {
                  pst.setInt(9, 1); 
                }
                                    
              }   

              // Obtenemos el valor binario para todas las caracterìsticas del perfil que sean del tipo CARACTERÍSTICA (CAR)
              // ya que todas ellas se miden de diferente manera
              if (rs.getString(2).equals("CAR"))
              {
                // Si estamos evaluando la caracterìstica: 
                if(rs.getInt(3)== 1 || rs.getInt(3)== 2 || rs.getInt(3)== 3 )
                {
                 // Crea un lista para almacenar los valores de los campos que queremos
                 ArrayList<String> caracCandidatos = new ArrayList<> ();           
                 caracCandidatos = caracCandidatos(idCandidato);

                  //Para: Edad
                  if(rs.getInt(3)== 1)
                  {
                    int edadCand = Integer.parseInt(caracCandidatos.get(1));
                    
                    // Actualiza el valor de la edad
                    pst.setInt(7, edadCand);

                    System.out.println("edad:" + edadCand);
                    System.out.println("valor:" + rs.getString(8).substring(0,1));

                
//                    if(rs.getString(8).trim(). )
                    if( edadCand < rs.getInt(6)  || edadCand > rs.getInt(7))
                      {
                       pst.setInt(9, 0); 
                      }
                    else
                      {
                       pst.setInt(9, 1); 
                      }
                      
                  }
                 
                  //Para: Sexo
                  if(rs.getInt(3)== 2)
                  {
                    String sexoCand = caracCandidatos.get(0);
                    
                    // Actualiza el valor del sexo
                    pst.setString(8, sexoCand);

                    System.out.println("sexo:" + sexoCand);
                    System.out.println("valor:" + rs.getString(8).substring(0,1));

                
                    if(rs.getString(8).trim().equals("Cualquiera") )
                    {
                      pst.setInt(9, 1);                         
                    }
                    else
                    {
                       if(rs.getString(8).substring(0,1).equals(sexoCand))
                       {
                         pst.setInt(9, 1);                         
                       }
                       else
                       {
                       pst.setInt(9, 0);                         
                           
                       }            
                    }
                      
                  }
                  

                  //Para: Estado Civil
                  if(rs.getInt(3)== 3)
                  {
                    String edoCivilCand = caracCandidatos.get(2);
                    
                    // Actualiza el valor del estado civil
                    pst.setString(8, edoCivilCand);

                    System.out.println("sexo:" + edoCivilCand);
                    System.out.println("valor:" + rs.getString(8).substring(0,1));

                
                    if(rs.getString(8).trim().equals("Cualquiera") )
                    {
                      pst.setInt(9, 1);                         
                    }
                    else
                    {
                       if(rs.getString(8).substring(0,1).equals(edoCivilCand))
                       {
                         pst.setInt(9, 1);                         
                       }
                       else
                       {
                       pst.setInt(9, 0);                                                    
                       }            
                    }
                      
                  }


                }
                
                //Para: Estudios academicos
                if(rs.getInt(3)== 4)
                {
                   int nivelEduca;

                   switch( rs.getString(8).trim())
                   {  
                    case "Primaria"                   : nivelEduca = 1  ;  break;
                    case "Secundaria"                 : nivelEduca = 2  ;  break;
                    case "Educación media superior"   : nivelEduca = 3  ;  break;
                    case "Educación superior"         : nivelEduca = 4  ;  break;
                    case "Maestría"                   : nivelEduca = 5  ;  break;
                    case "Doctorado"                  : nivelEduca = 6  ;  break;
                    default                           : nivelEduca = 0  ;  break;
                   }
                   
                   boolean encontrado =   educacionCandidatos(idCandidato, "1", "", nivelEduca );

                    System.out.println("nivel educativo:" + nivelEduca);
                    System.out.println("valor:" + rs.getString(8).trim());
                    System.out.println("encontrado:" + String.valueOf(encontrado));

                    // Actualiza el valor del nivel educativo
                    pst.setString(8, rs.getString(8).trim());
                   
                    if(rs.getString(8).trim().equals("Cualquiera") )
                    {
                      pst.setInt(9, 1);                         
                    }
                    else
                    {
                      if(encontrado )
                      {
                        pst.setInt(9, 1);                         
                      }
                      else
                      {
                        pst.setInt(9, 0);                                                    
                      }                                    
                    }

                    
                }
               
                //Para: Experiencia en el puesto
                if(rs.getInt(3)== 5)
                {
                 // Crea un lista para almacenar los valores de los campos que queremos
                 ArrayList<String> caracPuesto = new ArrayList<> ();           
                 caracPuesto = caracPuesto(idCandidato, id_perfil_idoneo);
                 
                 String puestoActual = caracPuesto.get(1);
                 System.out.println("IND puestoActual:" + puestoActual);

                 int antiguedadPuestoUlt;

                 if(puestoActual.equals("N"))
                 {
                   // Actualiza el valor de la edad
                   pst.setInt(7, 0);                    
                   System.out.println("puestoActual:" + '0');
                   
                   antiguedadPuestoUlt = 0;
                 }
                 else
                 {
                   
                   // Crea un lista para almacenar los valores de los campos que queremos
                   ArrayList<String> camposEmpleoCand = new ArrayList<> ();           
       
                   camposEmpleoCand = caracEmpleo(idCandidato);
                   
                   antiguedadPuestoUlt = Integer.parseInt(camposEmpleoCand.get(7));
                   System.out.println("Antiguedad puestoActual:" + String.valueOf(antiguedadPuestoUlt));                                     

                   // Actualiza el valor de la edad
                   pst.setInt(7, antiguedadPuestoUlt);                    
                   
                 }                     
                                      
//                  if(rs.getString(8).trim(). )
                    if( antiguedadPuestoUlt < rs.getInt(6)  || antiguedadPuestoUlt > rs.getInt(7))
                      {
                       pst.setInt(9, 0); 
                      }
                    else
                      {
                       pst.setInt(9, 1); 
                      }
                    
                }


                //Para: Idioma inglés
                if(rs.getInt(3)== 6)
                {
                   // Crea un lista para almacenar los valores de los campos que queremos
                   ArrayList<String> camposIdiomas = new ArrayList<> ();           
                   camposIdiomas = caracIdioma(idCandidato, "ING");
                   
                   int nivelIdioma;
                    
                   if(camposIdiomas.isEmpty())
                   {
                     // Actualiza el valor del nivel de inglés
                     pst.setInt(8, 0);                    
                     System.out.println("Nivel idioma Inglés NULL:" + '0');
                     nivelIdioma = 0;
                    
                   }
                   else                       
                   {
                     nivelIdioma = Integer.parseInt(camposIdiomas.get(0));
                     System.out.println("Nivel idioma Ingles:" + String.valueOf(nivelIdioma));                                                         
                   }

                   int nivelIdiomaIdoneo;
                   
                   switch( rs.getString(8).trim())
                   {  
                    case "No lo conozco"      : nivelIdiomaIdoneo = 0  ;  break;
                    case "Bajo"               : nivelIdiomaIdoneo = 1  ;  break;
                    case "Medio"              : nivelIdiomaIdoneo = 2  ;  break;
                    case "Alto"               : nivelIdiomaIdoneo = 3  ;  break;
                    case "Con certificación"  : nivelIdiomaIdoneo = 4  ;  break;
                    default                   : nivelIdiomaIdoneo = 0  ;  break;
                   }

                     // Actualiza el valor del nivel de inglés
                     pst.setInt(8, nivelIdioma);                    

                     System.out.println("Nivel idioma Ingles idóneo:" + String.valueOf(nivelIdiomaIdoneo));                                                         
                   
//                  if(rs.getString(8).trim(). )
                   if( nivelIdioma >=  nivelIdiomaIdoneo)
                      {
                       pst.setInt(9, 1); 
                      }
                    else
                      {
                       pst.setInt(9, 0); 
                      }                                              
                                     
                }
                
                
                //Para: Idioma francés
                if(rs.getInt(3)== 7)
                {
                   // Crea un lista para almacenar los valores de los campos que queremos
                   ArrayList<String> camposIdiomas = new ArrayList<> ();           
                   camposIdiomas = caracIdioma(idCandidato, "FRA");
                   
                   int nivelIdioma;
                    
                   if(camposIdiomas.isEmpty())
                   {
                     // Actualiza el valor del nivel de francés
                     pst.setInt(8, 0);                    
                     System.out.println("Nivel idioma francés NULL:" + '0');
                     nivelIdioma = 0;
                    
                   }
                   else                       
                   {
                     nivelIdioma = Integer.parseInt(camposIdiomas.get(0));
                     System.out.println("Nivel idioma francés:" + String.valueOf(nivelIdioma));                                                         
                   }

                   int nivelIdiomaIdoneo;
                   
                   switch( rs.getString(8).trim())
                   {  
                    case "No lo conozco"      : nivelIdiomaIdoneo = 0  ;  break;
                    case "Bajo"               : nivelIdiomaIdoneo = 1  ;  break;
                    case "Medio"              : nivelIdiomaIdoneo = 2  ;  break;
                    case "Alto"               : nivelIdiomaIdoneo = 3  ;  break;
                    case "Con certificación"  : nivelIdiomaIdoneo = 4  ;  break;
                    default                   : nivelIdiomaIdoneo = 0  ;  break;
                   }

                     // Actualiza el valor del nivel de francés
                     pst.setInt(8, nivelIdioma);                    

                     System.out.println("Nivel idioma francés idóneo:" + String.valueOf(nivelIdiomaIdoneo));                                                         
                   
//                  if(rs.getString(8).trim(). )
                   if( nivelIdioma >=  nivelIdiomaIdoneo)
                      {
                       pst.setInt(9, 1); 
                      }
                    else
                      {
                       pst.setInt(9, 0); 
                      }
                                 
                }
                

                //Para: Idioma Alemán
                if(rs.getInt(3)== 8)
                {
                   // Crea un lista para almacenar los valores de los campos que queremos
                   ArrayList<String> camposIdiomas = new ArrayList<> ();           
                   camposIdiomas = caracIdioma(idCandidato, "ALE");
                   
                   int nivelIdioma;
                    
                   if(camposIdiomas.isEmpty())
                   {
                     // Actualiza el valor del nivel de Alemán
                     pst.setInt(8, 0);                    
                     System.out.println("Nivel idioma Alemán NULL:" + '0');
                     nivelIdioma = 0;
                    
                   }
                   else                       
                   {
                     nivelIdioma = Integer.parseInt(camposIdiomas.get(0));
                     System.out.println("Nivel idioma Alemán:" + String.valueOf(nivelIdioma));                                                         
                   }

                   int nivelIdiomaIdoneo;
                   
                   switch( rs.getString(8).trim())
                   {  
                    case "No lo conozco"      : nivelIdiomaIdoneo = 0  ;  break;
                    case "Bajo"               : nivelIdiomaIdoneo = 1  ;  break;
                    case "Medio"              : nivelIdiomaIdoneo = 2  ;  break;
                    case "Alto"               : nivelIdiomaIdoneo = 3  ;  break;
                    case "Con certificación"  : nivelIdiomaIdoneo = 4  ;  break;
                    default                   : nivelIdiomaIdoneo = 0  ;  break;
                   }

                     // Actualiza el valor del nivel de Alemán
                     pst.setInt(8, nivelIdioma);                    

                     System.out.println("Nivel idioma Alemán idóneo:" + String.valueOf(nivelIdiomaIdoneo));                                                         
                   
//                  if(rs.getString(8).trim(). )
                   if( nivelIdioma >=  nivelIdiomaIdoneo)
                      {
                       pst.setInt(9, 1); 
                      }
                    else
                      {
                       pst.setInt(9, 0); 
                      }
                                 
                }
                
                //Para: Idioma japonés
                if(rs.getInt(3)== 9)
                {
                   // Crea un lista para almacenar los valores de los campos que queremos
                   ArrayList<String> camposIdiomas = new ArrayList<> ();           
                   camposIdiomas = caracIdioma(idCandidato, "JAP");
                   
                   int nivelIdioma;
                    
                   if(camposIdiomas.isEmpty())
                   {
                     // Actualiza el valor del nivel de japonés
                     pst.setInt(8, 0);                    
                     System.out.println("Nivel idioma japonés NULL:" + '0');
                     nivelIdioma = 0;
                    
                   }
                   else                       
                   {
                     nivelIdioma = Integer.parseInt(camposIdiomas.get(0));
                     System.out.println("Nivel idioma japonés:" + String.valueOf(nivelIdioma));                                                         
                   }

                   int nivelIdiomaIdoneo;
                   
                   switch( rs.getString(8).trim())
                   {  
                    case "No lo conozco"      : nivelIdiomaIdoneo = 0  ;  break;
                    case "Bajo"               : nivelIdiomaIdoneo = 1  ;  break;
                    case "Medio"              : nivelIdiomaIdoneo = 2  ;  break;
                    case "Alto"               : nivelIdiomaIdoneo = 3  ;  break;
                    case "Con certificación"  : nivelIdiomaIdoneo = 4  ;  break;
                    default                   : nivelIdiomaIdoneo = 0  ;  break;
                   }

                     // Actualiza el valor del nivel de japonés
                     pst.setInt(8, nivelIdioma);                    

                     System.out.println("Nivel idioma japonés idóneo:" + String.valueOf(nivelIdiomaIdoneo));                                                         
                   
//                  if(rs.getString(8).trim(). )
                   if( nivelIdioma >=  nivelIdiomaIdoneo)
                      {
                       pst.setInt(9, 1); 
                      }
                    else
                      {
                       pst.setInt(9, 0); 
                      }
                                 
                }


                //Para: Idioma mandarín
                if(rs.getInt(3)== 10)
                {
                   // Crea un lista para almacenar los valores de los campos que queremos
                   ArrayList<String> camposIdiomas = new ArrayList<> ();           
                   camposIdiomas = caracIdioma(idCandidato, "MAN");
                   
                   int nivelIdioma;
                    
                   if(camposIdiomas.isEmpty())
                   {
                     // Actualiza el valor del nivel de mandarín
                     pst.setInt(8, 0);                    
                     System.out.println("Nivel idioma mandarín NULL:" + '0');
                     nivelIdioma = 0;
                    
                   }
                   else                       
                   {
                     nivelIdioma = Integer.parseInt(camposIdiomas.get(0));
                     System.out.println("Nivel idioma mandarín:" + String.valueOf(nivelIdioma));                                                         
                   }

                   int nivelIdiomaIdoneo;
                   
                   switch( rs.getString(8).trim())
                   {  
                    case "No lo conozco"      : nivelIdiomaIdoneo = 0  ;  break;
                    case "Bajo"               : nivelIdiomaIdoneo = 1  ;  break;
                    case "Medio"              : nivelIdiomaIdoneo = 2  ;  break;
                    case "Alto"               : nivelIdiomaIdoneo = 3  ;  break;
                    case "Con certificación"  : nivelIdiomaIdoneo = 4  ;  break;
                    default                   : nivelIdiomaIdoneo = 0  ;  break;
                   }

                     // Actualiza el valor del nivel de mandarín
                     pst.setInt(8, nivelIdioma);                    

                     System.out.println("Nivel idioma mandarín idóneo:" + String.valueOf(nivelIdiomaIdoneo));                                                         
                   
//                  if(rs.getString(8).trim(). )
                   if( nivelIdioma >=  nivelIdiomaIdoneo)
                      {
                       pst.setInt(9, 1); 
                      }
                    else
                      {
                       pst.setInt(9, 0); 
                      }
                                 
                }


                
              }
              
              
              pst.executeUpdate();
             
//              actualizaCalif( idCandidato, id_perfil_idoneo);         

              agregado = true;
              
           } catch (SQLException ex) {
               Logger.getLogger(VentanaPerfilesIdoneosPrincipal.class.getName()).log(Level.SEVERE, null, ex);
            }

           

         
           
         }
       
        
        rs.close();
        con.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }
       
     c.cerrarConexion();
   
                
     
    return agregado;
 }
 
 
 public  boolean altaPerfilCandidatoGen(String idCandidato, int idPerfilIdoneo, Date fechaVigencia, String estatusCarac)
 {
    boolean agregado = false;

     ConsultaFecha consFecha = new ConsultaFecha();
     Date fechaActual = consFecha.consultarFechaActual();
     Conexion c = new Conexion();
     Connection con = c.getConexion();
 
     // INSERT TABLA: Perfiles_candidatos_general
     String sql_2 = "INSERT INTO Perfiles_candidatos_general (Id_candidato, Id_perfil_idoneo, Distancia_hamming, Distancia_euclidiana, Distancia_russelrao, Distancia_jaccard, Fecha_alta, Fecha_vigencia, Estatus_perfil) VALUES (?,?,?,?,?,?,?,?,?)";

     try (PreparedStatement pst = con.prepareStatement(sql_2)) 
       {                                
        pst.setString(1, idCandidato);            
        pst.setInt(2, idPerfilIdoneo);
        pst.setDouble(3, 0.00);
        pst.setDouble(4, 0.00);
        pst.setDouble(5, 0.00);
        pst.setDouble(6, 0.00);
        pst.setDate(7, fechaActual);
        pst.setDate(8, fechaVigencia);
        pst.setString(9, estatusCarac);
           
        pst.executeUpdate();
           
        pst.close();
           
            
        } catch (SQLException ex) {
             Logger.getLogger(VentanaPerfilesIdoneosPrincipal.class.getName()).log(Level.SEVERE, null, ex);
          }
     
    return agregado;
     
 }
 
  public int obtieneAniosConoc(String idCandidato, String idPuesto, int idConocTi)
 {
    int aniosExperiencia = 0;

     Conexion c = new Conexion();
     Connection con = c.getConexion();
 
     // Consulta tabla: Conocimientos_cand
     String sql_1 = "SELECT * FROM Conocimientos_cand WHERE Id_candidato = '" + idCandidato + "'"
                                                     + "AND Id_puesto = '" + idPuesto + "'" 
                                                     + "AND Id_conoc_it =" + idConocTi;

     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
                  
         while(rs.next())
         {        
            aniosExperiencia = rs.getInt(4);
         }
       
        rs.close();
        con.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }

       
     c.cerrarConexion();
    
    
    return aniosExperiencia;
 }

  public ArrayList caracCandidatos(String idCandidato)
 {

     // Crea un lista para almacenar los valores de los campos que queremos
     ArrayList<String> caracCandidatos = new ArrayList<> ();           

     Conexion c = new Conexion();
     Connection con = c.getConexion();
 
     // Consulta tabla: Candidatos
     String sql_1 = "SELECT * FROM Candidatos WHERE Id_candidato = '" + idCandidato + "'" ;

     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
                  
         while(rs.next())
         {        
            caracCandidatos.add(rs.getString(3));
            caracCandidatos.add(String.valueOf(rs.getInt(4)));
            caracCandidatos.add(rs.getString(5));
         }
       
        rs.close();
        con.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }

       
     c.cerrarConexion();
    
    
    return caracCandidatos;
 }

  public ArrayList caracPuesto(String idCandidato, int perfilIdoneo)
 {
     
     // Recupera el puesto del perfil idóneo
     // Crea un lista para almacenar los valores de los campos que queremos
     ArrayList<String> camposPuestosTI = new ArrayList<> ();           
     
     ConsultasDescripciones consultasDesc = new ConsultasDescripciones();
     camposPuestosTI = consultasDesc.consultarPerfilesIdoneosGen(perfilIdoneo);

     String idPuesto = camposPuestosTI.get(0);
     
             
     // Crea un lista para almacenar los valores de los campos que queremos
     ArrayList<String> caracPuestoTI = new ArrayList<> ();           

     Conexion c = new Conexion();
     Connection con = c.getConexion();
 
     
     // Consulta tabla: Candidatos
     String sql_1 = "SELECT * FROM Puestos_TI_cand WHERE Id_candidato = '" + idCandidato + "'" 
                         + " AND Id_puesto = '" + idPuesto + "'";

     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
                  
         while(rs.next())
         {                     
            caracPuestoTI.add(rs.getString(2));
            caracPuestoTI.add(rs.getString(3));
            caracPuestoTI.add(String.valueOf(rs.getDouble(4)));
         }
       
        rs.close();
        con.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }

       
     c.cerrarConexion();
    
    
    return caracPuestoTI;
 }


  
  public ArrayList caracEmpleo(String idCandidato)
 {
     
     // Crea un lista para almacenar los valores de los campos que queremos
     ArrayList<String> camposEmpleos = new ArrayList<> ();           
     

     Conexion c = new Conexion();
     Connection con = c.getConexion();
 
     
     // Consulta tabla: Candidatos
     String sql_1 = "SELECT * FROM Empleos_cand WHERE Id_candidato = '" + idCandidato + "'" 
                   + "AND Id_tipo_empleo IN (1,2)";

     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
                  
         while(rs.next())
         {                     
            camposEmpleos.add(rs.getString(2));
            camposEmpleos.add(String.valueOf(rs.getInt(3)));
            camposEmpleos.add(String.valueOf(rs.getInt(4)));
            camposEmpleos.add(String.valueOf(rs.getInt(5)));
            camposEmpleos.add(rs.getString(6));
            camposEmpleos.add(rs.getString(7));
            camposEmpleos.add(rs.getString(8));
            camposEmpleos.add(String.valueOf(rs.getInt(9)));
            camposEmpleos.add(String.valueOf(rs.getDouble(10)));
            
                    
         }
       
        rs.close();
        con.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }

       
     c.cerrarConexion();
    
    
    return camposEmpleos;
 }
  

  public ArrayList caracIdioma(String idCandidato, String idioma)
 {
     
     // Crea un lista para almacenar los valores de los campos que queremos
     ArrayList<String> camposIdiomas = new ArrayList<> ();           
     
     Conexion c = new Conexion();
     Connection con = c.getConexion();
 
     
     // Consulta tabla: Candidatos
     String sql_1 = "SELECT * FROM Idiomas_cand WHERE Id_candidato = '" + idCandidato + "'" 
                   + "AND Id_idioma = '" + idioma +  "'";

     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
                  
         while(rs.next())
         {                     
           camposIdiomas.add(String.valueOf(rs.getInt(3)));
                           
         }
       
        rs.close();
        con.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }

       
     c.cerrarConexion();
    
    
    return camposIdiomas;
 }
  
  
  
  public boolean educacionCandidatos(String idCandidato, String opcion, String valor1, int valor2 )
 {

     boolean encontrado = false;
     
     Conexion c = new Conexion();
     Connection con = c.getConexion();
 
     // Consulta tabla: Educacion_academica_cand
     String sql_1 = "SELECT * FROM Educacion_academica_cand WHERE Id_candidato = '" + idCandidato + "'"
                   + "ORDER BY Id_nivel";

     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
                  
         while(rs.next())
         {        
          System.out.println("rs.getInt(2)" + String.valueOf(rs.getInt(2)));
           if(opcion.equals("1"))
           {       
             if(valor2 <= rs.getInt(2))
             {       
               encontrado = true;
             }                
           }
           
         }
       
        rs.close();
        con.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }

       
     c.cerrarConexion();
    
    
    return encontrado;
 }
  
  
  public void actualizaCalif(String idCandidato, int idPerfilIdoneo)
 {

     Conexion c = new Conexion();
     Connection con = c.getConexion();

     int evalPerfil = 0;
     
     // Consulta tabla: Conocimientos_cand
     String sql_1 = "SELECT * FROM Perfiles_candidatos_detalle WHERE Id_candidato = '" + idCandidato + "'"
                                                     + "AND Id_perfil_idoneo = '" + idPerfilIdoneo + "'" ;


     int evaluacion = 0;
     
     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
                  
         while(rs.next())
         {        
            if(rs.getInt(9)==1)
            {
             evaluacion ++;             
            }
                    
         }

    String sql_2 = "UPDATE Perfiles_candidatos_general SET Distancia_hamming = '" + evaluacion + "'"
                    + "WHERE Id_candidato = '" + idCandidato + "'"
                      + "AND Id_perfil_idoneo = " + idPerfilIdoneo ;
         
       try (PreparedStatement pst = con.prepareStatement(sql_2)) 
       {
            pst.executeUpdate();           
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        rs.close();
        con.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }

       
     c.cerrarConexion();
    
    
 }

  
}
