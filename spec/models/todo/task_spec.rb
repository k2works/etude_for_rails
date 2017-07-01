# == Schema Information
#
# Table name: todo_tasks
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  content    :text             not null
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Todo::Task, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
