# == Schema Information
#
# Table name: rails_tutorial_toy_microposts
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe RailsTutorial::Toy::Micropost, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
