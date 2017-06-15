module Todo
  # taskテーブルを表現するモデルクラスです
  # @author k2works
  class Task < ActiveRecord::Base
    scope :status_is, ->(status) { where(status: status) }

    NOT_YET = 0 # タスクが完了していない

    DONE = 1 # タスクが完了した

    PENDING = 2 # 保留中のタスク

    # ステータスの名称と数値の組み合わせの値
    STATUS = {
        'NOT_YET' => NOT_YET,
        'DONE' => DONE,
        'PENDING' => PENDING
    }.freeze

    validates :name, presence: true, length: {maximum: 140}
    validates :content, presence: true
    validates :status, numericality: true, inclusion: {in: STATUS.values}
  end
end