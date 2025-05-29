import ch.bildspur.artnet.*;


public class ArtnetSenderThread extends Thread {

    private byte[][] data;
    private String remote;
    private ArtNetClient artnet;
    Object lock;
    private int index;

    public ArtnetSenderThread( ArtNetClient artnet, String remote, byte[][] data, Object lock) {
        this.data = data;
        this.remote = remote;
        this.artnet = artnet;
        this.lock = lock;
        this.index = 0;
    }

    public void run() {
        while (true) {
            synchronized(lock) {
                if (index < data.length && data[index].length <= 512) {
                    artnet.unicastDmx(remote, 0, index, data[index]);
                    index = (index + 1) % data.length; // Loop back to the start
                } else {
                    index = 0;
                }
            }
            try {
                Thread.sleep(3); // Sleep for 3 milliseconds
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                break;
            }
        }
    }
}