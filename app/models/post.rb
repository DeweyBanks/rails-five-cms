class Post < ApplicationRecord
  belongs_to :campaign, optional: true
  belongs_to :category
  has_many :taggings, :dependent => :delete_all
  has_many :tags, through: :taggings
  has_many :keywordings, :dependent => :delete_all
  has_many :keywords, through: :keywordings
  has_many :pictures
  has_many :documents
  accepts_nested_attributes_for :pictures, reject_if: proc { |attributes| attributes[:image].blank? }, allow_destroy: true
  accepts_nested_attributes_for :documents, reject_if: proc { |attributes| attributes[:file].blank? }, allow_destroy: true
  before_validation :set_slug
  before_validation :clean_up_status
  validates :title, :presence => true
  has_attached_file :main_image, styles: { medium: "300x300>", thumb: "100x100>" , carousel: "550x550>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :main_image, content_type: /\Aimage\/.*\z/

  after_save :ensure_only_one_featured_post


  def to_param
    "#{slug}"
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_keywords=(names)
    self.keywords = names.split(",").map do |name|
        Keyword.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).uniq.join(", ")
  end

  def all_keywords
    self.keywords.map(&:name).uniq.join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def self.search(search)
    where("title LIKE ? OR body LIKE ?", "%#{search}%", "%#{search}%")
  end

  def published?
    status == "published"
  end

  def archived?
    status == "archived"
  end

  def preview?
    status == "preview"
  end

  def featured?
    featured
  end

  def self.archived
    where(:status => "archived")
  end

  def self.published
    where.not(published_at: nil).where("published_at ?" <= Time.zone.now.to_s).where(status: "published")
  end

  def self.scheduled
    where.not(published_at: nil).where("published_at ?" > Time.zone.now.to_s)
  end

  def self.preview
    where(published_at: nil)
  end

  def self.without(id)
    where.not(:id => id)
  end

  def self.last_loaded(id)
    where('id > ?', id)
  end

  private

    def ensure_only_one_featured_post
      category.posts.where(featured: true).where.not(id: id).update_all(featured: false)
    end

    def set_slug
      title = self.title.to_s.downcase.gsub(" ", "-").gsub(",","").gsub(".","").gsub("'","")
      if title.length > 37
        title = title[0...37]
      end
      self.slug = self.title unless self.slug.present?
      check = Post.find_by(slug: self.slug)
      self.slug += "-#{self.id}" unless check.nil?
      self.slug
    end

    def clean_up_status
      case status
      when "preview"
        self.published_at = nil
      when "published"
        self.published_at = Time.zone.now
      when "archived"
        self.published_at = nil
      end
      true
    end

end
