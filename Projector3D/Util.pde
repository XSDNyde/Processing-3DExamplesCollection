

public void drawCoordinateSystemOnto( PGraphics g )
{
  g.noStroke();
  g.fill( 127 );
  g.box( 15 );
  
  g.sphereDetail( 10 );
  
  g.strokeWeight( 5 );
  g.push();
  g.stroke( color( 255, 0, 0 ) );
  g.line( 0, 0, 0, 1000, 0, 0 );
  g.noStroke();
  g.fill( color( 191, 0, 0 ) );
  for( int i = 0; i < 1000; i += 100 )
  {
    g.translate( 100, 0, 0 );
    g.sphere( 5 );
  }
  g.pop();
  
  g.push();
  g.stroke( color( 0, 255, 0 ) );
  g.line( 0, 0, 0, 0, 1000, 0 );
  g.noStroke();
  g.fill( color( 0, 191, 0 ) );
  for( int i = 0; i < 1000; i += 100 )
  {
    g.translate( 0, 100, 0 );
    g.sphere( 5 );
  }
  g.pop();
  
  g.push();
  g.stroke( color( 0, 0, 255 ) );
  g.line( 0, 0, 0, 0, 0, 1000 );
  g.noStroke();
  g.fill( color( 0, 0, 191 ) );
  for( int i = 0; i < 1000; i += 100 )
  {
    g.translate( 0, 0, 100 );
    g.sphere( 5 );
  }
  g.pop();
}
