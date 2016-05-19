class Admin::SingleArticlesController < Admin::BaseController
  authorize_resource :class => false
  
  before_action :find_data, except: [:index, :new, :create]
  
  def index
    @single_articles = SingleArticle.all
  end
  
  def new
    @data = SingleArticle.new
  end
  
  def create
    single_article = SingleArticle.new(post_params)
    single_article.save!
    
    redirect_to admin_single_articles_path(single_article), notice: '添加成功'
  end
  
  def edit
    
  end
  
  def update
    @data.update_attributes(post_params)
    
    redirect_to admin_single_articles_path(@data), notice: '编辑成功'
  end
  
  def destroy
    redirect_to :back, notice: '不可以删除' and return unless @data.can_delete?
    @data.destroy!
    redirect_to :back, notice: '删除成功'
  end
  
  private
  def find_data
    @data = SingleArticle.find(params[:id])
  end
  
  def post_params
    params.require(:single_article).permit!
  end
end
