class PostsController < ApplicationController

  def index
    @posts = Post.all
    respond_to do |format|
      format.html 
      format.json do
        render :json => @posts
      end
    end
  end
    # 어떤 프론트 형태에 respond 할것인지 컨트롤러에서 위 명령문으로 정의해줌 


  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @post = Post.new
      @post["body"] = params["body"]
      @post["image"] = params["image"]
      @post.uploaded_image.attach(params["uploaded_image"])
      @post["user_id"] = @user["id"]
      @post.save
    else
      flash["notice"] = "Login first."
    end
    redirect_to "/posts"
  end

  before_action :allow_cors
  def allow_cors
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email, X-User-Token, X-User-Email'
    response.headers['Access-Control-Max-Age'] = '1728000'
  end

end