class PrefecturesController < ApplicationController
  before_action :set_prefecture, only: %i[ show edit update destroy ]
  include RedisGraphClient
  # GET /prefectures or /prefectures.json
  def index
    @prefectures = Prefecture.all
    @all_nodes = pp rg.query("""MATCH (n) RETURN n""").resultset.first
    # p "--------------"
    # cmd = """CREATE (:Rider {name:'Valentino Rossi'})-[:rides]->(:Team {name:'Yamaha'}), (:Rider {name:'Dani Pedrosa'})-[:rides]->(:Team {name:'Honda'}), (:Rider {name:'Andrea Dovizioso'})-[:rides]->(:Team {name:'Ducati'})"""
    # pp rg.query(cmd)
    # p "--------------"
    # cmd = """MATCH (r:Rider)-[:rides]->(t:Team) WHERE t.name = 'Yamaha' RETURN r.name, t.name"""
    # pp rg.query(cmd)
    # p "--------------"
  end

  # GET /prefectures/1 or /prefectures/1.json
  def show
  end

  # GET /prefectures/new
  def new
    @prefecture = Prefecture.new
  end

  # GET /prefectures/1/edit
  def edit
  end

  # POST /prefectures or /prefectures.json
  def create
    @prefecture = Prefecture.new(prefecture_params)
    @prefecture.name = @prefecture.name.capitalize
    respond_to do |format|
      if @prefecture.save
        format.html { redirect_to prefecture_url(@prefecture), notice: "Prefecture was successfully created." }
        format.json { render :show, status: :created, location: @prefecture }
        p "--------------"
        pp rg.query("""CREATE (n:Prefecture {name: '#{@prefecture.name}'}) RETURN n""").resultset.first
        p "--------------"
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prefecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prefectures/1 or /prefectures/1.json
  def update
    respond_to do |format|
    @prefecture.name = @prefecture.name.capitalize
      if @prefecture.update(prefecture_params)
        format.html { redirect_to prefecture_url(@prefecture), notice: "Prefecture was successfully updated." }
        format.json { render :show, status: :ok, location: @prefecture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prefecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prefectures/1 or /prefectures/1.json
  def destroy
    @prefecture.destroy

    respond_to do |format|
      format.html { redirect_to prefectures_url, notice: "Prefecture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prefecture
      @prefecture = Prefecture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prefecture_params
      params.require(:prefecture).permit(:name)
    end
end
