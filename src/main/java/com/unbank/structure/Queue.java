package com.unbank.structure;

import java.util.LinkedList;

public class Queue<E> extends LinkedList<E>
{

	private static final long serialVersionUID = 1L;
	private int waitingThreads = 0;

	public synchronized void insert(E e)
	{
		addLast(e);
		notify();
	}

	public synchronized E remove()
	{
		if ( isEmpty() ) {
			try	{ 
				waitingThreads++;
				wait();
			} catch (InterruptedException e){
				Thread.interrupted();
			}
			waitingThreads--;
		}
		return removeFirst();
	}

	public boolean isEmpty() {
		return 	(size() - waitingThreads <= 0);
	}
}
