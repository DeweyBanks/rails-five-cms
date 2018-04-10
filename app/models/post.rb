class Post < ApplicationRecord
  include Filterable
  has_secure_password validations: false
  validates :password,
    length: { minimum: 6 },
    allow_blank: true
  validates_confirmation_of :password, allow_blank: true

  belongs_to :campaign, optional: true
  belongs_to :category, optional: true
  has_many :taggings, :dependent => :delete_all
  has_many :tags, through: :taggings
  has_many :keywordings, :dependent => :delete_all
  has_many :keywords, through: :keywordings
  has_many :pictures
  has_many :documents
  before_validation :set_slug
  before_validation :clean_up_status
  accepts_nested_attributes_for :pictures, reject_if: proc { |attributes| attributes[:image].blank? }, allow_destroy: true
  accepts_nested_attributes_for :documents, reject_if: proc { |attributes| attributes[:file].blank? }, allow_destroy: true
  has_attached_file :main_image, styles: { medium: "300x300>", thumb: "100x100>" , carousel: "550x550>" }, default_url: "/images/:style/missing.png"
  validates :title, :presence => true
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

  # def self.category(category_id)
  #   where(category_id: category_id)
  # end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def self.search(search)
    where("title LIKE ? OR body LIKE ?", "%#{search}%", "%#{search}%")
  end

  def published?
    if self.published_at
      self.published_at <= Time.zone.now.to_s
    else
      false
    end
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
    where.not(published_at: nil).where("published_at ?" <= Time.zone.now.to_s)
  end

  def self.scheduled
    where("published_at >= ?", Time.zone.now )
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

  def user_verified(verified_username, password)
    verified = authenticate(password)
    verified && verified_username
  end

  private

    def ensure_only_one_featured_post
      category.posts.where(featured: true).where.not(id: id).update_all(featured: false)
    end

    def set_slug
      slug_title = self.title.to_s.gsub(" ", "-").gsub(",","").gsub(".","").gsub("'","")
      if slug_title.length > 37
        slug_title = slug_title[0...37]
      end
      self.slug = slug_title unless self.slug.present?
      self.slug.downcase!
    end

    def clean_up_status
      if locked
        status = "preview"
      end
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

    def update_status
      if self.published_at <= Time.zone.now
        self.status == "published"
        self.save
      end
    end

end
