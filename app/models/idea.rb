class Idea < ApplicationRecord
  belongs_to :user

  def to_json
    data = {
      title: self.title,
      memo: self.memo
    }
  end
end
