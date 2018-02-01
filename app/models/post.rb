class Post < ApplicationRecord
  belongs_to :campaign
  belongs_to :category
  has_many :comments, as: :commentable, :dependent => :destroy
  has_many :taggings, :dependent => :delete_all
  has_many :tags, through: :taggings
  before_validation :set_slug
  validates :slug, :presence => true

  def to_param
    "#{slug}"
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).uniq.join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  protected

    def set_slug
      self.slug = self.title.downcase.gsub(" ", "-") unless self.slug.present?
    end

end
