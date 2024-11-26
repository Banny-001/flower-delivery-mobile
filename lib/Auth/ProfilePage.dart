import 'dart:convert';
import 'dart:io';
import 'package:bloombox_mobile/ApiCalls.dart';
import 'package:bloombox_mobile/Auth/LoginPage.dart';
import 'package:bloombox_mobile/Auth/Passwordchange.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name;
    String? email;
  String? profileImage;
  // String? phoneNumber;
  File? _imageFile;
  bool isEditingPhone = false;
  TextEditingController phoneController = TextEditingController();
  


  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  // Fetch user profile information from the backend
  Future<void> _fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final url = Uri.parse('http://127.0.0.1:8000/api/profile');
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
         name = data['name'];
          email = data['email'];
          // phoneNumber = data['phone'];
          profileImage = data['profile_image_url'];
          // phoneController.text = phoneNumber ?? '';
        });
      }
    }
  }

  // Function to pick image from gallery or camera
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _uploadProfileImage();
    }
  }

  // Upload profile image to backend
  Future<void> _uploadProfileImage() async {
    if (_imageFile == null) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse('http://127.0.0.1:8000/api/upload-profile-image');

    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('profile_image', _imageFile!.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        profileImage = _imageFile!.path;
      });
    }
  }

  // Update phone number on backend
  // Future<void> _updatePhoneNumber() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');

  //   final url = Uri.parse('https://e236-156-0-233-57.ngrok-free.app/api/update-phone');
  //   final response = await http.put(
  //     url,
  //     headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"},
  //     body: json.encode({"phone": phoneController.text}),
  //   );

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       phoneNumber = phoneController.text;
  //       isEditingPhone = false;
  //     });
  //   } else {
  //     // ignore: use_build_context_synchronously
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Failed to update phone number.')),
  //     );
  //   }
  // }

  // Navigate to change password page
  void _changePassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordPage()),
    );
  }

  // Logout function
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('http://127.0.0.1:8000/api/user-logout');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      await prefs.remove('token');
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile image with option to add or remove
            CircleAvatar(
              radius: 60,
              backgroundImage: profileImage != null
                  ? NetworkImage(profileImage!)
                  : const AssetImage('assets/default_profile.png') as ImageProvider,
                   child: IconButton(
              icon: const Icon(Icons.camera_alt),
              iconSize:30,
              onPressed: _pickImage,
            ),
            ),
            
            const SizedBox(height: 16),

            // Display username with label
            Column(
              children: [
               Text(
                    'Name: ${ name ?? 'Loading...'}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                 const SizedBox(height: 8),
              Text(
                'Email: ${email ?? 'Loading...'}',
                style: const TextStyle(fontSize: 18),
              ),
               
              ],
            ),
            const SizedBox(height: 16),

            // Phone number with label and edit option
            // Column(
            //   children: [
            //     const Text(
            //       'Phone Number:',
            //       style: TextStyle(fontWeight: FontWeight.bold),
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         if (isEditingPhone)
            //           SizedBox(
            //             width: 150,
            //             child: TextField(
            //               controller: phoneController,
            //               keyboardType: TextInputType.phone,
            //               decoration: const InputDecoration(
            //                 hintText: 'Enter phone number',
            //               ),
            //             ),
            //           )
            //         else
            //           Text(
            //             phoneNumber ?? 'Not available',
            //             style: const TextStyle(fontSize: 18),
            //           ),
            //         IconButton(
            //           icon: Icon(isEditingPhone ? Icons.check : Icons.edit),
            //           onPressed: () {
            //             if (isEditingPhone) {
            //               _updatePhoneNumber();
            //             } else {
            //               setState(() {
            //                 isEditingPhone = true;
            //               });
            //             }
            //           },
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            const SizedBox(height: 20),

            // Buttons for Change Password, Settings, Terms and Conditions, Support, and Logout
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.blue),
              title: const Text('Change Password'),
              onTap: _changePassword,
            ),
          ListTile(
              leading: const Icon(Icons.wallet, color: Colors.blue),
              title: const Text('Payment Methods'),
              onTap: () {
                // Navigate to settings page (implement navigation)
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.blue),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings page (implement navigation)
              },
            ),
            ListTile(
              leading: const Icon(Icons.description, color: Colors.blue),
              title: const Text('Terms and Conditions'),
              onTap: () {
                // Navigate to terms and conditions page (implement navigation)
              },
            ),
            ListTile(
              leading: const Icon(Icons.support, color: Colors.blue),
              title: const Text('Support'),
              onTap: () {
                // Navigate to support page (implement navigation)
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }
}
