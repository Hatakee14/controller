<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;
use App\Models\ProduksiModel;

use App\Models\RencanaproduksiModel;
use App\Models\StokModel;

class Produksi extends BaseController
{
    protected $produksi;
    protected $detailproduksi;
    protected $rencanaproduksi;
    protected $stokbahan;

    public function __construct(){
        $this->produksi = new ProduksiModel();
       
        $this->rencanaproduksi = new RencanaproduksiModel();
        $this->stokbahan = new StokModel();
    }

    public function index()
    {
        
        $data = [
            'stok' => $this->stokbahan->where('JumlahStok <',30)->countAllResults(),
            'minta' => $this->stokbahan->where('JumlahStok <', 30)->findAll(),
            'hariini' => $this->produksi->where('TanggalMulaiProduksi =',date('Y-m-d'))->countAllResults(),
            'rencana' => $this->produksi->where('TanggalMulaiProduksi >',date('Y-m-d'))->countAllResults(),
            'detail' => $this->produksi->findAll()
        ];
        return view('welcome_message',$data);

    }
    public function tambah(){
        $data =[
            'stok' => $this->stokbahan->findAll(),
            'produk' => $this->produksi->findAll(),
        ];
        return view ('tambah',$data);
    }
    public function simpan()

{
    $nama_barang = $this->request->getPost('nama_barang');
    $tanggal_mulai = $this->request->getPost('tanggal_mulai');
    $tanggal_selesai = $this->request->getPost('tanggal_selesai');
    $jumlah_produksi = $this->request->getPost('jumlah_produksi');
    $bahan_baku = $this->request->getPost('bahan_baku');
    $filee = $this->request->getFile('file');

    // generate nama file random
    $timestamp = date('Ymd_His'); // Menggunakan format tanggal dan waktu sekarang
    $file = $nama_barang . '_' . $timestamp . '.' . $filee->getExtension();
    $filee->move('FILE', $file);
    // Ubah array bahan baku menjadi string dengan implode

    // Siapkan data yang akan disimpan ke dalam model produksi
    $data = [
        'TanggalMulaiProduksi' => $tanggal_mulai,
        'TanggalSelesaiProduksi' => $tanggal_selesai,
        'JumlahProduksi' => $jumlah_produksi,
        'bahanbaku' => $bahan_baku, // Simpan data bahan baku dalam bentuk string
        'NamaBarang' => $nama_barang,
        'file' => $file,
    ];

    // Simpan data ke dalam model produksi
    $this->produksi->insert($data);

    return redirect()->to('tambah'); // Kembali ke view tambah setelah data disimpan
}
    public function update()
{
    $id = $this->request->getPost('id');
    $nama_barang = $this->request->getPost('nama_barang');
    $tanggal_mulai = $this->request->getPost('tanggal_mulai');
    $tanggal_selesai = $this->request->getPost('tanggal_selesai');
    $jumlah_produksi = $this->request->getPost('jumlah_produksi');
    $bahan_baku = $this->request->getPost('bahan_baku'); 
    $filee = $this->request->getFile('file');

    // generate nama file random
    $timestamp = date('Ymd_His'); // Menggunakan format tanggal dan waktu sekarang
    $file = $nama_barang . '_' . $timestamp . '.' . $filee->getExtension();
    $filee->move('FILE', $file);

    // Ubah array bahan baku menjadi string dengan implode
    $this->produksi->update($id,[
        'TanggalMulaiProduksi' => $tanggal_mulai,
        'TanggalSelesaiProduksi' => $tanggal_selesai,
        'JumlahProduksi' => $jumlah_produksi,
        'bahanbaku' => $bahan_baku, // Simpan data bahan baku dalam bentuk string
        'NamaBarang' => $nama_barang,
        'file' => $file,
    ]);
    // Siapkan data yang akan disimpan ke dalam model produksi

    return redirect()->to('tambah'); // Kembali ke view tambah setelah data disimpan
}

public function hapus($id){
    $file = $id['file'];
    $this->produksi->delete($id);
    $filePath = 'public/FILE/' . $file;
        if (file_exists($filePath)) {
            unlink($filePath);
        }
    
    return redirect()->to('tambah');
}

    
}
