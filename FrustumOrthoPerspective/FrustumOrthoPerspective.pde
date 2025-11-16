double lastTick;
Camera g_camera;


void setup()
{
  size( 1600, 900, P3D );
  g_camera = new Camera();
  g_camera.setup();
  
  lastTick = millis();
  
  sphereDetail( 20, 10 );
  strokeWeight( 2.0 );
  stroke( 255, 0, 0 );
  fill( 0, 0, 255 );
}



void draw()
{
  background( color( 0, 255, 128 ) );
  double tick = millis();
  double deltaTime = tick - lastTick;
  lastTick = tick;
  
  drawCoordinateSystem();
  
  rotateY( (float) ( tick / 5000.0d * TWO_PI ) );
  sphere( 1 );
  translate( 5, 0, 0 );
  sphere( 1 );
}



void drawCoordinateSystem()
{
  pushStyle();
  pushMatrix();
  stroke( color( 255, 0, 0 ) );
  line( 0, 0, 0, 5, 0, 0 );
  fill( color( 255, 0, 0 ) );
  translate( 5, 0, 0 );
  box( 0.1 );
  popMatrix();
  pushMatrix();
  stroke( color( 0, 255, 0 ) );
  line( 0, 0, 0, 0, 5, 0 );
  fill( color( 0, 255, 0 ) );
  translate( 0, 5, 0 );
  box( 0.1 );
  popMatrix();
  pushMatrix();
  stroke( color( 0, 0, 255 ) );
  line( 0, 0, 0, 0, 0, 5 );
  fill( color( 0, 0, 255 ) );
  translate( 0, 0, 5 );
  box( 0.1 );
  popMatrix();
  popStyle();
}
