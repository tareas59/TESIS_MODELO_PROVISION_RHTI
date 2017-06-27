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
public class PerfilesCandidatosAlta2 

{
 
 public  boolean altaPerfilCandidatoDet(String idCandidato, int id_perfil_idoneo, String idPuesto, String metodoMedida)
 {
    boolean agregado = false;
     
     Conexion c = new Conexion();
     Connection con = c.getConexion();
     String sql_1 = "SELECT * FROM Caracteristicas_perfiles_TI";
     String sql_2 = "SELECT * FROM Codigos_perfiles_TI WHERE Id_puesto ='"+ idPuesto +"'";
     String sql_3 = "INSERT INTO Perfiles_candidatos_detalle (Id_candidato, Id_perfil_idoneo, Metodo_medida, Id_tipo_carac_perfil, Id_carac_perfil, Ind_carac, Tipo_valor, Valor_num, Valor_text, Valor_binario_perfil) VALUES (?,?,?,?,?,?,?,?,?,?)";
          
     //Ciclo 1: Carga de las "CARACTERÍSTICAS" del perfil de TI
     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
                  
         while(rs.next())
         {        
           // INSERT TABLA: Perfiles_candidatos_detalle
           try (PreparedStatement pst = con.prepareStatement(sql_3)) 
           {  
              pst.setString(1,idCandidato);
              pst.setInt(2, id_perfil_idoneo);
              pst.setString(3, metodoMedida);
              pst.setString(4,"CAR");
              pst.setInt(5, rs.getInt(1));

              // Recupera valores de Tabla: Perfiles_idoneos_detalle
              ConsultasDescripciones camposPerfilesIdoneosDet = new ConsultasDescripciones();             
              
              // Crea un lista para almacenar los valores de los campos que queremos
              ArrayList<String> listaPerfilesIdoneosDet = new ArrayList<> ();     
              listaPerfilesIdoneosDet =  camposPerfilesIdoneosDet.consultarPerfilesIdoneosDet(id_perfil_idoneo, "CAR", rs.getInt(1));
              
              pst.setString(6,listaPerfilesIdoneosDet.get(0));
              pst.setString(7,listaPerfilesIdoneosDet.get(1));
              pst.setInt(8, 0);
              pst.setString(9,"");                                  
              pst.setInt(10, 0);
                            
              pst.executeUpdate();
             
              agregado = true;
              
           } catch (SQLException ex) {
               Logger.getLogger(VentanaPerfilesIdoneosPrincipal.class.getName()).log(Level.SEVERE, null, ex);
            }
         }
       
//        st.close();
        rs.close();
//      c.cerrarConexion();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }


     //Ciclo 2: Carga de los "CONOCIMIENTOS" del perfil de TI
     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_2);
            
         while(rs.next())
         {        
           // INSERT TABLA: Perfiles_candidatos_detalle
           try (PreparedStatement pst = con.prepareStatement(sql_3)) 
           {  
              pst.setString(1,idCandidato);
              pst.setInt(2, id_perfil_idoneo);
              pst.setString(3, metodoMedida);
              pst.setString(4,"CON");
              pst.setInt(5, rs.getInt(2));

              // Recupera valores de Tabla: Perfiles_idoneos_detalle
              ConsultasDescripciones camposPerfilesIdoneosDet = new ConsultasDescripciones();             
              
              // Crea un lista para almacenar los valores de los campos que queremos
              ArrayList<String> listaPerfilesIdoneosDet = new ArrayList<> ();     
              listaPerfilesIdoneosDet =  camposPerfilesIdoneosDet.consultarPerfilesIdoneosDet(id_perfil_idoneo, "CON", rs.getInt(2));
              
              pst.setString(6,listaPerfilesIdoneosDet.get(0));
              pst.setString(7,listaPerfilesIdoneosDet.get(1));
              pst.setInt(8, 0);
              pst.setString(9,"");                                  
              pst.setInt(10, 0);
              
              pst.executeUpdate();
             
              agregado = true;
              
           } catch (SQLException ex) {
               Logger.getLogger(VentanaPerfilesIdoneosPrincipal.class.getName()).log(Level.SEVERE, null, ex);
            }
         }
       
        rs.close();
//      c.cerrarConexion();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }

     c.cerrarConexion();
   
             
    
      
    return agregado;
 }
 
 
 public  boolean altaPerfilCandidatoGen(String idCandidato, int idPerfilIdoneo, Date fechaVigencia, String metodoMedida, String estatusCarac)
 {
    boolean agregado = false;

     ConsultaFecha consFecha = new ConsultaFecha();
     Date fechaActual = consFecha.consultarFechaActual();
     Conexion c = new Conexion();
     Connection con = c.getConexion();
 
     // INSERT TABLA: Perfiles_candidatos_general
     String sql_2 = "INSERT INTO Perfiles_candidatos_general (Id_candidato, Id_perfil_idoneo, Metodo_medida, Fecha_alta, Fecha_vigencia, Estatus_perfil, Evaluacion_perfil) VALUES (?,?,?,?,?,?,?)";

     try (PreparedStatement pst = con.prepareStatement(sql_2)) 
       {                                
        pst.setString(1, idCandidato);            
        pst.setInt(2, idPerfilIdoneo);
        pst.setString(3, metodoMedida);
        pst.setDate(4, fechaActual);
        pst.setDate(5, fechaVigencia);
        pst.setString(6, estatusCarac);
        pst.setInt(7, 0);
           
        pst.executeUpdate();
           
        pst.close();
           
            
        } catch (SQLException ex) {
             Logger.getLogger(VentanaPerfilesIdoneosPrincipal.class.getName()).log(Level.SEVERE, null, ex);
          }
     
    return agregado;
     
 }
    
}
