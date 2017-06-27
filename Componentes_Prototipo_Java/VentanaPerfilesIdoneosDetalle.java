/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tesis_rhti;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author CD
 */
public class VentanaPerfilesIdoneosDetalle extends javax.swing.JFrame {

    /**
     * Creates new form CandidatosInfo
     */

    public VentanaPerfilesIdoneosDetalle() {
        initComponents();
//      mostrarDatos(0,"",0);
        setLocationRelativeTo(null);
        setResizable(false);
        jTextField1.setEditable(false);
        jTextField2.setEditable(false);
        jTextField3.setEditable(false);
        jTextField4.setEditable(false);

    }
       

    void mostrarDatos(int idPerfil, String idTipoCarac,int idCaracPerfil)  {
       
     DefaultTableModel tablaDinamica = new DefaultTableModel();

     tablaDinamica.addColumn("ID PERFIL");
     tablaDinamica.addColumn("TIPO CARACTERÍSTICA ");
     tablaDinamica.addColumn("ID");
     tablaDinamica.addColumn("DESCRIPCIÓN");
     tablaDinamica.addColumn("REQUERIDA");
     tablaDinamica.addColumn("TIPO DE VALOR");
//   tablaDinamica.addColumn("VALOR RANGO INICIAL");
//   tablaDinamica.addColumn("VALOR RANGO FINAL");
//   tablaDinamica.addColumn("VALOR VARIABLE");
     tablaDinamica.addColumn("VALOR");
     tablaDinamica.addColumn("VALOR BINARIO FINAL");
     
     
     tableCandidatos.setModel(tablaDinamica);

     Conexion c = new Conexion();
     Connection con = c.getConexion();
     String [] array = new String[8];
     int numReg = 0;
     String idTipoCarac1 = "";
     String idTipoCarac2 = "";
     int idCaracPerfil1 = 0;
     int idCaracPerfil2 = 0;
             
     if(idTipoCarac.equals("")) 
        {
         idTipoCarac1 = "";
         idTipoCarac2 = "ZZZ";
        }
     else
        {
         idTipoCarac1 = idTipoCarac;
         idTipoCarac2 = idTipoCarac;
        }

     if(idCaracPerfil == 0) 
        {
         idCaracPerfil1 = 0;
         idCaracPerfil2 = 99999;
        }
     else
        {
         idCaracPerfil1 = idCaracPerfil;
         idCaracPerfil2 = idCaracPerfil;
        }

     
     String sql_1 = "SELECT * FROM Perfiles_idoneos_detalle WHERE Id_Perfil_idoneo = '" + idPerfil + "'"
               + "AND Id_tipo_carac_perfil BETWEEN '" + idTipoCarac1 +   "' AND '" + idTipoCarac2 +   "'"
               + "AND Id_carac_perfil      BETWEEN " + idCaracPerfil1 + " AND " + idCaracPerfil2  
               + "ORDER BY Id_perfil_idoneo,Id_tipo_carac_perfil, Id_carac_perfil";
     
     try {            
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery(sql_1);

             
         while(rs.next())
         {        
          array[0]= String.valueOf(rs.getInt(1));

          String tipCarac ;
          String opcion;
          switch( rs.getString(2) )
          {  
           case "CAR" : tipCarac = "Característica";  opcion = "2" ; break;
           case "CON" : tipCarac = "Conocimiento"  ;  opcion = "1" ; break;
           default    : tipCarac = " "             ;  opcion = " ";  break;
          }          
          array[1]= tipCarac;
          array[2]= String.valueOf(rs.getInt(3));

          ConsultasDescripciones consultasDescripciones = new ConsultasDescripciones();
          String descCarac = consultasDescripciones.consultarDescripCodigoConoc(rs.getInt(3), opcion);                 
          array[3]=descCarac;

          String reqCarac ;
          switch( rs.getString(4) )
          {  
           case "S" : reqCarac = "Si";  break;
           case "N" : reqCarac = "No";  break;
           default  : reqCarac = " ";  break;
          }          
          array[4]= reqCarac;


          String tipValCarac ;

          String valCaracteristica;
          String valCarac1 = "";
          String valCarac2 = "";
          
        if (rs.getString(2).equals("CON"))
          {  
            switch( rs.getInt(6) )
            {  
             case -1 : valCarac1 =  "0"  ;  break;
             case 0  : valCarac1 = "<1"  ;  break;
             case 16 : valCarac1 = ">15" ;  break;
             default : valCarac1 = String.valueOf(rs.getInt(6)) ;  break;
            }          

            switch( rs.getInt(7) )
            {  
             case -1 : valCarac2 =  "0"  ;  break;
             case 0  : valCarac2 = "<1"  ;  break;
             case 15 : valCarac2 = "15"  ;  break;
             case 16 : valCarac2 = ">15" ;  break;
             default : valCarac2 = String.valueOf(rs.getInt(7)) ;  break;
            }          
              
          }
        if (rs.getString(2).equals("CAR"))
          {  
           valCarac1 = String.valueOf(rs.getInt(6));
           valCarac2 = String.valueOf(rs.getInt(7));                            
          }
                             
          
          switch( rs.getString(5) )
          {  
           case "R" : tipValCarac = "Rango"    ; valCaracteristica = "De " + valCarac1 + " a " + valCarac2 + " años" ;  break;
           case "V" : tipValCarac = "Variable" ; valCaracteristica = rs.getString(8) ;  break;
           default  : tipValCarac = " "        ; valCaracteristica = " " ; break;                     
          }                   
 
             
          array[5]= tipValCarac;          
          array[6]= valCaracteristica;
          array[7]= String.valueOf(rs.getInt(9));
 
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

    
    void cargarCombo(int opcion, int ini, int fin) {

     // Inicializar combo con espacios
     if (opcion == 0)             
         {
          jComboBox2.removeAllItems();
          jComboBox3.removeAllItems();
         }

     // Llenar combo con Si/No
     if (opcion == 1)             
         {
          jComboBox1.removeAllItems();
          jComboBox1.addItem("Si");
          jComboBox1.addItem("No");             
         }

     // Llenar combo para: Rangos de años
     if (opcion == 2)             
         {
          jComboBox2.removeAllItems();
          jComboBox3.removeAllItems();

          for (int i = ini; i <= fin ; i ++)
         {
          jComboBox2.addItem(String.valueOf(i));            
         }

          for (int i = ini; i <= fin ; i ++)
         {
          jComboBox3.addItem(String.valueOf(i));            
         }
              
         }

     // Llenar combo para: Rangos de años de experiencia (Conocimientos)
     if (opcion == 3)             
         {
           String [] arrayExper1 = new String[18];
           arrayExper1[0] = "Ninguna";
           arrayExper1[1] = "Menos de 1 año";
           arrayExper1[2] = "1 año";
           arrayExper1[3] = "2 años";
           arrayExper1[4] = "3 años";
           arrayExper1[5] = "4 años";
           arrayExper1[6] = "5 años";
           arrayExper1[7] = "6 años";
           arrayExper1[8] = "7 años";
           arrayExper1[9] = "8 años";
           arrayExper1[10]= "9 años";
           arrayExper1[11]= "10 años";
           arrayExper1[12]= "11 años";
           arrayExper1[13]= "12 años";
           arrayExper1[14]= "13 años";
           arrayExper1[15]= "14 años";
           arrayExper1[16]= "15 años";
           arrayExper1[17]= "Mas de 15 años";
             
           String [] arrayExper2 = new String[18];
           arrayExper2[0]= "Ninguna";
           arrayExper2[1]= "Menos de 1 año";
           arrayExper2[2]= "1 año";
           arrayExper2[3]= "2 años";
           arrayExper2[4]= "3 años";
           arrayExper2[5]= "4 años";
           arrayExper2[6]= "5 años";
           arrayExper2[7]= "6 años";
           arrayExper2[8]= "7 años";
           arrayExper2[9]= "8 años";
           arrayExper2[10]= "9 años";
           arrayExper2[11]= "10 años";
           arrayExper2[12]= "11 años";
           arrayExper2[13]= "12 años";
           arrayExper2[14]= "13 años";
           arrayExper2[15]= "14 años";
           arrayExper2[16]= "15 años";
           arrayExper2[17]= "Mas de 15 años";
             
          jComboBox2.removeAllItems();
          jComboBox3.removeAllItems();

          for (int i = 0; i <= 17 ; i ++)
         {
          jComboBox2.addItem(arrayExper1[i]);            
         }

          for (int i = 0; i <= 17 ; i ++)
         {
          jComboBox3.addItem(arrayExper2[i]);            
         }
              
         }
     
     // Llenar combo para: Sexo
     if (opcion == 4)             
         {
          jComboBox2.removeAllItems();
          jComboBox2.addItem("Masculino");
          jComboBox2.addItem("Femenino");             
          jComboBox2.addItem("Cualquiera");             
         }

     // Llenar combo para: Estado civil
     if (opcion == 5)             
         {
          jComboBox2.removeAllItems();
          jComboBox2.addItem("Soltero(a)");
          jComboBox2.addItem("Casado(a)");             
          jComboBox2.addItem("Cualquiera");             
         }

     // Llenar combo para: Estudios academicos
     if (opcion == 6)             
         {
          jComboBox2.removeAllItems();
          jComboBox2.addItem("Primaria");
          jComboBox2.addItem("Secundaria");             
          jComboBox2.addItem("Educación media superior");             
          jComboBox2.addItem("Educación superior");             
          jComboBox2.addItem("Maestría");
          jComboBox2.addItem("Doctorado");             
          jComboBox2.addItem("Cualquiera");             
         }

/*     // Llenar combo para: Estudios posgrado
     if (opcion == 7)             
         {
          jComboBox2.removeAllItems();
          jComboBox2.addItem("Maestría");
          jComboBox2.addItem("Doctorado");             
          jComboBox2.addItem("Cualquiera");             
         }
*/
     
     // Llenar combo para: Puesto
     if (opcion == 8)             
         {
          jComboBox2.removeAllItems();
          jComboBox2.addItem("Desarrollador Cobol");
          jComboBox2.addItem("Analista Cobol");             
          jComboBox2.addItem("Líder de Proyecto Cobol");             
          jComboBox2.addItem("Gerente perfil Cobol");
          jComboBox2.addItem("Desarrollador Java");             
          jComboBox2.addItem("Analista Java");             
          jComboBox2.addItem("Líder de Proyecto Java");             
          jComboBox2.addItem("Gerente Perfil Java");             
          jComboBox2.addItem("Administrador de Base de Datos Oracle");             
         }

     // Llenar combo para: Idiomas
     if (opcion == 9)             
         {
          jComboBox2.removeAllItems();
          jComboBox2.addItem("No lo conozco");
          jComboBox2.addItem("Bajo");             
          jComboBox2.addItem("Medio");             
          jComboBox2.addItem("Alto");
          jComboBox2.addItem("Con certificación");             
         }
     
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
        jPanel2 = new javax.swing.JPanel();
        jTextField1 = new javax.swing.JTextField();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jTextField2 = new javax.swing.JTextField();
        jTextField3 = new javax.swing.JTextField();
        jLabel5 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        jTextField4 = new javax.swing.JTextField();
        jLabel7 = new javax.swing.JLabel();
        jLabel8 = new javax.swing.JLabel();
        jComboBox1 = new javax.swing.JComboBox<>();
        jComboBox2 = new javax.swing.JComboBox<>();
        jComboBox3 = new javax.swing.JComboBox<>();
        jLabel1 = new javax.swing.JLabel();
        jLabel9 = new javax.swing.JLabel();
        buttonBuscar = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        tableCandidatos = new javax.swing.JTable();
        jButton1 = new javax.swing.JButton();
        jLabel2 = new javax.swing.JLabel();

        jMenuItem1.setText("MODIFICAR");
        jMenuItem1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem1ActionPerformed(evt);
            }
        });
        jPopupMenu1.add(jMenuItem1);

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("ACTUALIZACIÓN DE CARACTERíSTICAS DE UN PERFIL IDÓNEO");

        jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder("ACTUALIZAR CARACTERÍSTICAS DEL PERFIL IDÓNEO"));

        jTextField1.setToolTipText("");
        jTextField1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextField1ActionPerformed(evt);
            }
        });

        jLabel3.setText("ID PERFIL");

        jLabel4.setText("TIPO");

        jTextField3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextField3ActionPerformed(evt);
            }
        });

        jLabel5.setText("ID CARACTERÍSTICA");

        jLabel6.setText("DESCRIPCIÓN");

        jTextField4.setToolTipText("");
        jTextField4.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextField4ActionPerformed(evt);
            }
        });

        jLabel7.setText("REQUERIDA");

        jLabel8.setText("RANGO");

        jComboBox1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jComboBox1ActionPerformed(evt);
            }
        });

        jComboBox2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jComboBox2ActionPerformed(evt);
            }
        });

        jLabel1.setText("de:");

        jLabel9.setText("a:");

        buttonBuscar.setText("ACTUALIZAR");
        buttonBuscar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonActualizar(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGap(36, 36, 36)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel5, javax.swing.GroupLayout.PREFERRED_SIZE, 174, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel6)
                    .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 72, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel3))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, 58, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jTextField2, javax.swing.GroupLayout.PREFERRED_SIZE, 127, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jTextField4, javax.swing.GroupLayout.PREFERRED_SIZE, 291, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jTextField3, javax.swing.GroupLayout.PREFERRED_SIZE, 58, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(59, 59, 59)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(jLabel9)
                            .addGroup(jPanel2Layout.createSequentialGroup()
                                .addComponent(jLabel8)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(jLabel1)))
                        .addGap(6, 6, 6))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel7)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)))
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jComboBox2, 0, 139, Short.MAX_VALUE)
                            .addComponent(jComboBox3, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addGap(0, 0, Short.MAX_VALUE))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jComboBox1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 127, Short.MAX_VALUE)
                        .addComponent(buttonBuscar)))
                .addContainerGap())
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(36, 36, 36)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel3)
                            .addComponent(jTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel4)
                            .addComponent(jTextField2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel5)
                            .addComponent(jTextField3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jTextField4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel6)))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(38, 38, 38)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel7)
                            .addComponent(jComboBox1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(buttonBuscar))
                        .addGap(18, 18, 18)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel8)
                            .addComponent(jComboBox2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel1))
                        .addGap(14, 14, 14)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jComboBox3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel9))))
                .addContainerGap(63, Short.MAX_VALUE))
        );

        tableCandidatos.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {

            }
        ));
        tableCandidatos.setToolTipText("");
        tableCandidatos.setComponentPopupMenu(jPopupMenu1);
        jScrollPane1.setViewportView(tableCandidatos);

        jButton1.setText("REGRESAR");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        jLabel2.setFont(new java.awt.Font("Tahoma", 1, 16)); // NOI18N
        jLabel2.setText("CARACTERÍSTICAS DEL PERFIL IDÓNEO");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(36, 36, 36)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jButton1)
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(jScrollPane1)
                        .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap(28, Short.MAX_VALUE))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jLabel2)
                .addGap(354, 354, 354))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(41, 41, 41)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(16, 16, 16)
                .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 299, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jButton1)
                .addContainerGap(25, Short.MAX_VALUE))
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
                new VentanaPerfilesIdoneosDetalle().setVisible(true);
            }
        });
    }

    private void buttonActualizar(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonActualizar

     Conexion c = new Conexion();
     Connection con = c.getConexion();


     //Recuperar valor para el campo: Ind_carac
     String indCarac;
     switch( jComboBox1.getSelectedItem().toString() )
       {  
        case "Si" : indCarac = "S"  ;  break;
        case "No" : indCarac = "N"  ;  break;
        default   : indCarac = ""    ;  break;
       }          


     //Recuperar valores para los campos: Valor_variable, Valor_rango_ini y Valos_rango_fin
     String valorVariable ="";
     int valorRangoIni = 0 ;
     int valorRangoFin = 0 ;

        if (jTextField2.getText().equals("Conocimiento"))
          {  
           switch( jComboBox2.getSelectedItem().toString() )
           {  
                 case "Ninguna"        : valorRangoIni = -1 ;  break;
                 case "Menos de 1 año" : valorRangoIni = 0  ;  break;
                 case "1 año"          : valorRangoIni = 1  ;  break;
                 case "2 años"         : valorRangoIni = 2  ;  break;
                 case "3 años"         : valorRangoIni = 3  ;  break;
                 case "4 años"         : valorRangoIni = 4  ;  break;
                 case "5 años"         : valorRangoIni = 5  ;  break;
                 case "6 años"         : valorRangoIni = 6  ;  break;
                 case "7 años"         : valorRangoIni = 7  ;  break;
                 case "8 años"         : valorRangoIni = 8  ;  break;
                 case "9 años"         : valorRangoIni = 9  ;  break;
                 case "10 años"        : valorRangoIni = 10 ;  break;
                 case "11 años"        : valorRangoIni = 11 ;  break;
                 case "12 años"        : valorRangoIni = 12 ;  break;
                 case "13 años"        : valorRangoIni = 13 ;  break;
                 case "14 años"        : valorRangoIni = 14 ;  break;
                 case "15 años"        : valorRangoIni = 15 ;  break;
                 case "Mas de 15 años" : valorRangoIni = 16 ;  break;
                 default               : valorRangoIni = 0 ;  break;
           }          

           switch( jComboBox3.getSelectedItem().toString() )
           {  
                 case "Ninguna"        : valorRangoFin = -1 ;  break;
                 case "Menos de 1 año" : valorRangoFin = 0  ;  break;
                 case "1 año"          : valorRangoFin = 1  ;  break;
                 case "2 años"         : valorRangoFin = 2  ;  break;
                 case "3 años"         : valorRangoFin = 3  ;  break;
                 case "4 años"         : valorRangoFin = 4  ;  break;
                 case "5 años"         : valorRangoFin = 5  ;  break;
                 case "6 años"         : valorRangoFin = 6  ;  break;
                 case "7 años"         : valorRangoFin = 7  ;  break;
                 case "8 años"         : valorRangoFin = 8  ;  break;
                 case "9 años"         : valorRangoFin = 9  ;  break;
                 case "10 años"        : valorRangoFin = 10 ;  break;
                 case "11 años"        : valorRangoFin = 11 ;  break;
                 case "12 años"        : valorRangoFin = 12 ;  break;
                 case "13 años"        : valorRangoFin = 13 ;  break;
                 case "14 años"        : valorRangoFin = 14 ;  break;
                 case "15 años"        : valorRangoFin = 15 ;  break;
                 case "Mas de 15 años" : valorRangoFin = 16 ;  break;
                 default               : valorRangoFin = 0 ;  break;
           }          
              
          }

        if (jTextField2.getText().equals("Característica"))
          {               
            if (jLabel8.getText().equals("RANGO"))
            {  
             System.out.println("valorRangoIni " + jComboBox2.getSelectedItem().toString() );
             System.out.println("valorRangoFin " + jComboBox3.getSelectedItem().toString() );
               valorRangoIni = Integer.parseInt(jComboBox2.getSelectedItem().toString());
               valorRangoFin = Integer.parseInt(jComboBox3.getSelectedItem().toString());
                
            }
            if (jLabel8.getText().equals("VALOR"))
            {  
             System.out.println("jComboBox2 " + jComboBox2.getSelectedItem().toString() );
             valorVariable  = jComboBox2.getSelectedItem().toString();
            }
   
          }
     
     //Recuperar valores para los campos de WHERE       
     int idPerfil = Integer.parseInt(jTextField1.getText());
     String idTipoCarac = jTextField2.getText();
     int idCaracPerfil = Integer.parseInt(jTextField3.getText());

     String tipCarac ;
     switch( idTipoCarac )
       {  
        case "Característica" : tipCarac = "CAR"  ;  break;
        case "Conocimiento"   : tipCarac = "CON"  ;  break;
        default               : tipCarac = " "    ;  break;
       }          
     
     // ACTUALIZACIÓN DE LA TABLA: Perfiles_idoneos_detalle 
     String sql_0 = "";
     String sql_1 = "UPDATE Perfiles_idoneos_detalle SET Ind_carac = '" + indCarac + "' , "
                                                   + "Valor_rango_ini = '" + valorRangoIni + "' ,"
                                                   + "Valor_rango_fin = '" + valorRangoFin + "' "
                    + "WHERE Id_Perfil_idoneo = '" + idPerfil + "'"
                      + "AND Id_tipo_carac_perfil = '" + tipCarac + "'"
                      + "AND Id_carac_perfil      = " + idCaracPerfil  ;

     String sql_2 = "UPDATE Perfiles_idoneos_detalle SET Ind_carac = '" + indCarac + "' , "
                                                   + "Valor_variable = '" + valorVariable + "'"
                    + "WHERE Id_Perfil_idoneo = '" + idPerfil + "'"
                      + "AND Id_tipo_carac_perfil = '" + tipCarac + "'"
                      + "AND Id_carac_perfil      = " + idCaracPerfil  ;

    if (jLabel8.getText().equals("RANGO"))
       {  
          sql_0 = sql_1;
       }
    if (jLabel8.getText().equals("VALOR"))
       {  
          sql_0 = sql_2;          
       }

     
       try (PreparedStatement pst = con.prepareStatement(sql_0)) 
       {
            pst.executeUpdate();
            mostrarDatos(idPerfil,"",0);
            
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }
       c.cerrarConexion();
     
    }//GEN-LAST:event_buttonActualizar

    private void jMenuItem1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem1ActionPerformed
    
    // Método para submenú interno: "Modificar"
    
    int fila = tableCandidatos.getSelectedRow();          
    if (fila >= 0)
    {
        jTextField1.setText(tableCandidatos.getValueAt(fila, 0).toString());
        jTextField2.setText(tableCandidatos.getValueAt(fila, 1).toString());
        jTextField3.setText(tableCandidatos.getValueAt(fila, 2).toString());
        jTextField4.setText(tableCandidatos.getValueAt(fila, 3).toString().trim() );
        
        jTextField1.setEditable(false);
        jTextField2.setEditable(false);
        jTextField3.setEditable(false);
        jTextField4.setEditable(false);
        

        int idPerfil = Integer.parseInt(jTextField1.getText());
        String idTipoCarac = jTextField2.getText();
        int idCaracPerfil = Integer.parseInt(jTextField3.getText());
        
        String tipCarac ;
        switch( idTipoCarac )
         {  
          case "Característica" : tipCarac = "CAR"  ;  break;
          case "Conocimiento"   : tipCarac = "CON"  ;  break;
          default               : tipCarac = " "    ;  break;
         }          

       // Busca en la tabla "Perfiles_idoneos_detalle", para recuperar el valor de los campos          
        Conexion c = new Conexion();
        Connection con = c.getConexion();

        String sql_1 = "SELECT * FROM Perfiles_idoneos_detalle WHERE Id_Perfil_idoneo = '" + idPerfil + "'"
                  + "AND Id_tipo_carac_perfil = '" + tipCarac + "'"
                  + "AND Id_carac_perfil      = " + idCaracPerfil  ;
        
        try {            
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql_1);

             
            while(rs.next())
            {        
              cargarCombo(1,0,0);                     
              switch( rs.getString(4))
              {  
               case "S" : jComboBox1.setSelectedItem("Si") ;  break;
               case "N" : jComboBox1.setSelectedItem("No") ;  break;
               default  : jComboBox1.setSelectedItem("")   ;  break;
              }


          //Carga en combos las caracterìsticas tipo CAR (carcaterísticas)
           if (rs.getString(2).equals("CAR") )
            { 
          
              if (rs.getString(5).equals("V") )
              {        

                switch( rs.getInt(3))
                {  
                 case 2   : cargarCombo(4,18,75) ;  break;
                 case 3   : cargarCombo(5,0,50)  ;  break;
                 case 4   : cargarCombo(6,18,75) ;  break;
                 case 6   : cargarCombo(9,0,0) ;  break;
                 case 7   : cargarCombo(9,0,0) ;  break;
                 case 8   : cargarCombo(9,0,0) ;  break;
                 case 9   : cargarCombo(9,0,0) ;  break;
                 case 10  : cargarCombo(9,0,0) ;  break;
                 default  : cargarCombo(2,0,0) ;  break;
                }
                                  
                jComboBox2.setSelectedItem(rs.getString(8).trim());                
                jComboBox3.setVisible(false);                      
                jLabel8.setText("VALOR");
                jLabel1.setText("");
                jLabel9.setText("");
              }
             
              if (rs.getString(5).equals("R") )
              { 

                switch( rs.getInt(3))
                {  
                 case 1   : cargarCombo(2,18,75) ;  break;
                 case 5   : cargarCombo(2,0,50) ;  break;
                 default  : cargarCombo(2,0,0) ;  break;
                }

                jComboBox2.setSelectedItem(String.valueOf(rs.getInt(6)));
                jComboBox3.setVisible(true);
                jComboBox3.setSelectedItem(String.valueOf(rs.getInt(7)));

                jLabel8.setText("RANGO");
              }
            }  
              
          //Carga en combos las caracterìsticas tipo CON (Conocimientos)
           if (rs.getString(2).equals("CON") )
            { 
              cargarCombo(3,0,0); 

              if (rs.getString(5).equals("R") )
              { 
                jLabel8.setText("RANGO");

                switch( rs.getInt(6))
                {  
                 case -1  : jComboBox2.setSelectedItem("Ninguna") ;  break;
                 case 0   : jComboBox2.setSelectedItem("Menos de 1 año") ;  break;
                 case 1   : jComboBox2.setSelectedItem("1 año") ;  break;
                 case 2   : jComboBox2.setSelectedItem("2 años") ;  break;
                 case 3   : jComboBox2.setSelectedItem("3 años") ;  break;
                 case 4   : jComboBox2.setSelectedItem("4 años") ;  break;
                 case 5   : jComboBox2.setSelectedItem("5 años") ;  break;
                 case 6   : jComboBox2.setSelectedItem("6 años") ;  break;
                 case 7   : jComboBox2.setSelectedItem("7 años") ;  break;
                 case 8   : jComboBox2.setSelectedItem("8 años") ;  break;
                 case 9   : jComboBox2.setSelectedItem("9 años") ;  break;
                 case 10  : jComboBox2.setSelectedItem("10 años") ;  break;
                 case 11  : jComboBox2.setSelectedItem("11 años") ;  break;
                 case 12  : jComboBox2.setSelectedItem("12 años") ;  break;
                 case 13  : jComboBox2.setSelectedItem("13 años") ;  break;
                 case 14  : jComboBox2.setSelectedItem("14 años") ;  break;
                 case 15  : jComboBox2.setSelectedItem("15 años") ;  break;
                 case 16  : jComboBox2.setSelectedItem("Mas de 15 años") ;  break;
                 default  : jComboBox2.setSelectedItem("") ;  break;
                }
                
                jComboBox3.setVisible(true);

                switch( rs.getInt(7))
                {  
                 case -1  : jComboBox3.setSelectedItem("Ninguna") ;  break;
                 case 0   : jComboBox3.setSelectedItem("Menos de 1 año") ;  break;
                 case 1   : jComboBox3.setSelectedItem("1 año") ;  break;
                 case 2   : jComboBox3.setSelectedItem("2 años") ;  break;
                 case 3   : jComboBox3.setSelectedItem("3 años") ;  break;
                 case 4   : jComboBox3.setSelectedItem("4 años") ;  break;
                 case 5   : jComboBox3.setSelectedItem("5 años") ;  break;
                 case 6   : jComboBox3.setSelectedItem("6 años") ;  break;
                 case 7   : jComboBox3.setSelectedItem("7 años") ;  break;
                 case 8   : jComboBox3.setSelectedItem("8 años") ;  break;
                 case 9   : jComboBox3.setSelectedItem("9 años") ;  break;
                 case 10  : jComboBox3.setSelectedItem("10 años") ;  break;
                 case 11  : jComboBox3.setSelectedItem("11 años") ;  break;
                 case 12  : jComboBox3.setSelectedItem("12 años") ;  break;
                 case 13  : jComboBox3.setSelectedItem("13 años") ;  break;
                 case 14  : jComboBox3.setSelectedItem("14 años") ;  break;
                 case 15  : jComboBox3.setSelectedItem("15 años") ;  break;
                 case 16  : jComboBox3.setSelectedItem("Mas de 15 años") ;  break;
                 default  : jComboBox2.setSelectedItem("") ;  break;
                }

              }
               
            } 


           }   
       
        rs.close();
        c.cerrarConexion();
            
        } catch (SQLException ex) {
            Logger.getLogger(VentanaPerfilesIdoneosDetalle.class.getName()).log(Level.SEVERE, null, ex);
        }
        
       
    }
    else
    {
      JOptionPane.showMessageDialog(null, "Debes seleccionar una Característica");                
    }
    
    }//GEN-LAST:event_jMenuItem1ActionPerformed

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
       VentanaPerfilesIdoneosPrincipal perfilesIdoneos = new VentanaPerfilesIdoneosPrincipal();
       perfilesIdoneos.setVisible(true);
      
       perfilesIdoneos.mostrarDatos("");
             
       dispose();        
    }//GEN-LAST:event_jButton1ActionPerformed

    private void jTextField1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jTextField1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jTextField1ActionPerformed

    private void jTextField4ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jTextField4ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jTextField4ActionPerformed

    private void jTextField3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jTextField3ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jTextField3ActionPerformed

    private void jComboBox1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jComboBox1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jComboBox1ActionPerformed

    private void jComboBox2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jComboBox2ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jComboBox2ActionPerformed



    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton buttonBuscar;
    private javax.swing.JButton jButton1;
    private javax.swing.JComboBox<String> jComboBox1;
    private javax.swing.JComboBox<String> jComboBox2;
    private javax.swing.JComboBox<String> jComboBox3;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JMenuItem jMenuItem1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPopupMenu jPopupMenu1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTextField jTextField1;
    private javax.swing.JTextField jTextField2;
    private javax.swing.JTextField jTextField3;
    private javax.swing.JTextField jTextField4;
    private javax.swing.JTable tableCandidatos;
    // End of variables declaration//GEN-END:variables

    
}
