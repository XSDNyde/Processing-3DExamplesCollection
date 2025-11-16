


class Camera
{
  PMatrix3D MV;
  PVector eye;
  PVector center;
  PVector up;
  
  PMatrix3D P;
  float left, right;
  float bottom, top;
  float near, far;
  float depth;
  final float NEAR_MIN = 0.01f;
  ProjectionMode projectionMode;
    
  float[][] CornersNDC = new float[][] {
      new float[] { -1, -1, -1, 1 },
      new float[] {  1, -1, -1, 1 },
      new float[] { -1,  1, -1, 1 },
      new float[] {  1,  1, -1, 1 },
      new float[] { -1, -1,  1, 1 },
      new float[] {  1, -1,  1, 1 },
      new float[] { -1,  1,  1, 1 },
      new float[] {  1,  1,  1, 1 },
  };
  
  
  public
  Camera( float eyeX, float eyeY, float eyeZ, float centerX, float centerY, float centerZ, float upX, float upY, float upZ, float width, float height, float depth )
  {
    eye    = new PVector( eyeX, eyeY, eyeZ );
    center = new PVector( centerX, centerY, centerZ );
    up     = new PVector( upX, upY, upZ );
    
    this.depth = depth;
    left = - width / 2f;
    right = width / 2f;
    bottom = - height / 2f;
    top = height / 2f;
    near = max( NEAR_MIN, PVector.dist( eye, center ) - depth / 2f );
    //near = PVector.dist( eye, center );
    //println( PVector.dist( eye, center ) );
    far = near + depth;
    projectionMode = ProjectionMode.ORTHOGRAPHIC;
    
    pushMatrix();
    camera( eye.x, eye.y, eye.z,
            center.x, center.y, center.z,
            up.x, up.y, up.z );
    MV = (PMatrix3D) ( getMatrix().get() );
    applyProjectionMode();
    popMatrix();
  }
  
  
  public void applyProjectionMode()
  {
    PGraphicsOpenGL gOGL = ((PGraphicsOpenGL) g);
    gOGL.pushProjection();
    switch ( projectionMode ) 
    {
      case ORTHOGRAPHIC :
        ortho( left, right, bottom, top, near, far );
        break;
      case PERSPECTIVE :
        frustum( left, right, bottom, top, near, far );
        break;
    }
    P = gOGL.projection.get();
    gOGL.popProjection();
  }
  
  
  public
  PMatrix3D getMV() { return MV; }
  PMatrix3D getP() { return P; }
  
  PMatrix3D getInverseMVP()
  {
    PMatrix3D inv = P.get();
    inv.apply( MV );
    inv.invert();
    
    //PVector t = new PVector( 0, 0, 0 );
    //float[] tNDC = new float[] { 0, 0, 750, 1 };
    //float[] tHomogenous = new float[ tNDC.length ];
    //PVector t = new PVector( 0.9996722, -0.99975485, -0.88180625 );
    //inv.mult( tNDC, tHomogenous );
    //printArray( tHomogenous );
    
    //float[] tNDC = new float[] { 0, 0, 1, 1 };
    //float[] result = new float[ 4 ];
    //inv.mult( tNDC, result );
    //result[0] /= result[3];
    //result[1] /= result[3];
    //result[2] /= result[3];
    //printArray( result );
    
    return inv;
  }
  
  
  Frustum getFrustumInWS()
  {
    PMatrix3D inv = getInverseMVP();
    float[][] CornersWS = new float[ 8 ][ 4 ];
    for( int i = 0; i < CornersNDC.length; i++ )
    {
      inv.mult( CornersNDC[i], CornersWS[i] );
      CornersWS[i][0] /= CornersWS[i][3];
      CornersWS[i][1] /= CornersWS[i][3];
      CornersWS[i][2] /= CornersWS[i][3];
      CornersWS[i][3] = 1f;
      //printArray( CornersWS[i] );
    }
    
    return new Frustum( new PVector( CornersWS[0][0], CornersWS[0][1], CornersWS[0][2] ),
                        new PVector( CornersWS[1][0], CornersWS[1][1], CornersWS[1][2] ),
                        new PVector( CornersWS[2][0], CornersWS[2][1], CornersWS[2][2] ),
                        new PVector( CornersWS[3][0], CornersWS[3][1], CornersWS[3][2] ),
                        new PVector( CornersWS[4][0], CornersWS[4][1], CornersWS[4][2] ),
                        new PVector( CornersWS[5][0], CornersWS[5][1], CornersWS[5][2] ),
                        new PVector( CornersWS[6][0], CornersWS[6][1], CornersWS[6][2] ),
                        new PVector( CornersWS[7][0], CornersWS[7][1], CornersWS[7][2] ) );
  }
  
  
  public
  void activateFor( PGraphicsOpenGL gOGL )
  {
    gOGL.setMatrix( MV );
    gOGL.setProjection( P );
  }
  
  
  void toggleProjectionMode()
  {
    projectionMode = ProjectionMode.values()[ ( projectionMode.ordinal() + 1 ) % ProjectionMode.values().length ];
    println( "Setting projection matrix to " + projectionMode.name() );
    applyProjectionMode();
  }
  
  
  public void print()
  {
    println( "Projection mode: " + projectionMode.name() );
    println( "MV" ); MV.print();
    println( "P" ); P.print();
  }
}
  
  
enum ProjectionMode
{
  ORTHOGRAPHIC,
  PERSPECTIVE;
}
