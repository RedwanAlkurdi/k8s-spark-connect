import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;
import java.io.IOException;

public class SSLSocketCheck {
    public static void main(String[] args) {
        if (args.length != 2) {
            System.err.println("Usage: java SSLSocketCheck <host> <port>");
            return;
        }

        String host = args[0];
        int port = Integer.parseInt(args[1]);

        try {
            SSLSocketFactory factory = (SSLSocketFactory) SSLSocketFactory.getDefault();
            try (SSLSocket socket = (SSLSocket) factory.createSocket(host, port)) {
                socket.startHandshake();
                System.out.println("✅ SSL handshake successful with " + host + ":" + port);
            }
        } catch (IOException e) {
            System.err.println("❌ SSL handshake failed:");
            e.printStackTrace();
        }
    }
}

