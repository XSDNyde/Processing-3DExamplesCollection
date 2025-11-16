

class Camera
{
  int m_screenWidth = width;
  int m_screenHeight = height;
  float m_aspectRatio = (float) m_screenWidth / m_screenHeight;
  boolean m_orthogonal = true;
  PVector m_position = new PVector( 2.5, 5, -5 );
  PVector m_lookAt = new PVector( 0, 0, 0 );
  PVector m_up = new PVector( 0, -1, 0 );
  PVector m_frustumLR = new PVector( -10, 10 );
  PVector m_frustumBT = new PVector( m_frustumLR.x / m_aspectRatio, m_frustumLR.y / m_aspectRatio );
  PVector m_frustumNF = new PVector( 1, 15 );


  Camera()
  {
    
  }
  
  

  void setup()
  {
    camera( m_position.x, m_position.y, m_position.z,
            m_lookAt.x,   m_lookAt.y,   m_lookAt.z,
            m_up.x,       m_up.y,       m_up.z );
    ortho( m_frustumLR.x, m_frustumLR.y,
           m_frustumBT.x, m_frustumBT.y,
           m_frustumNF.x, m_frustumNF.y );
  }
  
  
  
  void toggleProjection()
  {
    m_orthogonal = !m_orthogonal;
    if( m_orthogonal )
      ortho( m_frustumLR.x, m_frustumLR.y,
             m_frustumBT.x, m_frustumBT.y,
             m_frustumNF.x, m_frustumNF.y );
    else
    {
      frustum( m_frustumLR.x, m_frustumLR.y,
               m_frustumBT.x, m_frustumBT.y,
               m_frustumNF.x, m_frustumNF.y );
    }
  }


}
