require 'rails_helper'

RSpec.describe SearchService do
  subject { described_class.new(query) }
  let (:result) { subject.search }

  context '#search' do
    context 'single model' do
      shared_examples 'finds all' do |type:|
        it "finds all #{type.to_s}" do
          expect(result[type].send(:resource).length).to eq(expected.length)
          expect(result[type].send(:resource)).to eq(expected)
        end
      end

      context 'only tags' do
        before(:example) do
          %w(#tagOne #tagTwo #tagThree #anotherTag #testTag #testOther #notTest).each do |text|
            create(:tag, text: text)
          end
        end

        let (:query) { "#tag" }
        let (:expected) { Tag.search_by_text(query).order('tags.taggings_count DESC').limit(20).to_a }

        include_examples 'finds all', type: :tags
      end

      context 'only users' do
        before(:example) do
          create(:user, first_name: 'Test')
          create(:user, last_name: 'Test')
          create(:user, first_name: 'Testing')
          create(:user, last_name: 'NoTesting')
          create(:user)
        end

        let (:query) { "Test" }
        let (:expected) { User.search_by_full_name(query).order('users.followers_count DESC').limit(10).to_a }

        include_examples 'finds all', type: :users
      end

      context 'only albums' do
        before(:example) do
          %w(albumTest album\ Test anotherAlbum another\ Album test).each do |name|
            create(:album, name: name)
          end
        end

        let (:query) { "album" }
        let (:expected) { Album.search_by_name(query).order('albums.photos_count DESC').limit(20).to_a }

        include_examples 'finds all', type: :albums
      end
    end

    context 'multiple models' do
      before(:example) do
        %w(#testTag #testOther #notTest).each { |text| create(:tag, text: text) }
        %w(testAlbum album\ Test anotherAlbum another\ Album test).each { |name| create(:album, name: name) }
        create(:user, first_name: 'test')
        create(:user, last_name: 'Test')
        create(:user, first_name: 'Testing')
      end

      let (:expected_tags) { Tag.search_by_text(query).order('tags.taggings_count DESC').limit(20).to_a }
      let (:expected_albums) { Album.search_by_name(query).order('albums.photos_count DESC').limit(20).to_a }
      let (:expected_users) { User.search_by_full_name(query).order('users.followers_count DESC').limit(10).to_a }

      let (:query) { 'Test' }

      it 'finds all' do
        expect(result[:tags].send(:resource).length).to eq(expected_tags.length)
        expect(result[:tags].send(:resource)).to eq(expected_tags)

        expect(result[:albums].send(:resource).length).to eq(expected_albums.length)
        expect(result[:albums].send(:resource)).to eq(expected_albums)

        expect(result[:users].send(:resource).length).to eq(expected_users.length)
        expect(result[:users].send(:resource)).to eq(expected_users)
      end
    end
  end
end
