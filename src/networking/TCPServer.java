package networking;

import java.net.*;
import java.io.*;

public class TCPServer {
	
	Socket sock;
	InputStream recvStream;
	OutputStream sendStream;
	String request;
	String response;
	
	TCPServer(Socket s) throws IOException, UnknownHostException{
		sock = s;
		recvStream = sock.getInputStream();
		sendStream = sock.getOutputStream();
	}
	
	void getRequest() {
		try {
			int dataSize;
			while ((dataSize = recvStream.available()) ==0);
			byte []recvBuff = new byte[dataSize];
			recvStream.read(recvBuff, 0, dataSize);
			String sb = new String(recvBuff,0,dataSize);
			request =(new StringBuffer(sb.trim())).reverse().toString();
		}
		catch(IOException ex) {
			System.err.println("IOException in getRequest");
		}
	}
	
	void process() {
		response = "TCP ServerL Hi. You sain, "+request;
	}
	
	void sendResponse() {
		try {
			byte[] sendBuff = new byte [response.length()];
			sendBuff = response.getBytes();
			sendStream.write(sendBuff,0,sendBuff.length);
		} catch(IOException ex) {
			System.err.println("IOException in sendResponse");
		}
	}
	
	void close() {
		try {
			recvStream.close();
			sendStream.close();
			sock.close();
		}catch(IOException ex) {
			System.err.println("IOException in close");
		}
	}

	public static void main(String[] args) throws IOException{
		// TODO Auto-generated method stub
		final int port = 7777;
		ServerSocket listenSock = new ServerSocket(port);
		while(true) {
			TCPServer server = new TCPServer(listenSock.accept());
			server.getRequest();
			server.process();
			server.sendResponse();
			server.close();
		}
	}

}
