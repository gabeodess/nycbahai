FactoryGirl.define do

  factory :contribution do
    transient do
      include_email false
    end
    amount 10
    date{ Time.zone.today - 1.year }
    num 1
    sequence(:name){ |n| "#{Faker::Name.name} #{n}" }
    after(:create) do |contribution, context|
      FactoryGirl.create(:contributer_email_address, :name => contribution.name) if context.include_email
    end
  end

end
