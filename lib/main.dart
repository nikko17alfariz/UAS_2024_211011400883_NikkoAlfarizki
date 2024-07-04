import 'package:flutter/material.dart';
import 'package:uas_crypto_app/services/crypto_services.dart';
import 'package:uas_crypto_app/models/crypto_model.dart';

void main() => runApp(CryptoApp());

class CryptoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoinAja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CryptoListPage(),
    );
  }
}

class CryptoListPage extends StatefulWidget {
  @override
  _CryptoListPageState createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  late Future<List<Crypto>> futureCryptos;

  @override
  void initState() {
    super.initState();
    futureCryptos = CryptoService.fetchCryptos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptoinAja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Crypto>>(
          future: futureCryptos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available'));
            } else {
              final cryptos = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columnSpacing: 16.0,
                    columns: [
                      DataColumn(label: Text('Crypto')),
                      DataColumn(label: Text('Harga')),
                      DataColumn(label: Text('24 Jam')),
                      DataColumn(label: Text('1 MGG')),
                      DataColumn(label: Text('1 BLN')),
                      DataColumn(label: Text('1 THN')),
                      DataColumn(label: Text('Market Cap')),
                    ],
                    rows: cryptos.map((crypto) {
                      return DataRow(cells: [
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              crypto.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(crypto.symbol),
                          ],
                        )),
                        DataCell(Text('\$${crypto.price.toStringAsFixed(2)}')),
                        DataCell(Text(
                          '${crypto.change24h.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: crypto.change24h < 0
                                ? Colors.red
                                : Colors.green,
                          ),
                        )),
                        DataCell(Text(
                          '${crypto.change7d.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color:
                                crypto.change7d < 0 ? Colors.red : Colors.green,
                          ),
                        )),
                        DataCell(Text(
                          '${crypto.change30d.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: crypto.change30d < 0
                                ? Colors.red
                                : Colors.green,
                          ),
                        )),
                        DataCell(Text(
                          '${crypto.change1y.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color:
                                crypto.change1y < 0 ? Colors.red : Colors.green,
                          ),
                        )),
                        DataCell(
                            Text('\$${crypto.marketCap.toStringAsFixed(2)}')),
                      ]);
                    }).toList(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
