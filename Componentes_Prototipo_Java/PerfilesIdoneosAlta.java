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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author CD
 */
public class PerfilesIdoneosAlta 

{
 
 // Alta en la tabla: Perfiles_idoneos_detalle
 public  boolean altaPerfilIdoneoDet(int id_perfil_idoneo, String idPuesto)
 {
    boolean agregado = false;
     
     Conexion c = new Conexion();
     Connection con = c.getConexion();
     String sql_1 = "SELECT * FROM Caracteristicas_perfiles_TI";
     String sql_2 = "SELECT * FROM Codigos_perfiles_TI WHERE Id_puesto ='"+ idPuesto +"'";
     String sql_3 = "INSERT INTO Perfiles_idoneos_detalle (Id_perfil_idoneo, Id_tipo_carac_perfil, Id_carac_perfil, Ind_carac, Tipo_valor, Valor_rango_ini, Valor_rango_fin, Valor_variable, Valor_binario_perfil) VALUES (?,?,?,?,?,?,?,?,?)";
          
     //Ciclo 1: Carga de las "CARACTERÍSTICAS" del perfil de TI
     try {
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);
            
         while(rs.next())
         {        
           // INSERT TABLA: Perfiles_idoneos_detalle
           try (PreparedStatement pst = con.prepareStatement(sql_3)) 
           {  
              pst.setInt(1, id_perfil_idoneo);
              pst.setString(2, "CAR");
              pst.setInt(3, rs.getInt(1));
              pst.setString(4, "S");
              pst.setString(5,rs.getString(3));
              pst.setInt(6, 0);
              pst.setInt(7, 0);
              pst.setString(8, "");
              pst.setInt(9, 1);

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
           // INSERT TABLA: Codigos_perfiles_idoneos
           try (PreparedStatement pst = con.prepareStatement(sql_3)) 
           {  
              pst.setInt(1, id_perfil_idoneo);
              pst.setString(2, "CON");
              pst.setInt(3, rs.getInt(2));
              pst.setString(4, "S");
              pst.setString(5,"R");
              pst.setInt(6, -1);
              pst.setInt(7, -1);
              pst.setString(8, "");
              pst.setInt(9, 1);

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
    
 // Alta en la tabla: Perfiles_idoneos_general
 public  boolean altaPerfilIdoneoGen(int idPerfilIdoneo, String puestoTI, String descPerfil)
 {
    boolean agregado = false;
     
        ConsultaFecha consFecha = new ConsultaFecha();
        Conexion c = new Conexion();
        Connection con = c.getConexion();
 
        // INSERT TABLA: Perfiles_idoneos_general
        String sql_1 = "INSERT INTO Perfiles_idoneos_general (Id_perfil_idoneo, Id_puesto, Descrip_perfil_idoneo, Fecha_alta, Fecha_vigencia,Estatus_perfil) VALUES (?,?,?,?,?,?)";

        try (PreparedStatement pst = con.prepareStatement(sql_1)) 
        {
            
            Date fechaActual = consFecha.consultarFechaActual();
                    
            pst.setInt(1, idPerfilIdoneo);            
            pst.setString(2, puestoTI);
            pst.setString(3, descPerfil);
            pst.setDate(4, fechaActual);
            pst.setString(5, "2018-05-20");
            pst.setString(6, "A");

            pst.executeUpdate();
           
            pst.close();
            con.close();
            
        } catch (SQLException ex) {
             Logger.getLogger(VentanaPerfilesIdoneosPrincipal.class.getName()).log(Level.SEVERE, null, ex);
            }

     c.cerrarConexion();
   
                       
    return agregado;
 }


}
