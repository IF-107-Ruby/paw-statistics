require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should belong_to(:user).optional(true) }
  it { should have_many(:columns) }
end
