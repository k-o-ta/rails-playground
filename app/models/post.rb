class Post < ApplicationRecord

  has_many :post_publishes

  scope :with_latest_publish, lambda {
    joins(<<~SQL)
        LEFT OUTER JOIN post_publishes AS new_post_publishes
          ON post_publishes.post_id = new_post_publishes.post_id
          AND post_publishes.created_at < new_post_publishes.created_at
    SQL
      .where('new_post_publishes.post_id': nil)
      .eager_load(:post_publishes)
  }

  def published?
    return false if latest_publish.blank?

    !latest_publish.withdrawn?
  end

  def publish_at!(at = Date.today, created_at = Time.zone.now)
    post_publishes.create!(published_at: at, created_at: created_at)
  end

  def latest_publish
    @latest_publish ||= post_publishes.max_by(&:created_at)
  end
end
