class MaterialSourcesController < ApplicationController
  def index
    @sources = MaterialSource.all
    respond_to do |format|
      format.html
      format.json { render json: @sources }
    end
  end

  def new
    @source = MaterialSource.new
  end

  def create
    @source = MaterialSource.new(source_params)
    return render(:new) if @source.invalid?(:url)
    @source.set_content
    return render(:new) if @source.errors.present?
    @source.save && redirect_to(root_path)
  end

  def show
    find_material_source
    render json: @source
  end

  def edit
    find_material_source
  end

  def update
    find_material_source
    @source.update_attributes(source_params) ? redirect_to(@source) : render(:edit)
  end

  def destroy
    find_material_source
    @source.destroy && redirect_to(root_path)
  end

  private

  def find_material_source
    @source = MaterialSource.find(params[:id])
  end

  def source_params
    params.require(:material_source).permit(:url, :title, :episode, :year, :duration, :aspect_ratio)
  end
end
