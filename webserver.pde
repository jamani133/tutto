


void setupServer() {
  server = new Server(this, 8080);
  println("Server running at http://localhost:8080");
}


// 🔁 Loop function
void runServer() {
  Client client = server.available();
  
  if (client != null) {
    String request = client.readString();
    
    if (request != null) {
      println(request);

      // Serve HTML
      if (request.startsWith("GET / ")) {
        sendHTML(client);
      }

      // Handle button input
      else if (request.contains("/input?key=")) {
        char key = extractKey(request);
        handleInput(key);

        sendOK(client);
      }

      client.stop();
    }
  }
}


// 📄 Send HTML page
void sendHTML(Client client) {
  client.write("HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n");
  
  String[] html = loadStrings("index.html");
  for (String line : html) {
    client.write(line + "\n");
  }
}


// 🔍 Extract character safely
char extractKey(String request) {
  int index = request.indexOf("key=") + 4;
  return request.charAt(index);
}


// ✅ Send response
void sendOK(Client client) {
  client.write("HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nOK");
}
