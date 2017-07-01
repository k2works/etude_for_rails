require 'rails_helper'

RSpec.describe PerfectRails::BlogPost, type: :model do
  let(:blog_post) { PerfectRails::BlogPost.new }
  let(:new_blog_post) { PerfectRails::BlogPost.new }

  describe '#as_json' do
    it 'JSON形式でシリアライズされる' do
      blog_post.subject = "Rails Guides"
      blog_post.body = "Rails is Cool!"
      blog_post.created_at = Time.current
      expect(blog_post.as_json.to_json).to be_json
      expect(blog_post.as_json(root: true).to_json).to be_json
    end

  end

  describe '#to_json' do
    it 'JSON形式でシリアライズされる' do
      blog_post.subject = "Rails Guides"
      blog_post.body = "Rails is Cool!"
      blog_post.created_at = Time.current
      expect(blog_post.to_json(root: true)).to be_json_including(
                                                   "blog_post" => {
                                                       "subject"    => "Rails Guides",
                                                       "body"       => "Rails is Cool!"
                                                   })

    end
  end

  describe '#from_json' do
    it 'JSON形式でデシリアライズされる' do
      blog_post.subject = "Rails Guides"
      blog_post.body = "Rails is Cool!"
      blog_post.created_at = Time.current
      new_blog_post.from_json(blog_post.to_json)
      expect(new_blog_post.to_json(root: true)).to be_json_including(
                                                   "blog_post" => {
                                                       "subject"    => "Rails Guides",
                                                       "body"       => "Rails is Cool!"
                                                   })

    end

  end
end