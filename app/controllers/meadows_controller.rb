class MeadowsController < ApplicationController
  before_action :set_meadow, only: [:show, :edit, :update, :destroy]

  # GET /meadows
  # GET /meadows.json
  def index
    @meadows = Meadow.all
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
    @meadow = Meadow.new(meadow_params)

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
    respond_to do |format|
      format.html { redirect_to meadows_url, notice: 'Meadow was successfully destroyed.' }
      format.json { head :no_content }
    end
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
end
