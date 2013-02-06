class Entry
# %%entry

  include Mongoid::Document
  %w[
      anxiety  happiness  irritation
      my_content  my_title  share_public  tag
      ].each{|e| field e.to_sym, type: String}
end
