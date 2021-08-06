import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';


final orpc = OdooClient("http://10.0.2.2:8069"+'/xmlrpc/2/object');
void main() async {
  await orpc.authenticate('anirban', 'admin', 'admin');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XmlRpc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Future<dynamic> fetchContacts() {
    return orpc.callKw({
      'model': 'crm.lead',
      'method': 'search_read',
      'args': [],
      'kwargs': {
       
        'domain': [],
        'fields': ['id', 'name', 'expectedrevenue', '__last_update'],
        'limit': 80,
      },
    });
  }

  Widget buildListItem(Map<String, dynamic> record) {
    var unique = record['__last_update'] as String;
    unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
    // final avatarUrl =
    //     '${orpc.baseURL}/web/image?model=res.partner&id=${record["id"]}&unique=$unique';
        
    return ListTile(
      //leading: CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
      title: Text(record['name']),
      subtitle: Text(record['expectedrevenue'] is String ? record['expectedrevenue'] : ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: Center(
        child: FutureBuilder(
            future: fetchContacts(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final record =
                          snapshot.data[index] as Map<String, dynamic>;
                      return buildListItem(record);
                    });
              } else {
                if (snapshot.hasError) return Text('Unable to fetch data');
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}