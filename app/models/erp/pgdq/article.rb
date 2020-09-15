module Erp::Pgdq
  class Article < ApplicationRecord
    mount_uploader :image, Erp::Pgdq::ArticleUploader
    
    belongs_to :creator, class_name: "Erp::User"
    belongs_to :category, class_name: "Erp::Pgdq::Category"
    
    validates :name, :presence => true
    validates :category_id, :presence => true
    validates :date_public, :presence => true
    validates :name, :uniqueness => true
    
    def self.get_active
			self.where(archived: false)
		end
    
    def self.get_articles
      self.get_active.order('date_public DESC')
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
      query = query.limit(20).map{|article| {value: article.id, text: article.get_name} }
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
		
		def get_category_name
      category.present? ? category.get_name : ''
    end
		
		def get_full_category_name
      category.present? ? category.get_full_name : ''
    end
		
		after_save :update_cache_search
		after_save :create_alias
		
    def update_cache_search
			str = []
			str << name.to_s.downcase.strip
			self.update_column(:cache_search, str.join(" ") + " " + str.join(" ").to_ascii)
		end
        
    def create_alias
      name = self.name
      self.update_column(:alias, name.to_ascii.downcase.to_s.gsub(/[^0-9a-z \/\-\.]/i, '').gsub(/[ \/\.]+/i, '-').strip)
    end
  end
end