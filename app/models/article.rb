class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings,
  dependent: :destroy
  has_attached_file :image, styles: { medium: '700x700>', thumb: '100x100>' }

  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png']

  def tag_list
    tags.join(', ')
  end

  def tag_list=(tag_list)
    tag_names = tag_list.strip.downcase.split(', ').uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
end
