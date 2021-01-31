class BrandsController < ApplicationController
  before_action :admin_only, only: %i[release]
  before_action :set_brand, only: %i[show edit update destroy release]

  # GET /brands
  # GET /brands.json
  def index
    @brands = params[:query] ? Brand.search(params[:query]) : Brand.all
  end

  # GET /brands/1
  # GET /brands/1.json
  def show; end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit; end

  # POST /brands
  # POST /brands.json
  def create
    @brand = Brand.new(brand_params)
    @brand.created_by = Current.user.id
    @brand.custom = true

    respond_to do |format|
      if @brand.save
        format.html { redirect_to @brand, notice: 'Brand was successfully created.' }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # release a brand from a users 'custom' limit cap
  # TODO: only admin
  # TODO: email notification to user that their brand has been released
  def release
    respond_to do |format|
      if @brand.update(custom: false, released_by: Current.user.id, released_at: Time.current)
        format.html { redirect_to @brand, notice: 'Brand has been released.' }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :index }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1
  # PATCH/PUT /brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to @brand, notice: 'Brand was successfully updated.' }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to brands_url, notice: 'Brand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:category, :custom, :image, :image_cache, :info, :name, :query, :url)
  end
end
