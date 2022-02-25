class PostPublish < ApplicationRecord
  belongs_to :post
  has_one :post_publish_delete

  validate :already_published

  def withdraw
    raise "すでに削除済みです: (post_publish_id: #{id})" if post_publish_delete.present?

    create_post_publish_delete(post_publish_id: id)
  end

  def withdrawn?
    post_publish_delete.present?
  end

  private

  def already_published
    published = self.class.order(created_at: :DESC).find_by(post_id: post_id)

    return if published.blank?
    return if published.post_publish_delete.present?

    errors.add(:already_published, "すでにpublish済みです: #{post_id}")
  end
end
