class LiquidServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(req, res)
    handle(:get, req, res)
  end

  def do_POST(req, res)
    handle(:post, req, res)
  end

  private

  def handle(type, req, res)
    @request = req
    @response = res

    @request.path_info =~ /(\w+)\z/
    @action = $1 || 'email' 
    @assigns = send(@action) if respond_to?(@action)

    hm=@request.path_info
    if hm.include? "png"
      @response['Content-Type'] = "image/png"
    elsif hm.include? "css"
      @response['Content-Type'] = "text/css"
    else
      @response['Content-Type'] = "text/html"
    end
    @response.status = 200
    
    @response.body = Liquid::Template.parse(read_template).render(@assigns, filters: [EmailOpts])
  end
  
  def read_template(filename = @action)
    hm=@request.path_info
    if hm.include? "png"
      File.read("#{__dir__}/assets"+hm)
    elsif hm.include? "css"
      File.read("#{__dir__}/assets"+hm)
    else
      File.read("#{__dir__}/templates/#{filename}.liquid")
    end
  end

end
