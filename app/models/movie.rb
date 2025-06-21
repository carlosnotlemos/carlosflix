class Movie < ApplicationRecord
  before_validation :generate_slug

  validates :title, :slug, :video_master_url, presence: { message: "não pode ficar em branco!" }
  validates :slug, uniqueness: { message: "deve ser único" }

  private

  def generate_slug
    self.slug ||= title.parameterize if title.present?
  end
end
