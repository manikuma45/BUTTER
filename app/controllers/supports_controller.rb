class SupportsController < ApplicationController
before_action :set_support, only: [:show, :edit, :update, :destroy]

  def index
  	@supports = Support.all
  end

  def new
  	@support = Support.new
  end

  def show
  end

  def edit
  end

  def create
  	@support = Support.create(support_params)
   if @support.save
  	redirect_to supports_path, notice: "新しいサポートを作成しました！"
   else
  	render :new
   end
  end

def update
	if @support.update(support_params)
	 redirect_to support_path, notice: "サポートを編集しました！"
	else
		render :edit
	end
end

def destroy
	if @support.destroy
		redirect_to supports_path, notice: "サポートを削除しました!"
	end
end

private

def support_params
	params.require(:support).permit(:title, :content, :image, :price, :image_cache)
end

def set_support
	@support = Support.find(params[:id])
end

end