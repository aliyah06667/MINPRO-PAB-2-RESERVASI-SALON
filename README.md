## <p align="center">MINI PROJECT PEMOGRAMAN APLIKASI BERGERAK (2) "RESERVASI SALON"</p>

## <p align="center">BEAUTI-FY SALON</p>

<img width="1200" height="400" alt="beauti-fysalon img" src="https://github.com/user-attachments/assets/cfa42b6d-4117-47af-a00c-5bc3ce3750c5" />

### <p align="center">Preview Aplikasi</p> 

<p align="center">
  <img src="https://github.com/user-attachments/assets/a95a1a91-4c8f-4c47-b232-5211d9880ee4" width="300"/>
  <img src="https://github.com/user-attachments/assets/116edb3f-24af-460b-8b16-7a94118306dd" width="300"/>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/ae99b0f8-0440-42a5-b84c-982390da0dc2" width="300"/>
  <img src="https://github.com/user-attachments/assets/82c6ad67-3c3c-4f0d-9efa-4b13967bf456" width="300"/>
</p>

### <p align="center">Disusun Oleh:</p> 

<p align="center">Aliyah Azzah Sekedang</p> 

<p align="center">(2409116021)</p>

---

## 📁 DESKRIPSI APLIKASI

**Beauti-Fy Salon** adalah aplikasi mobile berbasis Flutter untuk mengelola reservasi layanan salon secara digital. Aplikasi ini memungkinkan pengguna untuk melakukan pencatatan dan pengelolaan data booking secara terstruktur melalui sistem CRUD (Create, Read, Update, Delete).

Seluruh data disimpan menggunakan Supabase sehingga tidak lagi menggunakan penyimpanan lokal. Selain itu, proses login dan pendaftaran akun juga menggunakan ***Supabase Authentication*** agar setiap pengguna memiliki akun masing-masing. Struktur aplikasi disusun dengan memisahkan model data, pengelolaan database, dan tampilan halaman agar kode lebih mudah dibaca dan dikembangkan.

---

<details>
<summary><h2>📁 STRUKTUR FOLDER<h2></summary>

Berikut ini adalah struktur utama pada folder `lib`,

```
lib/
│
├── main.dart
├── models/
│   └── reservation.dart
├── services/
│   └── reservation_service.dart
└── pages/
    ├── login_page.dart
    ├── register_page.dart
    ├── home_page.dart
    ├── add_page.dart
    └── edit_page.dart
```

### *1. main.dart*

File `main.dart` berfungsi sebagai titik awal aplikasi dijalankan. File ini memiliki beberapa peran penting, yaitu:
- Mengatur inisialisasi Supabase saat aplikasi pertama kali dibuka
- Mengatur tema aplikasi (light mode dan dark mode)
- Menentukan halaman awal yang ditampilkan
- Menjalankan runApp() sebagai entry point aplikasi

Selain itu, pengaturan perubahan tema juga diletakkan pada bagian ini agar bisa diakses oleh seluruh halaman, yang artinya `main.dart` adalah pusat pengaturan awal aplikasi.

### *2. Folder models/*

Folder ini menyimpan file yang digunakan untuk mendefinisikan struktur data. Folder `models` berisi:

- #### *reservation.dart*

  File ini digunakan untuk mendefinisikan struktur reservasi yang terdiri dari beberapa field seperti id, name, contact, service, date, notes, dan price. Dengan adanya model ini, pengelolaan dan pengiriman data antara form, halaman, dan service yang terhubung dengan Supabase menjadi lebih mudah.

### *3. services/*

Folder ini menyimpan file yang digunakan untuk menangani proses komunikasi antara aplikasi dengan database Supabase. Folder `services` berisi:

- #### *reservation_service.dart*

  File ini digunakan untuk menjalankan seluruh operasi CRUD (Create, Read, Update, Delete) pada tabel `reservations` di Supabase. Beberapa fungsi yang terdapat di dalamnya, yaitu:
  - `getReservations()` : mengambil seluruh data
  - `addReservation()` : menambahkan data baru
  - `updateReservation()` : mengubah data yang sudah ada
  - `deleteReservation()` : menghapus data

Dengan memisahkan bagian ini dari halaman, kode menjadi lebih bersih karena halaman hanya bertugas menampilkan tampilan, sedangkan proses penyimpanan data ditangani oleh service. Dibuat terpisah untuk memudahkan jika suatu saat ingin mengganti sistem database tanpa mengubah banyak kode di bagian tampilan.

### *4. Folder pages/*

Folder ini menyimpan file yang terdapat seluruh halaman untuk berinteraksi langsung dengan pengguna. Folder `pages` berisi:

- #### *login_page.dart*

  Halaman autentikasi pengguna untuk masuk ke dalam aplikasi menggunakan email dan password melalui Supabase Auth. Dilengkapi dengan validasi input, fitur show/hide password, notifikasi login berhasil/gagal, serta navigasi ke halaman register.

- #### *register_page.dart*

  Halaman pendaftaran akun baru menggunakan email dan password melalui Supabase Auth. Terdapat validasi minimal password dan notifikasi jika registrasi berhasil atau gagal. Setelah berhasil, pengguna diarahkan kembali ke halaman login.

- #### *home_page.dart*
  
  Halaman utama yang menampilkan daftar reservasi dan mengelola state data reservasi serta fitur-fitur yaitu Tambah data, Edit data dan Hapus data. Data ditampilkan langsung dari database Supabase.
  
- #### *add_page.dart*
  
  Halaman berisi form untuk menambahkan data reservasi baru menggunakan TextField, DropdownButtonFormField, dan showDatePicker. Data yang disimpan akan dikirim ke Supabase.
  
- #### *edit_page.dart*
  
  Halaman berfungsi untuk mengubah data reservasi yang sudah ada atau sebelumnya telah dibuat di halaman `add_page`. Data lama akan otomatis terisi dan dapat diperbarui.

---
</details>

<details>
<summary><h2>📁 STRUKTUR DATABASE<h2></summary>

Berikut ini adalah struktur database yang digunakan pada aplikasi **Beauti-Fy Salon**. Database disimpan menggunakan Supabase dan memiliki satu tabel utama bernama reservations yang berfungsi untuk menyimpan seluruh data booking pelanggan.

| Kolom | Tipe Data | Keterangan                                                                                 |
| ---------- | --------- | ------------------------------------------------------------------------------------------ |
| id         | bigint    | Primary key. Dibuat otomatis menggunakan sistem identity dari database.                    |
| name       | text      | Menyimpan nama pelanggan. Tidak boleh kosong.                                              |
| contact    | text      | Menyimpan nomor kontak pelanggan. Tidak boleh kosong.                                      |
| service    | text      | Menyimpan jenis layanan yang dipilih. Tidak boleh kosong.                                  |
| date       | text      | Menyimpan tanggal reservasi. Tidak boleh kosong.                                           |
| notes      | text      | Menyimpan catatan tambahan dari pelanggan. Boleh kosong.                                   |
| price      | integer   | Menyimpan harga layanan sesuai pilihan service. Tidak boleh kosong.                        |
| created_at | timestamp | Menyimpan waktu saat data reservasi dibuat. Otomatis terisi dengan waktu saat insert data. |

Penjelasan tambahan:

- Kolom `id` dibuat otomatis oleh database sehingga setiap reservasi memiliki identitas unik.
- Kolom yang memiliki keterangan *not null* berarti wajib diisi sebelum data dapat disimpan.
- Kolom `notes` bersifat opsional sehingga pengguna boleh mengosongkannya.
- Kolom `created_at` terisi otomatis menggunakan `now()` saat data pertama kali dibuat.
- Harga layanan (`price`) disimpan dalam bentuk angka bertipe integer agar lebih mudah digunakan untuk perhitungan jika suatu saat ingin dikembangkan lebih lanjut.

---

</details>

<details>
<summary><h2>📁 FITUR APLIKASI<h2></summary>

**Beauti-Fy Salon** memiliki beberapa fitur utama yang terbagi ke dalam *LoginPage*, *RegisterPage*, *HomePage*, *AddPage*, *EditPage*, serta sistem pendukung seperti *Theme Management*, *Loading State*, dan *Error Handling*. Pada bagian ini akan saya jelaskan fitur-fitur yang tersedia serta bagaimana fitur tersebut diimplementasikan di dalam kode program dan integrasinya dengan Supabase.

### 1. LoginPage

*LoginPage* merupakan halaman awal aplikasi yang berfungsi sebagai sistem autentikasi pengguna sebelum dapat mengakses fitur utama aplikasi. Halaman ini menggunakan `StatefulWidget` karena terdapat perubahan state seperti loading indicator dan toggle visibility password.

**Fitur yang tersedia:**
- Input email dan password
- Validasi form (tidak boleh kosong)
- Show / Hide password
- Login menggunakan Supabase Auth
- Loading indicator saat proses login
- Notifikasi berhasil / gagal
- Navigasi ke RegisterPage

**Controller yang digunakan:**

~~~ Javascript
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
~~~

Controller ini digunakan untuk mengambil nilai input dari pengguna.

**Proses login dilakukan menggunakan Supabase Auth:**

~~~ Javascript
await Supabase.instance.client.auth.signInWithPassword(
  email: emailController.text.trim(),
  password: passwordController.text.trim(),
);
~~~

Sebelum proses login dijalankan, sistem akan melakukan validasi agar email dan password tidak kosong.

**State loading dikontrol menggunakan:**

~~~ Javascript
setState(() {
  isLoading = true;
});
~~~

Loading indicator akan muncul untuk memberi tahu pengguna bahwa proses sedang berjalan.

Jika login berhasil:
- Menampilkan SnackBar: "Login successful"
- Navigasi ke HomePage menggunakan Navigator.pushReplacement

Jika gagal:
- Menampilkan pesan error menggunakan SnackBar

### 2. RegisterPage

RegisterPage digunakan untuk membuat akun baru menggunakan ***Supabase Authentication***. Halaman ini juga menggunakan `StatefulWidget` karena membutuhkan validasi input dan loading state.

**Fitur yang tersedia:**
- Input email dan password
- Validasi form (tidak boleh kosong)
- Password minimal 8 karakter
- Show / Hide password
- Register menggunakan Supabase Auth
- Loading indicator saat proses regist
- Notifikasi berhasil / gagal
- Navigasi ke LoginPage
  
**Proses registrasi dilakukan menggunakan:**

~~~ Javascript
await Supabase.instance.client.auth.signUp(
  email: emailController.text.trim(),
  password: passwordController.text.trim(),
);
~~~

Sebelum proses dijalankan, sistem memastikan:
- Email tidak kosong
- Password tidak kosong
- Password memenuhi minimal karakter

Jika registrasi berhasil:
- Menampilkan SnackBar "Account successfully created"
- Kembali ke *LoginPage*

### 3. HomePage

*HomePage* merupakan halaman utama setelah pengguna berhasil login. Halaman ini menampilkan seluruh data reservasi yang diambil dari database Supabase. Halaman ini menggunakan `StatefulWidget` karena data bersifat dinamis dan berubah setelah operasi CRUD.

**Fitur yang tersedia:**
- Menampilkan seluruh data reservasi dari Supabase
- Loading indicator saat mengambil data
- Error handling jika gagal load data
- Tombol tambah data
- Tombol edit data
- Tombol delete data
- Konfirmasi sebelum delete
- Logout
- Konfirmasi sebelum logout
- Refresh otomatis setelah melakukan CRUD

 #### a. Menampilkan Data (Read)

Data diambil melalui ReservationService:

~~~ Javascript
Future<List> getReservations() async {
  final data = await supabase.from('reservations').select();
  return data;
}
~~~

Selama proses pengambilan data berlangsung, ditampilkan `CircularProgressIndicator`. Data ditampilkan menggunakan `ListView.builder`, dan setiap item reservasi menampilkan atribut:
- name
- contact
- service
- date
- notes
- price

Setelah data berubah (create, update, delete), `setState()` dipanggil agar tampilan otomatis diperbarui.

#### b. Tombol Tambah Data

Pada bagian bawah halaman terdapat tombol  `FloatingActionButton` untuk menambahkan reservasi baru.

~~~ Javascript
FloatingActionButton(
  onPressed: () {
    Navigator.push(...);
  },
)
~~~

Tombol ini mengarahkan pengguna ke *AddPage*.

#### c. Tombol Edit

Setiap item memiliki tombol edit yang akan mengirimkan data lama ke *EditPage* melalui parameter constructor:

~~~ Javascript
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => EditPage(reservation: selectedData),
  ),
);
~~~

Data lama kemudian diisi otomatis ke dalam form.

#### d. Tombol Delete

Delete Reservation digunakan untuk menghapus data reservasi yang sudah ada dari database Supabase. Sebelum data benar-benar dihapus, sistem akan menampilkan dialog konfirmasi untuk memastikan pengguna tidak menghapus data secara tidak sengaja.

**Dialog konfirmasi ditampilkan menggunakan:**

~~~ Javascript
showDialog(
context: context,
builder: (context) => AlertDialog(
title: Text("Delete Confirmation"),
content: Text("Are you sure you want to delete this reservation?"),
actions: [
TextButton(
onPressed: () => Navigator.pop(context),
child: Text("Cancel"),
),
TextButton(
onPressed: () async {
await supabase.from('reservations').delete().eq('id', id);
Navigator.pop(context);
},
child: Text("Delete"),
),
],
),
);
~~~

Jika pengguna memilih Cancel:
- Proses penghapusan dibatalkan
- Dialog ditutup

Jika pengguna memilih Delete:
- Data dihapus menggunakan:
  ~~~ Javascript
  await supabase
  .from('reservations')
  .delete()
  .eq('id', id);
  ~~~

- Jika berhasil:
  - Menampilkan "Data successfully deleted"
  - Dialog tertutup
  - Kembali ke *HomePage*
  - Data otomatis diperbarui

#### e. Logout

Logout dilakukan menggunakan:

~~~ Javascript
await Supabase.instance.client.auth.signOut();
~~~

Setelah logout:
- Kembali ke *LoginPage*

### 4. AddPage (Create Reservation)

*AddPage* digunakan untuk menambahkan data reservasi baru ke database Supabase.

**Komponen form yang digunakan:**
- `TextField` untuk name, contact, notes
- `DropdownButtonFormField` untuk memilih service
- `showDatePicker()` untuk memilih tanggal

**Implementasi DatePicker:**

~~~ Javascript
final pickedDate = await showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2023),
  lastDate: DateTime(2100),
);
~~~

Harga layanan otomatis ditentukan berdasarkan pilihan service.

**Data dikirim ke Supabase melalui:**

~~~ Javascript
await supabase.from('reservations').insert({
  'name': name,
  'contact': contact,
  'service': service,
  'date': date,
  'notes': notes,
  'price': price,
});
~~~

Sebelum data dikirim, sistem melakukan validasi agar field penting tidak kosong.

Jika berhasil:
- Menampilkan "Data successfully created"
- Kembali ke *HomePage*
- Data otomatis diperbarui

### 5. EditPage (Update Reservation)

*EditPage* digunakan untuk memperbarui data reservasi yang sudah ada. 

**Data lama dikirim dari HomePage dan diinisialisasi ke dalam controller:**

~~~ Javascript
nameController.text = widget.reservation['name'];
~~~

**Proses update dilakukan menggunakan:**

~~~ Javascript
await supabase
  .from('reservations')
  .update({
    'name': name,
    'contact': contact,
    'service': service,
    'date': date,
    'notes': notes,
    'price': price,
  })
  .eq('id', id);
~~~

Jika berhasil:
- Menampilkan "Data successfully updated"
- Kembali ke *HomePage*
- Data otomatis diperbarui

### 6. Dark Mode & Light Mode

Aplikasi mendukung perubahan tema tampilan.

**Fitur yang tersedia:**
- Toggle Light Mode
- Toggle Dark Mode
- Tampilan berubah secara real-time

**Implementasi menggunakan ThemeMode pada MaterialApp:**

~~~ Javascript
themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
~~~

State dikontrol menggunakan `setState()` sehingga perubahan langsung terlihat tanpa perlu restart aplikasi.

### 7. Loading State & Error Handling

Aplikasi menangani proses asynchronous dan kesalahan.

**Setiap proses penting dibungkus dalam try-catch:**

~~~ Javascript
try {
  ...
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(e.toString())),
  );
}
~~~

**Loading indicator menggunakan:**

~~~ Javascript
if (isLoading)
  CircularProgressIndicator()
~~~

Hal ini memastikan aplikasi tetap responsif dan informatif saat terjadi proses atau kesalahan.

### 9. Database Supabase

Seluruh data:
- Disimpan di database Supabase
- Tidak menggunakan List lokal
- Menggunakan tabel `reservations`
- Dikelola melalui `ReservationService`

Pemisahan antara tampilan dan pengelolaan database membuat kode lebih rapi dan mudah dikembangkan jika suatu saat ingin menambahkan fitur baru.

---

</details>


<details>
<summary><h2>📁 WIDGET & KOMPONEN YANG DIGUNAKAN<h2></summary>
  
Aplikasi **Beauti-Fy Salon** menggunakan beberapa widget dan komponen utama dalam pengembangannya. Seluruh tampilan dan interaksi pada aplikasi dibangun menggunakan widget bawaan Flutter. Setiap widget memiliki peran masing-masing, mulai dari mengatur struktur halaman, menangani input pengguna, menampilkan data, hingga memberikan notifikasi dan dialog konfirmasi.

Berikut ini adalah daftar widget dan komponen yang digunakan beserta fungsinya di dalam aplikasi:

| WIDGET / KOMPONEN         | KETERANGAN                                                                                                                    |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| MaterialApp               | Widget utama (root) aplikasi yang mengatur tema, navigasi awal, dan konfigurasi global aplikasi.                              |
| ThemeData                 | Digunakan untuk mengatur tampilan visual seperti warna, font, dan brightness pada Light Mode dan Dark Mode.                   |
| ThemeMode                 | Mengontrol perubahan tema secara dinamis berdasarkan kondisi (light atau dark).                                               |
| Scaffold                  | Kerangka dasar setiap halaman yang menyediakan AppBar, body, dan FloatingActionButton.                                        |
| AppBar                    | Menampilkan judul halaman serta tombol aksi seperti logout dan toggle tema.                                                   |
| SafeArea                  | Menjaga agar tampilan tidak tertutup oleh sistem UI perangkat seperti notch atau status bar.                                  |
| Column                    | Menyusun widget secara vertikal, biasanya digunakan pada form input.                                                          |
| Row                       | Menyusun widget secara horizontal, misalnya untuk tombol edit dan delete dalam satu baris.                                    |
| Container                 | Membungkus widget lain dan mengatur properti seperti warna, padding, margin, dan border.                                      |
| Padding                   | Memberikan jarak antar widget agar tampilan lebih rapi dan tidak terlalu rapat.                                               |
| SizedBox                  | Memberikan jarak atau ukuran tetap antar komponen.                                                                            |
| Center                    | Memposisikan widget tepat di tengah layar, misalnya untuk loading indicator.                                                  |
| Expanded                  | Membuat widget menyesuaikan ruang kosong yang tersedia dalam Row atau Column.                                                 |
| Text                      | Menampilkan informasi seperti nama pelanggan, layanan, tanggal, dan harga.                                                    |
| Icon                      | Menampilkan ikon untuk memperjelas fungsi tombol atau field tertentu.                                                         |
| TextField                 | Digunakan untuk input data seperti nama, kontak, email, password, dan catatan.                                                |
| TextEditingController     | Mengontrol serta mengambil nilai dari TextField.                                                                              |
| DropdownButtonFormField   | Digunakan untuk memilih jenis layanan salon melalui dropdown.                                                                 |
| InputDecoration           | Mengatur tampilan TextField seperti label, hint, icon, dan border.                                                            |
| showDatePicker            | Digunakan untuk memilih tanggal reservasi melalui dialog kalender.                                                            |
| Navigator.push            | Digunakan untuk berpindah ke halaman baru seperti AddPage dan EditPage.                                                       |
| Navigator.pushReplacement | Digunakan untuk mengganti halaman, misalnya setelah login berhasil agar tidak bisa kembali ke halaman login.                  |
| Navigator.pop             | Digunakan untuk kembali ke halaman sebelumnya atau menutup dialog.                                                            |
| MaterialPageRoute         | Mengatur perpindahan halaman beserta transisinya.                                                                             |
| ListView.builder          | Menampilkan daftar reservasi secara dinamis berdasarkan data dari Supabase.                                                   |
| Card                      | Menampilkan data reservasi dalam bentuk kartu agar lebih terstruktur dan mudah dibaca.                                        |
| ListTile                  | Digunakan untuk menyusun informasi reservasi dalam satu baris yang rapi (jika digunakan).                                     |
| IconButton                | Tombol aksi seperti edit dan delete pada setiap item reservasi.                                                               |
| FloatingActionButton      | Tombol utama untuk menambahkan reservasi baru.                                                                                |
| SnackBar                  | Menampilkan notifikasi seperti "Data successfully created", "updated", atau "deleted".                                        |
| ScaffoldMessenger         | Mengontrol dan menampilkan SnackBar pada halaman tertentu.                                                                    |
| AlertDialog               | Menampilkan dialog konfirmasi sebelum menghapus data.                                                                         |
| TextButton                | Tombol aksi pada dialog seperti Cancel dan Delete.                                                                            |
| CircularProgressIndicator | Menampilkan loading indicator saat proses asynchronous berjalan (login, register, CRUD, fetch data).                          |
| StatefulWidget            | Digunakan pada halaman yang memiliki perubahan data dinamis seperti HomePage, AddPage, EditPage, LoginPage, dan RegisterPage. |
| StatelessWidget           | Digunakan pada widget atau halaman yang tidak memiliki perubahan state.                                                       |
| setState()                | Digunakan untuk memperbarui tampilan setelah terjadi perubahan data atau state.                                               |

---

</details>



<details>
<summary><h2>📁 TAMPILAN APLIKASI (LIGHT/DARK)<h2></summary>

Berikut ini adalah hasil implementasi antarmuka dari aplikasi Beauti-Fy Salon.
Setiap halaman ditampilkan dalam dua mode, yaitu Light Mode dan Dark Mode, untuk menunjukkan bahwa sistem tema berjalan dengan baik dan konsisten di seluruh aplikasi. Pada mode terang, warna latar lebih cerah dengan teks yang kontras sehingga mudah dibaca, sedangkan pada mode gelap warna latar berubah menjadi lebih gelap dengan teks terang untuk mengurangi ketegangan mata saat digunakan dalam kondisi minim cahaya.

### 1. Halaman LoginPage

#### *Tampilan Light Mode*
  
<img width="1919" height="905" alt="image" src="https://github.com/user-attachments/assets/a95a1a91-4c8f-4c47-b232-5211d9880ee4" />

#### *Tampilan Dark Mode*
  
<img width="1919" height="904" alt="image" src="https://github.com/user-attachments/assets/808be766-461f-4f77-8c72-c9f230f40a68" />

### 2. Halaman RegisterPage

#### *Tampilan Light Mode*

<img width="1919" height="907" alt="Image" src="https://github.com/user-attachments/assets/116edb3f-24af-460b-8b16-7a94118306dd" />

#### *Tampilan Dark Mode*

<img width="1919" height="900" alt="Image" src="https://github.com/user-attachments/assets/63acceae-e680-45a0-a006-3d650bda3b9d" />

### 3. Halaman HomePage

#### *Tampilan Light Mode*

<img width="1919" height="907" alt="Image" src="https://github.com/user-attachments/assets/41aaec33-7a63-43e4-a2df-34bf2d154a8a" />

#### *Tampilan Dark Mode*

<img width="1919" height="908" alt="Image" src="https://github.com/user-attachments/assets/7d16de9a-b5c8-49aa-9a59-c4f4ce9998a7" />

### 4. Add Reservation Page

#### *Tampilan Light Mode*

<img width="1919" height="903" alt="Image" src="https://github.com/user-attachments/assets/82c6ad67-3c3c-4f0d-9efa-4b13967bf456" />

#### *Tampilan Dark Mode*

<img width="1919" height="904" alt="Image" src="https://github.com/user-attachments/assets/0ab2ded1-9531-4255-9c86-57d719b54582" />

### 5. Edit Reservation Page

#### *Tampilan Light Mode*

<img width="1919" height="905" alt="Image" src="https://github.com/user-attachments/assets/d3e0822a-3772-4e66-8717-6116a992b489" />

#### *Tampilan Dark Mode*

<img width="1919" height="905" alt="Image" src="https://github.com/user-attachments/assets/b5b1f910-ae73-4a50-878e-2d2d19d1cd9e" />

### 6. Dialog Konfirmasi Delete

#### *Tampilan Light Mode*

<p align="center">
   <img width="556" height="306" alt="Image" src="https://github.com/user-attachments/assets/3e21a84e-6c03-4afa-8f5f-f78888baf1e1" />
</p>

#### *Tampilan Dark Mode*

<p align="center">
   <img width="522" height="282" alt="Image" src="https://github.com/user-attachments/assets/6b97a849-1b4f-4bd7-a1ea-01e9034fdf06" />
</p>

### 7. Dialog Konfirmasi Logout

#### *Tampilan Light Mode*

<p align="center">
   <img width="433" height="282" alt="Image" src="https://github.com/user-attachments/assets/f1ac1183-91d9-4120-8d40-701afd7de3a1" />
</p>

#### *Tampilan Dark Mode*

<p align="center">
   <img width="442" height="278" alt="Image" src="https://github.com/user-attachments/assets/e1f93cca-93e2-451e-8afa-81168f27a78f" />
</p>

---

</details>

<details>
<summary><h2>📁 ALUR PENGGUNAAN APLIKASI<h2></summary>

Berikut ini adalah alur penggunaan aplikasi **Beauti-Fy Salon** dari pertama kali dibuka hingga pengguna keluar dari sistem:

### 1. Masuk Halaman Login

Pada saat pertama kali membuka aplikasi, pengguna akan langsung diarahkan ke halaman *LoginPage*. 

<p align="center"><img width="1919" height="907" alt="Image" src="https://github.com/user-attachments/assets/19f69132-7938-4824-9595-c12c35543fef" /></p>

Di halaman ini, pengguna diminta untuk:
- Memasukkan email
- Memasukkan password
- Menekan tombol "LOGIN"

<p align="center">
   <img src="https://github.com/user-attachments/assets/f8eca537-dcf5-4850-bee7-e24d34f89731" width="400" style="border:2px solid #ddd; border-radius:10px;">
</p>

Tersedia fitur show/hide password agar pengguna dapat memastikan kata sandi yang diketik sudah benar.

<p align="center">
  <img src="https://github.com/user-attachments/assets/2272c4b3-9022-4033-ae10-b7c60387acd2" width="300"/>
  <img src="https://github.com/user-attachments/assets/934c03e4-99ba-4d31-8a9e-0e29504b1974" width="300"/>
</p>

Jika belum memiliki akun, pengguna dapat menekan tombol Sign Up untuk menuju halaman pendaftaran.

<p align="center">
   <img src="https://github.com/user-attachments/assets/37f08454-b302-465a-93f6-2e28461550c6" width="400" style="border:2px solid #ddd; border-radius:10px;">
</p>

Jika login berhasil:
- Muncul notifikasi “Login successful”
- Pengguna langsung diarahkan ke HomePage

Jika gagal:
- Muncul pesan error
- Pengguna tetap berada di halaman login

### 2. Mendaftar di Halaman Register

Setelah menekan “Sign Up”, pengguna akan masuk ke halaman *RegisterPage*. 

<img width="1919" height="907" alt="Image" src="https://github.com/user-attachments/assets/116edb3f-24af-460b-8b16-7a94118306dd" />

Di halaman ini, pengguna diminta untuk:
- Memasukkan email
- Memasukkan password
- Menekan tombol "REGISTER"

<p align="center">
   <img src="https://github.com/user-attachments/assets/47e79c11-949e-4c6d-8918-3adc269e7357" width="400" style="border:2px solid #ddd; border-radius:10px;">
</p>

Sistem akan melakukan validasi:
- Field tidak boleh kosong
  <img width="1919" height="903" alt="Image" src="https://github.com/user-attachments/assets/10a148df-bd95-4088-969f-d69c2f7e397a" />
- Password minimal 8 karakter
  <img width="1919" height="912" alt="Image" src="https://github.com/user-attachments/assets/bec898ac-864b-4842-ad05-92e43b34a1f3" />

Jika berhasil:
- Muncul pesan “Account successfully created”
- Pengguna otomatis kembali ke halaman login
  <img width="1919" height="903" alt="Image" src="https://github.com/user-attachments/assets/d4930069-4b31-48c9-96eb-31739b00a745" />

### 3. Mengakses HomePage

Setelah berhasil login, pengguna akan tiba di halaman utama atau *HomePage*. Tampilan pertama akan menampilkan teks "No Reservation Yet." jika pengguna belum membuat suatu reservasi.

<img width="1919" height="907" alt="Image" src="https://github.com/user-attachments/assets/41aaec33-7a63-43e4-a2df-34bf2d154a8a" />

Di sini, semua reservasi yang pernah dibuat ditampilkan dalam bentuk daftar. Setiap kartu reservasi menampilkan nama pelanggan, kontak, layanan, tanggal, catatan, dan harga layanan. Pengguna bisa melihat seluruh reservasi dengan mudah dan rapi.

<img width="1919" height="907" alt="Image" src="https://github.com/user-attachments/assets/ae99b0f8-0440-42a5-b84c-982390da0dc2" />

Di *HomePage*, terdapat beberapa tombol aksi:
- Tombol + untuk menambahkan reservasi baru
- Tombol edit (✏️) untuk memperbarui data reservasi
- Tombol delete (🗑️) untuk menghapus reservasi
- Tombol logout untuk keluar dari akun
- Toggle tema

### 4. Menambahkan Reservasi Baru
Untuk menambahkan reservasi, pengguna dapat menekan tombol + Book Now di pojok kanan bawah.

<p align="center">
   <img src="https://github.com/user-attachments/assets/435be1d5-6e7e-42c0-a57a-4c14e3f884f2">
</p>

Pengguna akan diarahkan ke halaman *AddPage*. 

<img width="1919" height="904" alt="Image" src="https://github.com/user-attachments/assets/bc7b3d3a-3e7d-4474-8192-2d7173e1d015" />

Di halaman ini, pengguna mengisi:
- Nama pelanggan
- Kontak
- Pilihan layanan (melalui dropdown)
  
  <img width="1919" height="903" alt="Image" src="https://github.com/user-attachments/assets/b5e4e8d8-a95a-4aef-b9eb-3538f18b625a" />
- Tanggal (melalui DatePicker)
  
  <img width="1919" height="903" alt="Image" src="https://github.com/user-attachments/assets/fc3a3305-7a58-49a5-8d79-0e31d7144ea8" />  
- Catatan tambahan (Notes)

Setelah semua data diisi, pengguna dapat menekan tombol "BOOK APPOINTMENT". 

<p align="center">
   <img src="https://github.com/user-attachments/assets/b04ace18-3eed-4bc9-a14e-76459bdd6cc2" width="400" style="border:2px solid #ddd; border-radius:10px;">
</p>

Selain itu, pada halaman ini juga tersedia tombol "Reset Form". Tombol ini berfungsi untuk mengosongkan seluruh kolom input sehingga pengguna dapat mengulang pengisian data dari awal tanpa perlu menghapus satu per satu.

<p align="center">
   <img src="https://github.com/user-attachments/assets/eae5766d-fcf4-4405-b8a5-1f0e7fb43592" width="400" style="border:2px solid #ddd; border-radius:10px;">
</p>

Jika berhasil:
- Muncul notifikasi “Reservation successfully created”
- Aplikasi kembali ke HomePage
- Data otomatis muncul dalam daftar
  
  <img width="1919" height="909" alt="Image" src="https://github.com/user-attachments/assets/dda202a2-eb45-4024-b018-13f570b6e0ca" />

### 5. Mengubah Reservasi yang Sudah Ada
Jika ada data reservasi yang perlu diperbarui, pengguna cukup menekan tombol edit (✏️) pada kartu reservasi yang ingin diubah. 

<p align="center">
   <img src="https://github.com/user-attachments/assets/9341ef94-e259-4a89-9288-f6d678edc6ac" width="400" style="border:2px solid #ddd; border-radius:10px;">
</p>

Pengguna akan diarahkan ke halaman edit dengan data yang sudah terisi dengan data sebelumnya.

<img width="1919" height="905" alt="Image" src="https://github.com/user-attachments/assets/956afe5a-ee25-48cd-b6b6-6e8b70f7a3a0" />

Pengguna bisa mengubah informasi yang diperlukan. Setelah selesai, pengguna dapat menekan tombol "UPDATE RESERVATION". 

<p align="center">
   <img src="https://github.com/user-attachments/assets/b96be2a1-26da-4295-82f2-4db3c5203b30" width="400" style="border:2px solid #ddd; border-radius:10px;">
</p>

Pada halaman ini juga tersedia tombol "Reset Changes". Tombol tersebut berfungsi untuk mengembalikan isi form ke data awal sebelum diedit, sehingga perubahan yang sudah diketik dapat dibatalkan tanpa harus keluar dari halaman edit.

<p align="center">
   <img src="https://github.com/user-attachments/assets/62904580-755e-4aa6-b5e4-50c674ccdcdf" width="400" style="border:2px solid #ddd; border-radius:10px;">
</p>

Jika berhasil:
- Muncul pesan “Reservation successfully updated”
- Data pada HomePage langsung diperbarui

<img width="1919" height="906" alt="Image" src="https://github.com/user-attachments/assets/adec9577-7d2d-4e8b-a3d0-00f9a9967ac8" />

### 6. Menghapus Reservasi
Untuk menghapus reservasi, pengguna menekan tombol delete (🗑️) pada kartu reservasi.

<p align="center">
   <img src="https://github.com/user-attachments/assets/abc6b6a6-767d-4d0d-9a04-3def44f01bba" width="400" style="border:2px solid #ddd; border-radius:10px;">
</p>

Sistem akan menampilkan dialog konfirmasi.

<img width="1919" height="900" alt="Image" src="https://github.com/user-attachments/assets/a9b2da0b-6e36-4b9a-ae76-47b65cf2ecef" />

Jika memilih Cancel, data tidak dihapus.
Jika memilih Delete, maka:
- Data dihapus dari database
- Muncul notifikasi “Data successfully deleted”
- Daftar otomatis diperbarui

<img width="1918" height="903" alt="Image" src="https://github.com/user-attachments/assets/1e8034db-46ed-4099-add8-72cbf0ed7d89" />

### 7. Mengubah Tema Tampilan
Pengguna dapat mengganti tampilan antara **Light Mode** dan **Dark Mode** melalui tombol toggle di AppBar.

<p align="center">
   <img src="https://github.com/user-attachments/assets/ade775cc-6518-40c6-8a4d-9bb83c72623d" width="400" style="border:2px solid #ddd; border-radius:10px;">
</p>

Saat diganti, tampilan aplikasi akan berubah secara real-time sesuai pilihan pengguna tanpa perlu menutup aplikasi. Contohnya pada *HomePage* ini, 

<img width="1919" height="907" alt="Image" src="https://github.com/user-attachments/assets/41aaec33-7a63-43e4-a2df-34bf2d154a8a" />

<img width="1919" height="908" alt="Image" src="https://github.com/user-attachments/assets/7d16de9a-b5c8-49aa-9a59-c4f4ce9998a7" />

### 8. Logout
Jika pengguna selesai menggunakan aplikasi, mereka dapat menekan tombol Logout di *HomePage*. 

<p align="center">
   <img src="https://github.com/user-attachments/assets/2b275d7e-6df5-4d52-8145-bda3aed5f6a3" width="400" style="border:2px solid #ddd; border-radius:10px;">
</p>

Setelah tombol Logout ditekan, aplikasi tidak langsung keluar dari akun, melainkan akan menampilkan dialog konfirmasi terlebih dahulu. Dialog ini bertujuan untuk memastikan bahwa pengguna benar-benar ingin keluar dari aplikasi dan menghindari logout yang tidak disengaja.

<img width="1919" height="904" alt="Image" src="https://github.com/user-attachments/assets/ffa06b63-4143-4138-adf4-dbbee09a34a4" />

Pada dialog konfirmasi tersebut, terdapat dua pilihan tindakan:
- Cancel : Jika pengguna memilih tombol Cancel, maka proses logout dibatalkan dan pengguna tetap berada di halaman *HomePage*.
- Logout : Jika pengguna memilih tombol Logout, maka sistem akan menghapus sesi autentikasi pengguna dan mengarahkan kembali ke halaman *LoginPage*.
