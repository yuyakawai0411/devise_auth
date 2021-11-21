require 'rails_helper'

RSpec.describe "Ideas", type: :request do
  describe "GET users/:user_id/ideas" do
  let!(:user) { FactoryBot.create(:user) }
  let(:user_not_exidt) { user.id + 1 }
  let(:auth_token) { sign_in(user) }
  let!(:idea) { FactoryBot.create(:idea, user_id: user.id) }
    context "ログインユーザーとアイデア登録ユーザーが等しい時" do
      subject { get "/users/#{user.id}/ideas", headers: auth_token }
      it "アイデア情報が表示される" do
        subject
        json = JSON.parse(response.body)
        expect(json['data'][0]['title']).to eq(idea.title)
        expect(json['data'][0]['memo']).to eq(idea.memo)
      end
      it "HTTP200が返される" do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(200)   
      end
    end

    context "ログインユーザーとアイデア登録ユーザーが等しくない時" do
      subject { get "/users/#{user_not_exidt}/ideas", headers: auth_token }
      it "エラー文が表示される" do
        subject
        json = JSON.parse(response.body)
        expect(json['message']).to eq('ユーザーが違います') 
      end
      it "HTTP404が返される" do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end 
  end

  describe "POST users/:user_id/ideas" do
  let!(:user) { FactoryBot.create(:user) }
  let(:user_not_exidt) { user.id + 1 }
  let(:auth_token) { sign_in(user) }
  let(:idea_params) { FactoryBot.attributes_for(:idea, user_id: user.id) }
    context "ログインユーザーとアイデア登録ユーザーが等しい時" do
      subject { post "/users/#{user.id}/ideas", params: idea_params , headers: auth_token }
      it "アイデア情報が保存される" do
        expect{ subject }.to change {Idea.count}.by(1)
      end
      it "HTTP200が返される" do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(201) 
      end
    end

    context "ログインユーザーとアイデア登録ユーザーが等しくない時" do
      subject { post "/users/#{user_not_exidt}/ideas", params: idea_params , headers: auth_token }
      it "アイデアが保存されない" do
        expect{ subject }.to change {Idea.count}.by(0)
      end
      it "エラー文が表示される" do
        subject
        json = JSON.parse(response.body)
        expect(json['message']).to eq('ユーザーが違います') 
      end
      it "HTTP404が返される" do
        subject
        json = JSON.parse(response.body)
        expect(json['status']).to eq(404) 
      end
    end 
  end
end
