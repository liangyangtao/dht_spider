package net.javaw.test;

import java.io.File;

import net.javaw.torrent.TOTorrent;
import net.javaw.torrent.TOTorrentFactory;

public class TestMain
{

	public static void main(String[] args) throws Exception
	{

		File f = new File("C:/Users/ThinkPad/Desktop/我的BT文件/上传的文件/060514-614.torrent");
		String tarPathString = "种子清洁(Java万维网)";

		TOTorrent torrent = TOTorrentFactory.deserialiseFromBEncodedFile(f, tarPathString);

		torrent.print();

		torrent.serialiseToBEncodedFile(new File("C:/Users/ThinkPad/Desktop/我的BT文件/清洁后的文件/060514-614.torrent"));

	}
}