shared_examples "assigns album with attributes" do
  it "assigns @album" do
    request_exec
    expect(assigns(:album).attributes.except('created_at', 'updated_at', 'id'))
      .to eq(user.albums.build(album_attributes.except('tags')).attributes.except('created_at', 'updated_at', 'id'))
  end
end

shared_examples "saves album tags" do
  it "saves @album tags" do
    request_exec
    expect(assigns(:album).tags.map { |t| t.text }).to eq(album_attributes['tags'])
  end
end
