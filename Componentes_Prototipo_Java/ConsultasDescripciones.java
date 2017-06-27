/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tesis_rhti;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 *
 * @author CD
 */
public class ConsultasDescripciones 
{
    
    // ----- Consulta para recuperar la descripción de la tabla: Codigos_conocimientos_TI
 public  String consultarDescripCodigoConoc(int Id_carac_ti, String opcion)
 {

     Conexion c = new Conexion();
     Connection con = c.getConexion();
     String sql_0 = "";
     String sql_1 = "SELECT Descrip_conoc_it FROM Codigos_conocimientos_TI WHERE Id_conoc_it =" + Id_carac_ti ;
     String sql_2 = "SELECT Descrip_carac_it FROM Caracteristicas_perfiles_TI WHERE Id_caracteristica_it =" + Id_carac_ti ;
     String descrip_conoc_it = "";     
     
     if(opcion == "1") 
        {
         sql_0 = sql_1;
        }
     if(opcion == "2") 
        {
         sql_0 = sql_2;                
        }
     

     try {            
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_0);

             
         while(rs.next())
         {        
          descrip_conoc_it = rs.getString(1);          
         }   
       
        rs.close();
        c.cerrarConexion();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }
     
     return descrip_conoc_it;
        
     
 }


    // ----- Consulta para recuperar campos de la tabla: Perfiles_idoneos_general
 public  ArrayList consultarPerfilesIdoneosGen(int IdPerfilidoneo)
 {


     // Crea un lista para almacenar los valores de los campos que queremos
     ArrayList<String> camposPerfilesIdoneosGen = new ArrayList<> ();           
  
     Conexion c = new Conexion();
     Connection con = c.getConexion();
     String sql_1 = "SELECT * FROM Perfiles_idoneos_general "
             + "WHERE Id_perfil_idoneo =" + IdPerfilidoneo ;
     try {            
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);

             
         while(rs.next())
         {        
          camposPerfilesIdoneosGen.add(rs.getString(2));
          camposPerfilesIdoneosGen.add(rs.getString(3));
         }   
       
        rs.close();
        c.cerrarConexion();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }
     
     return camposPerfilesIdoneosGen;
             
 }
 
 
    // ----- Consulta para recuperar campos de la tabla: Perfiles_idoneos_detalle
 public  ArrayList consultarPerfilesIdoneosDet(int IdPerfilidoneo, String tipoCarac, int idCaracPerfil)
 {


     // Crea un lista para almacenar los valores de los campos que queremos
     ArrayList<String> camposPerfilesIdoneosDet = new ArrayList<> ();           
  
     Conexion c = new Conexion();
     Connection con = c.getConexion();
     String sql_1 = "SELECT * FROM Perfiles_idoneos_detalle "
             + "WHERE Id_perfil_idoneo =" + IdPerfilidoneo 
             + "AND Id_tipo_carac_perfil = '" + tipoCarac + "'" 
             + "AND Id_carac_perfil = " + idCaracPerfil ;
     try {            
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);

             
         while(rs.next())
         {        
          camposPerfilesIdoneosDet.add(rs.getString(4));
          camposPerfilesIdoneosDet.add(rs.getString(5));
         }   
       
        rs.close();
        c.cerrarConexion();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }
     
     return camposPerfilesIdoneosDet;
        
     
 }
 
 
}
