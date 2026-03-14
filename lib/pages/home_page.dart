import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/reservation.dart';
import '../services/reservation_service.dart';
import 'add_page.dart';
import 'edit_page.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ReservationService service = ReservationService();

  List<Reservation> reservations = [];
  bool isDarkMode = false;

  bool isLoading = false;
  String? errorMessage;

  String formatPrice(int price) {
    final formatter = NumberFormat("#,###", "id_ID");
    return "Rp${formatter.format(price)}";
  }

  /// LOAD DATA
  Future loadReservations() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await service.getReservations();

      setState(() {
        reservations = data.map((e) => Reservation.fromMap(e)).toList();
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load data. Please try again.";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load reservations")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// ADD DATA
  Future addReservation(Reservation r) async {
    try {
      setState(() => isLoading = true);

      await service.addReservation(r);
      await loadReservations();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Reservation successfully created"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to create reservation"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  /// DELETE DATA
  Future deleteReservation(int index) async {
    try {
      setState(() => isLoading = true);

      final id = reservations[index].id;
      await service.deleteReservation(id!);
      await loadReservations();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Reservation successfully deleted"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to delete reservation"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  /// UPDATE DATA
  Future updateReservation(int index, Reservation r) async {
    try {
      setState(() => isLoading = true);

      final id = reservations[index].id;
      await service.updateReservation(id!, r);
      await loadReservations();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Reservation successfully updated"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to update reservation"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    loadReservations();
  }

  /// LOGOUT
  Future logout() async {
    await Supabase.instance.client.auth.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });

    if (themeNotifier.value == ThemeMode.light) {
      themeNotifier.value = ThemeMode.dark;
    } else {
      themeNotifier.value = ThemeMode.light;
    }
  }

  /// CIRCLE BACKGROUND ICON
  Widget circleIcon(IconData icon, {VoidCallback? onTap, Color? iconColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFFFFCCE0) : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 6),
          ],
        ),
        child: Icon(
          icon,
          size: 16,
          color: iconColor ?? (isDarkMode ? Colors.black : Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// BOOK NOW BUTTON
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE91E63),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 10,
          ),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddPage()),
            );

            if (result != null) {
              await addReservation(result);
            }
          },
          child: const Text(
            "+ Book Now",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: Stack(
        children: [
          /// BACKGROUND IMAGE
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    isDarkMode
                        ? "assets/image/homepage_bgdark.png"
                        : "assets/image/homepage_bg.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          /// OVERLAY
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDarkMode
                    ? [
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.1),
                      ]
                    : [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.2),
                      ],
              ),
            ),
          ),

          /// NAVBAR
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: isDarkMode
                    ? const LinearGradient(
                        colors: [
                          Colors.black,
                          Color.fromARGB(255, 54, 52, 52),
                          Colors.black,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 184, 217, 252),
                          Color.fromARGB(255, 204, 230, 255),
                          Color.fromARGB(255, 184, 217, 252),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
              ),
            ),
          ),

          /// NAVBAR BUTTON
          Positioned(
            right: 20,
            top: 15,
            child: Row(
              children: [
                /// DARK MODE
                GestureDetector(
                  onTap: toggleTheme,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(0xFFF48FB1)
                          : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                /// LOGOUT WITH CONFIRMATION
                GestureDetector(
                  onTap: () async {
                    final confirm = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: const Text("Logout"),
                          content: const Text(
                            "Are you sure you want to logout?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE91E63),
                              ),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text(
                                "Logout",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm == true) {
                      await logout();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(0xFFF48FB1)
                          : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.logout,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 70),
              child: Column(
                children: [
                  /// HEADER
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    decoration: BoxDecoration(
                      gradient: isDarkMode
                          ? null
                          : const LinearGradient(
                              colors: [
                                Color(0xFFFFA4CD),
                                Color(0xFFFFCCE0),
                                Color(0xFFFFE3F5),
                                Color(0xFFFFCCE0),
                                Color(0xFFFFA4CD),
                              ],
                            ),
                      color: isDarkMode
                          ? const Color.fromARGB(255, 8, 0, 0).withOpacity(0.65)
                          : Colors.white.withOpacity(0.9),

                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(110),
                        bottomRight: Radius.circular(110),
                      ),

                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.spa,
                          size: 50,
                          color: Color(0xFFE91E63),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Beauti-Fy Salon",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: isDarkMode
                                ? const Color(0xFFFFCCE0)
                                : const Color(0xFFE91E63),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// BANNER
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 0, 0, 0).withOpacity(0.75)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.face_retouching_natural,
                          size: 50,
                          color: Color(0xFFE91E63),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi beauty peeps!",
                                style: GoogleFonts.playfairDisplay(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                  color: isDarkMode
                                      ? const Color(0xFFFFCCE0)
                                      : const Color(0xFFE91E63),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Let's make your appointment today",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// LIST RESERVATION
                  Expanded(
                    child: reservations.isEmpty
                        ? const Center(
                            child: Text(
                              "ⓘ No Reservation Yet.",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: reservations.length,
                            itemBuilder: (context, index) {
                              final data = reservations[index];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 18),
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? const Color.fromARGB(
                                          255,
                                          8,
                                          0,
                                          0,
                                        ).withOpacity(0.7)
                                      : Color(0xFFFFD9E8).withOpacity(0.95),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// NAME + ACTION BUTTON
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                circleIcon(Icons.person),
                                                const SizedBox(width: 8),
                                                Text(
                                                  data.name,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                circleIcon(
                                                  Icons.edit,
                                                  iconColor: Colors.blue,
                                                  onTap: () async {
                                                    final updated =
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (_) =>
                                                                EditPage(
                                                                  reservation:
                                                                      data,
                                                                  index: index,
                                                                ),
                                                          ),
                                                        );

                                                    if (updated != null) {
                                                      await updateReservation(
                                                        index,
                                                        updated,
                                                      );
                                                    }
                                                  },
                                                ),
                                                const SizedBox(width: 8),
                                                circleIcon(
                                                  Icons.delete,
                                                  iconColor: Colors.red,
                                                  onTap: () async {
                                                    final confirm = await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  20,
                                                                ),
                                                          ),
                                                          title: const Text(
                                                            "Delete Reservation",
                                                          ),
                                                          content: const Text(
                                                            "Are you sure you want to delete this reservation?",
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                  false,
                                                                );
                                                              },
                                                              child: const Text(
                                                                "Cancel",
                                                              ),
                                                            ),
                                                            ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    const Color(
                                                                      0xFFE91E63,
                                                                    ),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                  true,
                                                                );
                                                              },
                                                              child: const Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );

                                                    if (confirm == true) {
                                                      deleteReservation(index);
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 10),

                                        /// SERVICE
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE91E63),
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Text(
                                            "${data.service} • ${formatPrice(data.price)}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 12),

                                        /// CONTACT
                                        Row(
                                          children: [
                                            circleIcon(Icons.phone),
                                            const SizedBox(width: 6),
                                            Text(data.contact),
                                          ],
                                        ),

                                        const SizedBox(height: 6),

                                        /// DATE
                                        Row(
                                          children: [
                                            circleIcon(Icons.calendar_today),
                                            const SizedBox(width: 6),
                                            Text(data.date),
                                          ],
                                        ),

                                        if (data.notes.isNotEmpty) ...[
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              circleIcon(
                                                Icons.notes,
                                              ), 
                                              const SizedBox(width: 6),
                                              Expanded(child: Text(data.notes)),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
