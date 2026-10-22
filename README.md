# SPNXA Race Z

<div align="center">

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Game Engine](https://img.shields.io/badge/Engine-Custom_2D_Canvas-FF6F00?style=for-the-badge)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

</div>

A fast-paced 2D arcade car racing game built with Flutter's CustomPainter canvas engine. Features dynamic track scrolling, lane-changing physics, collision detection, and high-score progression.

---

## Game Architecture & Physics Loop

```mermaid
graph TD
    Ticker[60 FPS Game Loop Ticker] --> Input[Touch / Keyboard Steering Input]
    Input --> Physics[Velocity and Lateral Position Calculator]
    Ticker --> Spawner[Procedural Traffic Vehicle Spawner]
    
    Physics --> Canvas[CustomPainter 2D Canvas Renderer]
    Spawner --> Canvas
    
    Canvas --> Collision{Bounding Box Intersection?}
    Collision -- Yes --> Crash[Trigger Impact Animation and Game Over State]
    Collision -- No --> Score[Increment Distance and Score Multiplier]
    Score --> Ticker
    
    Crash --> Save[Persist Session High Score]
```

---

## Features

- **60 FPS Hardware-Accelerated Canvas**: Real-time 2D drawing pipeline utilizing Flutter's `CustomPainter`.
- **Dynamic Traffic Obstacles**: Randomly generated traffic cars with varying speeds across multiple roadway lanes.
- **Progressive Difficulty**: Speed acceleration scaling as the distance travelled increases.
- **Responsive Controls**: Supports both touch swipe gestures for mobile and keyboard arrow keys for web/desktop.
- **Local High Score Tracking**: Saves personal best records locally across sessions.

---

## Controls

| Platform | Steering Left | Steering Right |
| :--- | :--- | :--- |
| **Mobile / Touch** | Tap / Drag Left Screen Half | Tap / Drag Right Screen Half |
| **Desktop / Web** | Left Arrow Key (`<-`) or `A` | Right Arrow Key (`->`) or `D` |

---

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/Midhun-M-git/spnxa-race-z.git
   cd spnxa-race-z
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Launch the game:
   ```bash
   flutter run
   ```

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
