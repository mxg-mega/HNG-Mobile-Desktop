abstract class ControlStrategy {
  void handleMovement();
  void handleJump();
}

class MobileControls implements ControlStrategy {
  // Implement mobile-specific controls
  @override
  void handleMovement(){}
  @override
  void handleJump(){}
}

class DesktopControls implements ControlStrategy {
  // Implement desktop-specific controls
  @override
  void handleMovement(){}
  @override
  void handleJump(){}
}