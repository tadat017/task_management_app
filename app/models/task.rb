class Task < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

   validates :title, presence: { message: "タスク名は必須です" }, length: { maximum: 255, message: "タスク名は255文字以内で入力してください" }
  validates :description, length: { maximum: 500, message: "詳細は500文字以内で入力してください" }, allow_blank: true
  validates :deadline, presence: { message: "期限を入力してください" }, comparison: { greater_than: Date.today, message: "期限は未来の日付を選択してください" }
  validates :priority, inclusion: { in: [0, 1, 2], message: "優先度は0（低）, 1（中）, 2（高）のいずれかを選択してください" }
end