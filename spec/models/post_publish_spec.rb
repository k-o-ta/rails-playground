require 'rails_helper'

describe PostPublish, type: :model do
  describe '#withdraw' do
    subject { post_publish.withdraw }
    let(:post_publish) do
      post = FactoryBot.create(:post)
      post.publish_at!
    end

    context 'すでに削除済みの場合' do
      before { post_publish.withdraw }

      it do
        expect { subject }.to raise_error(RuntimeError, "すでに削除済みです: (post_publish_id: #{post_publish.id})")
                                .and change(PostPublishDelete, :count).by(0)
      end
    end

    context 'まだ削除済みでない場合' do
      it do
        expect { subject }.to change(PostPublishDelete, :count).by(1)
        expect(subject).to be_a(PostPublishDelete).and be_persisted
      end
    end
  end

  describe '#withdrawn?' do

  end

end
