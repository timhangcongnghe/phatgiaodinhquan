module Erp::Pgdq
  class Article < ApplicationRecord
    mount_uploader :image, Erp::Pgdq::ArticleUploader
    
    belongs_to :creator, class_name: 'Erp::User'
    belongs_to :category, class_name: 'Erp::Pgdq::Category'
    belongs_to :author, class_name: 'Erp::Pgdq::Author'
    
    validates :name, :presence => true
    validates :title_name, :presence => true
    validates :category_id, :presence => true
    validates :author_id, :presence => true
    validates :date_public, :presence => true
    validates :name, :uniqueness => true
    validates :title_name, :uniqueness => true
    validates :title_name, length: {maximum: 70}
    
    def self.get_active
			self.where(archived: false).where(active_display: true)
		end
    
    def self.get_articles
      self.get_active.order('date_public DESC')
    end
    
    def self.get_newest_articles
      self.get_active.order('date_public DESC').limit(10)
    end
    
    def self.get_sidebar_newest_articles
      self.get_active.order('date_public DESC').limit(5)
    end
    
    def self.get_sidebar_new_update_articles
      self.get_active.order('updated_at DESC').limit(5)
    end
    
    def self.get_slider_articles
      self.get_articles.where(is_slider: true)
    end
    
    def self.filter(query, params)
      params = params.to_unsafe_hash
      and_conds = []
      show_archived = false
      
			if params["filters"].present?
				params["filters"].each do |ft|
					or_conds = []
					ft[1].each do |cond|
						if cond[1]["name"] == 'show_archived'
							show_archived = true
						else
							or_conds << "#{cond[1]["name"]} = '#{cond[1]["value"]}'"
						end
					end
					and_conds << '('+or_conds.join(' OR ')+')' if !or_conds.empty?
				end
			end
			
      if params["keywords"].present?
        params["keywords"].each do |kw|
          or_conds = []
          kw[1].each do |cond|
            or_conds << "LOWER(#{cond[1]["name"]}) LIKE '%#{cond[1]["value"].downcase.strip}%'"
          end
          and_conds << '('+or_conds.join(' OR ')+')'
        end
      end
      
      if show_archived == true
        query = query.where(archived: true)
      else
        query = query.where(archived: false)
      end
      
      query = query.joins(:category)
      query = query.where(and_conds.join(' AND ')) if !and_conds.empty?
      query = query.joins(:creator)
      
      return query
    end
    
    def self.search(params)
      query = self.all
      query = self.filter(query, params)
      if params[:sort_by].present?
        order = params[:sort_by]
        order += " #{params[:sort_direction]}" if params[:sort_direction].present?
        query = query.order(order)
      end
      return query
    end
    
    def self.dataselect(keyword='')
      query = self.all
      if keyword.present?
        keyword = keyword.strip.downcase
        query = query.where('LOWER(name) LIKE ?', "%#{keyword}%")
      end
      query = query.limit(10).map{|article| {value: article.id, text: article.get_name} }
    end
    
    def self.frontend_search(params)
      query = self.get_articles
      
      if params[:keys].present?
        keyword = params[:keys].strip.downcase
        query = query.where("LOWER(erp_pgdq_articles.cache_search) LIKE ?", "%#{keyword}%")
      end
      
      return query
    end
    
    def archive
			update_columns(archived: true)
		end
		
		def unarchive
			update_columns(archived: false)
		end
		
		def get_name
      self.name
    end
    
    def get_title_name
      self.title_name
    end
		
		def get_category_name
      category.present? ? category.get_name : ''
    end
		
		def get_category_full_name
      category.present? ? category.get_full_name : ''
    end
    
		def get_author_name
      author.present? ? author.get_short_name : ''
    end
    
    def get_author_long_name
      author.present? ? author.get_long_name : ''
    end
    
    def check_active_display
			update_columns(active_display: true)
		end

    def uncheck_active_display
			update_columns(active_display: false)
		end
		
		after_save :update_cache_search
		after_create :create_alias
		
    def update_cache_search
			str = []
			str << name.to_s.downcase.strip
			self.update_column(:cache_search, str.join(" ") + " " + str.join(" ").to_ascii)
		end
        
    def create_alias
      name = self.title_name
      self.update_column(:alias, name.to_ascii.downcase.to_s.gsub(/[^0-9a-z \/\-\.]/i, '').gsub(/[ \/\.]+/i, '-').strip)
    end
  end
end