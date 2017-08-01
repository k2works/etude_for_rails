# == Schema Information
#
# Table name: baukis_messages
#
#  id              :integer          not null, primary key
#  customer_id     :integer          not null
#  staff_member_id :integer
#  root_id         :integer
#  parent_id       :integer
#  type            :string           not null
#  status          :string           default("new"), not null
#  subject         :string           not null
#  body            :text
#  remarks         :text
#  discarded       :boolean          default(FALSE), not null
#  deleted         :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Baukis::Message < ApplicationRecord
  belongs_to :customer, :class_name => 'Baukis::Customer', optional: true
  belongs_to :staff_member, :class_name => 'Baukis::StaffMember', optional: true
  belongs_to :root, :class_name => 'Baukis::Message', foreign_key: 'root_id', optional: true
  belongs_to :parent, :class_name => 'Baukis::Message', foreign_key: 'parent_id', optional: true
  has_many :message_tag_links, :class_name => 'Baukis::MessageTagLink', dependent: :destroy
  has_many :tags, -> { order(:value) } , through: :message_tag_links

  validates :subject, :body, presence: true
  validates :subject, length: { maximum: 80, allow_blank: true }
  validates :body, length: { maximum: 800, allow_blank: true }

  before_create do
    if parent
      self.customer = parent.customer
      self.root = parent.root || parent
    end
  end

  default_scope { order(created_at: :desc) }

  before_validation do
    if parent
      self.root = parent.root || parent
      self.customer = parent.customer
    end
  end

  attr_accessor :child_nodes

  def tree
    return @tree if @tree
    r = root || self
    messages = Baukis::Message.where(root_id: r.id).select(:id, :parent_id, :subject)
    @tree = Baukis::SimpleTree.new(r, messages)
  end

  def add_tag(label)
    self.class.transaction do
      Baukis::HashLock.acquire('tags', 'value', label)
      tag = Baukis::Tag.find_by(value: label)
      tag ||= Baukis::Tag.create!(value: label)
      unless message_tag_links.where(tag_id: tag.id).exists?
        message_tag_links.create!(tag_id: tag.id)
      end
    end
  end

  def remove_tag(label)
    self.class.transaction do
      Baukis::HashLock.acquire('tags', 'value', label)
      if tag = Baukis::Tag.find_by(value: label)
        message_tag_links.find_by(tag_id: tag.id).destroy
        if tag.message_tag_links.empty?
          tag.destroy
        end
      end
    end
  end
end
