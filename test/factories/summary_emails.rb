FactoryGirl.define do
  factory :summary_email do
    contributer "MyString"
    year{ Time.zone.today.year - 1 }
    sent_at "2016-02-24 11:35:25"
  end

end
