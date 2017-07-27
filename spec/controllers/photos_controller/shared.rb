shared_examples "assigns photo with attributes" do
  it "assigns @photo" do
    request_exec
    expect(assigns(:photo).attributes.except('created_at', 'updated_at', 'id', 'image'))
      .to eq(album.photos.build(photo_attributes.except('tags')).attributes.except('created_at', 'updated_at', 'id', 'image'))
    expect(assigns(:photo).image.size).to eq(photo_attributes[:image].size) if photo_attributes[:image]
  end
end

shared_examples "saves photo tags" do
  it "saves @photo tags" do
    request_exec
    expect(assigns(:photo).tags.map { |t| t.text }).to eq(photo_attributes['tags'])
  end
end
