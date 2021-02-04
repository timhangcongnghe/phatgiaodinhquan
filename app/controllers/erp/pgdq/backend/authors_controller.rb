module Erp
  module Pgdq
    module Backend
      class AuthorsController < Erp::Backend::BackendController
        before_action :set_author, only: [:edit, :update, :destroy]

        def list
          @authors = Author.search(params).paginate(:page => params[:page], :per_page => 20)
          render layout: nil
        end
        
        def new
          @author = Author.new
          if request.xhr?
            render '_form', layout: nil, locals: {author: @author}
          end
        end
    
        def edit
        end
        
        def create
          @author = Author.new(author_params)
          @author.creator = current_user
          
          if @author.save
            if request.xhr?
              render json: {status: 'success', text: @author.short_name, value: @author.id}
            else
              redirect_to erp_pgdq.edit_backend_author_path(@author), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {author: @author}
            else
              render :new
            end            
          end
        end

        def update
          if @author.update(author_params)
            if request.xhr?
              render json: {status: 'success', text: @author.short_name, value: @author.id}
            else
              redirect_to erp_pgdq.edit_backend_author_path(@author), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        def destroy
          @author.destroy
          respond_to do |format|
            format.html {redirect_to erp_pgdq.backend_authors_path, notice: t('.success')}
            format.json {render json: {'message': t('.success'), 'type': 'success'}}
          end
        end
        
        def dataselect
          respond_to do |format|
            format.json {render json: Author.dataselect(params[:keyword])}
          end
        end
        
        private
          def set_author
            @author = Author.find(params[:id])
          end
          
          def author_params
            params.fetch(:author, {}).permit(:image, :short_name, :long_name, :description, :email, :facebook, :youtube, :twitter, :instagram, :tiktok)
          end
      end
    end
  end
end