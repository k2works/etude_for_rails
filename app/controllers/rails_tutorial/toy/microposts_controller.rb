class RailsTutorial::Toy::MicropostsController < RailsTutorial::ApplicationController
  before_action :set_rails_tutorial_toy_micropost, only: [:show, :edit, :update, :destroy]

  # GET /rails_tutorial/toy/microposts
  # GET /rails_tutorial/toy/microposts.json
  def index
    @rails_tutorial_toy_microposts = RailsTutorial::Toy::Micropost.all
  end

  # GET /rails_tutorial/toy/microposts/1
  # GET /rails_tutorial/toy/microposts/1.json
  def show
  end

  # GET /rails_tutorial/toy/microposts/new
  def new
    @rails_tutorial_toy_micropost = RailsTutorial::Toy::Micropost.new
  end

  # GET /rails_tutorial/toy/microposts/1/edit
  def edit
  end

  # POST /rails_tutorial/toy/microposts
  # POST /rails_tutorial/toy/microposts.json
  def create
    @rails_tutorial_toy_micropost = RailsTutorial::Toy::Micropost.new(rails_tutorial_toy_micropost_params)

    respond_to do |format|
      if @rails_tutorial_toy_micropost.save
        format.html { redirect_to @rails_tutorial_toy_micropost, notice: 'Micropost was successfully created.' }
        format.json { render :show, status: :created, location: @rails_tutorial_toy_micropost }
      else
        format.html { render :new }
        format.json { render json: @rails_tutorial_toy_micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rails_tutorial/toy/microposts/1
  # PATCH/PUT /rails_tutorial/toy/microposts/1.json
  def update
    respond_to do |format|
      if @rails_tutorial_toy_micropost.update(rails_tutorial_toy_micropost_params)
        format.html { redirect_to @rails_tutorial_toy_micropost, notice: 'Micropost was successfully updated.' }
        format.json { render :show, status: :ok, location: @rails_tutorial_toy_micropost }
      else
        format.html { render :edit }
        format.json { render json: @rails_tutorial_toy_micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rails_tutorial/toy/microposts/1
  # DELETE /rails_tutorial/toy/microposts/1.json
  def destroy
    @rails_tutorial_toy_micropost.destroy
    respond_to do |format|
      format.html { redirect_to rails_tutorial_toy_microposts_url, notice: 'Micropost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rails_tutorial_toy_micropost
      @rails_tutorial_toy_micropost = RailsTutorial::Toy::Micropost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rails_tutorial_toy_micropost_params
      params.require(:rails_tutorial_toy_micropost).permit(:content, :user_id)
    end
end
