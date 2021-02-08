module Erp
  module Pgdq
    module Backend
      class ArticlesController < Erp::Backend::BackendController
        before_action :set_article, only: [:uncheck_active_display, :check_active_display, :edit, :update, :destroy]

        def list
          @articles = Article.search(params).paginate(:page => params[:page], :per_page => 20)
          render layout: nil
        end
        
        def new
          @article = Article.new
          if request.xhr?
            render '_form', layout: nil, locals: {article: @article}
          end
        end
    
        def edit
        end
        
        def create
          @article = Article.new(article_params)
          @article.creator = current_user
          
          if @article.save
            if request.xhr?
              render json: {status: 'success', text: @article.name, value: @article.id}
            else
              redirect_to erp_pgdq.edit_backend_article_path(@article), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {article: @article}
            else
              render :new
            end            
          end
        end

        def update
          if @article.update(article_params)
            if request.xhr?
              render json: {status: 'success', text: @article.name, value: @article.id}
            else
              redirect_to erp_pgdq.edit_backend_article_path(@article), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        def destroy
          @article.destroy          
          respond_to do |format|
            format.html {redirect_to erp_pgdq.backend_articles_path, notice: t('.success')}
            format.json {render json: {'message': t('.success'), 'type': 'success'}}
          end
        end
        
        def dataselect
          respond_to do |format|
            format.json {render json: article.dataselect(params[:keyword])}
          end
        end
        
        def check_active_display
          @article.check_active_display

          respond_to do |format|
          format.json {render json: {'message': t('.success'), 'type': 'success'}}
          end
        end
        
        def uncheck_active_display
          @article.uncheck_active_display

          respond_to do |format|
          format.json {render json: {'message': t('.success'), 'type': 'success'}}
          end
        end
        
        private
          def set_article
            @article = Article.find(params[:id])
          end
          
          def article_params
            params.fetch(:article, {}).permit(:is_slider, :image, :name, :title_name, :category_id, :author_id, :date_public, :meta_description, :tags, :content)
          end
      end
    end
  end
end