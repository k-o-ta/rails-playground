require 'rails_helper'

describe Post, type: :model do

  describe '.with_latest_publish' do
    subject { described_class.with_latest_publish }

    let(:post) { FactoryBot.create(:post) }
    let!(:only_publish) { post.publish_at! }

    let(:post2) { FactoryBot.create(:post) }
    let!(:multiple_publishes) do
      post2.publish_at!(Date.yesterday, 30.minutes.ago).withdraw
      post2.publish_at!
    end

    let!(:post3) { FactoryBot.create(:post) }

    it do
      expect(subject).to contain_exactly(post, post2, post3)
      expect(subject.map(&:post_publishes).to_a.flatten).to contain_exactly(only_publish, multiple_publishes)
    end
  end

  describe '#published?' do
    subject { post.published? }

    let(:post) { FactoryBot.create(:post) }

    context '一度もpublishされてない場合' do
      it { is_expected.to be false }
    end

    context '最後のpublishがdeleteされている場合' do
      before do
        post.publish_at!.withdraw
        post.publish_at!.withdraw
      end

      it { is_expected.to be false }
    end

    context '最後のpublishがdeleteされていない場合' do
      before do
        post.publish_at!.withdraw
        post.publish_at!
      end

      it { is_expected.to be true }
    end
  end

  describe '#publish_at!' do
    subject { post.publish_at! }
    let(:post) { FactoryBot.create(:post) }

    context '一度もpublishしていない場合' do
      it do
        expect { subject }.to change(PostPublish, :count).by(1)
        expect(subject).to be_a(PostPublish).and be_persisted
      end
    end

    context '最後のpublishがdeleteされている場合' do
      before do
        post.publish_at!.withdraw
        post.publish_at!.withdraw
      end

      it do
        expect { subject }.to change(PostPublish, :count).by(1)
        expect(subject).to be_a(PostPublish).and be_persisted
      end
    end

    context '最後のpublishがdeleteされていない場合' do
      before do
        post.publish_at!.withdraw
        post.publish_at!
      end

      it do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Already published すでにpublish済みです: #{post.id}")
                                .and change(PostPublish, :count).by(0)
      end
    end
  end

  describe '#latest_publish' do
    subject { post.latest_publish }
    let(:post) { FactoryBot.create(:post) }

    context '未publishの場合' do
      it { is_expected.to be nil }
    end

    context 'publish済みの場合' do
      let!(:publish) { post.publish_at! }

      it { is_expected.to eq publish}
    end

    context 'publishして削除済みの場合' do
      let!(:publish) do
        post.publish_at!(Date.yesterday, 30.minutes.ago).withdraw
        post.publish_at!
      end

      it { is_expected.to eq publish}
    end
  end
end
