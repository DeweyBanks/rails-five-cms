class Post < ApplicationRecord
  belongs_to :campaign
  belongs_to :category
  has_many :comments, as: :commentable, :dependent => :destroy
  has_many :taggings, :dependent => :delete_all
  has_many :tags, through: :taggings
  has_many :pictures
  accepts_nested_attributes_for :pictures, reject_if: proc { |attributes| attributes[:image].blank? }, allow_destroy: true

  before_validation :set_slug
  validates :title, :presence => true
  has_attached_file :main_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :main_image, content_type: /\Aimage\/.*\z/


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

  def self.search(search)
    where("title LIKE ? OR body LIKE ?", "%#{search}%", "%#{search}%")
  end

  protected

    def set_slug
      self.slug = self.title.downcase.gsub(" ", "-") unless self.slug.present?
    end

end
