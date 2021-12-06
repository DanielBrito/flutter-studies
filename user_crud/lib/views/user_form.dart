import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_crud/models/user.dart';
import 'package:user_crud/provider/users.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData["id"] = user.id;
    _formData["name"] = user.name;
    _formData["email"] = user.email;
    _formData["avatarUrl"] = user.avatarUrl;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = ModalRoute.of(context)?.settings.arguments;

    if (user != null) {
      _loadFormData(user as User);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Form"),
        actions: [
          IconButton(
              onPressed: () {
                final isValid = _form.currentState!.validate();

                if (isValid) {
                  _form.currentState!.save();

                  Provider.of<Users>(context, listen: false).put(User(
                      id: _formData["id"] ?? "",
                      name: _formData["name"] ?? "",
                      email: _formData["email"] ?? "",
                      avatarUrl: _formData["avatarUrl"] ?? ""));

                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                    initialValue: _formData["name"],
                    decoration: const InputDecoration(labelText: "Name"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Invalid name";
                      }

                      if (value.trim().length < 3) {
                        return "Minimum of 3 characters";
                      }

                      return null;
                    },
                    onChanged: (value) => _formData["name"] = value),
                TextFormField(
                    initialValue: _formData["email"],
                    decoration: const InputDecoration(labelText: "E-mail"),
                    onChanged: (value) => _formData["email"] = value),
                TextFormField(
                    initialValue: _formData["avatarUrl"],
                    decoration: const InputDecoration(labelText: "Avatar URL"),
                    onChanged: (value) => _formData["avatarUrl"] = value)
              ],
            )),
      ),
    );
  }
}
