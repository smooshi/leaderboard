class UsersController <ApplicationController
  before_filter :set_default_response_format
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def index
    @users = User.top(User.count)
  end

  def show
    @user = User.find_by_name(params[:name])
    respond_to do |format|
      format.json
    end
  end

  def get_top_10
    @top_10 = User.top(10)
  end

  def update
    @user = User.find_by_name(params[:name])
    respond_to do |format|
      if @user.save
        @user.add_score(params[:score].to_i)
        format.json { render json: @user.errors, status: :created}
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    #byebug
    @user = User.new(name:params[:name])

    respond_to do |format|
      if @user.save
        @user.add_score(params[:score].to_i)
        #format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user.errors, status: :created }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def set_default_response_format
    request.format = :json
  end
end