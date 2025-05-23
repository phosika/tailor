<?php
require_once('function.php');
dbconnect();
session_start();

if (!is_user()) {
	redirect('index.php');
}

?>
   
  

<?php
 $user = $_SESSION['username'];
$usid = $pdo->query("SELECT id FROM users WHERE username='".$user."'");
$usid = $usid->fetch(PDO::FETCH_ASSOC);
 $uid = $usid['id'];
 include ('header.php');



 if(isset($_GET["id"])){
  $orderid = $_GET["id"];
  
  // ການຢືນຢັນກ່ອນລຶບ
  if(!isset($_GET["confirm"])){
      echo "<script>
          if(confirm('ທ່ານແນ່ໃຈທີ່ຈະລຶບຂໍ້ມູນນີ້ແທ້ບໍ?')){
              window.location.href = '?id=$orderid&confirm=yes';
          } else {
              window.location.href = 'orderlist.php'; // ແທນທີ່ຢູ່ທີ່ຕ້ອງການ
          }
      </script>";
      exit();
  }

  // ການປ້ອງກັນ SQL Injection ໂດຍໃຊ້ Prepared Statement
  if($_GET["confirm"] === 'yes'){
      try {
          $stmt = $pdo->prepare("DELETE FROM `order` WHERE id = ?");
          $stmt->execute([$customerid]);
          echo "ລຶບຂໍ້ມູນສຳເລັດແລ້ວ";
      } catch(PDOException $e) {
          echo "ເກີດຂໍ້ຜິດພາດ: " . $e->getMessage();
      }
  }
}



// if(isset($_GET["id"])){
// $id = $_GET["id"];
// 	$pdo->exec("DELETE FROM `order` WHERE id='$id'");

// echo "<div class='alert alert-success alert-dismissable'>
// <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>	

// Order Deleted Successfully!

// </div>";


// }


 ?>
    <link href="css/style.default.css" rel="stylesheet">
  	<link href="css/jquery.datatables.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="../bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.css" rel="stylesheet">
    <!-- DataTables Responsive CSS -->
    <link href="../bower_components/datatables-responsive/css/dataTables.responsive.css" rel="stylesheet">


        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header" style="font-family: Noto Serif Lao">ເບິ່ງການສັ່ງຕັດ</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
			
			
			
			                 <div class="panel panel-default">
            
                    <div class="panel-body">
                    
                     <div class="clearfix mb30"></div>
            
                      <div class="table-responsive">
                      <table class="table table-striped" id="table2">

                                    <thead>
                                        <tr>
                                            <th style="font-family: Noto Serif Lao">ລດ #</th>
                                            <th style="font-family: Noto Serif Lao">ລູກຄ້າ</th>
                                            <th style="font-family: Noto Serif Lao">ລາຍລະອຽດ</th>
                                            <th style="font-family: Noto Serif Lao">ວັນທີຮັບເຄື່ອງ</th>
                                            <th style="font-family: Noto Serif Lao">ມູນຄ່າລວມ</th>
                                            <th style="font-family: Noto Serif Lao">ຍອກເຫຼືອ</th>
                                            <th style="font-family: Noto Serif Lao">Action</th>
                                        </tr>
                                    </thead>
                                     <tbody>
<?php

$ddaa = $pdo->query("SELECT id, customer, description, date_received, amount, paid FROM `order` ORDER BY id desc");
    while ($data = $ddaa->fetch(PDO::FETCH_ASSOC))
    {
$rname = $pdo->query("SELECT fullname FROM customer WHERE id='".$data['customer']."'");
$rname =	$rname->fetch(PDO::FETCH_ASSOC);
$balance = 	$data['amount'] - $data['paid'];
 echo "                                 <tr>
                                            <td>$data[id]</td>
                                            <td>$rname[fullname]</td>
											<td>$data[description]</td>
                                            <td>$data[date_received]</td>
											<td>$data[amount] KIP</td>
											<td>$balance KIP</td>
                                   
                                            
											<td>
<a href='addpayment.php?id=$data[id]' class='btn btn-success btn-xs'>Add Payment</a>
<a href='printinvoice.php?id=$data[id]' class='btn btn-warning btn-xs'>Receipt</a>
<a href='orderedit.php?id=$data[id]' class='btn btn-info btn-xs'>Update</a>
<a href='orderlist.php?id=$data[id]'><button type='button' class='btn btn-danger btn-xs'>DELETE</button></a>
";

echo "</td></tr>";

}
?>
										
                                    </tbody>
                                </table>
                            </div><!-- table-responsive -->
		  
        </div>
      </div>
                  
      

      
    </div><!-- contentpanel -->
    </div>
        <!-- /#page-wrapper --><?php
 include ('footer.php');
 ?>
 <script src="js/jquery.datatables.min.js"></script>
<script src="js/select2.min.js"></script>

<script>
  jQuery(document).ready(function() {
    
    "use strict";
    
    jQuery('#table1').dataTable();
    
    jQuery('#table2').dataTable({
      "sPaginationType": "full_numbers"
    });
    
    // Select2
    jQuery('select').select2({
        minimumResultsForSearch: -1
    });
    
    jQuery('select').removeClass('form-control');
    
    // Delete row in a table
    jQuery('.delete-row').click(function(){
      var c = confirm("Continue delete?");
      if(c)
        jQuery(this).closest('tr').fadeOut(function(){
          jQuery(this).remove();
        });
        
        return false;
    });
    
    // Show aciton upon row hover
    jQuery('.table-hidaction tbody tr').hover(function(){
      jQuery(this).find('.table-action-hide a').animate({opacity: 1});
    },function(){
      jQuery(this).find('.table-action-hide a').animate({opacity: 0});
    });
  
  
  });
</script>



</body>
</html>
