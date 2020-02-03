class Comment

  attr_accessor :id_gossip, :content

  def initialize(id_gossip, content)
    @id_gossip = id_gossip.to_i
    @content = content.to_s
  end

  def save
    CSV.open("./db/comment.csv", "ab") do |csv|
      csv << [@id_gossip, @content]
    end
  end

  def self.by_id_gossip(id_gossip_select)
    all_comment_gossip = []
    Comment.all.each do |one_comment|
      (one_comment.id_gossip.to_i == id_gossip_select.to_i)? (all_comment_gossip << one_comment) : ""
    end
    all_comment_gossip
  end

  def self.all()
    all_comments = []
    CSV.read('./db/comment.csv', headers: true, header_converters: :symbol, converters: :all).each do |csv_line| 
      all_comments << Comment.new(csv_line[0], csv_line[1])
      print csv_line[0], csv_line[1]
    end
    all_comments
  end

end