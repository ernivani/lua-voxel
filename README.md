# Lua 3D Project

This project is a simple demonstration of 3D rendering using the Lua programming language and the Love2D framework.

## Project Structure

The project is structured as follows:

- `main.lua`: The entry point of the application. It initializes the rendering engine, loads resources, and handles user input.
- `src/`: This folder contains the source code of the rendering engine and mathematical utilities.
  - `engine.lua`: The 3D rendering engine.
  - `matrix.lua`: Utilities for working with matrices.
  - `vector3.lua`: Utilities for working with 3D vectors.
  - `color.lua`: Utilities for working with colors.
  - `triangle.lua`: Utilities for working with triangles.
  - `cube.lua`: Utilities for working with cubes.
  - `debug.lua`: Utilities for debugging.
- `sounds/`: This folder contains the audio files used by the project.

## How to Run

To run this project, you will need [Love2D](https://love2d.org/). Once you have it installed, you can run the project using the following command in the terminal:

- On Windows:
```bash
start "" "C:\Program Files\LOVE\love.exe" "C:\path\to\the\project"
```

- On Linux:
```bash
love /path/to/the/project
```

- On macOS:
```bash
open -n -a love /path/to/the/project
```

please replace `/path/to/the/project` with the actual path to the project folder.

## Controls

- `W` and `S` keys: Move the camera forward and backward.
- `A` and `D` keys: Move the camera left and right.
- `space` and `left-shift` keys: Move the camera up and down.
- `escape` key: Quit the application.


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
