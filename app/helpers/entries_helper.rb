module EntriesHelper

 def width_for(emotional_state)
   emotional_state.to_i * 20
 end

 def like_status_for(entry, user)
   return "Nobody knows the feeling." if entry.likes == 0
   out = []
   if entry.liked? user
     out << "You"
     out << "and" if entry.likes > 1
     out << "#{entry.likes - 1} others" if entry.likes > 1
   else
     out << "#{entry.likes} others" if entry.likes > 1
   end
   #You and <b><%= rand(10) %></b> others know the feeling
   out << "know the feeling."
   out.join(" ").html_safe
 end
end
