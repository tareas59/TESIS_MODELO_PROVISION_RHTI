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
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author CD
 */
public class VentanaPerfilesIdoneosPrincipal extends javax.swing.JFrame {

    /**
     * Creates new form CandidatosInfo
     */

    public VentanaPerfilesIdoneosPrincipal() {
        initComponents();
        mostrarDatos("");     
        cargarCombo();
        setLocationRelativeTo(null);
        setResizable(false);
    }
       
    void mostrarDatos(String idPerfilIdoneo) {
       
     DefaultTableModel tablaDinamica = new DefaultTableModel(); 

     tablaDinamica.addColumn("ID PERFIL IDÓNEO");
     tablaDinamica.addColumn("PUESTO");
     tablaDinamica.addColumn("DESCRIPCIÓN PERFIL IDÓNEO");
     tablaDinamica.addColumn("FECHA ALTA");
     tablaDinamica.addColumn("FECHA VIGENCIA");
     tablaDinamica.addColumn("ESTATUS");
     
     tableCandidatos.setModel(tablaDinamica);

     Conexion c = new Conexion();
     Connection con = c.getConexion();
     String sql_0 = "";
     String sql_1 = "SELECT * FROM Perfiles_idoneos_general";
     String sql_2 = "SELECT * FROM Perfiles_idoneos_general WHERE Id_perfil_idoneo ='"+ idPerfilIdoneo +"'";
     String [] array = new String[6];
     int numReg = 0;
        
     if(idPerfilIdoneo.equals("")) 
        {
         sql_0 = sql_1;
        }
     else
        {
         sql_0 = sql_2;                
        }
            
     try {            
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_0);

             
         while(rs.next())
         {        
          array[0]= String.valueOf(rs.getInt(1));
          array[1]= rs.getString(2);
          array[2]= rs.getString(3);
          array[3]= String.valueOf(rs.getDate(4));
          array[4]= String.valueOf(rs.getDate(5));
          array[5]= rs.getString(6);
 
          tablaDinamica.addRow(array);           
          numReg ++;
         }   
       
         if (numReg == 0)
            {
            JOptionPane.showMessageDialog(null, "No se encontraron resultados.\nIntente nuevamente");     
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        c.cerrarConexion();


    }
            

    void cargarCombo() {
       
     Conexion c = new Conexion();
     Connection con = c.getConexion();
     String sql_0 = "SELECT * FROM Codigos_puestos_TI";
                    
     try {            
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_0);

             
         while(rs.next())
         {
           jComboBox1.addItem(rs.getString(1));
         }   
                  
         rs.close();
         
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        c.cerrarConexion();

    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPopupMenu1 = new javax.swing.JPopupMenu();
        jMenuItem1 = new javax.swing.JMenuItem();
        jMenuItem2 = new javax.swing.JMenuItem();
        jPanel2 = new javax.swing.JPanel();
        txtIdCandidato = new javax.swing.JTextField();
        buttonBuscar = new javax.swing.JButton();
        buttonMostrar = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jButton1 = new javax.swing.JButton();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jTextField2 = new javax.swing.JTextField();
        jLabel5 = new javax.swing.JLabel();
        jTextField3 = new javax.swing.JTextField();
        jComboBox1 = new javax.swing.JComboBox<>();
        jScrollPane1 = new javax.swing.JScrollPane();
        tableCandidatos = new javax.swing.JTable();
        jLabel2 = new javax.swing.JLabel();
        jButton2 = new javax.swing.JButton();

        jMenuItem1.setText("ACTUALIZAR PERFIL IDÓNEO");
        jMenuItem1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem1ActionPerformed(evt);
            }
        });
        jPopupMenu1.add(jMenuItem1);

        jMenuItem2.setText("ENCONTRAR CANDIDATOS");
        jMenuItem2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem2ActionPerformed(evt);
            }
        });
        jPopupMenu1.add(jMenuItem2);

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("CONSULTA Y ALTA DE PERFILES IDÓNEOS");

        jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder("Consulta Perfiles Idóneos"));
        jPanel2.setToolTipText("");
        jPanel2.setName(""); // NOI18N

        txtIdCandidato.setName(""); // NOI18N
        txtIdCandidato.setOpaque(false);
        txtIdCandidato.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtIdCandidatoActionPerformed(evt);
            }
        });

        buttonBuscar.setText("BUSCAR");
        buttonBuscar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonBuscarActionPerformed(evt);
            }
        });

        buttonMostrar.setText("MOSTRAR TODOS");
        buttonMostrar.setToolTipText("");
        buttonMostrar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonMostrarActionPerformed(evt);
            }
        });

        jLabel1.setText("ID PERFIL");

        jButton1.setText("ALTA PERFIL IDÓNEO");
        jButton1.setMaximumSize(new java.awt.Dimension(165, 29));
        jButton1.setMinimumSize(new java.awt.Dimension(165, 29));
        jButton1.setName(""); // NOI18N
        jButton1.setPreferredSize(new java.awt.Dimension(165, 29));
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        jLabel3.setText("ID PUESTO");

        jLabel4.setText("DESCRIPCIÓN PERFIL");

        jTextField2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextField2ActionPerformed(evt);
            }
        });

        jLabel5.setText("FECHA DE VIGENCIA");

        jTextField3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextField3ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addGap(32, 32, 32)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel4)
                    .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 143, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel3)
                    .addComponent(jLabel5))
                .addGap(18, 18, 18)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jTextField2, javax.swing.GroupLayout.PREFERRED_SIZE, 357, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField3, javax.swing.GroupLayout.PREFERRED_SIZE, 103, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jComboBox1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 178, Short.MAX_VALUE)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jButton1, javax.swing.GroupLayout.DEFAULT_SIZE, 225, Short.MAX_VALUE)
                            .addComponent(buttonMostrar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addGap(39, 39, 39))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(txtIdCandidato, javax.swing.GroupLayout.PREFERRED_SIZE, 60, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(buttonBuscar)
                        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addContainerGap(41, Short.MAX_VALUE)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(txtIdCandidato, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(buttonBuscar))
                        .addGap(18, 18, 18)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel3)
                            .addComponent(jComboBox1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel4)
                            .addComponent(jTextField2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(14, 14, 14)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel5)
                            .addComponent(jTextField3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 42, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(buttonMostrar, javax.swing.GroupLayout.PREFERRED_SIZE, 41, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(15, 15, 15)))
                .addContainerGap())
        );

        tableCandidatos.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {

            }
        ));
        tableCandidatos.setComponentPopupMenu(jPopupMenu1);
        jScrollPane1.setViewportView(tableCandidatos);

        jLabel2.setFont(new java.awt.Font("Tahoma", 1, 16)); // NOI18N
        jLabel2.setText("PERFILES IDÓNEOS");

        jButton2.setText("REGRESAR");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap(30, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jPanel2, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.TRAILING))
                        .addContainerGap())
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jLabel2)
                        .addGap(437, 437, 437))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jButton2, javax.swing.GroupLayout.PREFERRED_SIZE, 119, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addContainerGap())))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(38, 38, 38)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(28, 28, 28)
                .addComponent(jLabel2)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 270, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(jButton2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(VentanaPrincipal.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(VentanaPrincipal.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(VentanaPrincipal.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(VentanaPrincipal.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new VentanaPerfilesIdoneosPrincipal().setVisible(true);
            }
        });
    }

    private void jMenuItem1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem1ActionPerformed
//         JOptionPane.showMessageDialog(null, "Debe introducir un ID");
   
    int fila = tableCandidatos.getSelectedRow();
    if (fila >= 0)
    {
       VentanaPerfilesIdoneosDetalle perfilesIdoneos = new VentanaPerfilesIdoneosDetalle();
       perfilesIdoneos.setVisible(true);
      
       int IdPerfilIdoneo = Integer.parseInt(tableCandidatos.getValueAt(fila, 0).toString() );    
       perfilesIdoneos.mostrarDatos(IdPerfilIdoneo,"",0);
             
       dispose();        
    }
    else
    {
      JOptionPane.showMessageDialog(null, "Debes seleccionar una Perfil");                
    }
        
    
    }//GEN-LAST:event_jMenuItem1ActionPerformed

    private void jTextField3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jTextField3ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jTextField3ActionPerformed

    private void jTextField2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jTextField2ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jTextField2ActionPerformed

    private void buttonMostrarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonMostrarActionPerformed

        
        mostrarDatos("");
    }//GEN-LAST:event_buttonMostrarActionPerformed

    private void buttonBuscarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonBuscarActionPerformed

        if (txtIdCandidato.getText().equals(""))
        {
            JOptionPane.showMessageDialog(null, "Debe introducir un ID");
        }
        else
        {
            mostrarDatos(txtIdCandidato.getText());
        }
    }//GEN-LAST:event_buttonBuscarActionPerformed

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed

        int idPerfilIdoneo = Integer.parseInt(txtIdCandidato.getText());
        String puestoTI    = jComboBox1.getSelectedItem().toString();
        String descPerfil  = jTextField2.getText();

        PerfilesIdoneosAlta perfIdonAlta = new PerfilesIdoneosAlta();
        // INSERT TABLA: Perfiles_idoneos_general 
        perfIdonAlta.altaPerfilIdoneoGen(idPerfilIdoneo, puestoTI, descPerfil);
        // INSERT TABLA: Perfiles_idoneos_detalle
        perfIdonAlta.altaPerfilIdoneoDet(idPerfilIdoneo, puestoTI);        
        
        mostrarDatos("");

     
    }//GEN-LAST:event_jButton1ActionPerformed

    private void txtIdCandidatoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtIdCandidatoActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtIdCandidatoActionPerformed

    private void jMenuItem2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem2ActionPerformed
        // TODO add your handling code here:       
    int fila = tableCandidatos.getSelectedRow();          
    int idPerfilIdoneo = Integer.parseInt(tableCandidatos.getValueAt(fila, 0).toString());            

    if (fila >= 0)
    {
       VentanaBusquedaCandidatos busquedaCandidatos = new VentanaBusquedaCandidatos();
       busquedaCandidatos.setVisible(true);
       
       busquedaCandidatos.mostrarDatosInicio(idPerfilIdoneo);
      
             
       dispose();        
    }
    else
    {
      JOptionPane.showMessageDialog(null, "Debes seleccionar una Perfil");                
    }

    }//GEN-LAST:event_jMenuItem2ActionPerformed

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        // TODO add your handling code here:
       VentanaPrincipal perfilesIdoneos = new VentanaPrincipal();
       perfilesIdoneos.setVisible(true);
      
             
       dispose();        

    }//GEN-LAST:event_jButton2ActionPerformed



    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton buttonBuscar;
    private javax.swing.JButton buttonMostrar;
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JComboBox<String> jComboBox1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JMenuItem jMenuItem1;
    private javax.swing.JMenuItem jMenuItem2;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPopupMenu jPopupMenu1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTextField jTextField2;
    private javax.swing.JTextField jTextField3;
    private javax.swing.JTable tableCandidatos;
    private javax.swing.JTextField txtIdCandidato;
    // End of variables declaration//GEN-END:variables

    
}
