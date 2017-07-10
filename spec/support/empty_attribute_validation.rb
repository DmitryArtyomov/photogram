shared_examples 'empty attribute validation' do |empty_attribute:, validity:|
  it "is #{validity ? '' : 'not '}valid #{empty_attribute ? 'without ' + empty_attribute.to_s : 'with valid attributes'}" do
    subject.send("#{empty_attribute.to_s}=", nil) if empty_attribute
    expect(subject).send(validity ? "to" : "to_not", be_valid)
  end
end
