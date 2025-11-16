


class Frustum
{
  private
  PVector
    lbn,
    rbn,
    rtn,
    ltn,
    lbf,
    rbf,
    rtf,
    ltf;
    
  Frustum( PVector lbn, PVector rbn, PVector ltn, PVector rtn,
           PVector lbf, PVector rbf, PVector ltf, PVector rtf )
  {
    this.lbn = lbn;
    this.rbn = rbn;
    this.rtn = rtn;
    this.ltn = ltn;
    this.lbf = lbf;
    this.rbf = rbf;
    this.rtf = rtf;
    this.ltf = ltf;
  }
  
  
  void renderOnto( PGraphics g )
  {
    g.beginShape( QUADS );
    
    //near
    g.vertex( lbn.x, lbn.y, lbn.z );
    g.vertex( rbn.x, rbn.y, rbn.z );
    g.vertex( rtn.x, rtn.y, rtn.z );
    g.vertex( ltn.x, ltn.y, ltn.z );
    //right
    g.vertex( rbn.x, rbn.y, rbn.z );
    g.vertex( rbf.x, rbf.y, rbf.z );
    g.vertex( rtf.x, rtf.y, rtf.z );
    g.vertex( rtn.x, rtn.y, rtn.z );
    //far
    g.vertex( rbf.x, rbf.y, rbf.z );
    g.vertex( lbf.x, lbf.y, lbf.z );
    g.vertex( ltf.x, ltf.y, ltf.z );
    g.vertex( rtf.x, rtf.y, rtf.z );
    //left
    g.vertex( lbf.x, lbf.y, lbf.z );
    g.vertex( lbn.x, lbn.y, lbn.z );
    g.vertex( ltn.x, ltn.y, ltn.z );
    g.vertex( ltf.x, ltf.y, ltf.z );
    //top
    g.vertex( ltn.x, ltn.y, ltn.z );
    g.vertex( rtn.x, rtn.y, rtn.z );
    g.vertex( rtf.x, rtf.y, rtf.z );
    g.vertex( ltf.x, ltf.y, ltf.z );
    //bottom
    g.vertex( rbn.x, rbn.y, rbn.z );
    g.vertex( lbn.x, lbn.y, lbn.z );
    g.vertex( lbf.x, lbf.y, lbf.z );
    g.vertex( rbf.x, rbf.y, rbf.z );
    
    g.endShape();
  }
}
