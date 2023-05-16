class BooksController < ApplicationController
  def new
    # @book = Book.new # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
  end

  def create
    @book = Book.new(book_params) #データを受け取り新規登録するためのインスタンス作成
    if @book.save #データをデータベースに保存するためのsaveメソッド実行
      flash[:notice] = "create successfully"
      redirect_to book_path(@book.id) #show画面へリダイレクト
    else
      @books = Book.all
      render :index
    end
  end
  def index
     @book = Book.new # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
     @books = Book.all
  end

  def show
     @book = Book.find(params[:id])
  end

  def edit
     @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "update successfully"
      redirect_to book_path(book.id)
    else
      @book = book
      render :edit
    end
  end
  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    flash[:notice] = "destroy successfully"
    redirect_to '/books'  # 投稿一覧画面へリダイレクト  
  end
  
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
