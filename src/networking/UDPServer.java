package networking;

import java.net.*;
import java.io.*;

public class UDPServer {
	
	final int buffSize = 32;
	DatagramSocket sock;
	String request;
	String response;
	InetAddress clientAddr;
	int clientPort;

	
	UDPServer(DatagramSocket s)
	{
		sock =s;
	}
	
	void getRequest() {
		try {
			byte[] recvBuff = new byte[buffSize];
			DatagramPacket recvPacket = new DatagramPacket(recvBuff, buffSize);
			sock.receive(recvPacket);
			recvBuff = recvPacket.getData();
			String sb = new String(recvBuff,0,recvBuff.length);
			request =(new StringBuffer(sb.trim())).reverse().toString();
			clientAddr = recvPacket.getAddress();
			clientPort = recvPacket.getPort();
		}
		catch(SocketException ex) {
			System.err.println("SocketException in getRequest");
		}
		catch(IOException ex) {
			System.err.println("IOException in getRequest");
		}
	}
	
	void process() {
		response = "UDP ServerL Hi. You sain, "+ request ;
	}
	
	void sendResponse()
	{
		try
		{
			byte[] sendBuff = new byte[buffSize];
			sendBuff = response.getBytes();
			DatagramPacket sendPacket = new DatagramPacket(sendBuff, sendBuff.length, clientAddr, clientPort);
			sock.send(sendPacket);
		}
		catch(SocketException ex) {
			System.err.println("SocketException in sendResponse");
		}
		catch(IOException ex) {
			System.err.println("IOException in sendResponse");
		}
	}

	public static void main(String[] args) throws IOException,SocketException{
		// TODO Auto-generated method stub
		final int port = 7788;
		DatagramSocket sock = new DatagramSocket(port);
		while(true) {
			UDPServer server = new UDPServer(sock);
			server.getRequest();
			server.process();
			server.sendResponse();
		}

	}

}
