shared_examples 'text length validation' do |length:, validity:, prefix: nil|
  it "is #{validity ? '' : 'not '}valid with #{length} #{'symbol'.pluralize(length)} text" do
    subject.text = "#{prefix}#{Faker::Lorem.characters(length)}"
    expect(subject).send(validity ? "to" : "to_not", be_valid)
  end
end
