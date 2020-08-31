module Erp
  module Pgdq
    module Backend
      class CategoriesController < Erp::Backend::BackendController
        before_action :set_category, only: [:archive, :unarchive, :move_up, :move_down, :show, :edit, :update, :destroy]
        def list
          @categories = Category.search(params).paginate(:page => params[:page], :per_page => 20)
          render layout: nil
        end
        
        def new
          @category = Category.new
          if request.xhr?
            render '_form', layout: nil, locals: {category: @category}
          end
        end
    
        def edit
        end
        
        def create
          @category = Category.new(category_params)
          @category.creator = current_user
          
          if @category.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @category.name,
                value: @category.id
              }
            else
              redirect_to erp_pgdq.edit_backend_category_path(@category), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {category: @category}
            else
              render :new
            end            
          end
        end

        def update
          if @category.update(category_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @category.name,
                value: @category.id
              }
            else
              redirect_to erp_pgdq.edit_backend_category_path(@category), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        def destroy
          @category.destroy          
          respond_to do |format|
            format.html { redirect_to erp_pgdq.backend_categories_path, notice: t('.success') }
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
              render json: Category.dataselect(params[:keyword])
            }
          end
        end
        
        def archive
          @category.archive
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
          @category.unarchive
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
          @category.move_up
          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end

        def move_down
          @category.move_down
          respond_to do |format|
          format.json {
            render json: {
            }
          }
          end
        end
        
        private
          def set_category
            @category = Category.find(params[:id])
          end
          
          def category_params
            params.fetch(:category, {}).permit(:image, :name, :parent_id, :meta_keywords, :meta_description, :tags, :content)
          end
      end
    end
  end
end