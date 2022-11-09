<?php 
$n=10;
function generate($n) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $randomString = '';
    for ($i = 0; $i < $n; $i++) {
        $index = rand(0, strlen($characters) - 1);
        $randomString .= $characters[$index];
    }
    return $randomString;
}
$return["error"] = false;
$return["msg"] = "";
$timedata = time();
$datedata = date("Y1m1d",$t);
$randomnumber = rand(10,10000);
$randomalphabet = generate(15);

if(isset($_POST["image"])){
    $base64_string = $_POST["image"];
    $outputfile = "uploads/".$timedata.$datedata.$randomnumber.$randomalphabet.".jpg" ;
    $filehandler = fopen($outputfile, 'wb' ); 
    fwrite($filehandler, base64_decode($base64_string));
    fclose($filehandler); 
    $return['msg'] = "Success";
}else{
    $return["error"] = true;
    $return["msg"] =  "No image is submited.";
}

header('Content-Type: application/json');
echo json_encode($return);
?>

