package networking;

import java.net.*;
import java.util.Scanner;
import java.io.*;


public class UDPClient {
	
	final int buffSize= 32 ;
	DatagramSocket sock;
	String request;
	String response;
	InetAddress servAddr;
	int servPort;
	
	UDPClient (DatagramSocket s, String sName, int sPort) throws UnknownHostException{
		sock =s;
		servAddr = InetAddress.getByName(sName);
		servPort = sPort;
	}
	
	void makeRequest() {
		System.out.print("Enter a string : ");
		Scanner scanner = new Scanner(System.in);
		String inString = scanner.nextLine();
		System.out.println("String read from console is : \n"+inString);
		request = inString;
		scanner.close();
	}
	
	void sendRequest() {
		try {
			byte[] sendBuff = new byte [buffSize];
			sendBuff = request.getBytes();
			DatagramPacket sendPacket = new DatagramPacket(sendBuff, sendBuff.length, servAddr, servPort);
			sock.send(sendPacket);
		}
		catch(SocketException ex) {
			System.err.println("SocketException in sendRequest");
		}
		catch(IOException ex) {
			System.err.println("IOException in sendRequest");
		}
	}
	
	void getResponse() {
		try {
			byte[] recvBuff = new byte [buffSize];
			DatagramPacket recvPacket = new DatagramPacket(recvBuff,buffSize);
			sock.receive(recvPacket);
			recvBuff = recvPacket.getData();
			response = new String(recvBuff, 0,recvBuff.length);
		}
		catch(SocketException ex) {
			System.err.println("SocketException in getResponse");
		}
		catch(IOException ex) {
			System.err.println("IOException in getResponse");
		}
	}
	
	void useResponse() {
		System.out.println("String received from server is: \n"+response);
	}
	
	void close() {
		sock.close();
	}
	public static void main(String[] args) throws IOException, SocketException {
		// TODO Auto-generated method stub
		final int servPort = 7788;
		final String servName = "localhost";
		DatagramSocket sock = new DatagramSocket();
		UDPClient client = new UDPClient(sock, servName, servPort);
		client.makeRequest();
		client.sendRequest();
		client.getResponse();
		client.useResponse();
		client.close();
	}

}
