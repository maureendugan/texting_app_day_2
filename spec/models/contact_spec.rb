require 'spec_helper'

describe Contact do
  it { should belong_to :user}
  it { should validate_numericality_of :phone_number }
  it { should ensure_length_of(:phone_number).is_at_least(10) }
  it { should ensure_length_of(:phone_number).is_at_most(10) }
end
