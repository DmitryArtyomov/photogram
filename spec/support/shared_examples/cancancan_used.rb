shared_examples 'cancancan_used' do
  it "uses CanCanCan" do
    expect(subject).to respond_to(:current_ability)
  end
end
