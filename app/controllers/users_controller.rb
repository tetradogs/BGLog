class UsersController < ApplicationController

  before_action :user_information, only:[:show]

  def show
    end


  private

  def user_information
    @user = User.find(params[:id])
    @listings = @user.listings
    @listings_all = @user.listings.order("updated_at asc")

  #新着情報(1ヶ月に更新されたものを更新日時を降順に５件だけ)
    @listings_recently_limit5 =@listings.order("updated_at desc").limit(5)
    #@listings_recently_limit5 =@listings.where(updated_at: Time.now.all_month).reverse_order.limit(5)

  #新着情報(1ヶ月)
    @listings_recently =@listings.where(updated_at: Time.now.all_month)

    #valuation
    @listings_highlyRate = @listings.where(valuation: "★★★★★").order("updated_at asc")
    #status
    @listings_have = @listings.where(status_have: "1").order("updated_at asc")
    @listings_verygood = @listings.where(status_verygood: "1").order("updated_at asc")
    @listings_want = @listings.where(status_want: "1").order("updated_at asc")
    @listings_can_instruction = @listings.where(status_can_instruction: "1").order("updated_at asc")

    #game-content
    @listings_content = @listings.where.not(game_content: "").order("updated_at asc")
    #game_counting
    @listings_counting = @listings.order("game_counting desc")
  #Userの傾向を見る（プレイ時間）
    #Userの時間の情報を取得する
    @listings_game_time_10 = @listings.where(game_time: "10")
    @listings_game_time_30 = @listings.where(game_time: "30")
    @listings_game_time_60 = @listings.where(game_time: "60")
    @listings_game_time_90 = @listings.where(game_time: "90")
    @listings_game_time_120 = @listings.where(game_time: "120")

    #Userの数を数える
    @listings_game_time_10_count = @listings.where(game_time: "10").count
    @listings_game_time_30_count = @listings.where(game_time: "30").count
    @listings_game_time_60_count = @listings.where(game_time: "60").count
    @listings_game_time_90_count = @listings.where(game_time: "90").count
    @listings_game_time_120_count = @listings.where(game_time: "120").count
    #プレイ時間で最も多いものを選ぶ
    array =[@listings_game_time_10_count,@listings_game_time_30_count,@listings_game_time_60_count,@listings_game_time_90_count,@listings_game_time_120_count]
    game_time_max = array.max

    case
    when @listings_game_time_10_count == game_time_max
        @your_game_time = "10"
      when @listings_game_time_30_count == game_time_max
        @your_game_time = "30"
      when @listings_game_time_60_count == game_time_max
        @your_game_time = "60"
      when @listings_game_time_90_count == game_time_max
        @your_game_time = "90"
      when @listings_game_time_120_count == game_time_max
        @your_game_time = "120"
    end
    #プレイ時間の総数から割合をみる
    @listings_game_time_all_count = @listings_game_time_10_count + @listings_game_time_30_count + @listings_game_time_60_count + @listings_game_time_90_count + @listings_game_time_120_count

  #Userの傾向を見る（プレイ人数）

    #Userのプレイ時間の情報を取得する
    @listings_game_player_2 = @listings.where(game_player: "2")
    @listings_game_player_3 = @listings.where(game_player: "3")
    @listings_game_player_4 = @listings.where(game_player: "4")
    @listings_game_player_5 = @listings.where(game_player: "5")
    @listings_game_player_6 = @listings.where(game_player: "6")

    #Userのプレイ人数の情報を取得する
    @listings_game_player_2_count = @listings.where(game_player: "2").count
    @listings_game_player_3_count = @listings.where(game_player: "3").count
    @listings_game_player_4_count = @listings.where(game_player: "4").count
    @listings_game_player_5_count = @listings.where(game_player: "5").count
    @listings_game_player_6_count = @listings.where(game_player: "6").count

    #プレイ人数で最も多いものを選ぶ
    array_player =[@listings_game_player_2_count,@listings_game_player_3_count,@listings_game_player_4_count,@listings_game_player_5_count,@listings_game_player_6_count]
    game_player_max = array_player.max

    case
    when @listings_game_player_2_count == game_player_max
        @your_game_player = "2"
      when @listings_game_player_3_count == game_player_max
        @your_game_player = "3"
      when @listings_game_player_4_count == game_player_max
        @your_game_player = "4"
      when @listings_game_player_5_count == game_player_max
        @your_game_player = "5"
      when @listings_game_player_6_count == game_player_max
        @your_game_player = "6"
      end
      #プレイ人数の総数から割合を見る
      @listings_game_player_all_count = @listings_game_player_2_count + @listings_game_player_3_count + @listings_game_player_4_count + @listings_game_player_5_count + @listings_game_player_6_count


    #本日更新した情報をtweetする（10分前：10.minutes.ago）
      #updated_tweet = current_user.listings.where(updated_at: (10.minutes.ago)..(Time.now))
      if user_signed_in?
      updated_tweet = current_user.listings.where(updated_at: Time.now.all_day)
        if updated_tweet.present?
          @updated_tweet = updated_tweet
        else
          @updated_tweet = nil
        end
      end
    #追加されたり回数が増えたものをツイートするための情報取得=>ゲームカウントだけが増えたものを設定できなくなった…
      #本日追加されたもの
        #created_tweet = current_user.listings.where(created_at: Time.now.all_day)
      #本日回数が増えたもの
        #updated_count_tweet = current_user.listings.where(game_counting: today_count)
  end
end
