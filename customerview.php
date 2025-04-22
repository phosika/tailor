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


// if(isset($_GET["id"])){
// $customerid = $_GET["id"];
// $pdo->exec("DELETE FROM customer WHERE id='".$customerid."'");
// }

if(isset($_GET["id"])){
  $customerid = $_GET["id"];
  
  // ການຢືນຢັນກ່ອນລຶບ
  if(!isset($_GET["confirm"])){
      echo "<script>
          if(confirm('ທ່ານແນ່ໃຈທີ່ຈະລຶບຂໍ້ມູນນີ້ແທ້ບໍ?')){
              window.location.href = '?id=$customerid&confirm=yes';
          } else {
              window.location.href = 'customerview.php'; // ແທນທີ່ຢູ່ທີ່ຕ້ອງການ
          }
      </script>";
      exit();
  }

  // ການປ້ອງກັນ SQL Injection ໂດຍໃຊ້ Prepared Statement
  if($_GET["confirm"] === 'yes'){
      try {
          $stmt = $pdo->prepare("DELETE FROM customer WHERE id = ?");
          $stmt->execute([$customerid]);
          echo "ລຶບຂໍ້ມູນສຳເລັດແລ້ວ";
      } catch(PDOException $e) {
          echo "ເກີດຂໍ້ຜິດພາດ: " . $e->getMessage();
      }
  }
}


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
                    <h1 class="page-header" style="font-family: Noto Serif Lao">ລູກຄ້າທັງໝົດ</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
			
			
			
			<div class="contentpanel">
                     <div class="panel panel-default">
                
                        <div class="panel-body">
                        
                         <div class="clearfix mb30"></div>
                
                          <div class="table-responsive">
                          <table class="table table-striped" id="table2">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th style="font-family: Noto Serif Lao">ຊື່ ແລະ ນາມສະກຸນ</th>
                                            <th style="font-family: Noto Serif Lao">ທີ່ຢູ່</th>
                                            <th style="font-family: Noto Serif Lao">ເບີຕິດຕໍ່</th>
                                            <th style="font-family: Noto Serif Lao">ເພດ</th>
                                            <th style="font-family: Noto Serif Lao">ຄຳສັ່ງ</th>
                                        </tr>
                                    </thead>
                                     <tbody>
<?php

$ddaa = $pdo->query("SELECT id, address, fullname, phonenumber, sex FROM customer ORDER BY id");
    while ($data = $ddaa->fetch(PDO::FETCH_ASSOC))
    {
		if($data['sex'] ==0)
		{
			$data['sex']='Male';
		}
		else
		{
			$data['sex']='Female';
		}
		$mes = $pdo->query("SELECT * FROM `measurement` WHERE `customer_id` = ".$data['id']." LIMIT 1");
		if(!$mes->fetch(PDO::FETCH_ASSOC)){
		$measure = '<a href="addmeasurement.php?id='.$data['id'].'" class="btn btn-warning btn-xs">ເພີ່ມການວັດແທກໃຫມ່</a>';
		}
		else{
		$measure = '<a href="editmeasurement.php?id='.$data['id'].'" class="btn btn-warning btn-xs">ແກ້ໄຂການວັດແທກ</a>';
		}
			

 echo "<tr>
         <td>$data[id]</td>
				 <td><a href='customeredit.php?id=$data[id]'>$data[fullname]</a></td>
         <td>$data[address]</td>
				 <td>$data[phonenumber]</td>
				 <td>$data[sex]</td>                                 
				 <td><a href='orderadd.php?id=$data[id]' class='btn btn-success btn-xs'>ສັ່ງ່ຕັດໃຫມ່</a>$measure
             <a href='customerview.php?id=$data[id]'><button type='button' class='btn btn-danger btn-xs'>ລຶມຂໍ້ມູນລູກຄ້າ</button></a>
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
        <!-- /#page-wrapper -->

   <?php
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




