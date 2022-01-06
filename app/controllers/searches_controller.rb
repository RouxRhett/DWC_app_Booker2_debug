class SearchesController < ApplicationController
  def search
    #検索するmodel
    @model = params["model"]
    #検索内容
    @content = params["content"]
    #検索方法
    @method = params["method"]
    #検索結果
    @records = search_for(@model, @content, @method)
  end

  def cat_search
    #検索内容
    @category = params[:category]
    redirect_to books_path(cat_search: "true", category: @category)
  end

  #このクラスでしか利用しない為、privateにする
  private
  def search_for(model, content, method)
    if model == 'user'
      if method == 'perfect'
        User.where(name: content)
      elsif method == 'prifix'
        User.where('name LIKE ?', content+'%')
      elsif method == 'backward'
        User.where('name LIKE ?', '%'+content)
      elsif method == 'partial'
        User.where('name LIKE ?', '%'+content+'%')
      end
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      elsif method == 'prifix'
        Book.where('title LIKE ?', content+'%')
      elsif method == 'backward'
        Book.where('title LIKE ?', '%'+content)
      elsif method == 'partial'
        Book.where('title LIKE ?', '%'+content+'%')
      end
    end
  end
end
