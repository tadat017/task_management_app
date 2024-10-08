Rails.application.routes.draw do
  resources :tasks do
    member do
      patch :toggle_complete
    end

    collection do
        delete 'delete_expired', to: 'tasks#delete_expired'
      # 期限切れタスクを一括削除するためのルートを追加
    end
  end

  root 'tasks#index'
end
