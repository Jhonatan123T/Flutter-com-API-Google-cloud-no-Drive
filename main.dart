import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleDriveScreen(),
    );
  }
}

class GoogleDriveScreen extends StatefulWidget {
  const GoogleDriveScreen({super.key});

  @override
  State<GoogleDriveScreen> createState() => _GoogleDriveScreenState();
}

class _GoogleDriveScreenState extends State<GoogleDriveScreen> {
  late drive.DriveApi driveApi;
  late AuthClient client;

  bool authenticated = false;
  bool loading = false;

  List<drive.File> files = [];

  @override
  void initState() {
    super.initState();
    authenticate();
  }

  Future<void> authenticate() async {
    final jsonKey = await rootBundle.loadString(
      'assets/testesemflutter-5e5f7b9c6227.json',
    );

    final credentials = ServiceAccountCredentials.fromJson(jsonKey);

    const scopes = [drive.DriveApi.driveScope];

    client = await clientViaServiceAccount(credentials, scopes);

    driveApi = drive.DriveApi(client);

    setState(() {
      authenticated = true;
    });
  }

  Future<void> listFiles() async {
    setState(() {
      loading = true;
    });

    final response = await driveApi.files.list(
      $fields: "files(id,name,mimeType)",
    );

    setState(() {
      files = response.files ?? [];
      loading = false;
    });
  }

  Future<void> downloadFile(String fileId, String fileName) async {
    final media =
        await driveApi.files.get(
              fileId,
              downloadOptions: drive.DownloadOptions.fullMedia,
            )
            as drive.Media;

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');

    final sink = file.openWrite();
    await media.stream.pipe(sink);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Arquivo baixado em: ${file.path}")));
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Drive Flutter")),
      body: !authenticated
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 18),

                const Text(
                  "Autenticado com sucesso!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: listFiles,
                  child: const Text("Listar arquivos do Drive"),
                ),

                const SizedBox(height: 20),

                if (loading) const CircularProgressIndicator(),

                if (!loading)
                  Expanded(
                    child: ListView.builder(
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];

                        return ListTile(
                          title: Text(file.name ?? "Sem nome"),
                          subtitle: Text(file.id ?? ""),
                          trailing: IconButton(
                            icon: const Icon(Icons.download),
                            onPressed: () {
                              if (file.id != null) {
                                downloadFile(file.id!, file.name ?? "arquivo");
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
    );
  }
}
