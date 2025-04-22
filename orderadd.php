<?php
require_once('function.php');
dbconnect();
session_start();


if (!is_user()) {
    redirect('index.php');
}

$user = $_SESSION['username'];
include('header.php');

// Get user ID safely
try {
    $stmt = $pdo->prepare("SELECT id FROM users WHERE username = ?");
    $stmt->execute([$user]);
    $usid = $stmt->fetch(PDO::FETCH_ASSOC);
    $uid = $usid['id'] ?? null;
} catch (PDOException $e) {
    die("Database error: " . $e->getMessage());
}


?>


<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header" style="font-family: Noto Serif Lao">ເພີ່ມການຄຳສັ່ງຕັດ</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">

        <div class="col-md-10 col-md-offset-1">




            <?php
if ($_POST) {
	try {
    // Input validation first
    if (empty($_POST['customer'])) {
        throw new Exception("Customer is required");
    }
    
    // Start transaction ONLY after validations
	        // Transaction management
	$shouldCommit = false;
    if (!$pdo->inTransaction()) {
        $pdo->beginTransaction();
		$shouldCommit = true;
    }

		// Sanitize inputs
		$customer = (int)$_POST['customer'];
		$desc = htmlspecialchars($_POST['desc']);
		$date_received = $_POST['date_received'];
		$completed = in_array($_POST['completed'], ['Yes', 'No']) ? $_POST['completed'] : 'No';
		$date_collected = $_POST['date_collected'] ?? null;
		$amount = (float)$_POST['amount'];
		$paid = (float)($_POST['paid'] ?? 0);
		$received_by = (int)$_POST['received_by'];

		// Validate customer exists
		$stmt = $pdo->prepare("SELECT id FROM customer WHERE id = ?");
		$stmt->execute([$customer]);
		if (!$stmt->fetch()) {
			throw new Exception("Invalid customer selected");
		}



		// Insert order
		$stmt = $pdo->prepare("INSERT INTO `order` 
			(customer, description, amount, paid, received_by, date_received, completed, date_collected) 
			VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

		$stmt->execute([
			$customer,
			$desc,
			$amount,
			$paid,
			$received_by,
			$date_received,
			$completed,
			$date_collected
		]);

		$cid = $pdo->lastInsertId();

		// Get customer name for calendar
		$stmt = $pdo->prepare("SELECT fullname FROM customer WHERE id = ?");
		$stmt->execute([$customer]);
		$name = $stmt->fetchColumn() . ": " . substr($desc, 0, 100);

		$color = $completed === 'No' ? '#a00000' : '#00a014';


		        // Insert calendar event
				$stmt = $pdo->prepare("INSERT INTO calendar 
				(title, description, start, end, allDay, color, url, category, user_id) 
				VALUES (?, ?, ?, ?, 'true', ?, ?, 'Orders', ?)");
	
			$stmt->execute([
				$name,
				$desc,
				$date_received,
				$date_collected,
				$color,
				"../orderedit.php?id=$cid",
				$uid
			]);
	
			if ($shouldCommit) {
				$pdo->commit();
			}

		echo "<div class='alert alert-success alert-dismissable'>
			<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>	
			Order Added Successfully!
		  </div>";


	} catch (Exception $e) {
        if ($pdo->inTransaction() && $shouldCommit) {
            $pdo->rollBack();
        }
    // Handle error
    die("Error: " . $e->getMessage());
	}

}
 
?>



            <script>
            $(function() {
                $("#datepicker").datepicker();
            });
            </script>



            <!-- The form remains mostly the same but with added validation -->
            <form action="orderadd.php" method="post" onsubmit="return validateForm()">

                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>ເລືອກຊື່ລູກຄ້າ</label>
                            <select name="customer" class="form-control" required>
                                <option value="">ກະລຸນາເລືອກຊື່ລູກຄ້າ</option>
                                <?php
					$ddaa = $pdo->query("SELECT id, fullname FROM customer ORDER BY fullname");
					while ($data = $ddaa->fetch(PDO::FETCH_ASSOC)) {
						$selected = (isset($_GET['id']) && $data['id'] == $_GET['id']) ? 'selected' : '';
						echo "<option value='{$data['id']}' $selected>{$data['fullname']}</option>";
					}
					?>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <!-- Add required attributes to other mandatory fields -->
                        <div class="form-group">
                            <label>ລາຍລະອຽກເພີ່ມຕື່ມ</label>
                            <input type="text" name="desc" class="form-control" required>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label> ວັນທີຮັບເຄື່ອງ</label><br/>
                            <input type="date" name="date_received" style="width:200px; height: 40px;" />
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>ຜູ້ຮັບສັ່ງຕັດ</label>
                            <select name="received_by" class="form-control" required>
                                <option value="">ເລືອກຊື່ພະນັກງານ</option>
                                <?php
					$staff = $pdo->query("SELECT id, fullname FROM staff ORDER BY fullname");
					while ($member = $staff->fetch(PDO::FETCH_ASSOC)) {
						echo "<option value='{$member['id']}'";
						echo ">{$member['fullname']}</option>";
					}
					?>
                            </select>
                        </div>
                    </div>

                </div>

                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>ມູນຄ່າລວມ</label>
                            <?php echo "LAK";?><br/>
                            <input type="text" name="amount" style="width:200px; height: 40px;" />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>ຈ່າຍມັດຈຳ </label>
                            <?php echo "LAK";?>
                            <br />
                            <input type="text" name="paid" style="width:200px; height: 40px;" />
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>ສະຖານະ?</label><br />
                            <select name="completed" class="form-control">
                                <option value='No'>ຢັງດຳເນີນການ</option>
                                <option value='Yes'>ສຳເລັດ</option>
                            </select>

                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>ວັນທີ່ສັ່ງຕັດ</label><br />
                            <input type="date" name="date_collected" style="width:200px; height: 40px;" /><br /><br />
                        </div>
                    </div>

                </div>

                <button type="submit" class="btn btn-primary" value="ADD">ບັນທຶກຂໍ້ມູນ</button>



                <!-- Rest of the form with similar validation -->
            </form>




        </div>

    </div>
    <!-- /.row -->
</div>
<!-- /#page-wrapper -->

 



<script src="js/bootstrap-timepicker.min.js"></script>


<script>
jQuery(document).ready(function() {


    jQuery("#ssn").mask("999-99-9999");

    // Time Picker
    jQuery('#timepicker').timepicker({
        defaultTIme: false
    });
    jQuery('#timepicker2').timepicker({
        showMeridian: false
    });
    jQuery('#timepicker3').timepicker({
        minuteStep: 15
    });


});

function validateForm() {
    // Add client-side validation
    const amount = document.querySelector('[name="amount"]');
    if (isNaN(amount.value) || amount.value <= 0) {
        alert('Please enter a valid amount');
        return false;
    }
    return true;
}
</script>

<?php
 include ('footer.php');
 ?>