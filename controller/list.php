<?php
header('Access-Control-Allow-Origin: *');

include "konekdb.php";

$stmt = $db->prepare("SELECT id, judul, pengarang, penerbit, kategori, sinopsis, tanggal_terbit FROM books");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>