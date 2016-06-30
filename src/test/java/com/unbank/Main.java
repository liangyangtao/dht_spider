package com.unbank;

import java.net.InetSocketAddress;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

import com.unbank.listener.OnAnnouncePeerListener;
import com.unbank.listener.OnGetPeersListener;
import com.unbank.server.DHTServer;
import com.unbank.structure.DownloadPeer;
import com.unbank.task.WireMetadataDownloadTask;
import com.unbank.util.ByteUtil;

public class Main {

	public static long count = 0;
	public static BlockingQueue<DownloadPeer> dps = new LinkedBlockingQueue<>();

	public static void main(String[] args) throws Exception {

		Thread t = new WireMetadataDownloadTask(dps);
		t.start();

		DHTServer server = new DHTServer("0.0.0.0", 6882, 88800);
		server.setOnGetPeersListener(new OnGetPeersListener() {

			@Override
			public void onGetPeers(InetSocketAddress address, byte[] info_hash) {
				System.out.println("get_peers request, address:"
						+ address.getHostString() + ", info_hash:"
						+ ByteUtil.byteArrayToHex(info_hash));
			}
		});
		server.setOnAnnouncePeerListener(new OnAnnouncePeerListener() {

			@Override
			public void onAnnouncePeer(InetSocketAddress address,
					byte[] info_hash, int port) {
				System.out.println("announce_peer request, address:"
						+ address.getHostString() + ":" + port + ", info_hash:"
						+ ByteUtil.byteArrayToHex(info_hash));

				if (dps.size() > 10000) {
					return;
				}
				try {
					dps.put(new DownloadPeer(address.getHostString(), port,
							info_hash));
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		});
		server.start();
	}

}
