import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/reservation.dart';

class EditPage extends StatefulWidget {
  final Reservation reservation;
  final int index;

  const EditPage({super.key, required this.reservation, required this.index});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController contactController;
  late TextEditingController dateController;
  late TextEditingController notesController;

  String? selectedService;
  int selectedPrice = 0;

  final Map<String, int> services = {
    "Hair Cut": 50000,
    "Hair Coloring": 150000,
    "Creambath": 80000,
    "Facial": 120000,
    "Body Spa": 200000,
    "Eyelash Extension": 250000,
  };

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.reservation.name);
    contactController = TextEditingController(text: widget.reservation.contact);
    dateController = TextEditingController(text: widget.reservation.date);
    notesController = TextEditingController(text: widget.reservation.notes);

    selectedService = widget.reservation.service;
    selectedPrice = widget.reservation.price;
  }

  Future pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      dateController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  void updateReservation() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(
      context,
      Reservation(
        id: widget.reservation.id,
        name: nameController.text,
        contact: contactController.text,
        service: selectedService!,
        date: dateController.text,
        notes: notesController.text,
        price: selectedPrice,
      ),
    );
  }

  void resetForm() {
    nameController.text = widget.reservation.name;
    contactController.text = widget.reservation.contact;
    dateController.text = widget.reservation.date;
    notesController.text = widget.reservation.notes;

    setState(() {
      selectedService = widget.reservation.service;
      selectedPrice = widget.reservation.price;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Scaffold(
      body: Column(
        children: [
          /// ================= NAVBAR =================
          Container(
            height: 70,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              gradient: isDark
                  ? const LinearGradient(
                      colors: [Colors.black, Color(0xFF2B2B2B)],
                    )
                  : const LinearGradient(
                      colors: [
                        Color(0xFFFFA4CD),
                        Color(0xFFFFCCE0),
                        Color(0xFFFFE3F5),
                        Color(0xFFFFCCE0),
                        Color(0xFFFFA4CD),
                      ],
                    ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  "Beauti-Fy Salon",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: isDark
                        ? const Color(0xFFFFC1E3)
                        : const Color(0xFFD81B60),
                  ),
                ),
              ],
            ),
          ),

          /// ================= CONTENT =================
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    isDark
                        ? "assets/image/homepage_bgdark.png"
                        : "assets/image/homepage_bg.png",
                    fit: BoxFit.cover,
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 50,
                      horizontal: 40,
                    ),
                    child: Row(
                      children: [
                        /// NOTES IMAGE
                        Expanded(
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                isDark
                                    ? "assets/image/notesdark.png"
                                    : "assets/image/notes.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 30),

                        /// FORM
                        Expanded(
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 35,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF1F1F1F)
                                    : const Color(0xFFFFD6E7),
                                borderRadius: BorderRadius.circular(35),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 35,
                                    offset: const Offset(0, 25),
                                  ),
                                ],
                              ),
                              child: SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "EDIT RESERVATION",
                                        style: GoogleFonts.poppins(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 30),

                                      TextFormField(
                                        controller: nameController,
                                        decoration: const InputDecoration(
                                          labelText: "Customer Name *",
                                          prefixIcon: Icon(Icons.person),
                                        ),
                                        validator: (value) =>
                                            value == null || value.isEmpty
                                            ? "Name is required"
                                            : null,
                                      ),
                                      const SizedBox(height: 18),

                                      TextFormField(
                                        controller: contactController,
                                        decoration: const InputDecoration(
                                          labelText: "Contact Number *",
                                          prefixIcon: Icon(Icons.phone),
                                        ),
                                        validator: (value) =>
                                            value == null || value.isEmpty
                                            ? "Contact number is required"
                                            : null,
                                      ),
                                      const SizedBox(height: 18),

                                      DropdownButtonFormField<String>(
                                        value: selectedService,
                                        decoration: const InputDecoration(
                                          labelText: "Select Service *",
                                          prefixIcon: Icon(Icons.spa),
                                        ),
                                        items: services.entries.map((entry) {
                                          return DropdownMenuItem<String>(
                                            value: entry.key,
                                            child: Text(
                                              "${entry.key} - ${currency.format(entry.value)}",
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            selectedService = val;
                                            selectedPrice = services[val]!;
                                          });
                                        },
                                        validator: (value) => value == null
                                            ? "Please choose a service"
                                            : null,
                                      ),
                                      const SizedBox(height: 18),

                                      TextFormField(
                                        controller: dateController,
                                        readOnly: true,
                                        onTap: pickDate,
                                        decoration: const InputDecoration(
                                          labelText: "Reservation Date *",
                                          prefixIcon: Icon(
                                            Icons.calendar_today,
                                          ),
                                        ),
                                        validator: (value) => value!.isEmpty
                                            ? "Please choose reservation date"
                                            : null,
                                      ),
                                      const SizedBox(height: 18),

                                      TextFormField(
                                        controller: notesController,
                                        maxLines: 2,
                                        decoration: const InputDecoration(
                                          labelText: "Notes",
                                          prefixIcon: Icon(Icons.notes),
                                        ),
                                      ),
                                      const SizedBox(height: 30),

                                      ElevatedButton(
                                        onPressed: updateReservation,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFFE91E63,
                                          ),
                                          minimumSize: const Size(
                                            double.infinity,
                                            55,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "UPDATE RESERVATION",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),

                                      OutlinedButton(
                                        onPressed: resetForm,
                                        style: OutlinedButton.styleFrom(
                                          minimumSize: const Size(
                                            double.infinity,
                                            50,
                                          ),
                                        ),
                                        child: const Text("Reset Changes"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
