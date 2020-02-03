class Gossip
  attr_accessor :author, :content, :id

  def initialize(author, content, id)
    @author = author
    @content = content
    @id = id
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content, @id]
    end
  end

  def self.find(find_id)
    find_id = find_id.to_i
    gossip_found = nil
    Gossip.all.each do |one_gossip|
      (one_gossip.id.to_i == find_id)? gossip_found = one_gossip : ""
    end
    gossip_found
  end

  def self.update(author,content,id)
    gossip = Gossip.id
    gossip.content = content
    gossip.author = author
    gossip.save
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line| 
      all_gossips << Gossip.new(csv_line[0], csv_line[1], csv_line[2])
    end
    return all_gossips
  end
end