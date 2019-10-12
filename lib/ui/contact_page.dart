import 'dart:io';

import 'package:agenda/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;
  ContactPage({this.contact});

  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;
  Contact _editContact;

  @override
  void initState() {
    super.initState();

    if(widget.contact == null) {
      _editContact = Contact();
    } else {
      _editContact = Contact.fromMap(widget.contact.toMap());
    }

    _nameController.text = _editContact.name;
    _phoneController.text = _editContact.phone;
    _emailController.text = _editContact.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editContact.name ?? "Novo Contato"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
        onPressed: () {
          if(_editContact.name != null && _editContact.name.isNotEmpty) {
            Navigator.pop(context, _editContact);
          } else {
            FocusScope.of(context).requestFocus(_nameFocus);
          }
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _editContact.img != null ? FileImage(File(_editContact.img)) : AssetImage("images/man.png")
                  )
                ),
              ),
            ),
            TextField(
              controller: _nameController,
              focusNode: _nameFocus,
              decoration: InputDecoration(labelText: "Nome"),
              onChanged: (text) {
                _userEdited = true;
                setState(() {
                  if(text != ""){
                    _editContact.name = text; 
                  }else {
                    _editContact.name = "Novo Contato";
                  }
                });
              },
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Telefone"),
              onChanged: (text) {
                _userEdited = true;
                _editContact.phone = text;
              },
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              onChanged: (text) {
                _userEdited = true;
                _editContact.email = text;
              },
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }
}