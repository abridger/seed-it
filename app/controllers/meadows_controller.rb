class MeadowsController < ApplicationController
  before_action :set_meadow, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  # GET /meadows
  # GET /meadows.json
  def index
    @meadows = Meadow.all.paginate(page: params[:page])
  end

  # GET /meadows/1
  # GET /meadows/1.json
  def show
  end

  # GET /meadows/new
  def new
    @meadow = Meadow.new
  end

  # GET /meadows/1/edit
  def edit
  end

  # POST /meadows
  # POST /meadows.json
  def create
    @meadow = current_user.meadows.build(meadow_params)

    respond_to do |format|
      if @meadow.save
        format.html { redirect_to @meadow, notice: 'Meadow was successfully created.' }
        format.json { render :show, status: :created, location: @meadow }
      else
        format.html { render :new }
        format.json { render json: @meadow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meadows/1
  # PATCH/PUT /meadows/1.json
  def update
    respond_to do |format|
      if @meadow.update(meadow_params)
        format.html { redirect_to @meadow, notice: 'Meadow was successfully updated.' }
        format.json { render :show, status: :ok, location: @meadow }
      else
        format.html { render :edit }
        format.json { render json: @meadow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meadows/1
  # DELETE /meadows/1.json
  def destroy
    @meadow.destroy
    flash[:success] = "Meadow deleted"
    redirect_to request.referrer || meadows_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meadow
      @meadow = Meadow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meadow_params
      params.require(:meadow).permit(:name, :description)
    end

    def correct_user
      @meadow = current_user.meadows.find_by(id: params[:id])
      redirect_to root_url if @meadow.nil?
    end
end
