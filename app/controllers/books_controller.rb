class BooksController < ApplicationController

def search
  retry_count = 0
  begin
      if params[:keyword].present?
      #　デバックログ出力するために記述
      Amazon::Ecs.debug = true

      # Amazon::Ecs::Responceオブジェクトの取得
      books = Amazon::Ecs.item_search(
      params[:keyword],
      search_index: 'Toys',
      response_group: 'ItemAttributes, Images',
      country: 'jp',
      item_page: '1'
      )

      # ゲームのタイトル,画像URL, 詳細ページURLの取得
          @books = []
          books.items.each do |item|
          book = Book.new(
          item.get('ItemAttributes/Title'),
          item.get('LargeImage/URL'),
          item.get('DetailPageURL'),
          )
          @books << book
          end

          #検索キーワードを検索結果に表示させる（inputのnameに:keywordとしているので、params[:keyword]で読み取れる）
          @search_word = params[:keyword]
      end
      rescue
      retry_count += 1
      if retry_count < 5
        sleep(5)
        retry
      else
        return false
      end
      end

      #searchの変数
      #@listing = current_user.listings.build
      @listing = Listing.new


      #検索したワードの取得
      #@search_word = params[:book]
end




end
