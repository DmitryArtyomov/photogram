shared_examples "contains fields" do |*vars|
  vars.each do |var_name|
    it "contains '#{var_name.to_s}' field" do
      expect(subject[var_name.to_s]).to eq(sample.send(var_name))
    end
  end
end

shared_examples "fields count" do |count|
  it "doesn't contain extra fields" do
    expect(subject.keys.length).to eq(count)
  end
end
