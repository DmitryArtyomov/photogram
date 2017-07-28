shared_examples "assigns comment with attributes" do
  it "assigns @comment" do
    request_exec
    expect(assigns(:comment).attributes.except('created_at', 'updated_at', 'id'))
      .to eq(photo.comments.build(comment_attributes.tap {|c| c[:user_id] = user.id } )
        .attributes.except('created_at', 'updated_at', 'id'))
  end
end
