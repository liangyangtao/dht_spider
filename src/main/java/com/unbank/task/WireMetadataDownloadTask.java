package com.unbank.task;

import java.net.InetSocketAddress;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.BlockingQueue;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.unbank.db.BaseDao;
import com.unbank.handler.AnnouncePeerInfoHashWireHandler;
import com.unbank.listener.OnMetadataListener;
import com.unbank.structure.DownloadPeer;
import com.unbank.structure.Torrent;
import com.unbank.util.BZipUtil;

public class WireMetadataDownloadTask extends Thread {
	private Logger logger = Logger.getLogger(WireMetadataDownloadTask.class);
	private AnnouncePeerInfoHashWireHandler handler = new AnnouncePeerInfoHashWireHandler();

	private BlockingQueue<DownloadPeer> dps;

	public WireMetadataDownloadTask(BlockingQueue<DownloadPeer> dps) {
		super();
		this.dps = dps;
		initHandler();
	}

	@Override
	public void run() {

		while (true) {
			try {
				if (dps.size() > 0) {
					DownloadPeer peer = dps.take();
					handler.handler(
							new InetSocketAddress(peer.getIp(), peer.getPort()),
							peer.getInfo_hash());
				}
				Thread.sleep(500);
			} catch (InterruptedException e) {
				// ignore
				e.printStackTrace();
			}
		}

	}

	private void initHandler() {
		handler.setOnMetadataListener(new OnMetadataListener() {
			@Override
			public void onMetadata(Torrent torrent) {
				// System.out.println("finished,dps size:" + dps.size());
				if (torrent == null || torrent.getInfo() == null) {
					logger.info(torrent + " 为空");
					return;
				}
				String sql = "insert into tb_file ";
				Map<String, Object> colums = new HashMap<String, Object>();
				colums.put("info_hash", torrent.getInfo_hash());
				colums.put("name", torrent.getInfo().getName());
				colums.put("files", BZipUtil.bZip2(JSON.toJSONBytes(torrent
						.getInfo().getFiles())));
				new BaseDao().executeMapSQL(sql, colums);

			}
		});
	}

}
