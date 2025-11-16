Camera cameraMain;
Camera cameraMiniMap;
PGraphics backBufferMiniMap;


void setup()
{
  size( 1600, 900, P3D );
  assert this.g instanceof PGraphicsOpenGL : "This sketch needs to be in OpenGL 3D ( P3D ) mode!";
  backBufferMiniMap = createGraphics( 500, 500, P3D );
  assert backBufferMiniMap instanceof PGraphicsOpenGL : "This buffer needs to be in OpenGL 3D ( P3D ) mode!";
  
  cameraMain = new Camera( 2000, 500, -2000,
                           0, 0, 0,
                           0, -1, 0,
                           width, height, 1500f );
  cameraMiniMap = new Camera( 0, 1000, 0,
                              0, 0, 0,
                              0, 0, -1,
                              500, 500, 1000);
}



void draw()
{
  background( color( 31, 63, 63 ) );
  
  cameraMain.activateFor( (PGraphicsOpenGL) this.g );
  
  drawCoordinateSystemOnto( g );
  
  strokeWeight( 1.0 );
  stroke( color( 255 ) );
  fill( color( 255, 0, 255, 63 ) );
  box( 100, 100, 100 );
  
  translate( 0, 100, 0 );
  fill( color( 127, 588, 127, 63 ) );
  box( 100, 100, 100 );
  
  // Minimap rendering
  Frustum frustum = cameraMain.getFrustumInWS();
  
  backBufferMiniMap.beginDraw();
  
  backBufferMiniMap.background( color( 255, 0, 255, 63 ) );
  cameraMiniMap.activateFor( (PGraphicsOpenGL) backBufferMiniMap );
  
  float scaleMiniMap = 1f / 8f;
  backBufferMiniMap.scale( scaleMiniMap );  // zoom out by scaling smaller
  backBufferMiniMap.translate( 0, 0, 0 );  // translate to focus on whatever you want centered in minimap
  drawCoordinateSystemOnto( backBufferMiniMap );
  
  backBufferMiniMap.noFill();
  backBufferMiniMap.stroke( color( 255 ) );
  backBufferMiniMap.strokeWeight( 2f / scaleMiniMap );
  frustum.renderOnto( backBufferMiniMap );
  
  backBufferMiniMap.endDraw();
  
  // back to default 2D rendering mode
  resetMatrix();
  ortho();
  
  // blit minimap onto main buffer
  translate( width/2f - backBufferMiniMap.width, height/2f - backBufferMiniMap.height, 0 );
  image( backBufferMiniMap, 0, 0); 
}



void mouseClicked()
{
  cameraMain.toggleProjectionMode();
}
