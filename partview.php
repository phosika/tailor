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


if(isset($_GET["typeid"])){
$typeid = $_GET["typeid"];
$pdo->exec("DELETE FROM part WHERE id='".$typeid."'");}



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
                    <h1 class="page-header">Measurement Part</h1>
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
                                            <th>#</th>
                                            <th>Measurement Type</th>
                                            <th>Measurement Part</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                     <tbody>
<?php

// $ddaa = $pdo->query("SELECT id, type, title FROM part ORDER BY id");

$ddaa = $pdo->query("
    SELECT part.id, type.title AS type_title, part.title 
    FROM part 
    LEFT JOIN type ON part.type = type.id 
    ORDER BY part.id
");

while ($data = $ddaa->fetch(PDO::FETCH_ASSOC)) {
  echo "<tr>
          <td>{$data['id']}</td>
          <td>" . ($data['type_title'] ?? 'N/A') . "</td>
          <td>{$data['title']}</td>
          <td>
              <a href='partedit.php?id={$data['id']}' class='btn btn-info btn-xs'>Edit</a>
              -<a href='partview.php?typeid={$data['id']}'><button type='button' class='btn btn-danger btn-xs'>DELETE</button></a>
          </td>
        </tr>";
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
