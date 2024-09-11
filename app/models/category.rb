class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '仕事' },
    { id: 2, name: '家事' },
    { id: 3, name: '運動' },
    { id: 4, name: '勉強' },
    { id: 5, name: 'その他' }
  ]
end
