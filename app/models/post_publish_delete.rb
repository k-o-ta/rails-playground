class PostPublishDelete < ApplicationRecord
  belongs_to :post_publish

  validate :cannot_be_updated

  private

  def cannot_be_updated
    return unless self.class.find_by(post_publish_id: post_publish_id)

    errors.add(:already_deleted, "すでに削除済みです(post_publish_id: #{post_publish_id})")
  end
end
