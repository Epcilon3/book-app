<?php
header('Content-Type: application/json');

include "konekdb.php";

$judul = $_POST['judul'];
$pengarang = $_POST['pengarang'];
$penerbit = $_POST['penerbit'];
$kategori = $_POST['kategori'];
$sinopsis = $_POST['sinopsis'];
$tanggal_terbit = $_POST['tanggal_terbit'];

// Validasi tahun terbit
// if (!is_numeric($tanggal_terbit) || strlen($tanggal_terbit) != 4 || $tanggal_terbit < 1000 || $tanggal_terbit > 9999) {
//    echo json_encode([
//        'success' => false,
//        'message' => 'Tahun terbit tidak valid.'
//    ]);
//    exit;
// }

// Siapkan query untuk menyisipkan data
$stmt = $db->prepare("INSERT INTO books (judul, pengarang, penerbit, kategori, sinopsis, tanggal_terbit) 
                      VALUES (?, ?, ?, ?, ?, ?)");

// Eksekusi query
$result = $stmt->execute([$judul, $pengarang, $penerbit, $kategori, $sinopsis, $tanggal_terbit]);


// Kirim respons JSON
echo json_encode([
    'success' => $result
]);
?>
