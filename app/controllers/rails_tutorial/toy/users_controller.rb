class RailsTutorial::Toy::UsersController < ApplicationController
  before_action :set_rails_tutorial_toy_user, only: [:show, :edit, :update, :destroy]

  # GET /rails_tutorial/toy/users
  # GET /rails_tutorial/toy/users.json
  def index
    @rails_tutorial_toy_users = RailsTutorial::Toy::User.all
  end

  # GET /rails_tutorial/toy/users/1
  # GET /rails_tutorial/toy/users/1.json
  def show
  end

  # GET /rails_tutorial/toy/users/new
  def new
    @rails_tutorial_toy_user = RailsTutorial::Toy::User.new
  end

  # GET /rails_tutorial/toy/users/1/edit
  def edit
  end

  # POST /rails_tutorial/toy/users
  # POST /rails_tutorial/toy/users.json
  def create
    @rails_tutorial_toy_user = RailsTutorial::Toy::User.new(rails_tutorial_toy_user_params)

    respond_to do |format|
      if @rails_tutorial_toy_user.save
        format.html { redirect_to @rails_tutorial_toy_user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @rails_tutorial_toy_user }
      else
        format.html { render :new }
        format.json { render json: @rails_tutorial_toy_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rails_tutorial/toy/users/1
  # PATCH/PUT /rails_tutorial/toy/users/1.json
  def update
    respond_to do |format|
      if @rails_tutorial_toy_user.update(rails_tutorial_toy_user_params)
        format.html { redirect_to @rails_tutorial_toy_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @rails_tutorial_toy_user }
      else
        format.html { render :edit }
        format.json { render json: @rails_tutorial_toy_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rails_tutorial/toy/users/1
  # DELETE /rails_tutorial/toy/users/1.json
  def destroy
    @rails_tutorial_toy_user.destroy
    respond_to do |format|
      format.html { redirect_to rails_tutorial_toy_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rails_tutorial_toy_user
      @rails_tutorial_toy_user = RailsTutorial::Toy::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rails_tutorial_toy_user_params
      params.require(:rails_tutorial_toy_user).permit(:name, :email)
    end
end
