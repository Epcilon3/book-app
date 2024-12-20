<?php
header('Content-Type: application/json');

include "konekdb.php";

$id = $_POST['id'];
$judul = $_POST['judul'];
$pengarang = $_POST['pengarang'];
$penerbit = $_POST['penerbit'];
$kategori = $_POST['kategori'];
$sinopsis = $_POST['sinopsis'];
$tanggal_terbit = $_POST['tanggal_terbit'];

$stmt = $db->prepare("UPDATE books SET judul = ?, pengarang = ?, penerbit = ?, kategori = ?, sinopsis = ?, tanggal_terbit = ? WHERE id = ?");
$result = $stmt -> execute([$judul, $pengarang, $penerbit, $kategori, $sinopsis, $tanggal_terbit, $id]);

echo json_encode([
    'success' => $result
]);
?>