module EmailOpts 
  def imgs(i_d)
    '<img src="'+i_d+'" />'
  end

end

class Servlet < LiquidServlet
  def email
    { 'jsond' => dada , 'type' => 'dist'}
  end

  private

  def dada
    file = File.read('announcement_dada.json')
    jsond=JSON.parse(file)
  end 

end
