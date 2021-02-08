module Erp::Pgdq
  class Author < ApplicationRecord
    include Erp::CustomOrder
    mount_uploader :image, Erp::Pgdq::AuthorUploader
    
    belongs_to :creator, class_name: 'Erp::User'
    has_many :articles, class_name: 'Erp::Pgdq::Article'
    
    validates :short_name, :presence => true
    validates :short_name, :uniqueness => true
    validates :long_name, :presence => true
    validates :long_name, :uniqueness => true
    validates :title_name, :presence => true
    validates :title_name, :uniqueness => true
    validates :title_name, length: {maximum: 60}
    
    def self.get_active
			self.where(archived: false).order('custom_order ASC')
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
        query = query.where('LOWER(short_name) LIKE ?', "%#{keyword}%")
      end
      query = query.limit(10).map{|author| {value: author.id, text: author.get_short_name} }
    end
    
    def archive
			update_columns(archived: true)
		end
		
		def unarchive
			update_columns(archived: false)
		end
    
    def get_title_name
			self.title_name
		end
    
    def get_short_name
			self.short_name
		end
		
		def get_long_name
      self.long_name
    end
    
    def get_article_count
			self.articles.get_active.count
		end
    
    after_save :create_alias
    
    def create_alias
      name = self.title_name
      self.update_column(:alias, name.to_ascii.downcase.to_s.gsub(/[^0-9a-z \/\-\.]/i, '').gsub(/[ \/\.]+/i, '-').strip)
    end
  end
end