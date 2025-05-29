# ArtnetSenderExample

This Processing sketch demonstrates how to send Art-Net DMX data from Processing to control lighting fixtures or other Art-Net compatible devices. It uses the [bildspur/ArtNet library](https://github.com/bildspur/artnet) to handle Art-Net communication over UDP.

## Features

- Sends Art-Net packets over UDP to a specified IP address
- Supports multiple universes and up to 512 DMX channels per universe
- Example shows how to generate color patterns and control brightness interactively
- Threaded sending for smooth and reliable DMX output

## Requirements

- [Processing](https://processing.org/) (tested with version 4.x)
- [bildspur/ArtNet library](https://github.com/bildspur/artnet) for Processing
- Network access to your Art-Net device (e.g., LED controller, lighting console)

## Usage

1. Install the bildspur/ArtNet library in Processing.
2. Open `ArtnetSenderExample.pde` in Processing.
3. Adjust the `remote` IP address to match your Art-Net device.
4. Optionally, change the number of universes, LEDs, or colors as needed.
5. Run the sketch. Move your mouse horizontally to change the brightness of the output.

## Example Code

```java
// Example usage in Processing
ArtnetSender artnet = new ArtnetSender("192.168.0.100", 0);
artnet.send(1, 255); // Send value 255 to channel 1
```

The included sketch demonstrates sending color data to 8 universes, each with up to 75 RGB LEDs (225 channels per universe). The color and brightness are controlled interactively.

## Files

- `ArtnetSenderExample.pde` — Main Processing sketch
- `ArtnetSenderThread.java` — Helper thread for continuous Art-Net sending

## License

This example is provided for educational purposes.
