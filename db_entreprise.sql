-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 15, 2024 at 01:47 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_entreprise`
--

-- --------------------------------------------------------

--
-- Table structure for table `absensi`
--

CREATE TABLE `absensi` (
  `id_absen` int(11) NOT NULL,
  `nip` varchar(11) NOT NULL,
  `nama_pegawai` varchar(60) NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_keluar` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bagian`
--

CREATE TABLE `bagian` (
  `kd_bagian` varchar(8) NOT NULL,
  `nama_bagian` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bagian`
--

INSERT INTO `bagian` (`kd_bagian`, `nama_bagian`) VALUES
('gd', 'gudang'),
('prod', 'produksi');

-- --------------------------------------------------------

--
-- Table structure for table `gudang`
--

CREATE TABLE `gudang` (
  `kd_bahan` varchar(10) NOT NULL,
  `nama_bahan` varchar(20) NOT NULL,
  `satuan` varchar(10) NOT NULL,
  `stok_bahan` int(10) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `tanggal_keluar` date NOT NULL,
  `kd_bagian` varchar(8) NOT NULL,
  `nip` varchar(11) NOT NULL,
  `nama_pegawai` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `nip` varchar(11) NOT NULL,
  `nama_pegawai` varchar(60) NOT NULL,
  `password` text NOT NULL,
  `kd_bagian` varchar(8) NOT NULL,
  `status` varchar(25) NOT NULL,
  `alamat` text NOT NULL,
  `tgl_lahir` date NOT NULL,
  `jekel` varchar(20) NOT NULL,
  `telepon` varchar(15) NOT NULL,
  `agama` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`nip`, `nama_pegawai`, `password`, `kd_bagian`, `status`, `alamat`, `tgl_lahir`, `jekel`, `telepon`, `agama`) VALUES
('12345678', 'abdul dul', '12345', 'gd', 'aktif', 'landung sari', '2004-03-25', 'laki - laki', '085566227711', 'islam');

-- --------------------------------------------------------

--
-- Table structure for table `pembelian`
--

CREATE TABLE `pembelian` (
  `id_pembelian` int(11) NOT NULL,
  `tanggal_pembelian` date DEFAULT NULL,
  `kode_supplier` varchar(10) DEFAULT NULL,
  `nama_supplier` varchar(100) DEFAULT NULL,
  `kode_bahan` varchar(10) DEFAULT NULL,
  `nama_bahan` varchar(100) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL,
  `total_harga` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `produksi`
--

CREATE TABLE `produksi` (
  `kode_produksi` varchar(11) NOT NULL,
  `kode_produk` varchar(11) NOT NULL,
  `nama_produk` varchar(25) NOT NULL,
  `tgl_produksi` date NOT NULL,
  `kd_bahan` varchar(10) NOT NULL,
  `nama_bahan` varchar(20) NOT NULL,
  `stok_bahan` int(10) NOT NULL,
  `nip` varchar(11) NOT NULL,
  `nama_pegawai` varchar(60) NOT NULL,
  `kd_bagian` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `kode_supplier` varchar(10) NOT NULL,
  `nama_supplier` varchar(100) DEFAULT NULL,
  `alamat_supplier` text DEFAULT NULL,
  `telepon_supplier` varchar(15) DEFAULT NULL,
  `email_supplier` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_keuangan`
--

CREATE TABLE `transaksi_keuangan` (
  `id_transaksi` int(11) NOT NULL,
  `tanggal_transaksi` date DEFAULT NULL,
  `jenis_transaksi` enum('pemasukan','pengeluaran') DEFAULT NULL,
  `jumlah` decimal(10,2) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `nip` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id_absen`),
  ADD KEY `nip` (`nip`);

--
-- Indexes for table `bagian`
--
ALTER TABLE `bagian`
  ADD PRIMARY KEY (`kd_bagian`);

--
-- Indexes for table `gudang`
--
ALTER TABLE `gudang`
  ADD PRIMARY KEY (`kd_bahan`),
  ADD KEY `kd_bagian` (`kd_bagian`,`nip`),
  ADD KEY `nip` (`nip`);

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`nip`),
  ADD KEY `kd_bagian` (`kd_bagian`);

--
-- Indexes for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD PRIMARY KEY (`id_pembelian`),
  ADD KEY `kode_supplier` (`kode_supplier`),
  ADD KEY `kode_bahan` (`kode_bahan`);

--
-- Indexes for table `produksi`
--
ALTER TABLE `produksi`
  ADD PRIMARY KEY (`kode_produksi`),
  ADD KEY `kd_bahan` (`kd_bahan`,`nip`,`kd_bagian`),
  ADD KEY `nip` (`nip`),
  ADD KEY `kd_bagian` (`kd_bagian`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`kode_supplier`);

--
-- Indexes for table `transaksi_keuangan`
--
ALTER TABLE `transaksi_keuangan`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `nip` (`nip`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pembelian`
--
ALTER TABLE `pembelian`
  MODIFY `id_pembelian` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaksi_keuangan`
--
ALTER TABLE `transaksi_keuangan`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensi`
--
ALTER TABLE `absensi`
  ADD CONSTRAINT `absensi_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `karyawan` (`nip`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `gudang`
--
ALTER TABLE `gudang`
  ADD CONSTRAINT `gudang_ibfk_1` FOREIGN KEY (`kd_bagian`) REFERENCES `bagian` (`kd_bagian`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `gudang_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `karyawan` (`nip`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD CONSTRAINT `karyawan_ibfk_1` FOREIGN KEY (`kd_bagian`) REFERENCES `bagian` (`kd_bagian`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD CONSTRAINT `pembelian_ibfk_1` FOREIGN KEY (`kode_supplier`) REFERENCES `supplier` (`kode_supplier`),
  ADD CONSTRAINT `pembelian_ibfk_2` FOREIGN KEY (`kode_bahan`) REFERENCES `gudang` (`kd_bahan`);

--
-- Constraints for table `produksi`
--
ALTER TABLE `produksi`
  ADD CONSTRAINT `produksi_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `karyawan` (`nip`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `produksi_ibfk_2` FOREIGN KEY (`kd_bagian`) REFERENCES `bagian` (`kd_bagian`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `produksi_ibfk_3` FOREIGN KEY (`kd_bahan`) REFERENCES `gudang` (`kd_bahan`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `transaksi_keuangan`
--
ALTER TABLE `transaksi_keuangan`
  ADD CONSTRAINT `transaksi_keuangan_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `karyawan` (`nip`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
