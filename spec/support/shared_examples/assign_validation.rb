shared_examples "assign_vars" do |*vars|
  vars.each do |var_name|
    it "assigns @#{var_name.to_s}" do
      request_exec
      expect(assigns(var_name)).to eq(send(var_name))
    end
  end
end

shared_examples "not_assign_vars" do |*vars|
  vars.each do |var_name|
    it "doesn't assign @#{var_name.to_s}" do
      request_exec
      expect(assigns(var_name)).to eq(nil)
    end
  end
end
