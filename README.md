# 📂 Flutter com API do Google Cloud no Drive

## 📱 Sobre o projeto

Olá, tudo bem? 👋

Ao criar o projeto em **Flutter**, o framework gera automaticamente toda a estrutura inicial do aplicativo.
Foram necessárias apenas pequenas modificações, como a criação de um arquivo **JSON** dentro da pasta `app`, utilizado para armazenar as **credenciais de acesso**.

Com essa configuração, temos um **exemplo funcional** de como utilizar o **Google Cloud integrado ao Google Drive** para acessar e abrir arquivos armazenados no Drive.

---

## 🚀 Tecnologias utilizadas

* Flutter
* Dart
* Google Cloud API
* Google Drive API

---

## ⚙️ Como funciona

O aplicativo realiza a autenticação utilizando as **credenciais configuradas no Google Cloud** e permite:

* Conectar ao Google Drive
* Localizar arquivos dentro de uma pasta específica
* Abrir ou acessar documentos armazenados no Drive

---

## 📁 Estrutura do projeto

```text
Flutter-com-API-Google-cloud-no-Drive
│
├── lib/
│   └── main.dart
│
├── android/
│
├── ios/
│
├── app/
│   └── credentials.json
│
└── pubspec.yaml
```

---

## 🔑 Configuração necessária

1. Criar um projeto no **Google Cloud Console**
2. Ativar a **Google Drive API**
3. Gerar um arquivo de **credenciais JSON**
4. Colocar o arquivo dentro da pasta:

```text
app/credentials.json
```

---

## ▶️ Executando o projeto

```bash
flutter pub get
flutter run
```

---

## 📚 Objetivo do projeto

Este projeto foi desenvolvido como **exemplo prático de integração entre Flutter e serviços do Google Cloud**, demonstrando como acessar arquivos diretamente do **Google Drive através de uma aplicação mobile**.

---

## 👨‍💻 Autor

Desenvolvido por **Jhonatan**
