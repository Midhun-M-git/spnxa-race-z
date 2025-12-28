import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math' show Random, min, max, sin;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Set preferred orientations and full screen mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    runApp(const CarRacingGame());
  });
}

class CarRacingGame extends StatelessWidget {
  const CarRacingGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speed Racer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1a237e),
              Color(0xFF000051),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'SP.NXA RACE Z',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.blue,
                            offset: Offset(0, 2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    _buildMenuButton(
                      context,
                      'Start Game',
                          () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const GameScreen()),
                      ),
                    ),
                    _buildMenuButton(
                      context,
                      'Continue',
                          () {
                        // Implement continue functionality
                      },
                    ),
                    _buildMenuButton(
                      context,
                      'Select Level',
                          () => _showLevelSelector(context),
                    ),
                    _buildMenuButton(
                      context,
                      'Select Car',
                          () => _showCarSelector(context),
                    ),
                    _buildMenuButton(
                      context,
                      'About',
                          () => _showAboutDialog(context),
                    ),
                  ],
                ),
              ),
              // Instagram handle at bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Instagram: @sp.nxa',
                  style: TextStyle(
                    color: Colors.white.withAlpha(180),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    shadows: const [
                      Shadow(
                        color: Colors.blue,
                        offset: Offset(0, 1),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context,
      String text,
      VoidCallback onPressed,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.blue[700]!, Colors.blue[900]!],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withAlpha(100),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showLevelSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[850],
        title: const Text(
          'Select Level',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 1; i <= 5; i++)
              ListTile(
                title: Text(
                  'Level $i',
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(level: i),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showCarSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[850],
        title: const Text(
          'Select Car',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var color in [Colors.red, Colors.blue, Colors.green, Colors.yellow])
              ListTile(
                leading: Icon(Icons.directions_car, color: color),
                title: Text(
                  '${color.toString().split('(')[1].split(')')[0]} Car',
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Implement car selection
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[850],
        title: const Text(
          'About',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Created by:',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Midhun',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'ATP23CS047',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'AHALIA SCHOOL OF ENGINEERING AND TECHNOLOGY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final int level;

  const GameScreen({super.key, this.level = 1});

  @override
  GameScreenState createState() => GameScreenState();
}

// Add these classes at the top level, after imports
class Particle {
  double x, y;
  double speed;
  double size;
  Color color;

  Particle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.color,
  });
}

enum ObstacleType { car, truck, barrier, powerup, coin }

class Obstacle {
  double x, y;
  ObstacleType type;
  Color color;
  bool collected;

  Obstacle({
    required this.x,
    required this.y,
    required this.type,
    required this.color,
    this.collected = false,
  });

  double get width => type == ObstacleType.truck ? 80.0 : 60.0;
  double get height => type == ObstacleType.truck ? 160.0 : 120.0;
}

class GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ValueNotifier<double> playerCarX = ValueNotifier<double>(0);
  final ValueNotifier<List<double>> obstacleY = ValueNotifier<List<double>>([]);
  final ValueNotifier<List<double>> obstacleX = ValueNotifier<List<double>>([]);
  final ValueNotifier<List<Color>> carColors = ValueNotifier<List<Color>>([]);
  final ValueNotifier<int> score = ValueNotifier<int>(0);
  final ValueNotifier<double> nitroFuel = ValueNotifier<double>(100);
  final ValueNotifier<bool> isNitroActive = ValueNotifier<bool>(false);

  bool isGameOver = false;
  double gameSpeed = 5;
  final double laneWidth = 80.0;
  final int numberOfLanes = 3;
  List<double> lanePositions = [];
  final Random random = Random();

  // Add timing variable
  late int _lastUpdateTime;

  // Initialize screen dimensions with default values
  double screenWidth = 0;
  double screenHeight = 0;
  double carWidth = 60;  // Default value
  double carHeight = 120; // Default value

  final List<Particle> particles = [];
  double roadScrollOffset = 0.0;

  late final int gameLevel;

  // Fix naming convention for constants
  static const double baseSpeed = 5.0;
  static const double maxSpeed = 20.0;
  static const int particleLimit = 15;
  static const double nitroBoost = 1.5;

  // Add new properties
  List<Obstacle> obstacles = [];
  int coins = 0;
  bool hasShield = false;
  int combo = 0;

  @override
  void initState() {
    super.initState();
    gameLevel = widget.level;
    gameSpeed = 5.0 + (gameLevel - 1) * 2.0;
    _lastUpdateTime = DateTime.now().millisecondsSinceEpoch;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(_updateGame);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScreenDimensions();
      _startGame();
    });
  }

  void _updateScreenDimensions() {
    final size = MediaQuery.of(context).size;
    setState(() {
      screenWidth = size.width;
      screenHeight = size.height;
      carWidth = screenWidth * 0.15;
      carHeight = carWidth * 2;

      // Calculate lane positions
      double laneSpacing = screenWidth / numberOfLanes;
      lanePositions = List.generate(
        numberOfLanes,
            (i) => (laneSpacing * i) + (laneSpacing - carWidth) / 2,
      );
    });
  }

  // Add screen size listener
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateScreenDimensions();
  }

  void _startGame() {
    // Reset game state
    score.value = 0;
    nitroFuel.value = 100;
    gameSpeed = 5.0 + (gameLevel - 1) * 2.0;
    isGameOver = false;
    roadScrollOffset = 0;
    particles.clear();
    obstacles.clear();
    playerCarX.value = screenWidth / 2 - carWidth / 2;

    // Initialize lanes
    double laneSpacing = screenWidth / numberOfLanes;
    lanePositions = List.generate(
      numberOfLanes,
          (i) => (laneSpacing * i) + (laneSpacing - carWidth) / 2,
    );

    // Create initial obstacles with proper spacing
    double spacing = screenHeight / 3;
    for (int i = 0; i < 6; i++) {
      _addNewObstacle(-i * spacing - 100);
    }

    _animationController.repeat();
  }

  void _addNewObstacle(double startY) {
    int lane = random.nextInt(numberOfLanes);
    double x = lanePositions[lane];

    // Ensure no obstacles are too close together
    while (_isLaneOccupied(lane, startY)) {
      lane = (lane + 1) % numberOfLanes;
      x = lanePositions[lane];
    }

    // Create new obstacle with weighted random type
    final rand = random.nextDouble();
    final type = rand < 0.4 ? ObstacleType.car :
    rand < 0.6 ? ObstacleType.truck :
    rand < 0.8 ? ObstacleType.coin :
    rand < 0.9 ? ObstacleType.powerup :
    ObstacleType.barrier;

    obstacles.add(Obstacle(
      x: x,
      y: startY,
      type: type,
      color: _getObstacleColor(type),
    ));
  }

  bool _isLaneOccupied(int lane, double y) {
    final laneX = lanePositions[lane];
    return obstacles.any((obstacle) =>
    (obstacle.y - y).abs() < 200 && // Vertical spacing check
        (obstacle.x - laneX).abs() < 20  // Lane position check
    );
  }

  void _updateGame() {
    if (isGameOver) return;

    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final deltaTime = (currentTime - _lastUpdateTime) / 1000.0;
    _lastUpdateTime = currentTime;

    setState(() {
      // Update road scroll
      roadScrollOffset += gameSpeed * deltaTime;

      // Update obstacles
      for (var obstacle in obstacles) {
        // Move obstacle
        final speed = gameSpeed * (isNitroActive.value ? nitroBoost : 1.0);
        obstacle.y += speed * deltaTime * 100; // Multiply by 100 for better visibility

        // Reset obstacles that move off screen
        if (obstacle.y > screenHeight + 100) {
          double newY = -100;
          // Find the highest obstacle
          for (var other in obstacles) {
            if (other != obstacle) {
              newY = min(newY, other.y - screenHeight / 3);
            }
          }
          obstacle.y = newY;
          _resetObstacle(obstacle);
        }
      }

      // Update score and speed
      score.value++;
      if (score.value % 500 == 0) {
        gameSpeed = min(gameSpeed + 0.5, maxSpeed);
      }

      // Update nitro
      if (isNitroActive.value) {
        nitroFuel.value = max(0, nitroFuel.value - 2 * deltaTime);
        if (nitroFuel.value <= 0) {
          isNitroActive.value = false;
        }
      } else if (nitroFuel.value < 100) {
        nitroFuel.value = min(100, nitroFuel.value + 10 * deltaTime);
      }

      // Update particles
      _updateParticles(deltaTime);

      // Check collisions
      _checkCollision();
    });
  }

  void _resetObstacle(Obstacle obstacle) {
    int lane = random.nextInt(numberOfLanes);
    while (_isLaneOccupied(lane, obstacle.y)) {
      lane = (lane + 1) % numberOfLanes;
    }

    obstacle.x = lanePositions[lane];
    obstacle.collected = false;

    final rand = random.nextDouble();
    obstacle.type = rand < 0.4 ? ObstacleType.car :
    rand < 0.6 ? ObstacleType.truck :
    rand < 0.8 ? ObstacleType.coin :
    rand < 0.9 ? ObstacleType.powerup :
    ObstacleType.barrier;

    obstacle.color = _getObstacleColor(obstacle.type);
  }

  void _updateParticles(double deltaTime) {
    particles.removeWhere((particle) => particle.y > screenHeight);

    for (var particle in particles) {
      particle.y += particle.speed * deltaTime;
    }

    // Update reference to particleLimit
    if (isNitroActive.value && particles.length < particleLimit) {
      _addParticle();
    }
  }

  void _addParticle() {
    particles.add(
      Particle(
        x: playerCarX.value + random.nextDouble() * carWidth,
        y: screenHeight - carHeight,
        speed: random.nextDouble() * 200 + 300, // Faster particles
        size: random.nextDouble() * 3 + 1,
        color: Colors.orange.withAlpha(150),
      ),
    );
  }

  Color _getObstacleColor(ObstacleType type) {
    switch (type) {
      case ObstacleType.car:
        return [Colors.red, Colors.blue, Colors.green, Colors.yellow][random.nextInt(4)];
      case ObstacleType.truck:
        return Colors.purple;
      case ObstacleType.barrier:
        return Colors.grey[800]!;
      case ObstacleType.powerup:
        return Colors.cyan;
      case ObstacleType.coin:
        return Colors.amber;
    }
  }

  void _checkCollision() {
    if (isGameOver) return;

    final playerBounds = Rect.fromLTWH(
      playerCarX.value + carWidth * 0.2, // Smaller collision box
      screenHeight - carHeight,
      carWidth * 0.6, // Reduced width for more forgiving collisions
      carHeight * 0.8, // Reduced height
    );

    for (var obstacle in obstacles) {
      if (obstacle.collected) continue;

      final obstacleBounds = Rect.fromLTWH(
        obstacle.x,
        obstacle.y,
        obstacle.width,
        obstacle.height,
      );

      if (playerBounds.overlaps(obstacleBounds)) {
        _handleCollision(obstacle);
      }
    }
  }

  void _handleCollision(Obstacle obstacle) {
    if (obstacle.collected) return;

    switch (obstacle.type) {
      case ObstacleType.coin:
        coins++;
        combo++;
        score.value += 10 * combo;
        obstacle.collected = true;
        break;
      case ObstacleType.powerup:
        hasShield = true;
        obstacle.collected = true;
        Future.delayed(const Duration(seconds: 5), () {
          setState(() => hasShield = false);
        });
        break;
      case ObstacleType.car:
      case ObstacleType.truck:
      case ObstacleType.barrier:
        if (!hasShield) {
          _gameOver();
        } else {
          hasShield = false;
          obstacle.collected = true;
        }
        combo = 0;
        break;
    }
  }

  void _gameOver() {
    isGameOver = true;
    _animationController.stop();
    _showGameOverDialog();
  }

  void _moveLeft() {
    if (isGameOver) return;
    setState(() {
      playerCarX.value = max(0, playerCarX.value - 20);
    });
  }

  void _moveRight() {
    if (isGameOver) return;
    setState(() {
      playerCarX.value = min(screenWidth - carWidth, playerCarX.value + 20);
    });
  }

  void _activateNitro() {
    if (nitroFuel.value > 0 && !isGameOver) {
      setState(() {
        isNitroActive.value = true;
        // Reduce nitro fuel while active
        nitroFuel.value = max(0, nitroFuel.value - 2);
        if (nitroFuel.value <= 0) {
          isNitroActive.value = false;
        }
      });
    }
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: const Text(
            'Game Over',
            style: TextStyle(
              color: Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Final Score: ${score.value}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'You crashed!',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainMenu()),
                );
              },
              child: const Text(
                'Main Menu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _startGame();
                });
              },
              child: const Text(
                'Play Again',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1a237e),
              Color(0xFF000051),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              _buildGameArea(),

              // Nitro button
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: _buildEnhancedNitroButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameArea() {
    return Stack(
      children: [
        // Background and road
        CustomPaint(
          size: Size.infinite,
          painter: EnvironmentPainter(
            roadScrollOffset,
            lanePositions,
            particles,
          ),
        ),

        // Score display
        Positioned(
          top: 20,
          left: 20,
          child: ValueListenableBuilder<int>(
            valueListenable: score,
            builder: (context, value, child) {
              return Text(
                'Score: $value',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),

        // Game elements
        Stack(
          children: [
            // Obstacles
            for (var obstacle in obstacles)
              if (!obstacle.collected)
                Positioned(
                  left: obstacle.x,
                  top: obstacle.y,
                  child: _buildObstacle(obstacle),
                ),

            // Player car
            ValueListenableBuilder<double>(
              valueListenable: playerCarX,
              builder: (context, value, child) {
                return Positioned(
                  left: value,
                  bottom: 20,
                  child: _buildPlayerCar(),
                );
              },
            ),
          ],
        ),

        // Controls
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTapDown: (_) => _moveLeft(),
                  child: Container(
                    height: 200,
                    color: Colors.transparent,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTapDown: (_) => _moveRight(),
                  child: Container(
                    height: 200,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerCar() {
    return ValueListenableBuilder<bool>(
      valueListenable: isNitroActive,
      builder: (context, isNitro, child) {
        return Transform.scale(
          scale: isNitro ? 1.2 : 1.0,
          child: Stack(
            children: [
              // Main car body
              Container(
                width: carWidth,
                height: carHeight,
                decoration: BoxDecoration(
                  color: Colors.red[700],
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.red[700]!,
                      Colors.red[900]!,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(100),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Windshield
                    Positioned(
                      top: 20,
                      left: 5,
                      right: 5,
                      height: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent.withAlpha(150),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    // Headlights
                    ...List.generate(2, (i) => Positioned(
                      bottom: 10,
                      left: i == 0 ? 5 : null,
                      right: i == 1 ? 5 : null,
                      child: Container(
                        width: 10,
                        height: 5,
                        color: Colors.yellow[600],
                      ),
                    )),
                  ],
                ),
              ),
              // Nitro effect
              if (isNitro)
                Positioned(
                  bottom: -20,
                  left: 10,
                  right: 10,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.orange,
                          Colors.orange.withAlpha(200),
                          Colors.orange.withAlpha(0),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildObstacle(Obstacle obstacle) {
    switch (obstacle.type) {
      case ObstacleType.car:
        return Container(
          width: obstacle.width,
          height: obstacle.height,
          decoration: BoxDecoration(
            color: obstacle.color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: obstacle.color.withAlpha(76),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: _buildVehicleDetails(),
        );

      case ObstacleType.truck:
        return Container(
          width: obstacle.width,
          height: obstacle.height,
          decoration: BoxDecoration(
            color: obstacle.color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: obstacle.color.withAlpha(76),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: _buildVehicleDetails(isTruck: true),
        );

      case ObstacleType.barrier:
        return Container(
          width: obstacle.width,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
            gradient: const LinearGradient(
              colors: [Colors.red, Colors.orange],
            ),
          ),
          child: const Center(
            child: Icon(Icons.warning, color: Colors.yellow),
          ),
        );

      case ObstacleType.powerup:
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.cyan,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.cyan.withAlpha(100),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Icon(Icons.shield, color: Colors.white),
        );

      case ObstacleType.coin:
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 2 * 3.14),
          duration: const Duration(seconds: 1),
          builder: (context, value, child) {
            return Transform.scale(
              scale: 0.8 + 0.2 * sin(value),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withAlpha(128),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.monetization_on, color: Colors.white),
              ),
            );
          },
        );
    }
  }

  Widget _buildVehicleDetails({bool isTruck = false}) {
    return Stack(
      children: [
        // Windshield
        Positioned(
          top: isTruck ? 40 : 20,
          left: 5,
          right: 5,
          height: isTruck ? 40 : 30,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent.withAlpha(150),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        // Headlights
        ...List.generate(2, (i) => Positioned(
          bottom: 10,
          left: i == 0 ? 5 : null,
          right: i == 1 ? 5 : null,
          child: Container(
            width: 10,
            height: 5,
            color: Colors.yellow[600],
          ),
        )),
      ],
    );
  }

  Widget _buildEnhancedNitroButton() {
    return ValueListenableBuilder<double>(
      valueListenable: nitroFuel,
      builder: (context, value, child) {
        final isActive = value > 0;
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: (isActive ? Colors.orange : Colors.grey).withAlpha(50),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: isActive ? _activateNitro : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              backgroundColor: isActive ? Colors.orange : Colors.grey,
              elevation: 10,
            ),
            child: const Text(
              'NITRO',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    playerCarX.dispose();
    obstacleY.dispose();
    obstacleX.dispose();
    carColors.dispose();
    score.dispose();
    nitroFuel.dispose();
    isNitroActive.dispose();
    super.dispose();
  }
}

class RoadPainter extends CustomPainter {
  final double offset;
  final List<double> lanePositions;
  final Paint _paint;

  RoadPainter(this.offset, this.lanePositions) : _paint = Paint()
    ..color = Colors.white
    ..strokeWidth = 5
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    const dashHeight = 40.0;
    const dashSpace = 20.0;
    final startY = -(offset % (dashHeight + dashSpace));

    for (double x in lanePositions.sublist(1)) {
      for (double y = startY; y < size.height; y += dashHeight + dashSpace) {
        canvas.drawLine(
          Offset(x - 20, y),
          Offset(x - 20, y + dashHeight),
          _paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(RoadPainter oldDelegate) =>
      oldDelegate.offset != offset;
}

// New EnvironmentPainter class for enhanced graphics
class EnvironmentPainter extends CustomPainter {
  final double offset;
  final List<double> lanePositions;
  final List<Particle> particles;
  final Paint _roadPaint;
  final Paint _linePaint;
  final Paint _glowPaint;

  EnvironmentPainter(this.offset, this.lanePositions, this.particles)
      : _roadPaint = Paint()
    ..color = Colors.grey[850]!
    ..style = PaintingStyle.fill,
        _linePaint = Paint()
          ..color = Colors.white
          ..strokeWidth = 5
          ..style = PaintingStyle.stroke,
        _glowPaint = Paint()
          ..color = Colors.blue.withAlpha(30)
          ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);

  @override
  void paint(Canvas canvas, Size size) {
    // Use hardware acceleration
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    // Draw road background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _roadPaint,
    );

    // Batch draw lane markers
    final path = Path();
    const dashHeight = 40.0;
    const dashSpace = 20.0;
    final startY = -(offset % (dashHeight + dashSpace));

    for (double x in lanePositions.sublist(1)) {
      for (double y = startY; y < size.height; y += dashHeight + dashSpace) {
        path.moveTo(x - 20, y);
        path.lineTo(x - 20, y + dashHeight);
      }
    }

    // Draw glow effect
    canvas.drawPath(path, _glowPaint);
    // Draw lines
    canvas.drawPath(path, _linePaint);

    // Batch draw particles
    if (particles.isNotEmpty) {
      final particlePaint = Paint();
      for (var particle in particles) {
        particlePaint.color = particle.color;
        canvas.drawCircle(
          Offset(particle.x, particle.y),
          particle.size,
          particlePaint,
        );
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant EnvironmentPainter oldDelegate) =>
      oldDelegate.offset != offset ||
          oldDelegate.particles.length != particles.length;
}

// Add this extension to make colors darker
extension ColorExtension on Color {
  Color darker() {
    const factor = 0.8;
    return Color.fromRGBO(
      (r * factor).round(),
      (g * factor).round(),
      (b * factor).round(),
      a,
    );
  }
}