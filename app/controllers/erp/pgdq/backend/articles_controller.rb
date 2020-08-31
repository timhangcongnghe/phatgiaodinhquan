module Erp
  module Pgdq
    module Backend
      class ArticlesController < Erp::Backend::BackendController
        before_action :set_article, only: [:archive, :unarchive, :move_up, :move_down, :show, :edit, :update, :destroy]
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
              render json: {
                status: 'success',
                text: @article.name,
                value: @article.id
              }
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
              render json: {
                status: 'success',
                text: @article.name,
                value: @article.id
              }
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
            format.html { redirect_to erp_pgdq.backend_articles_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def dataselect
          respond_to do |format|
            format.json {
              render json: article.dataselect(params[:keyword])
            }
          end
        end
        
        def archive
          @article.archive
          respond_to do |format|
          format.json {
            render json: {
            'message': t('.success'),
            'type': 'success'
            }
          }
          end
        end
        
        def unarchive
          @article.unarchive
          respond_to do |format|
          format.json {
            render json: {
            'message': t('.success'),
            'type': 'success'
            }
          }
          end
        end
        
        def move_up
          @article.move_up
          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end

        def move_down
          @article.move_down
          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end
        
        private
          def set_article
            @article = Article.find(params[:id])
          end
          
          def article_params
            params.fetch(:article, {}).permit(:is_slider, :image, :name, :category_id, :meta_keywords, :meta_description, :tags, :content)
          end
      end
    end
  end
end